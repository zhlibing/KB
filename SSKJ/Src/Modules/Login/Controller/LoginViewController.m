//
//  LoginViewController.m
//  SSKJ
//
//  Created by zpz on 2019/8/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTextFieldView.h"
#import "RegisterViewController.h"
#import "Login_Google_AlertView.h"
#import "AESCrypt.h"

#import "AppDelegate.h"
#import "Login_Type_Option.h"
#import "SSKJ_TabbarController.h"

#import "Lion_Forget_ViewController.h"

@interface LoginViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *welcomeLabel;
@property (nonatomic, strong) SSKJ_TextFieldView *accountView;
@property (nonatomic, strong) SSKJ_TextFieldView *pwdView;
@property (nonatomic, strong) UIButton *forgetBtn;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) UIButton *noAccountBtn;
@property (nonatomic, strong) UIButton *registeBtn;


@property (nonatomic, strong) SSKJ_Login_Model *loginModel;
@property (nonatomic, strong) Login_Google_AlertView *googleAlertView;
@property (nonatomic, strong) SSKJ_AreaCode_View *areaView;
@property (nonatomic, strong) Login_Type_Option *segmentControl;

@end

@implementation LoginViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.welcomeLabel];
    [self.view addSubview:self.accountView];
    [self.view addSubview:self.pwdView];
    [self.view addSubview:self.forgetBtn];
    [self.view addSubview:self.commitBtn];
    [self.view addSubview:self.noAccountBtn];
    [self.view addSubview:self.registeBtn];
    
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view.mas_top).offset(ScaleW(90));
        make.left.equalTo(self.view.mas_left).offset(ScaleW(20));
    }];
    
    [self.welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.titleLabel.mas_bottom).offset(ScaleW(10));
        make.left.equalTo(self.titleLabel);
    }];
    
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.welcomeLabel.mas_bottom).offset(ScaleW(40));
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(ScaleW(50)));
    }];
    
    
    
    [self.pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.accountView.mas_bottom).offset(ScaleW(20));
        make.left.height.right.equalTo(self.accountView);
        
    }];
    
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.pwdView.mas_bottom).offset(ScaleW(10));
        make.right.equalTo(self.view.mas_right).offset(-ScaleW(20));
        
    }];
    
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        
        make.top.equalTo(self.pwdView.mas_bottom).offset(ScaleW(70));
        make.left.equalTo(self.view.mas_left).offset(ScaleW(15));
        make.right.equalTo(self.view.mas_right).offset(-ScaleW(15));
        make.height.equalTo(@(ScaleW(45)));
        
    }];
    
    [self.noAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.commitBtn.mas_bottom).offset(ScaleW(20));
        make.left.equalTo(self.commitBtn.mas_left);
    }];
    
    [self.registeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.noAccountBtn.mas_right);
        make.centerY.equalTo(self.noAccountBtn.mas_centerY);
    }];
    
    
    
}

-(void)leftBtnAction:(id)sender
{
    [self goHome];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self addLeftNavItemWithImage:[UIImage imageNamed:@"root_back_w"]];

}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
//    self.navigationController.navigationBar.hidden = NO;

}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return NO;
}

- (void)backBtnAction{
    
    if (self.isLoginOut) {
        
        [self goHome];
        
    }else{

        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


- (void)goHome
{    
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([vc isKindOfClass:[SSKJ_TabbarController class]] && self.isLoginOut)
    {
        SSKJ_TabbarController *tabbVc = (SSKJ_TabbarController *)vc;
        tabbVc.selectedIndex = 0;
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


#pragma mark 注册
- (void)topButtonClick
{
    RegisterViewController *vc = [RegisterViewController new];
    WS(weakSelf);
    vc.registerSuccessBlock = ^(NSString * _Nonnull account) {
        weakSelf.accountView.field.text = account;
    };
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark 忘记密码
- (void)forgetBtnAction
{
    Lion_Forget_ViewController *vc = [Lion_Forget_ViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark 提交登录
- (void)commitBtnAction
{
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    
    
    if (!self.accountView.field.text.length) {
        [MBProgressHUD showError:self.accountView.field.placeholder];
        return;
    }
    
    if (![WLTools validateEmail:self.accountView.field.text] && ![RegularExpression validateMobile:self.accountView.field.text]) {
        [MBProgressHUD showError:SSKJLanguage(@"手机号或邮箱格式错误")];
        return;
    }
    
    if (self.pwdView.field.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入8-20位字母与数字组合", nil)];
        return;
    }
    
    if (![RegularExpression validatePassword:self.pwdView.field.text]) {
        [MBProgressHUD showError:SSKJLocalized(@"密码格式错误", nil)];
        return;
    }
    
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        params[@"username"] = self.accountView.field.text;
        
        params[@"password"] = self.pwdView.field.text;
        WS(weakSelf);
        
        
        [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_Login_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
            
            [hud hideAnimated:YES];
            
            WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
            
            if (netModel.status.integerValue == SUCCESSED)                    {
                //                    weakSelf.login_dic = json;
                [weakSelf.view endEditing:YES];
                SSKJ_Login_Model *loginModel = [SSKJ_Login_Model mj_objectWithKeyValues:netModel.data];
                
                weakSelf.loginModel = loginModel;
                [weakSelf handleLoginData:loginModel];
                
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

-(void)handleLoginData:(SSKJ_Login_Model *)loginModel
{
    
    // 登录的账号（手机或邮箱）
    [kUserDefaults setObject:self.accountView.field.text forKey:@"kAccount"];
    [kUserDefaults setObject:@(1) forKey:@"kLogin"];
    
    [[SSKJ_User_Tool sharedUserTool]saveLoginInfoWithLoginModel:loginModel];
    
    [self goHome];
}







#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:systemBoldFont(ScaleW(24))];
        [_titleLabel setTextColor:kTitleColor];
        [_titleLabel setText:SSKJLanguage(@"登录Okoex")];
    }
    return _titleLabel;
}


-(UILabel *)welcomeLabel
{
    if (!_welcomeLabel)
    {
        _welcomeLabel = [[UILabel alloc]init];
        [_welcomeLabel setFont:systemFont(ScaleW(12))];
        [_welcomeLabel setTextColor:kSubTitleColor];
        [_welcomeLabel setText:SSKJLanguage(@"欢迎登录")];
    }
    return _welcomeLabel;
}


-(UIButton *)noAccountBtn
{
    if (!_noAccountBtn)
    {
        _noAccountBtn = [[UIButton alloc]init];
        [_noAccountBtn setTitle:SSKJLanguage(@"没有账号？") forState:UIControlStateNormal];
        [_noAccountBtn setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        [_noAccountBtn.titleLabel setFont:systemFont(ScaleW(13))];
        [_noAccountBtn addTarget:self action:@selector(topButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noAccountBtn;
}


-(UIButton *)registeBtn
{
    if (!_registeBtn)
    {
        _registeBtn = [[UIButton alloc]init];
        [_registeBtn setTitle:SSKJLanguage(@"立即注册") forState:UIControlStateNormal];
        [_registeBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
        [_registeBtn.titleLabel setFont:systemFont(ScaleW(13))];
        [_registeBtn addTarget:self action:@selector(topButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registeBtn;
}



- (UIButton *)forgetBtn
{
    if (_forgetBtn == nil) {
        _forgetBtn = [WLTools allocButton:SSKJLanguage(@"忘记密码?") textColor:kSubTitleColor nom_bg:nil hei_bg:nil frame:CGRectZero];
        _forgetBtn.titleLabel.font = kFont(14);
        [_forgetBtn addTarget:self action:@selector(forgetBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
}

- (UIButton *)commitBtn
{
    if (_commitBtn == nil) {
        _commitBtn = [WLTools allocButton:SSKJLanguage(@"登录") textColor:kWhiteColor nom_bg:nil hei_bg:nil frame:CGRectZero];
        _commitBtn.backgroundColor = kBlueColor;
        _commitBtn.titleLabel.font = kFont(16);
        [_commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _commitBtn.layer.masksToBounds = YES;
        _commitBtn.layer.cornerRadius = ScaleW(5);
    }
    return _commitBtn;
}


- (SSKJ_TextFieldView *)accountView
{
    if (_accountView == nil) {
        _accountView = [[SSKJ_TextFieldView alloc] initWithType:2];
        [_accountView setImageName:@"login_account" placeholder:SSKJLanguage(@"请输入手机号码或邮箱") secureTextEntry:NO];
    }
    return _accountView;
}

- (SSKJ_TextFieldView *)pwdView{
    if (_pwdView == nil) {
        _pwdView = [[SSKJ_TextFieldView alloc] initWithType:2];
        [_pwdView setImageName:@"login_pwd" placeholder:SSKJLanguage(@"请输入8-20位登录密码") secureTextEntry:YES];
    }
    return _pwdView;
}







@end
