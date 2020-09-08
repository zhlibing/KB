//
//  My_Yuanli_HeaderView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/25.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Yuanli_HeaderView.h"

@interface My_Yuanli_HeaderView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *yesterdayTipLabel;
@property (nonatomic, strong) UILabel *yesterdayNumberLabel;
@property (nonatomic, strong) UILabel *totalTipLabel;
@property (nonatomic, strong) UILabel *totalNumberLabel;







@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *bottomLineview;





@end

@implementation My_Yuanli_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.tipLabel];
        [self.bgView addSubview:self.yesterdayTipLabel];
        [self.bgView addSubview:self.yesterdayNumberLabel];
        [self.bgView addSubview:self.totalTipLabel];
        [self.bgView addSubview:self.totalNumberLabel];
        
        
        [self addSubview:self.typeLabel];
        [self addSubview:self.numLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.bottomLineview];
        
        
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(ScaleW(10), ScaleW(10), ScaleW(50), ScaleW(10)));
        }];
        
        
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.top.equalTo(self.bgView.mas_top).offset(ScaleW(20));
            make.left.equalTo(self.bgView.mas_left).offset(ScaleW(25));
        }];
        
        [self.yesterdayNumberLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.top.equalTo(self.tipLabel.mas_bottom).offset(ScaleW(25));
            make.left.equalTo(self.tipLabel.mas_left);
        }];
        
        [self.yesterdayTipLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.top.equalTo(self.yesterdayNumberLabel.mas_bottom).offset(ScaleW(13));
            make.left.equalTo(self.tipLabel.mas_left);
        }];
        
        
        
        [self.totalNumberLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.top.equalTo(self.yesterdayNumberLabel.mas_top);
            make.left.equalTo(self.bgView.mas_centerX).offset(ScaleW(10));
        }];
        
        
        [self.totalTipLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.top.equalTo(self.yesterdayTipLabel.mas_top);
            make.left.equalTo(self.totalNumberLabel.mas_left);
        }];
        
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.top.equalTo(self.bgView.mas_bottom).offset(ScaleW(5));
            make.left.equalTo(self.bgView.mas_left);
            make.height.equalTo(@(ScaleW(45)));
        }];
        
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.top.height.equalTo(self.typeLabel);
            make.right.equalTo(self.mas_centerX);
        }];

        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.top.height.equalTo(self.typeLabel);
            make.right.equalTo(self.bgView.mas_right);
        }];
        
        [self.bottomLineview mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.left.right.bottom.equalTo(@(0));
            make.height.equalTo(@(0.3));
        }];
    }
    return self;
}




#pragma mark - Getter / Setter
-(UIView *)bgView
{
    if (!_bgView)
    {
        _bgView = [[UIView alloc]init];
        [_bgView setBackgroundColor:UIColorFromRGB(0xF1F3F6)];
        [_bgView setCornerRadius:ScaleW(5)];
    }
    return _bgView;
}


-(UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc]init];
        [_tipLabel setFont:systemFont(ScaleW(14))];
        [_tipLabel setTextColor:kSubTitleColor];
        [_tipLabel setText:SSKJLanguage(@"账户佣金明细")];
    }
    return _tipLabel;
}


-(UILabel *)yesterdayTipLabel
{
    if (!_yesterdayTipLabel)
    {
        _yesterdayTipLabel = [[UILabel alloc]init];
        [_yesterdayTipLabel setFont:systemFont(ScaleW(13))];
        [_yesterdayTipLabel setTextColor:kSubTitleColor];
        [_yesterdayTipLabel setText:SSKJLanguage(@"昨日返佣(USDT）")];
    }
    return _yesterdayTipLabel;
}


-(UILabel *)yesterdayNumberLabel
{
    if (!_yesterdayNumberLabel)
    {
        _yesterdayNumberLabel = [[UILabel alloc]init];
        [_yesterdayNumberLabel setFont:systemBoldFont(ScaleW(20))];
        [_yesterdayNumberLabel setTextColor:kTitleColor];
        [_yesterdayNumberLabel setText:@"0.00"];
    }
    return _yesterdayNumberLabel;
}


-(UILabel *)totalTipLabel
{
    if (!_totalTipLabel)
    {
        _totalTipLabel = [[UILabel alloc]init];
        [_totalTipLabel setFont:systemFont(ScaleW(13))];
        [_totalTipLabel setTextColor:kSubTitleColor];
        [_totalTipLabel setText:SSKJLanguage(@"累计返佣(USDT）")];
    }
    return _totalTipLabel;
}

-(UILabel *)totalNumberLabel
{
    if (!_totalNumberLabel)
    {
        _totalNumberLabel = [[UILabel alloc]init];
        [_totalNumberLabel setFont:systemBoldFont(ScaleW(20))];
        [_totalNumberLabel setTextColor:kTitleColor];
        [_totalNumberLabel setText:@"0.00"];
    }
    return _totalNumberLabel;
}




-(UILabel *)typeLabel
{
    if (nil == _typeLabel)
    {
        _typeLabel = [WLTools allocLabel:SSKJLocalized(@"名称", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), 0, ScaleW(96), self.height) textAlignment:NSTextAlignmentLeft];
    }
    return _typeLabel;
}

-(UILabel *)numLabel
{
    if (nil == _numLabel)
    {
        _numLabel = [WLTools allocLabel:SSKJLocalized(@"佣金", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(self.typeLabel.right, 0, 10, self.height) textAlignment:NSTextAlignmentLeft];
    }
    return _numLabel;
}


-(UILabel *)timeLabel
{
    if (nil == _timeLabel)
    {
        _timeLabel = [WLTools allocLabel:SSKJLocalized(@"返佣时间", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(self.numLabel.right, 0, 10, self.height) textAlignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}

-(UIView *)bottomLineview
{
    if (!_bottomLineview)
    {
        _bottomLineview = [[UIView alloc]init];
        [_bottomLineview setBackgroundColor:kLineColor];
    }
    return _bottomLineview;
}


@end
