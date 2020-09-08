//
//  Lion_Forget_SetViewController.m
//  SSKJ
//
//  Created by cy5566 on 2020/3/13.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "Lion_Forget_SetViewController.h"
#import "LoginViewController.h"
#import "Login_Google_AlertView.h"
#import "Mine_TitleAndInput_View.h"


@interface Lion_Forget_SetViewController ()




@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) SSKJ_TextFieldView *accountView;
@property (nonatomic, strong) SSKJ_TextFieldView *codeView;
@property (nonatomic, strong) UIButton *commitBtn;




@end

@implementation Lion_Forget_SetViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];;
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.accountView];
    [self.view addSubview:self.codeView];
    [self.view addSubview:self.commitBtn];
    
    
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(ScaleW(130));
        make.left.equalTo(self.view.mas_left).offset(ScaleW(20));
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
    
    
    
    
    
    
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.codeView.mas_bottom).offset(ScaleW(36));
        make.left.equalTo(self.view.mas_left).offset(ScaleW(15));
        make.right.equalTo(self.view.mas_right).offset(-ScaleW(15));
        make.height.equalTo(@(ScaleW(45)));
        
    }];
}



-(void)setAccount:(NSString *)account
{
    _account = account;
    
    if ([RegularExpression validateMobile:account])
    {
        [self.titleLabel setText:SSKJLanguage(@"手机找回")];
    }
    else if ([RegularExpression validateEmail:account])
    {
        [self.titleLabel setText:SSKJLanguage(@"邮箱找回")];
    }
}

#pragma mark - Private Method
#pragma mark 重置密码
- (void)commitBtnAction
{
    if (self.codeView.valueString.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入新登录密码", nil)];
        return;
    }
    
    if (![RegularExpression validatePassword:self.codeView.valueString])
    {
           [MBProgressHUD showError:SSKJLocalized(@"密码格式不正确", nil)];
           return;
       }
    
    if (self.codeView.valueString.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请再次输入登录密码", nil)];
        return;
    }
    
    if (![self.accountView.valueString isEqualToString:self.codeView.valueString])
    {
        [MBProgressHUD showError:SSKJLocalized(@"两次密码输入不一致", nil)];
        return;
    }
    
    
    [self forgetRequset];
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




- (SSKJ_TextFieldView *)accountView
{
    if (_accountView == nil)
    {
        _accountView = [[SSKJ_TextFieldView alloc] initWithType:2];
        [_accountView setImageName:@"login_pwd" placeholder:SSKJLanguage(@"请输入8-20位字母与数字组合") secureTextEntry:YES];
    }
    return _accountView;
}





- (SSKJ_TextFieldView *)codeView
{
    if (_codeView == nil)
    {
        _codeView = [[SSKJ_TextFieldView alloc] initWithType:2];
        [_codeView setImageName:@"login_pwd" placeholder:SSKJLanguage(@"请再次输入新密码") secureTextEntry:YES];
    }
    return _codeView;
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

- (void)forgetRequset
{
    
    NSDictionary *params = nil;
    
    if ([WLTools validateEmail:self.account])
    {
        params = @{
            @"email":self.account,
            @"code":self.code,
            @"password":self.accountView.valueString,
            @"password_confirmation":self.codeView.valueString,
        };
    }
    else
    {
        params = @{
            @"phone":self.account,
            @"code":self.code,
            @"password":self.accountView.valueString,
            @"password_confirmation":self.codeView.valueString,

        };
    }
       
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        WS(weakSelf);
        
        [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_ForgetPWD_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
            
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            
            WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
            
            if (netModel.status.integerValue == SUCCESSED)        {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:responseObject[@"msg"]];
                    // 重新去登录一次新密码
                    [self popToLoginVc];
                });
            }
            else
            {
                [MBProgressHUD showError:responseObject[@"msg"]];
            }
        } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
            [MBProgressHUD showError:SSKJLocalized(SSKJLocalized(@"网络出错", nil), nil)];
            
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        }];
}







-(void)popToLoginVc
{
    for (SSKJ_BaseViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[LoginViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
}

@end
