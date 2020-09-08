//
//  MineSafeCenterHeaderView.m
//  SSKJ
//
//  Created by SSKJ on 2020/2/21.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "MineSafeCenterHeaderView.h"

@interface MineSafeCenterHeaderView ()

@property (nonatomic, strong) UILabel *safeTipLabel; //!< 安全提示标签
@property (nonatomic, strong) UILabel *safeLevelLabel; //!< 安全级别标签
@property (nonatomic, strong) UIView *safeBgLevelView; //!< 安全低级别标签
@property (nonatomic, strong) UIView *safeInstructionsLevelView; //!< 安全级别标签

@property (nonatomic, strong) UILabel *moreTipLabel; //!< 多重验证提示标签

@end


@implementation MineSafeCenterHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        [self addSubview:self.safeTipLabel];
        [self addSubview:self.safeLevelLabel];
        [self addSubview:self.safeBgLevelView];
        [self addSubview:self.safeInstructionsLevelView];
        [self addSubview:self.moreTipLabel];
        
        [self.safeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.mas_top).offset(ScaleW(ScaleW(30)));
            make.left.equalTo(self.mas_left).offset(ScaleW(15));

        }];
        
        
        [self.safeLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.safeTipLabel.mas_top);
            make.left.equalTo(self.safeTipLabel.mas_right).offset(ScaleW(10));
            
        }];
        
        
        [self.safeBgLevelView setFrame:CGRectMake(ScaleW(15), ScaleW(69), ScreenWidth-ScaleW(30), 5)];
        
        
        
    
        [self.moreTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.safeBgLevelView.mas_bottom).offset(ScaleW(18));
            make.left.equalTo(self.safeTipLabel.mas_left);
            
        }];
        

        
        
    }
    return self;
}


/// 设置用户信息
/// @param userinfo SSKJ_UserInfo_Model 用户对象
-(void)setUserInfo:(SSKJ_UserInfo_Model*)userinfo
{
    
    BOOL BindPhone = NO;
    BOOL BindEmail = NO;
    BOOL BindAuthentication = NO;
    
    
    BindPhone = [RegularExpression validateMobile:userinfo.phone];
    BindEmail = [WLTools validateEmail:userinfo.email];
    
    
    
    if (userinfo.authentication.integerValue == 3)
    {
        BindAuthentication = YES;
    }
    
    if (BindPhone && BindEmail && BindAuthentication)
    {
        [self.safeLevelLabel setText:SSKJLanguage(@"高")];
        [self.safeInstructionsLevelView setFrame:CGRectMake(self.safeBgLevelView.x, self.safeBgLevelView.y, self.safeBgLevelView.width, self.safeBgLevelView.height)];
        
    }
    else if ((BindPhone & BindEmail) || (BindPhone && BindAuthentication) || (BindEmail && BindAuthentication))
    {
        [self.safeLevelLabel setText:SSKJLanguage(@"中")];
        [self.safeInstructionsLevelView setFrame:CGRectMake(self.safeBgLevelView.x, self.safeBgLevelView.y, (((ScreenWidth-ScaleW(30))/3)*2), self.safeBgLevelView.height)];
        
    }
    else if (BindPhone || BindEmail || BindAuthentication)
    {
        [self.safeLevelLabel setText:SSKJLanguage(@"低")];
        [self.safeInstructionsLevelView setFrame:CGRectMake(self.safeBgLevelView.x, self.safeBgLevelView.y, (((ScreenWidth-ScaleW(30))/3.0)*1), self.safeBgLevelView.height)];
    }
}


#pragma mark - Getter / Setter
-(UILabel *)safeTipLabel
{
    if (!_safeTipLabel)
    {
        _safeTipLabel  = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLanguage(@"安全级别") textColor:kBlueColor font:systemFont(ScaleW(14))];
    }
    return _safeTipLabel;
}

-(UILabel *)safeLevelLabel
{
    if (!_safeLevelLabel)
    {
        _safeLevelLabel  = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLanguage(@"低") textColor:UIColorFromRGB(0x2FE091) font:systemFont(ScaleW(14))];
    }
    return _safeLevelLabel;
}

-(UIView *)safeBgLevelView
{
    if (!_safeBgLevelView)
    {
        _safeBgLevelView = [[UIView alloc]init];
        [_safeBgLevelView setBackgroundColor:kLineColor];
    }
    return _safeBgLevelView;
}

-(UIView *)safeInstructionsLevelView
{
    if (!_safeInstructionsLevelView)
    {
        _safeInstructionsLevelView = [[UIView alloc]init];
        [_safeInstructionsLevelView setBackgroundColor:kBlueColor];
    }
    return _safeInstructionsLevelView;
}


-(UILabel *)moreTipLabel
{
    if (!_moreTipLabel)
    {
        _moreTipLabel  = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLanguage(@"请至少开启两项安全验证") textColor:kBlueColor font:systemFont(ScaleW(10))];
    }
    return _moreTipLabel;
}


@end
