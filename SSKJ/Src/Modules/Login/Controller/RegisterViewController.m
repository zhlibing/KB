//
//  RegisterViewController.m
//  SSKJ
//
//  Created by zpz on 2019/6/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "RegisterViewController.h"

#import "GoCoin_Login_BGView.h"

#import "VerifyCodeButton.h"

#import "Register_Choose_Country_View.h"

//#import "GlobalProtocolViewController.h"

#import "SSKJ_Protocol_ViewController.h"
#import "Choose_AreaCode_View.h"

@interface RegisterViewController ()


@property (nonatomic,strong) UIScrollView *scrollView;


@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *switchBtn;
@property (nonatomic,strong) SSKJ_TextFieldView *codeView;
@property (nonatomic,strong) SSKJ_TextFieldView *accountView;
@property (nonatomic,strong) SSKJ_TextFieldView *pwdBgView;
@property (nonatomic,strong) SSKJ_TextFieldView *twoPwdBgView;
@property (nonatomic,strong) SSKJ_TextFieldView *yaoqingBgView;
@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) UIButton *registeBtn;
@property (nonatomic, strong) UIButton *noAccountBtn;
@property (nonatomic,strong) UIButton * tongyiBtn;
@property (nonatomic,strong) UIButton * xieyiBtn;


@property (nonatomic,assign) NSInteger index;//1 手机号  2邮箱


@property (nonatomic,strong) Choose_AreaCode_View *areaCodeView;

@property (nonatomic,copy) NSString * mcode;
@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setIndex:1];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.switchBtn];
    [self.view addSubview:self.accountView];
    [self.view addSubview:self.codeView];
    [self.codeView addSubview:self.codeBtn];
    [self.view addSubview:self.pwdBgView];
    [self.view addSubview:self.twoPwdBgView];
    [self.view addSubview:self.yaoqingBgView];
    [self.view addSubview:self.tongyiBtn];
    [self.view addSubview:self.xieyiBtn];
    [self.view addSubview:self.commitBtn];
    [self.view addSubview:self.noAccountBtn];
    [self.view addSubview:self.registeBtn];
    
    
    
     [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
           make.top.equalTo(self.view.mas_top).offset(ScaleW(130));
           make.left.equalTo(self.view.mas_left).offset(ScaleW(20));
       }];
       
       
       [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
          
           make.left.equalTo(self.tipLabel.mas_right).offset(ScaleW(15));
           make.bottom.equalTo(self.tipLabel.mas_bottom);
       }];
       
       
       
       [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {

           make.top.equalTo(self.tipLabel.mas_bottom).offset(ScaleW(45));
           make.left.right.equalTo(self.view);
           make.height.equalTo(@(ScaleW(50)));

       }];



       [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {

           make.top.equalTo(self.accountView.mas_bottom).offset(ScaleW(10));
           make.left.height.right.equalTo(self.accountView);
       }];


       [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {

           make.right.equalTo(self.codeView.mas_right).offset(-ScaleW(20));
           make.centerY.equalTo(self.codeView.mas_centerY);

       }];



    [self.pwdBgView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.codeView.mas_bottom).offset(ScaleW(10));
        make.left.height.right.equalTo(self.accountView);
    }];


    [self.twoPwdBgView mas_makeConstraints:^(MASConstraintMaker *make) {

           make.top.equalTo(self.pwdBgView.mas_bottom).offset(ScaleW(10));
           make.left.height.right.equalTo(self.accountView);

    }];
    
    
    [self.yaoqingBgView mas_makeConstraints:^(MASConstraintMaker *make) {

           make.top.equalTo(self.twoPwdBgView.mas_bottom).offset(ScaleW(10));
           make.left.height.right.equalTo(self.accountView);

    }];
    
    
    [self.tongyiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.yaoqingBgView.mas_bottom).offset(ScaleW(25));
        make.left.equalTo(self.view.mas_left).offset(ScaleW(15));
        make.height.width.equalTo(@(ScaleW(15)));
    }];
    
    
    [self.xieyiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.tongyiBtn.mas_centerY);
        make.left.equalTo(self.tongyiBtn.mas_right).offset(ScaleW(5));
    }];
    
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.xieyiBtn.mas_bottom).offset(ScaleW(20));
        make.left.equalTo(self.view.mas_left).offset(ScaleW(15));
        make.right.equalTo(self.view.mas_right).offset(-ScaleW(15));
        make.height.equalTo(@(ScaleW(45)));
        
    }];
    
    
    [self.noAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.commitBtn.mas_bottom).offset(ScaleW(20));
        make.right.equalTo(self.commitBtn.mas_centerX);
    }];
    
    [self.registeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.noAccountBtn.mas_right);
        make.centerY.equalTo(self.noAccountBtn.mas_centerY);
    }];
    
    
    
}


#pragma mark - Private Method
-(void)switAction:(UIButton*)sender
{
    switch (sender.tag)
    {
        case 1:
        {
            [sender setTag:2];
            [sender setTitle:SSKJLanguage(@"切换手机注册") forState:UIControlStateNormal];
            [self.tipLabel setText:SSKJLanguage(@"邮箱注册")];
            [self.accountView setImageName:@"youxiang-icon" placeholder:SSKJLanguage(@"请输入邮箱地址") secureTextEntry:NO];
            
            
        }
            break;
        case 2:
        {
            [sender setTag:1];
            [sender setTitle:SSKJLanguage(@"切换邮箱注册") forState:UIControlStateNormal];
            [self.tipLabel setText:SSKJLanguage(@"手机注册")];
            [self.accountView setImageName:@"shouji-icon" placeholder:SSKJLanguage(@"请输入手机号") secureTextEntry:NO];
            
        }
            break;
    }
    
    [self setIndex:sender.tag];
}

//返回
- (void)backBtClick{
    [self.navigationController popViewControllerAnimated:YES];
}


// 获取验证码点击事件
- (void)codeAction:(UIButton *)sender
{
    switch (self.index)
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
                [MBProgressHUD showError:SSKJLanguage(@"邮箱格式不正确") toView:self.view];
            }
        }
            break;
    }
}


//用户注册协议
- (void)xieyiBtnAcion
{
    
    
    SSKJ_Protocol_ViewController *protocolVC = [[SSKJ_Protocol_ViewController alloc] init];
    protocolVC.type = @"6";
    [self.navigationController pushViewController:protocolVC animated:YES];
    
    
}
//同意按钮点击事件
- (void)tongyiBtnAction:(UIButton*)sender
{
    switch (sender.tag)
    {
        case 1:
        {
            [sender setTag:2];
            [sender setImage:[UIImage imageNamed:@"login_weixuanze"] forState:UIControlStateNormal];
            
        }
            break;
        case 2:
        {
            [sender setTag:1];
            [sender setImage:[UIImage imageNamed:@"login_xuanze"] forState:UIControlStateNormal];
        }
            break;
    }
}
//注册请求
- (void)nextBtnAction
{
    if (self.index == 1)
    {
        if (self.accountView.valueString.length == 0)
        {
            [MBProgressHUD showError:SSKJLocalized(@"请输入正确的手机号", nil)];
            return;
        }
    }
    if (self.index == 2)
    {
        if (![RegularExpression validateEmail:self.accountView.valueString])
        {
            [MBProgressHUD showError:SSKJLocalized(@"请输入正确的邮箱", nil)];
            return;
        }
    }
    
    
    if (self.codeView.valueString.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入验证码", nil)];
        return;
    }
    if (![RegularExpression validatePassword:self.pwdBgView.valueString])
    {
        [MBProgressHUD showError:SSKJLocalized(@"密码提示", nil)];
        
        return;
    }
    if (![self.pwdBgView.valueString isEqualToString:self.twoPwdBgView.valueString]
        ) {
        [MBProgressHUD showError:SSKJLocalized(@"两次密码输入不一致", nil)];
        return;
    }
    if (self.yaoqingBgView.valueString.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入邀请码", nil)];
        return;
    }
    
    [self requestRegisterUrl];
}



#pragma mark - Getter / Setter
-(UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc]init];
        [_tipLabel setText:SSKJLanguage(@"手机注册")];
        [_tipLabel setFont:systemFont(ScaleW(24))];
        [_tipLabel setTextColor:kTitleColor];
    }
    return _tipLabel;
}

-(UIButton *)switchBtn
{
    if (!_switchBtn)
    {
        _switchBtn = [[UIButton alloc]init];
        [_switchBtn setTitle:SSKJLanguage(@"切换邮箱注册") forState:UIControlStateNormal];
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


- (SSKJ_TextFieldView *)pwdBgView
{
    if (_pwdBgView == nil)
    {
        _pwdBgView = [[SSKJ_TextFieldView alloc] initWithType:2];
        [_pwdBgView setImageName:@"login_pwd" placeholder:SSKJLanguage(@"请输入密码 ") secureTextEntry:YES];
    }
    return _pwdBgView;
}





- (SSKJ_TextFieldView *)twoPwdBgView
{
    if (_twoPwdBgView == nil)
    {
        _twoPwdBgView = [[SSKJ_TextFieldView alloc] initWithType:2];
        [_twoPwdBgView setImageName:@"login_pwd" placeholder:SSKJLanguage(@"请再次输入密码") secureTextEntry:YES];
    }
    return _twoPwdBgView;
}


- (SSKJ_TextFieldView *)yaoqingBgView
{
    if (_yaoqingBgView == nil)
    {
        _yaoqingBgView = [[SSKJ_TextFieldView alloc] initWithType:2];
        [_yaoqingBgView setImageName:@"login_yq" placeholder:SSKJLanguage(@"请输入邀请码") secureTextEntry:NO];
    }
    return _yaoqingBgView;
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
        [_commitBtn setTitle:SSKJLanguage(@"注册") forState:UIControlStateNormal];
        [_commitBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_commitBtn.titleLabel setFont:systemFont(ScaleW(14))];
        [_commitBtn setBackgroundColor:kBlueColor];
        [_commitBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBtn;
}


- (UIButton *)tongyiBtn
{
    if (_tongyiBtn == nil)
    {
        
        _tongyiBtn = [[UIButton alloc]init];
        [_tongyiBtn addTarget:self action:@selector(tongyiBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_tongyiBtn setImage:[UIImage imageNamed:@"login_xuanze"] forState:UIControlStateNormal];
        [_tongyiBtn setTag:1];
    }
    return _tongyiBtn;
}

- (UIButton *)xieyiBtn
{
    if (_xieyiBtn == nil)
    {
        _xieyiBtn = [FactoryUI createButtonWithFrame:CGRectMake(self.tongyiBtn.maxX, self.tongyiBtn.y, ScaleW(100), ScaleW(20)) title:SSKJLocalized(@"点击注册即表示同意《用户注册协议》", nil) titleColor:kSubTitleColor imageName:@"" backgroundImageName:nil target:self selector:@selector(xieyiBtnAcion) font:systemFont(ScaleW(12))];
    }
    return _xieyiBtn;
}



-(UIButton *)noAccountBtn
{
    if (!_noAccountBtn)
    {
        _noAccountBtn = [[UIButton alloc]init];
        [_noAccountBtn setTitle:SSKJLanguage(@"已有账号,") forState:UIControlStateNormal];
        [_noAccountBtn setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        [_noAccountBtn.titleLabel setFont:systemFont(ScaleW(13))];
        [_noAccountBtn addTarget:self action:@selector(backBtClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noAccountBtn;
}


-(UIButton *)registeBtn
{
    if (!_registeBtn)
    {
        _registeBtn = [[UIButton alloc]init];
        [_registeBtn setTitle:SSKJLanguage(@"立即登录") forState:UIControlStateNormal];
        [_registeBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
        [_registeBtn.titleLabel setFont:systemFont(ScaleW(13))];
        [_registeBtn addTarget:self action:@selector(backBtClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registeBtn;
}


#pragma mark - NetWork Method 网络请求
// 获取手机验证码
-(void)requestSmsCode:(NSString*)account
{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = account;
    params[@"from"] = @"register";

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
    params[@"from"] = @"register";
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


//注册请求
- (void)requestRegisterUrl
{
    NSString *account;
    switch (self.index)
    {
        case 1:
        {
            account = @"phone";
        }
            break;
        case 2:
        {
            account = @"email";
        }
            break;
    }

    
    
    if (self.tongyiBtn.tag == 2)
    {
        [MBProgressHUD showError:@"请阅读并同意协议"];
        return;
    }
    
    
    
    
    NSDictionary *params = @{@"area_code":@"86",
                            account:self.accountView.valueString,
                            @"code":self.codeView.valueString,
                            @"recommend":self.yaoqingBgView.valueString,
                            @"password":self.pwdBgView.valueString,
                            @"password_confirmation":
                                 self.twoPwdBgView.valueString,
                            };

    NSLog(@"%@",params);
    
    
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_Register_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {

        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];

        if (netModel.status.integerValue == SUCCESSED)
        {
            if (weakSelf.registerSuccessBlock)
            {
                weakSelf.registerSuccessBlock(weakSelf.accountView.field.text);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
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


@end
