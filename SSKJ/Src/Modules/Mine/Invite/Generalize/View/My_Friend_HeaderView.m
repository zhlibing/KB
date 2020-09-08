//
//  My_Friend_HeaderView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Friend_HeaderView.h"

@interface My_Friend_HeaderView ()

@property (nonatomic, strong) UILabel *numberTipLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIView *lineView;


@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *bottomLineView;
@end

@implementation My_Friend_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.numberTipLabel];
        [self addSubview:self.numberLabel];
        [self addSubview:self.lineView];
        
        [self addSubview:self.nameLabel];
        [self addSubview:self.phoneLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.bottomLineView];
        
        
        [self.numberTipLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left).offset(ScaleW(15));
            make.height.equalTo(@(50));
        }];
        
        
        
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.top.equalTo(self.numberTipLabel);
            make.right.equalTo(self.mas_right).offset(-ScaleW(15));
            make.height.equalTo(self.numberTipLabel);
        }];
        
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.top.equalTo(self.numberTipLabel.mas_bottom);
            make.left.right.equalTo(@(0));
            make.height.equalTo(@(10));
        }];
        
        
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.equalTo(self.lineView.mas_bottom);
            make.left.equalTo(self.mas_left).offset(ScaleW(15));
            make.width.equalTo(@(ScaleW(90)));
            make.height.equalTo(@(45));
        }];
        
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.equalTo(self.nameLabel);
            make.left.equalTo(@(ScaleW(115)));
            make.width.equalTo(@(ScaleW(145)));
            make.height.equalTo(self.nameLabel);

        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.equalTo(self.nameLabel);
            make.right.equalTo(self.mas_right).offset(-ScaleW(15));
            make.height.equalTo(self.nameLabel);
        }];
        
        [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.left.right.equalTo(self.lineView);
            make.bottom.equalTo(self.mas_bottom);
            make.height.equalTo(@(0.3));
        }];
    }
    return self;
}










#pragma mark - Getter / Setter
-(UILabel *)numberTipLabel
{
    if (!_numberTipLabel)
    {
        _numberTipLabel = [[UILabel alloc]init];
        [_numberTipLabel setFont:systemFont(ScaleW(14))];
        [_numberTipLabel setTextColor:kSubTitleColor];
        [_numberTipLabel setText:SSKJLanguage(@"累计开户")];
    }
    return _numberTipLabel;
}


-(UILabel *)numberLabel
{
    if (!_numberLabel)
    {
        _numberLabel = [[UILabel alloc]init];
        [_numberLabel setFont:systemFont(ScaleW(14))];
        [_numberLabel setTextColor:kTitleColor];
        [_numberLabel setText:@"32人"];
    }
    return _numberLabel;
}


-(UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:kLineColor];
    }
    return _lineView;
}





-(UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc]init];
        [_nameLabel setFont:systemFont(ScaleW(13))];
        [_nameLabel setTextColor:kSubTitleColor];
        [_nameLabel setText:SSKJLanguage(@"名称")];
    }
    return _nameLabel;
}


-(UILabel *)phoneLabel
{
    if (!_phoneLabel)
    {
        _phoneLabel = [[UILabel alloc]init];
        [_phoneLabel setFont:systemFont(ScaleW(13))];
        [_phoneLabel setTextColor:kSubTitleColor];
        [_phoneLabel setText:SSKJLanguage(@"手机号码/邮箱地址")];
    }
    return _phoneLabel;
}


-(UILabel *)timeLabel
{
    if (!_timeLabel)
    {
        _timeLabel = [[UILabel alloc]init];
        [_timeLabel setFont:systemFont(ScaleW(13))];
        [_timeLabel setTextColor:kSubTitleColor];
        [_timeLabel setText:SSKJLanguage(@"注册时间")];
    }
    return _timeLabel;
}


-(UIView *)bottomLineView
{
    if (!_bottomLineView)
    {
        _bottomLineView = [[UIView alloc]init];
        [_bottomLineView setBackgroundColor:kLineColor];
    }
    return _bottomLineView;
}




@end
