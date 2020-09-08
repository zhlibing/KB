//
//  HEYueBoardHeaderView.m
//  SSKJ
//
//  Created by 姚立志 on 2020/8/11.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "HEYueBoardHeaderView.h"


@interface HEYueBoardHeaderView ()

@property (nonatomic, strong) UILabel *dongTaiNumberLabel;
@property (nonatomic, strong) UILabel *dongTaiTipLabel;

@property (nonatomic, strong) UILabel *fudongNumberLabel;
@property (nonatomic, strong) UILabel *fudongTipLabel;

@property (nonatomic, strong) UILabel *fengXianNumberLabel;
@property (nonatomic, strong) UILabel *fengXianTipLabel;

@property (nonatomic, strong) UILabel *markLabel;



@end


@implementation HEYueBoardHeaderView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:kBgColor];
        [self addSubview:self.dongTaiNumberLabel];
        [self addSubview:self.dongTaiTipLabel];
        [self addSubview:self.fudongNumberLabel];
        [self addSubview:self.fudongTipLabel];
        [self addSubview:self.fengXianNumberLabel];
        [self addSubview:self.fengXianTipLabel];
        [self addSubview:self.markLabel];
        
        
        [self.dongTaiNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(10);
            
        }];
        
        [self.dongTaiTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.dongTaiNumberLabel.mas_bottom).offset(10);
            make.left.equalTo(self.dongTaiNumberLabel);
            
        }];
        
        
        [self.fudongNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(self.dongTaiNumberLabel);
            make.centerX.equalTo(self.mas_centerX);
            
        }];
        
        [self.fudongTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {

            make.centerY.equalTo(self.dongTaiTipLabel.mas_centerY);
            make.centerX.equalTo(self.mas_centerX);
            
        }];
        
        
        [self.fengXianNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.centerY.equalTo(self.dongTaiNumberLabel);
            
        }];
        
        
        [self.fengXianTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.fengXianNumberLabel);
            make.centerY.equalTo(self.dongTaiTipLabel);
        }];
        
        
        
        [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(self.fengXianTipLabel.mas_centerY);
            make.right.equalTo(self.fengXianTipLabel.mas_left).offset(-10);
            make.width.height.equalTo(@(15));
        }];

        
    }
    return self;
}




- (void)setModel:(Heyue_OrderInfo_Model *)model
{
    _model = model;
    [self.dongTaiNumberLabel setText:model.totalusdt];
    [self.fudongNumberLabel setText:model.yingkui];
    [self.fengXianNumberLabel setText:model.risk];
}


#pragma mark - Private Method
- (void)createbaocangAlertView
{
    if (self.leverageModel.bc_rate.length == 0)
    {
        return;
    }
    
    [SSKJ_Default_AlertView showWithTitle:SSKJLocalized(@"风险率提醒", nil) message:[NSString stringWithFormat:SSKJLocalized(@"当风险率小于等于%@%%时，系统将自动平仓", nil),self.leverageModel.bc_rate] cancleTitle:@"" confirmTitle:SSKJLocalized(@"确定", nil) confirmBlock:^{
        
    }];
}



#pragma mark - Getter / Setter
-(UILabel *)dongTaiNumberLabel
{
    if (!_dongTaiNumberLabel)
    {
        _dongTaiNumberLabel = [[UILabel alloc]init];
        [_dongTaiNumberLabel setTextColor:kTitleColor];
        [_dongTaiNumberLabel setFont:systemFont(ScaleW(16))];
        [_dongTaiNumberLabel setText:@"--"];
    }
    return _dongTaiNumberLabel;
}


-(UILabel *)dongTaiTipLabel
{
    if (!_dongTaiTipLabel)
    {
        _dongTaiTipLabel = [[UILabel alloc]init];
        [_dongTaiTipLabel setTextColor:kSubTitleColor];
        [_dongTaiTipLabel setFont:systemFont(ScaleW(13))];
        [_dongTaiTipLabel setText:SSKJLanguage(@"动态权益")];
    }
    return _dongTaiTipLabel;
}





-(UILabel *)fudongNumberLabel
{
    if (!_fudongNumberLabel)
    {
        _fudongNumberLabel = [[UILabel alloc]init];
        [_fudongNumberLabel setTextColor:kTitleColor];
        [_fudongNumberLabel setFont:systemFont(ScaleW(16))];
        [_fudongNumberLabel setText:@"--"];
    }
    return _fudongNumberLabel;
}



-(UILabel *)fudongTipLabel
{
    if (!_fudongTipLabel)
    {
        _fudongTipLabel = [[UILabel alloc]init];
        [_fudongTipLabel setTextColor:kSubTitleColor];
        [_fudongTipLabel setFont:systemFont(ScaleW(13))];
        [_fudongTipLabel setText:SSKJLanguage(@"浮动盈亏")];
    }
    return _fudongTipLabel;
}



-(UILabel *)fengXianNumberLabel
{
    if (!_fengXianNumberLabel)
    {
        _fengXianNumberLabel = [[UILabel alloc]init];
        [_fengXianNumberLabel setTextColor:kTitleColor];
        [_fengXianNumberLabel setFont:systemFont(ScaleW(16))];
        [_fengXianNumberLabel setText:@"--"];
    }
    return _fengXianNumberLabel;
}



-(UILabel *)fengXianTipLabel
{
    if (!_fengXianTipLabel)
    {
        _fengXianTipLabel = [[UILabel alloc]init];
        [_fengXianTipLabel setTextColor:kSubTitleColor];
        [_fengXianTipLabel setFont:systemFont(ScaleW(13))];
        [_fengXianTipLabel setText:SSKJLanguage(@"风险率")];
        [_fengXianTipLabel setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createbaocangAlertView)];
        [_fengXianTipLabel addGestureRecognizer:tap];
        
    }
    return _fengXianTipLabel;
}

-(UILabel *)markLabel
{
    if (!_markLabel)
    {
        _markLabel = [[UILabel alloc]init];
        [_markLabel setTextColor:kWhiteColor];
        [_markLabel setBackgroundColor:UIColorFromRGB(0xB3B7C0)];
        [_markLabel setTextAlignment:NSTextAlignmentCenter];
        [_markLabel setFont:systemFont(10)];
        [_markLabel setText:@"?"];
        [_markLabel setCornerRadius:7.5];
        [_markLabel setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createbaocangAlertView)];
        [_markLabel addGestureRecognizer:tap];
    }
    return _markLabel;
}






@end
