//
//  My_GoogleVerify_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_GoogleVerify_ViewController.h"
#import "My_BindGoogle_AlertView.h"
#import "SSKJ_TextFieldView.h"
#import "My_Google_Model.h"

@interface My_GoogleVerify_ViewController ()


@property (nonatomic, strong) UILabel *warningLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *qrCodeImageView;
@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, strong) UIButton *copyButton;
@property (nonatomic, strong) SSKJ_TextFieldView *googleCodeView;
@property (nonatomic, strong) UIButton *nextButton;



@property (nonatomic, strong) My_BindGoogle_AlertView *alertView;

@property (nonatomic, strong) My_Google_Model *googleModel;


@end

@implementation My_GoogleVerify_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = SSKJLocalized(@"绑定谷歌验证器", nil);
    
    self.view.backgroundColor = kBgColor;
    
    [self addSubViews:YES];
    
    [self requestGoogle];
}


-(void)addSubViews:(BOOL)views
{
    if (views)
    {
        [self.view addSubview:self.warningLabel];
        [self.view addSubview:self.titleLabel];
        [self.view addSubview:self.qrCodeImageView];
        [self.view addSubview:self.codeLabel];
        [self.view addSubview:self.copyButton];
        [self.view addSubview:self.googleCodeView];
        [self.view addSubview:self.nextButton];
        
        
        
        [self.warningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.view.mas_top).offset(Height_NavBar+30);
            make.left.equalTo(self.view.mas_left).offset(15);
            make.right.equalTo(self.view.mas_right).offset(-15);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.warningLabel.mas_bottom).offset(50);
            make.centerX.equalTo(self.view.mas_centerX);
            
        }];
        
        
        [self.qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.titleLabel.mas_bottom).offset(30);
            make.width.height.equalTo(@(180));
            make.centerX.equalTo(self.view.mas_centerX);
            
        }];
        
        [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.qrCodeImageView.mas_bottom).offset(40);
            make.centerX.equalTo(self.qrCodeImageView.mas_centerX).offset(-30);
            
        }];
        
        [self.copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.codeLabel.mas_right).offset(5);
            make.centerY.equalTo(self.codeLabel.mas_centerY);
            
        }];
        
        [self.googleCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.codeLabel.mas_bottom).offset(60);
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(80));
            
        }];

        
        [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.googleCodeView.mas_bottom).offset(20);
            make.left.right.equalTo(self.warningLabel);
            make.height.equalTo(@(ScaleW(45)));
        }];
        
        
        
         if ([RegularExpression validateMobile:kAccount])
           {
//               [self.phoneTipLabel setText:[NSString stringWithFormat:@"%@ :%@",SSKJLanguage(@"手机号"),[RegularExpression mobilebyReplacingInRange:kAccount]]];
           }
           else
           {
//               [self.phoneTipLabel setText:[NSString stringWithFormat:@"%@ :%@",SSKJLanguage(@"邮箱"),kAccount]];
           }
    }
}






-(UILabel *)warningLabel
{
    if (nil == _warningLabel)
    {
        NSString *string = SSKJLocalized(@"打开谷歌验证器，扫描下方二维码或手动输入下述秘钥添加验证令牌。秘钥用户邮寄更换或遗失时找回谷歌验证器，绑定前请务必将下述秘钥备份保存。", nil);
        _warningLabel = [WLTools allocLabel:string font:systemFont(ScaleW(12)) textColor:UIColorFromRGB(0x666666) frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _warningLabel.numberOfLines = 0;
    }
    return _warningLabel;
}



-(UILabel *)titleLabel
{
    if (nil == _titleLabel)
    {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"请妥善备份秘钥以防遗失",nil) font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UIImageView *)qrCodeImageView
{
    if (nil == _qrCodeImageView)
    {
        _qrCodeImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _qrCodeImageView.backgroundColor = [UIColor whiteColor];
    }
    return _qrCodeImageView;
}

-(UILabel *)codeLabel
{
    if (nil == _codeLabel)
    {
        _codeLabel = [WLTools allocLabel:@"HDFLJDADF" font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
    }
    return _codeLabel;
}

-(UIButton *)copyButton
{
    if (nil == _copyButton)
    {
        _copyButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_copyButton setTitle:SSKJLocalized(@"复制",nil) forState:UIControlStateNormal];
        [_copyButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        _copyButton.titleLabel.font = systemFont(ScaleW(14));
        [_copyButton addTarget:self action:@selector(copyButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _copyButton;
}



-(SSKJ_TextFieldView *)googleCodeView
{
    if (!_googleCodeView)
    {
        _googleCodeView = [[SSKJ_TextFieldView alloc]init];
        [_googleCodeView setTitle:SSKJLanguage(@"谷歌验证码") placeholder:SSKJLanguage(@"请输入6位验证码") secureTextEntry:NO];
    }
    return _googleCodeView;
}






-(UIButton *)nextButton
{
    if (nil == _nextButton)
    {
        _nextButton = [[UIButton alloc]initWithFrame:CGRectZero];
        _nextButton.layer.cornerRadius = ScaleW(3);
        _nextButton.backgroundColor = kBlueColor;
        [_nextButton setTitle:SSKJLocalized(@"立即开启",nil) forState:UIControlStateNormal];
        [_nextButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _nextButton.titleLabel.font = systemFont(ScaleW(16));
        [_nextButton addTarget:self action:@selector(nextEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

-(My_BindGoogle_AlertView *)alertView
{
    if (nil == _alertView)
    {
        _alertView = [[My_BindGoogle_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        WS(weakSelf);
        _alertView.submitBlock = ^(NSString * _Nonnull googleCode, NSString * _Nonnull smsCode,NSString *type)
        {
            [weakSelf requestGoogleCommandWithCode:smsCode withGoogleCode:googleCode];
        };
    }
    return _alertView;
}

#pragma mark - Private Method
#pragma mark 获取验证码逻辑处理
-(void)smsButtonEvent
{
    if ([RegularExpression validateMobile:kAccount])
    {
        [self requestSMSCode];
    }
    else
    {
        [self requestEmailCode];
    }
}


#pragma mark 短信验证码
- (void)requestSMSCode
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *params = @{@"phone":kAccount,@"area_code":[SSKJ_User_Tool sharedUserTool].userInfoModel.area_code};
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GetSmsCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == 200)
        {
            [MBProgressHUD showError:netModel.msg];
            WS(weakSelf);
            [weakSelf changeCheckcodeButtonState];
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
    }];
}

#pragma mark 邮箱验证码
- (void)requestEmailCode
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = @{@"email":kAccount};
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GetEmailCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == 200)
        {
            [self changeCheckcodeButtonState];
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
    }];
}


#pragma mark 倒计时
- (void)changeCheckcodeButtonState
{
    [WLTools countDownWithButton:self.nextButton];
}


#pragma mark 绑定谷歌验证器
-(void)nextEvent
{

//    [self.alertView setShowWithType:MyGOOGLETYPEADD];
    
    [self requestGoogleCommandWithCode:self.codeLabel.text withGoogleCode:self.googleCodeView.valueString];
}


#pragma mark  复制 谷歌秘钥码
-(void)copyButtonEvent
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.codeLabel.text];
    [MBProgressHUD showSuccess:SSKJLocalized(@"复制成功",nil)];
}




#pragma mark 复制谷歌验证
// 复制
-(void)dumplcationEvent
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.googleModel.secret;
    [MBProgressHUD showSuccess:SSKJLocalized(@"复制成功",nil)];
}


#pragma mark - 网络请求
#pragma mark 请求谷歌二维码图片和私钥
-(void)requestGoogle
{
    WS(weakSelf);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:CreateGoogleCommand RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject)
    {
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == 200)
        {
            My_Google_Model *googleModel = [My_Google_Model mj_objectWithKeyValues:[netModel.data objectForKey:@"createSecret"]];
            [weakSelf setViewWithGoogleModel:googleModel];
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
    }];
    
}


#pragma mark 绑定谷歌验证器
-(void)requestGoogleCommandWithCode:(NSString *)code withGoogleCode:(NSString *)googleCode
{
    if (googleCode.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入谷歌验证码", nil)];
        return;
    }
    else if (code.length == 0)
    {
       [MBProgressHUD showError:SSKJLocalized(@"请输入验证码", nil)];
       return;
        
    }
    
    NSDictionary *params = @{@"google_code":googleCode,
                             @"google_secret":self.codeLabel.text
                             };
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:CheckGoogleCommand RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        [hud hideAnimated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == 200)
        {
            if (weakSelf.addGoogleBlock)
            {
                weakSelf.addGoogleBlock();
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
    {
        [hud hideAnimated:YES];
    }];
    
}

-(void)setViewWithGoogleModel:(My_Google_Model *)googleModel
{
    self.googleModel = googleModel;
    
    [self.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:googleModel.codeurl ]];
    self.codeLabel.text = googleModel.secret;
}



@end
