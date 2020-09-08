//
//  My_BindGoogle_AlertView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_BindGoogle_AlertView.h"

@interface My_BindGoogle_AlertView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *googleView;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIView *phoneView;
@property (nonatomic, strong) UILabel *phoneTitleLabel;
@property (nonatomic, strong) UITextField *iphoneTextField;
@property (nonatomic, strong) UIButton *smsCodeButton;
@property (nonatomic, strong) UIButton *submiteButton;

@property (nonatomic ,assign) CGFloat keyBoardHeight;


@end
@implementation My_BindGoogle_AlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
        [self setUI];
    }
    return self;
}

#pragma mark - UI
-(void)setUI
{
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.titleLabel];
    
    self.googleView = [self addInputViewWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleW(15), ScreenWidth, ScaleW(88)) title:SSKJLocalized(@"谷歌验证码", nil) placeHolder:SSKJLocalized(@"请输入谷歌验证码", nil) keyBoardType:UIKeyboardTypeASCIICapable withType:1];
    
    [self.alertView addSubview:self.googleView];
    
    self.phoneView = [self addInputViewWithFrame:CGRectMake(0, self.googleView.bottom , ScreenWidth, ScaleW(88)) title:SSKJLanguage(@"验证手机") placeHolder:SSKJLanguage(@"请输入手机验证码") keyBoardType:UIKeyboardTypeASCIICapable withType:2];
    
    [self.alertView addSubview:self.phoneView];
    [self.alertView addSubview:self.submiteButton];
    
    self.alertView.height = self.submiteButton.bottom + ScaleW(27);
    
    
    //添加键盘通知
    [self addKeyBoardNotification];
    
}

-(UIView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, ScreenWidth, 0)];
        [_alertView setBackgroundColor:UIColorFromRGB(0x081724)];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
        [_alertView addGestureRecognizer:tap];
        
//        _alertView.cornerRadius = ScaleW(<#width#>)
    }
    return _alertView;
}

- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:@"" font:systemBoldFont(ScaleW(15)) textColor:kBlueColor frame:CGRectMake(ScaleW(15), ScaleW(24), ScreenWidth, ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UIView *)addInputViewWithFrame:(CGRect )frame title:(NSString *)title placeHolder:(NSString *)placeHolder keyBoardType:(UIKeyboardType)keyBoardType withType:(NSInteger)type
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = UIColorFromRGB(0x081724);
    self.phoneTitleLabel = [WLTools allocLabel:title font:systemFont(ScaleW(13)) textColor:kBlueColor frame:CGRectMake(ScaleW(12), ScaleW(20), ScaleW(200), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    [view addSubview:self.phoneTitleLabel];
    
    
    
    switch (type)
    {
        case 1:
        {
            self.codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.phoneTitleLabel.x, self.phoneTitleLabel.bottom + ScaleW(14), ScaleW(200), ScaleW(40))];
           self.codeTextField.textColor = kBlueColor;
           self.codeTextField.font = systemFont(ScaleW(15));
           self.codeTextField.placeholder = placeHolder;
           self.codeTextField.keyboardType = keyBoardType;
            [self.codeTextField setPlaceholder:placeHolder];
           self.codeTextField.delegate = self;
           [view addSubview:self.codeTextField];
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.codeTextField.x, self.codeTextField.bottom, view.width - ScaleW(24), 1)];
            lineView.backgroundColor = kLineColor;
            [view addSubview:lineView];
        }
            break;
        case 2:
        {
            self.iphoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.phoneTitleLabel.x, self.phoneTitleLabel.bottom + ScaleW(14), ScaleW(200), ScaleW(40))];
           self.iphoneTextField.textColor = kBlueColor;
           self.iphoneTextField.font = systemFont(ScaleW(15));
           self.iphoneTextField.placeholder = placeHolder;
           self.iphoneTextField.keyboardType = keyBoardType;
            [self.iphoneTextField setPlaceholder:placeHolder];
           self.iphoneTextField.delegate = self;
           [view addSubview:self.iphoneTextField];
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.iphoneTextField.x, self.iphoneTextField.bottom, view.width - ScaleW(24), 1)];
              lineView.backgroundColor = kLineColor;
              [view addSubview:lineView];
            
            
            
            self.smsCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(12) - ScaleW(100), 0, ScaleW(100), ScaleW(30))];
                    self.smsCodeButton.centerY = self.codeTextField.centerY;
                    [self.smsCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
                    [self.smsCodeButton setTitleColor:kBlueColor forState:UIControlStateNormal];
                    self.smsCodeButton.titleLabel.font = systemFont(ScaleW(12.5));
                    self.smsCodeButton.layer.masksToBounds = YES;
                    self.smsCodeButton.layer.cornerRadius = self.smsCodeButton.height / 2;
            //        self.smsCodeButton.layer.borderColor = kBlueColor.CGColor;
            //        self.smsCodeButton.layer.borderWidth = 1;
                    [self.smsCodeButton addTarget:self action:@selector(getSmsCodeEvent) forControlEvents:UIControlEventTouchUpInside];
                    [self.smsCodeButton setBackgroundImage:[UIImage imageNamed:@"Public_Btn_Img"] forState:UIControlStateNormal];

                    [view addSubview:self.smsCodeButton];
        }
            break;
    }
    return view;

}

-(UIButton *)submiteButton
{
    if (nil == _submiteButton) {
        _submiteButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(12), self.phoneView.bottom + ScaleW(38), ScreenWidth - ScaleW(24), ScaleW(45))];
        _submiteButton.layer.cornerRadius = ScaleW(3);
        _submiteButton.backgroundColor = kBlueColor;
        [_submiteButton setTitle:SSKJLocalized(@"提交", nil) forState:UIControlStateNormal];
        [_submiteButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        _submiteButton.titleLabel.font = systemFont(ScaleW(16));
        [_submiteButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];

    }
    return _submiteButton;
}



- (void)setShowWithType:(MyGOOGLETYPE)showWithType
{
    _showWithType = showWithType;
    [self.smsCodeButton setHidden:YES];
    [self.codeTextField setText:@""];
    [self.iphoneTextField setText:@""];
    
    
    NSString *title = SSKJLocalized(@"验证手机", nil);
    NSString *placeHolder = SSKJLocalized(@"请输入手机验证码", nil);
    NSString *string = SSKJLocalized(@"绑定谷歌验证", nil);
    
    switch (showWithType)
    {
        case MyGOOGLETYPEDELETE:
        {
            string = SSKJLocalized(@"关闭谷歌验证", nil);
            title = SSKJLocalized(@"资金密码", nil);
            placeHolder = SSKJLocalized(@"请输入资金密码", nil);
            [self.iphoneTextField setSecureTextEntry:YES];
        }
            break;
        case MyGOOGLETYPEADD:
        {
            string = SSKJLocalized(@"绑定谷歌验证", nil);
            [self.smsCodeButton setHidden:NO];
            if ([RegularExpression validateEmail:kAccount])
            {
                title = SSKJLocalized(@"验证邮箱", nil);
                placeHolder = SSKJLocalized(@"请输入邮箱验证码", nil);
            }
            else
            {
                placeHolder = SSKJLocalized(@"请输入手机验证码", nil);
                string = SSKJLocalized(@"绑定谷歌验证", nil);
            }
            [self.iphoneTextField setSecureTextEntry:NO];
        }
            break;
        case MyGOOGLETYPEOPEN:
        {
            string = SSKJLocalized(@"开启谷歌验证", nil);
            title = SSKJLocalized(@"资金密码", nil);
            placeHolder = SSKJLocalized(@"请输入资金密码", nil);
            [self.iphoneTextField setSecureTextEntry:YES];
        }
            break;
    }
    
    [self.phoneTitleLabel setText:title];
    [self.iphoneTextField setPlaceholder:placeHolder];
    
    self.titleLabel.text = string;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.y = weakSelf.height -weakSelf.alertView.height;
    }];
}


-(void)hide
{
    
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.y = weakSelf.height;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
    
    //移除监听
    [self removeKeyBoardNotification];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hide];
}

#pragma mark - 用户操作
-(void)getSmsCodeEvent
{
    
    if ([RegularExpression validateMobile:kAccount] )
    {
        [self requestSmsCode];
    }
    else
    {
        [self requestEmailCode];
    }
}




-(void)submitEvent
{
    if (self.codeTextField.text.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入谷歌验证码", nil)];
        return;
    }
    
    
    NSString *title = SSKJLocalized(@"请输入手机验证码", nil);
    if ([RegularExpression validateEmail:kAccount])
    {
        title = SSKJLocalized(@"请输入邮箱验证码", nil);
    }
    
    
    NSString *type = @"";
    switch (self.showWithType)
    {
        case MyGOOGLETYPEDELETE:
        {
            type = @"stop";
        }
            break;
        case MyGOOGLETYPEADD:
        {
            type = @"随便写";
        }
            break;
        case MyGOOGLETYPEOPEN:
        {
            type = @"start";
        }
            break;
    }
    
    if (self.iphoneTextField.text.length == 0)
    {
        [MBProgressHUD showError:title];
        return;
    }
    
    if (self.submitBlock)
    {
        self.submitBlock([NSString stringWithFormat:@"%@",self.codeTextField.text], [NSString stringWithFormat:@"%@",self.iphoneTextField.text],type);
    }
    [self hide];
}

#pragma mark - 请求验证码
#pragma mark 获取短信验证码
- (void)requestSmsCode
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    NSDictionary *params = @{@"area_code":@"+86",@"phone":kAccount};
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GetSmsCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == 200)
        {
            [MBProgressHUD showError:SSKJLocalized(@"发送成功", nil)];
            [self changeCheckcodeButtonState];
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
    {
        [hud hideAnimated:YES];
    }];
}

#pragma mark 获取邮件验证
- (void)requestEmailCode
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    NSDictionary *params = @{@"email":kAccount,@"is_app":@"1"};
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GetEmailCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == 200) {
            [self changeCheckcodeButtonState];
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
    }];
}


// 倒计时
- (void)changeCheckcodeButtonState {
    __block int timeout= 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.smsCodeButton setTitle:SSKJLocalized(@"重新发送", nil) forState:UIControlStateNormal];
                self.smsCodeButton.enabled = YES;
                
            });
            
        }else{
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%d%@", seconds, SSKJLocalized(@"秒后重新发送", nil)];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.smsCodeButton setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateDisabled];
                self.smsCodeButton.enabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}

#pragma mark - textFildDelegate

- (void) textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"开始编辑");
    //获取键盘高度
    
    //调整fram
}




- (void) addKeyBoardNotification{
    
   
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification * _Nonnull note) {
//        NSLog(@"open :%@ \n%@", note.object, note.userInfo);
        //获取金盘高度
        NSValue *value = [note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect frame = value.CGRectValue;
        self.keyBoardHeight = frame.size.height;
        self.alertView.bottom = ScreenHeight - self.keyBoardHeight;
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification * _Nonnull note) {
        self.alertView.centerY += self.keyBoardHeight;
    }];
}
- (void) removeKeyBoardNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



@end
