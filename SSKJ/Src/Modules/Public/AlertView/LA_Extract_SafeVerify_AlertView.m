//
//  LA_Extract_SafeVerify_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/7/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "LA_Extract_SafeVerify_AlertView.h"
#import "SSKJ_TextFieldView.h"


@interface LA_Extract_SafeVerify_AlertView ()

@property (nonatomic, strong) UIView *boardView; //!< 承载面板
@property (nonatomic, strong) SSKJ_TextFieldView *codeView;  //!< 短信或者邮箱验证
@property (nonatomic, strong) SSKJ_TextFieldView *gooleCodeView; //!< 谷歌验证码
@property (nonatomic, strong) UIButton *codeButton;  //!< 短信或者邮箱验证
@property (nonatomic, strong) UIButton *submitButton; //!< 提交按钮
@property (nonatomic, strong) UILabel *titleLabel; //!< 安全验证
@property (nonatomic, strong) UILabel *leftTipLabel; //!< 请输入
@property (nonatomic, strong) UILabel *middleTipLabel; //!<  手机号或者邮箱
@property (nonatomic, strong) UILabel *rightTipLabel; //!< 收到的短信验证码

@property (nonatomic, strong) void (^submitBlock)(NSString *code);








@end
@implementation LA_Extract_SafeVerify_AlertView


+(void)showsubmitBlock:(void(^)(NSString *code))submitBlcok
{
    LA_Extract_SafeVerify_AlertView *alert = [[LA_Extract_SafeVerify_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    

    
    if ([RegularExpression validateEmail:kAccount])
    {
        [alert.middleTipLabel setText:[WLTools hideEmailWithEmail:kAccount]];
    }
    else
    {
        [alert.middleTipLabel setText:[WLTools hidePhoneMiddleNumberWithMobile:kAccount]];
    }
    [alert.boardView byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(10, 10)];
    alert.submitBlock = submitBlcok;
    [alert show];
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        [self addSubview:self.boardView];
        [self.boardView addSubview:self.titleLabel];
        [self.boardView addSubview:self.leftTipLabel];
        [self.boardView addSubview:self.middleTipLabel];
        
        [self.boardView addSubview:self.rightTipLabel];
        
        [self.boardView addSubview:self.codeView];
        [self.codeView addSubview:self.codeButton];
        [self.boardView addSubview:self.submitButton];
        
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.boardView.mas_top).offset(35);
            make.left.equalTo(self.boardView.mas_left).offset(15);
            
        }];
        
        [self.leftTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.titleLabel.mas_bottom).offset(25);
            make.left.equalTo(self.titleLabel);
        }];
        
        
        [self.middleTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(self.leftTipLabel);
            make.left.equalTo(self.leftTipLabel.mas_right).offset(2);
            
        }];
        
        
        [self.rightTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.leftTipLabel);
            make.left.equalTo(self.middleTipLabel.mas_right).offset(2);
        }];
        
        
        [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.leftTipLabel.mas_bottom).offset(15);
            make.left.equalTo(self.boardView.mas_left);
            make.right.equalTo(self.boardView.mas_right);
            make.height.equalTo(@(80));
        }];
        
        [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.codeView.backView.mas_right).offset(-10);
            make.centerY.equalTo(self.codeView.backView.mas_centerY);
            make.height.equalTo(@(40));
        }];
        
        

        [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.codeView.mas_bottom).offset(40);
            make.right.equalTo(self.boardView.mas_right).offset(-15);
            make.left.equalTo(self.titleLabel);
            make.height.equalTo(@(45));
        }];
        
        
        
        
        
        
        
        
        // 添加通知监听见键盘弹出/退出// 键盘出现的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
        // 键盘消失的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
        [self addTarget:self action:@selector(tapEvent) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}






-(UIView *)boardView
{
    if (nil == _boardView)
    {
        _boardView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 350)];
        [_boardView setBackgroundColor:kBgColor];
    }
    return _boardView;
}








-(UILabel *)titleLabel
{
    if (nil == _titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setText:SSKJLanguage(@"安全验证")];
        [_titleLabel setFont:systemBoldFont(ScaleW(16))];
        [_titleLabel setTextColor:kTitleColor];
    }
    return _titleLabel;
}

-(UILabel *)leftTipLabel
{
    if (nil == _leftTipLabel)
    {
        _leftTipLabel = [[UILabel alloc]init];
        [_leftTipLabel setText:SSKJLanguage(@"请输入")];
        [_leftTipLabel setFont:systemFont(ScaleW(14))];
        [_leftTipLabel setTextColor:kTitleColor];
    }
    return _leftTipLabel;
}


-(UILabel *)middleTipLabel
{
    if (nil == _middleTipLabel)
    {
        _middleTipLabel = [[UILabel alloc]init];
        [_middleTipLabel setFont:systemFont(ScaleW(14))];
        [_middleTipLabel setTextColor:kBlueColor];
    }
    return _middleTipLabel;
}


-(UILabel *)rightTipLabel
{
    if (nil == _rightTipLabel)
    {
        _rightTipLabel = [[UILabel alloc]init];
        [_rightTipLabel setText:SSKJLanguage(@"收到的验证码")];
        [_rightTipLabel setFont:systemFont(ScaleW(14))];
        [_rightTipLabel setTextColor:kTitleColor];
    }
    return _rightTipLabel;
}

-(SSKJ_TextFieldView *)codeView
{
    if (nil == _codeView)
    {

        _codeView = [[SSKJ_TextFieldView alloc] init];
        [_codeView setTitle:SSKJLanguage(@"验证码") placeholder:SSKJLanguage(@"请输入验证码") secureTextEntry:NO];
    }
    return _codeView;
}



- (SSKJ_TextFieldView *)gooleCodeView
{
    if (nil == _gooleCodeView)
    {

        _gooleCodeView = [[SSKJ_TextFieldView alloc] init];
        [_gooleCodeView setTitle:SSKJLanguage(@"谷歌验证码") placeholder:SSKJLanguage(@"请输入6位数谷歌验证码") secureTextEntry:NO];
    }
    return _gooleCodeView;
}


- (UIButton *)codeButton
{
    if (!_codeButton)
    {
        _codeButton = [[UIButton alloc]init];
        [_codeButton.titleLabel setFont:systemFont(ScaleW(15))];
        [_codeButton setTitle:SSKJLanguage(@"获取验证码") forState:UIControlStateNormal];
        [_codeButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        [_codeButton addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeButton;
}



- (UIButton *)submitButton
{
    if (!_submitButton)
    {
        _submitButton = [[UIButton alloc]init];
        [_submitButton setTitle:SSKJLanguage(@"提交") forState:UIControlStateNormal];
        [_submitButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
        [_submitButton setBackgroundColor:kBlueColor];
        [_submitButton setCornerRadius:ScaleW(5)];
    }
    return _submitButton;
}






#pragma mark - Private Method
-(void)show
{
    [AppWindow addSubview:self];
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        
        [weakSelf.boardView setY:(ScreenHeight - 350)];
    }];
}

// 隐藏
-(void)hide
{
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        
        [weakSelf.boardView setY:ScreenHeight];
        
    } completion:^(BOOL finished)
    {
        [weakSelf removeFromSuperview];
    }];    
}


-(void)confirmEvent
{
    if (self.codeView.valueString.length == 0)
    {
           [MBProgressHUD showError:SSKJLocalized(@"请输入短信验证码", nil)];
    }

    
    if (self.submitBlock)
    {
        self.submitBlock(self.codeView.valueString);
    }
    
    [self hide];
}


-(void)endEditEvent
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

-(void)tapEvent
{
    if ([self.codeView.field isFirstResponder] || [self.gooleCodeView.field isFirstResponder])
    {
        [self endEditEvent];
        return;
    }
    
    [self hide];
}



// 获取短信验证码
-(void)getCode
{
    if ([RegularExpression validateEmail:kAccount])
    {
        [self requestEmailCode];
    }
    else
    {
        [self requestSmsCode];
    }
}


#pragma mark -键盘监听方法
- (void)keyboardWasShown:(NSNotification *)notification
{
    UIView *backView;
    
    if (self.gooleCodeView.field.isFirstResponder) {
        backView = self.gooleCodeView;
    }
    else
    {
        backView = self.codeView;
    }
    // 获取键盘的高度
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat textFieldY = ScreenHeight - (ScreenHeight - self.boardView.height / 2 + backView.bottom);
    
    if (frame.size.height > textFieldY)
    {
        CGFloat yscale = frame.size.height - textFieldY;
        self.boardView.y = ScreenHeight - self.boardView.height / 2 - yscale;
    }
    
}


- (void)keyboardWillBeHiden:(NSNotification *)notification
{
    self.boardView.y = self.height - self.boardView.height;;
}



#pragma mark - 请求手机验证码

#pragma mark --- 网络请求 ---
// 获取手机验证码
-(void)requestSmsCode
{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = kAccount;
    params[@"type"] = @"4";

    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_GetSmsCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED)
        {
            [weakSelf endEditing:YES];
            [WLTools countDownWithButton:weakSelf.codeButton];
            
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
- (void)requestEmailCode
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"email"] = kAccount;
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_GetEmailCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED)
        {
            [weakSelf endEditing:YES];
            [WLTools countDownWithButton:weakSelf.codeButton];
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



