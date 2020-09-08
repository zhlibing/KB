//
//  BI_BindEmail_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/7/3.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "Mine_BindEmail_ViewController.h"
#import "SSKJ_TextFieldView.h"



@interface Mine_BindEmail_ViewController ()

@property (nonatomic, strong) SSKJ_TextFieldView *phoneView;
@property (nonatomic, strong) SSKJ_TextFieldView *codeOptionView;  //!< 验证码

@property (nonatomic, strong) UIButton *smsCodeButton;
@property (nonatomic, strong) UIButton *submitButton;


@end


@implementation Mine_BindEmail_ViewController



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = kBgColor;
    self.title = SSKJLanguage(@"绑定邮箱");
        
    [self unit:YES];

    
    
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}






-(void)unit:(BOOL)unit
{
    if (unit)
    {
        [self.view addSubview:self.phoneView];
        [self.view addSubview:self.codeOptionView];
        [self.view addSubview:self.smsCodeButton];
        [self.view addSubview:self.submitButton];
        
        
        [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.view.mas_top).offset(Height_NavBar+30);
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(80));
        }];
        
        [self.codeOptionView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.phoneView.mas_bottom).offset(ScaleW(15));
            make.left.height.equalTo(self.phoneView);
            make.right.equalTo(self.smsCodeButton.mas_left).offset(-10);
        }];
        
        [self.smsCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.view.mas_right).offset(-15);
            make.height.equalTo(@(44));
            make.width.equalTo(@(100));
            make.bottom.equalTo(self.codeOptionView.mas_bottom).offset(-10);
        }];
        
        [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.top.equalTo(self.codeOptionView.mas_bottom).offset(50);
            make.left.equalTo(self.view.mas_left).offset(15);
            make.right.equalTo(self.view.mas_right).offset(-15);
            make.height.equalTo(@(45));
            
        }];
    }
}





#pragma mark - Getter / Setter
- (SSKJ_TextFieldView *)phoneView
{
    if (nil == _phoneView)
    {
        _phoneView = [[SSKJ_TextFieldView alloc] init];
        [_phoneView setTitle:SSKJLanguage(@"邮箱地址") placeholder:SSKJLanguage(@"请输入邮箱地址") secureTextEntry:NO];
        
    }
    return _phoneView;
}



- (SSKJ_TextFieldView *)codeOptionView
{
    if (nil == _codeOptionView)
    {
        _codeOptionView = [[SSKJ_TextFieldView alloc] init];
        [_codeOptionView setTitle:SSKJLanguage(@"验证码") placeholder:SSKJLanguage(@"请输入邮箱验证码") secureTextEntry:NO];
        
    }
    return _codeOptionView;
}



-(UIButton *)smsCodeButton
{
    if (nil == _smsCodeButton)
    {
        _smsCodeButton = [[UIButton alloc]init];
        [_smsCodeButton setBackgroundColor:kBlueColor];
        [_smsCodeButton setCornerRadius:ScaleW(3)];
        [_smsCodeButton setTitle:SSKJLocalized(@"发送验证码", nil) forState:UIControlStateNormal];
        [_smsCodeButton.titleLabel setFont:systemFont(ScaleW(14))];
        [_smsCodeButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_smsCodeButton addTarget:self action:@selector(getSmsCodeEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smsCodeButton;
}




-(UIButton *)submitButton
{
    if (nil == _submitButton)
    {
        _submitButton = [[UIButton alloc]init];
        [_submitButton setCornerRadius:ScaleW(3)];
        [_submitButton setBackgroundColor:kBlueColor];
        [_submitButton setTitle:SSKJLocalized(@"提交", nil)  forState:UIControlStateNormal];
        [_submitButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_submitButton.titleLabel setFont:systemFont(ScaleW(16))];
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}




#pragma mark - Private Method
#pragma mark  获取验证码
-(void)getSmsCodeEvent:(UIButton*)sender
{

        NSString *email = self.phoneView.valueString;
        if (email == 0)
        {
            [MBProgressHUD showError:SSKJLocalized(@"请输入邮箱地址", nil)];
            return;
        }
        if (![RegularExpression validateEmail:email])
        {
            [MBProgressHUD showError:SSKJLocalized(@"邮箱格式错误", nil)];
            return;
        }
    
        [self getEmailCode:email];
    
    
    [self.phoneView.field resignFirstResponder];
}


#pragma mark 提交按钮响应事件
-(void)submitEvent
{
    [self.phoneView.field resignFirstResponder];
    [self.codeOptionView.field resignFirstResponder];
    
    
    NSString *email = self.phoneView.valueString;
    NSString *code = self.codeOptionView.valueString;
    if (email.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入邮箱地址", nil)];
        return;
    }
    
    if (![RegularExpression validateEmail:email]) {
        [MBProgressHUD showError:SSKJLocalized(@"邮箱格式错误", nil)];
        return;
    }
    
    if (code.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入邮箱验证码", nil)];
        return;
    }
    
    [self bindEmail:email withCode:code];
}

#pragma mark - 网络请求
#pragma mark  请求手机验证码
-(void)getSMCode:(NSString*)phone
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"account"];
    [params setObject:@"3" forKey:@"codeType"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GetSmsCode_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         if (net_model.status.integerValue == SUCCESSED)
         {
             [MBHUD showSuccess:SSKJLocalized(@"发送成功",nil)];
         }
         else
         {
             [MBHUD showError:net_model.msg];
         }
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         
     }];
}

#pragma mark  获取邮箱验证码
- (void)getEmailCode:(NSString*)email
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GetEmailCode_URL RequestType:RequestTypePost Parameters:@{@"email":email} Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         
         if (net_model.status.integerValue == SUCCESSED)
         {
             [MBHUD showSuccess:SSKJLocalized(@"发送成功",nil)];
             [WLTools countDownWithButton:weakSelf.smsCodeButton];
         }
         else
         {
             [MBHUD showError:net_model.msg];
         }
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBHUD hideHUDForView:weakSelf.view];
         
     }];
}


#pragma mark 绑定邮箱请求
- (void)bindEmail:(NSString*)email withCode:(NSString*)code
{
    
    WS(weakSelf);
    [MBHUD showHUDAddedTo:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:email forKey:@"email"];
    [params setObject:code forKey:@"code"];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_BindEmail_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        [MBHUD hideHUDForView:self.view];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == SUCCESSED)
        {
            if (weakSelf.successBlock)
            {
                weakSelf.successBlock(email);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBHUD hideHUDForView:self.view];
        
    }];
    
    
}



@end
