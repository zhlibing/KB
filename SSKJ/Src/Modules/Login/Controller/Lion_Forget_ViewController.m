//
//  Lion_Forget_ViewController.m
//  SSKJ
//
//  Created by cy5566 on 2020/3/13.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "Lion_Forget_ViewController.h"
#import "LoginTextFieldView.h"
#import "Lion_Forget_SetViewController.h"



@interface Lion_Forget_ViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *switchBtn;
@property (nonatomic, strong) SSKJ_TextFieldView *accountView;
@property (nonatomic, strong) SSKJ_TextFieldView *codeView;
@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, assign) NSInteger validate; //!<  1 手机找回 2邮箱找回



@end

@implementation Lion_Forget_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.switchBtn];
    [self.view addSubview:self.accountView];
    [self.view addSubview:self.codeView];
    [self.codeView addSubview:self.codeBtn];
    [self.view addSubview:self.commitBtn];
    [self setValidate:1];
    
    
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(ScaleW(130));
        make.left.equalTo(self.view.mas_left).offset(ScaleW(20));
    }];
    
    
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.titleLabel.mas_right).offset(ScaleW(15));
        make.bottom.equalTo(self.titleLabel.mas_bottom);
    }];
    
    
    
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.titleLabel.mas_bottom).offset(ScaleW(45));
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(ScaleW(50)));
        
    }];
    
    
    
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.accountView.mas_bottom).offset(ScaleW(20));
        make.left.height.right.equalTo(self.accountView);
    }];
    
    
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.codeView.mas_right).offset(-ScaleW(20));
        make.centerY.equalTo(self.codeView.mas_centerY);
        
    }];
    
    
    
    
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.codeView.mas_bottom).offset(ScaleW(36));
        make.left.equalTo(self.view.mas_left).offset(ScaleW(15));
        make.right.equalTo(self.view.mas_right).offset(-ScaleW(15));
        make.height.equalTo(@(ScaleW(45)));
        
    }];
    
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//    [self.navigationController setNavigationBarHidden:YES animated:NO];;

}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
}

#pragma mark - Private Method
-(void)switAction:(UIButton*)sender
{
    switch (sender.tag)
    {
        case 1:
        {
            [sender setTag:2];
            [sender setTitle:SSKJLanguage(@"切换手机找回") forState:UIControlStateNormal];
            [self.titleLabel setText:SSKJLanguage(@"邮箱找回")];
            [self.accountView setImageName:@"youxiang-icon" placeholder:SSKJLanguage(@"请输入邮箱地址") secureTextEntry:NO];
            
            
        }
            break;
        case 2:
        {
            [sender setTag:1];
            [sender setTitle:SSKJLanguage(@"切换邮箱找回") forState:UIControlStateNormal];
            [self.titleLabel setText:SSKJLanguage(@"手机找回")];
            [self.accountView setImageName:@"shouji-icon" placeholder:SSKJLanguage(@"请输入手机号") secureTextEntry:NO];
            
        }
            break;
    }
    
    [self setValidate:sender.tag];
}



-(void)codeAction:(UIButton*)sender
{
    switch (self.switchBtn.tag)
    {
        case 1:
        {
            if ([RegularExpression validateMobile:self.accountView.valueString])
            {
                [self requestSmsCode:self.accountView.valueString];
            }
            else
            {
                [MBProgressHUD showError:SSKJLanguage(@"手机号格式不正确") toView:self.view];
            }
        }
            break;
        case 2:
        {
            if ([RegularExpression validateEmail:self.accountView.valueString])
            {
                [self requestEmailCode:self.accountView.valueString];
            }
            else
            {
                [MBProgressHUD showError:SSKJLanguage(@"邮箱号格式不正确") toView:self.view];
            }
        }
            break;
    }
    
    
}

#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setText:SSKJLanguage(@"手机找回")];
        [_titleLabel setFont:systemFont(ScaleW(24))];
        [_titleLabel setTextColor:kTitleColor];
    }
    return _titleLabel;
}

-(UIButton *)switchBtn
{
    if (!_switchBtn)
    {
        _switchBtn = [[UIButton alloc]init];
        [_switchBtn setTitle:SSKJLanguage(@"切换邮箱找回") forState:UIControlStateNormal];
        [_switchBtn addTarget:self action:@selector(switAction:) forControlEvents:UIControlEventTouchUpInside];
        [_switchBtn.titleLabel setFont:systemFont(ScaleW(12))];
        [_switchBtn setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        [_switchBtn setTag:1];
    }
    return _switchBtn;
}



- (SSKJ_TextFieldView *)accountView
{
    if (_accountView == nil)
    {
        _accountView = [[SSKJ_TextFieldView alloc] initWithType:2];
        [_accountView setImageName:@"shouji-icon" placeholder:SSKJLanguage(@"请输入手机号") secureTextEntry:NO];
    }
    return _accountView;
}





- (SSKJ_TextFieldView *)codeView
{
    if (_codeView == nil)
    {
        _codeView = [[SSKJ_TextFieldView alloc] initWithType:2];
        [_codeView setImageName:@"login_code" placeholder:SSKJLanguage(@"请输入验证码") secureTextEntry:NO];
    }
    return _codeView;
}




-(UIButton *)codeBtn
{
    if (!_codeBtn)
    {
        _codeBtn = [[UIButton alloc]init];
        [_codeBtn setTitle:SSKJLanguage(@"获取验证码") forState:UIControlStateNormal];
        [_codeBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
        [_codeBtn.titleLabel setFont:systemFont(ScaleW(14))];
        [_codeBtn addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeBtn;
}
- (UIButton *)commitBtn
{
    if (_commitBtn == nil)
    {
        _commitBtn = [[UIButton alloc]init];
        [_commitBtn setTitle:SSKJLanguage(@"下一步") forState:UIControlStateNormal];
        [_commitBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_commitBtn.titleLabel setFont:systemFont(ScaleW(14))];
        [_commitBtn setBackgroundColor:kBlueColor];
        [_commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBtn;
}









- (void)backBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}







- (void)commitBtnAction
{
    if (self.accountView.field.text.length == 0)
    {
        [MBProgressHUD showError:@"请输入账号"];
        return;
    }
    
    if (self.codeView.valueString.length == 0)
    {
        [MBProgressHUD showError:@"请输入验证码"];
        return;
    }
    
    
    
    
    
    WS(weakSelf);
    NSDictionary *params = @{@"account":self.accountView.field.text};
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_CheckRegister_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (netModel.status.integerValue == 200)
         {
             Lion_Forget_SetViewController *vc = [Lion_Forget_SetViewController new];
             vc.account = self.accountView.field.text;
             vc.code = self.codeView.valueString;
             [weakSelf.navigationController pushViewController:vc animated:YES];
         }
         else
         {
             [MBProgressHUD showError:responseObject[@"msg"]];
         }
        
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         [SSTool error:SSKJLanguage(@"网络异常")];
     }];
    
}



#pragma mark --- 网络请求 ---
// 获取手机验证码
-(void)requestSmsCode:(NSString*)account
{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = account;

    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_GetSmsCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED)
        {
            [WLTools countDownWithButton:weakSelf.codeBtn];
            
        }
        else
        {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        
        [MBProgressHUD showError:SSKJLocalized(@"服务器请求异常", nil)];
        
    }];
}
//获取邮箱验证码
- (void)requestEmailCode:(NSString*)account
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"email"] = account;
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_GetEmailCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED)
        {
            [WLTools countDownWithButton:weakSelf.codeBtn];
        }
        else
        {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
    {
        [hud hideAnimated:YES];
        
        [MBProgressHUD showError:SSKJLocalized(@"服务器请求异常", nil)];
        
    }];
}


@end
