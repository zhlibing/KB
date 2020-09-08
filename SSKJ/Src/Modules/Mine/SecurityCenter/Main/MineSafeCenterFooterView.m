//
//  MineSafeCenterFooterView.m
//  SSKJ
//
//  Created by SSKJ on 2020/2/21.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "MineSafeCenterFooterView.h"

@implementation MineSafeCenterFooterView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.tipLabel];
        [self addSubview:self.loginPwdView];
        [self addSubview:self.payPwdView];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.top.equalTo(self.mas_top).offset(ScaleW(25));
            make.left.equalTo(self.mas_left).offset(ScaleW(15));
    
            
        }];
        
        [self.loginPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.tipLabel.mas_bottom).offset(ScaleW(10));
            make.left.right.equalTo(self);
            make.height.equalTo(@(ScaleW(56)));
            
            
        }];
        
        [self.payPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
           
           
            make.top.equalTo(self.loginPwdView.mas_bottom); make.left.height.right.equalTo(self.loginPwdView);
        }];
        
        
        
    }
    return self;
}


/// 设置用户信息
/// @param userinfo SSKJ_UserInfo_Model 用户对象
-(void)setUserInfo:(SSKJ_UserInfo_Model*)userinfo;
{
    NSString *status = (userinfo.config.payment_password_set.integerValue == 1) ? SSKJLocalized(@"已设置", nil) : SSKJLocalized(@"未设置", nil);
    [self.payPwdView.statusLabel setText:status];
}



#pragma mark - Getter / Setter
-(UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc]init];
        [_tipLabel setTextColor:kSubTitleColor];
        [_tipLabel setFont:systemFont(ScaleW(14))];
        [_tipLabel setText:SSKJLanguage(@"密码设置")];
    }
    return _tipLabel;
}

-(MineSafeCenterFooterItemView *)loginPwdView
{
    if (!_loginPwdView)
    {
        _loginPwdView = [[MineSafeCenterFooterItemView alloc]init];
        [_loginPwdView.cellTitleLabel setText:SSKJLanguage(@"登录密码")];
        [_loginPwdView.statusLabel setText:SSKJLanguage(@"已设置")];
    }
    return _loginPwdView;
}

-(MineSafeCenterFooterItemView *)payPwdView
{
    if (!_payPwdView)
    {
        _payPwdView = [[MineSafeCenterFooterItemView alloc]init];
        [_payPwdView.cellTitleLabel setText:SSKJLanguage(@"资金密码")];
        [_payPwdView.statusLabel setText:SSKJLanguage(@"未设置")];
    }
    return _payPwdView;
}





@end
