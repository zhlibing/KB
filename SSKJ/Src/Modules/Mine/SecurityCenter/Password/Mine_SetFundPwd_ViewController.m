//
//  My_SetTPWD_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "Mine_SetFundPwd_ViewController.h"
#import "Mine_TitleAndInput_View.h"
#import "BIAuthCodeHelper.h"
#import "Mine_BindGoogle_AlertView.h"



@interface Mine_SetFundPwd_ViewController ()

@property (nonatomic, strong) SSKJ_TextFieldView *pwdView;
@property (nonatomic, strong) SSKJ_TextFieldView *surePwdView;
@property (nonatomic, strong) SSKJ_TextFieldView *phoneView;

@property (nonatomic, strong) UILabel *frontTitlelabel;
@property (nonatomic, strong) UILabel *middleTitlelabel;
@property (nonatomic, strong) UILabel *behindTitlelabel;




@property (nonatomic, strong) UIButton *smsCodeButton;
@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) Mine_BindGoogle_AlertView *googleAlertView;
@end

@implementation Mine_SetFundPwd_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([SSKJ_User_Tool sharedUserTool].userInfoModel.config.payment_password_set.integerValue == 1)
    {
            self.title = SSKJLocalized(@"修改资金密码", nil);
    }
    else
    {
        self.title = SSKJLocalized(@"设置资金密码", nil);
    }
   
    
    
    [self.view addSubview:self.pwdView];
    [self.view addSubview:self.surePwdView];
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.smsCodeButton];
    [self.view addSubview:self.submitButton];
    [self.view addSubview:self.frontTitlelabel];
    [self.view addSubview:self.middleTitlelabel];
    [self.view addSubview:self.behindTitlelabel];
    
    
    
    [self.pwdView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(@(ScaleW(30) + Height_NavBar));
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(ScaleW(70)));
    }];
    
    
    [self.surePwdView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.pwdView.mas_bottom).offset(ScaleW(20));
        make.left.right.height.equalTo(self.pwdView);
    }];
    
    
    
    [self.frontTitlelabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.surePwdView.mas_bottom).offset(ScaleW(20));
        make.left.equalTo(@(ScaleW(15)));
        make.height.equalTo(@(ScaleW(20)));
    }];
    
    [self.middleTitlelabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
    
        make.left.equalTo(self.frontTitlelabel.mas_right);
        make.centerY.equalTo(self.frontTitlelabel.mas_centerY);
        make.height.equalTo(self.frontTitlelabel);
    }];
    
    [self.behindTitlelabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
       
        make.left.equalTo(self.middleTitlelabel.mas_right);
        make.centerY.equalTo(self.frontTitlelabel.mas_centerY);
        make.height.equalTo(self.frontTitlelabel.mas_height);
        
    }];
    
    

    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.frontTitlelabel.mas_bottom).offset(ScaleW(20));
        make.left.height.equalTo(self.pwdView);
        make.right.equalTo(@(-ScaleW(104)));
    }];


    [self.smsCodeButton mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.equalTo(self.phoneView.field.mas_centerY);
        make.width.equalTo(@(ScaleW(99)));
        make.right.equalTo(@(-15));
        make.height.equalTo(@(44));
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.phoneView.mas_bottom).offset(ScaleW(50));
        make.left.equalTo(@(ScaleW(15)));
        make.right.equalTo(@(-ScaleW(15)));
        make.height.equalTo(@(ScaleW(44)));
    }];
    
    
    NSString *string = @"";
    if ([RegularExpression validateEmail:self.phoneNumber])
    {
        string = [WLTools hideEmailWithEmail:self.phoneNumber];
    }
    else
    {
        string = [WLTools hidePhoneMiddleNumberWithMobile:self.phoneNumber];
    }
    
    [self.middleTitlelabel setText:string];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



#pragma mark - Getter / Setter
- (UILabel *)frontTitlelabel
{
    if (!_frontTitlelabel)
    {
        _frontTitlelabel = [[UILabel alloc]init];
        [_frontTitlelabel setFont:systemFont(ScaleW(12))];
        [_frontTitlelabel setTextColor:kTitleColor];
        [_frontTitlelabel setText:SSKJLanguage(@"请输入")];
    }
    return _frontTitlelabel;
}

- (UILabel *)middleTitlelabel
{
    if (!_middleTitlelabel)
    {
        _middleTitlelabel = [[UILabel alloc]init];
        [_middleTitlelabel setFont:systemFont(ScaleW(12))];
        [_middleTitlelabel setTextColor:kBlueColor];
    }
    return _middleTitlelabel;
}


- (UILabel *)behindTitlelabel
{
    if (!_behindTitlelabel)
    {
        _behindTitlelabel = [[UILabel alloc]init];
        [_behindTitlelabel setFont:systemFont(ScaleW(12))];
        [_behindTitlelabel setTextColor:kTitleColor];
        [_behindTitlelabel setText:SSKJLanguage(@"收到的验证码")];
    }
    return _behindTitlelabel;
}




- (SSKJ_TextFieldView *)pwdView
{
    if (nil == _pwdView)
    {
        _pwdView = [[SSKJ_TextFieldView alloc] init];
        [_pwdView setTitle:SSKJLanguage(@"新密码") placeholder:SSKJLanguage(@"请输入8-20位字母与数字组合") secureTextEntry:YES];
    }
    return _pwdView;
}





- (SSKJ_TextFieldView *)surePwdView
{
    if (nil == _surePwdView)
    {

        _surePwdView = [[SSKJ_TextFieldView alloc] init];
        [_surePwdView setTitle:SSKJLanguage(@"确认密码") placeholder:SSKJLanguage(@"请再次输入资金密码") secureTextEntry:YES];
    }
    return _surePwdView;
}
- (SSKJ_TextFieldView *)phoneView
{
    if (nil == _phoneView)
    {
        _phoneView = [[SSKJ_TextFieldView alloc] init];
        [_phoneView setTitle:SSKJLocalized(@"验证码", nil) placeholder:SSKJLanguage(@"请输入验证码") secureTextEntry:NO];
        
    }
    return _phoneView;
}




-(UIButton *)smsCodeButton
{
    if (nil == _smsCodeButton)
    {
        _smsCodeButton = [[UIButton alloc]init];
        [_smsCodeButton setTitle:SSKJLocalized(@"发送验证码", nil) forState:UIControlStateNormal];
        [_smsCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _smsCodeButton.titleLabel.font = systemFont(ScaleW(13));
        [_smsCodeButton addTarget:self action:@selector(codeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_smsCodeButton setBackgroundColor:kBlueColor];
        [_smsCodeButton setCornerRadius:ScaleW(5)];
    }
    return _smsCodeButton;
}

-(UIButton *)submitButton
{
    if (nil == _submitButton)
    {
        _submitButton = [[UIButton alloc]init];
        [_submitButton setCornerRadius:ScaleW(5)];
        _submitButton.backgroundColor = kBlueColor;
        [_submitButton setTitle:SSKJLocalized(@"提交",nil) forState:UIControlStateNormal];
        [_submitButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

-(Mine_BindGoogle_AlertView *)googleAlertView
{
    if (nil == _googleAlertView) {
        _googleAlertView = [[Mine_BindGoogle_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [_googleAlertView setType:GOOGLETYPEBIND];
        WS(weakSelf);
        _googleAlertView.submitBlock = ^(NSString * _Nonnull googleCode, NSString * _Nonnull smsCode) {
            [weakSelf requestGoogleSafty:googleCode];
        };
    }
    return _googleAlertView;
}
//谷歌安全验证
- (void) requestGoogleSafty:(NSString *)code{
    NSDictionary *params = @{
        @"code" : code,
        @"stockUserId" : kUserID,
    };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_GoginGoogleAuthVerify_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED) {
            //提交数据
            [weakSelf submitEvent];
            [weakSelf.googleAlertView hide];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
}

#pragma mark - Private Method
#pragma mark 获取验证码

- (void)codeBtnAction{
    
    [self.view endEditing:YES];

    if ([RegularExpression validateEmail:self.phoneNumber])
    {
        [self getEmailCodeEvent];
    }
    else
    {
        [self getSmsCodeEvent];
    }
    
}

-(void)getSmsCodeEvent
{
    
    NSDictionary *params = @{
                                @"phone":kAccount,
                                @"type":@"2",
                                };
    WS(weakSelf);
       //[NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/checkSlide"]
       MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GetSmsCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
        {
            [hud hideAnimated:YES];
            WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
           
            if (network_Model.status.integerValue == SUCCESSED)
            {
                [SSTool error:network_Model.msg];

                [WLTools countDownWithButton:weakSelf.smsCodeButton];
            }else{
                [SSTool error:network_Model.msg];
            }


        } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
        {
            [hud hideAnimated:YES];
            [SSTool error:SSKJLanguage(@"网络异常")];
        }];

}


-(void)getEmailCodeEvent
{
    
    NSDictionary *params = @{
                                @"email":kAccount,
                                };
    WS(weakSelf);
       //[NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/checkSlide"]
       MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GetEmailCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
        {
            [hud hideAnimated:YES];
            WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];

            if (network_Model.status.integerValue == SUCCESSED)
            {
                [SSTool error:network_Model.msg];

                [WLTools countDownWithButton:weakSelf.smsCodeButton];
            }else{
                [SSTool error:network_Model.msg];
            }


        } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
        {
            [hud hideAnimated:YES];
            [SSTool error:SSKJLanguage(@"网络异常")];
        }];

}


#pragma mark 提交设置登录密码

- (void) showGoogleAuth{

    [self submitEvent];
}

-(void)submitEvent
{
    if (self.pwdView.valueString.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入资金密码",nil)];
        return;
    }
    
    if (self.surePwdView.valueString.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请再次输入资金密码",nil)];
        return;
    }
    
    if (![self.pwdView.valueString isEqualToString:self.surePwdView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"两次密码输入不一致",nil)];
        return;
    }
    
    if (![RegularExpression validateAssetPassword:_pwdView.valueString])
    {
        [MBProgressHUD showError:SSKJLocalized(@"密码格式错误", nil)];
        return;
    }
    if (self.phoneView.valueString.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入验证码", nil)];
        return;
    }

    if (self.phoneView.valueString.length != 6)
    {
        [MBProgressHUD showError:SSKJLocalized(@"验证码错误", nil)];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([RegularExpression validateEmail:kAccount]) {
        [params setObject:kAccount forKey:@"email"];
    }else{
        [params setObject:kAccount forKey:@"phone"];
    }
    [params setObject:self.pwdView.valueString forKey:@"password"];
    [params setObject:self.phoneView.valueString forKey:@"code"];
    [params setObject:self.surePwdView.valueString forKey:@"password_confirmation"];
    
    
    NSString *url = BI_UpdatePswd_URL;
    if ([SSKJ_User_Tool sharedUserTool].userInfoModel.config.payment_password_set.integerValue == 0) {
        url = BI_SetPswd_URL;
    }
    
    WS(weakSelf);
    [MBHUD showHUDAddedTo:self.view];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:url RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         [MBHUD hideHUDForView:weakSelf.view];

         if (net_model.status.integerValue == SUCCESSED)
         {
             [MBHUD showError:net_model.msg];
             [SSKJ_User_Tool sharedUserTool].userInfoModel.config.payment_password_set = @"1";
             [weakSelf.navigationController popViewControllerAnimated:YES];
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

@end
