//
//  ChargeRecord_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/16.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "ChargeRecord_Cell.h"

@interface ChargeRecord_Cell ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *addressTitleLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *numberTitleLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *timeTitleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *describeTitleLabel;
@property (nonatomic, strong) UILabel *describeLabel;


@end

@implementation ChargeRecord_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = kBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.addressTitleLabel];
        [self.contentView addSubview:self.addressLabel];
        [self.contentView addSubview:self.numberTitleLabel];
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.timeTitleLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.describeTitleLabel];
        [self.contentView addSubview:self.describeLabel];
        
        [self.addressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView.mas_left).offset(ScaleW(15));
            make.top.equalTo(self.contentView.mas_top).offset(ScaleW(15));
            make.width.equalTo(@(ScaleW(100)));
        }];
        
        
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.addressTitleLabel.mas_right).offset(ScaleW(10));
            make.right.equalTo(self.contentView.mas_right).offset(-ScaleW(5));
            make.height.equalTo(@(ScaleW(40)));
            make.centerY.equalTo(self.addressTitleLabel);
        }];
        
        
        [self.numberTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.addressTitleLabel.mas_bottom).offset(ScaleW(10));
            make.left.equalTo(self.addressTitleLabel);
            
        }];
        
        
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.equalTo(self.addressLabel);
            make.centerY.equalTo(self.numberTitleLabel);
        }];
        
        
        
        
        
        [self.timeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.addressTitleLabel);
            make.top.equalTo(self.numberTitleLabel.mas_bottom).offset(ScaleW(10));
            
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.equalTo(self.addressLabel);
            make.centerY.equalTo(self.timeTitleLabel);
        }];
        
        
        [self.describeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.addressTitleLabel);
            make.top.equalTo(self.timeTitleLabel.mas_bottom).offset(ScaleW(10));
            
        }];
        
        [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.equalTo(self.addressLabel);
            make.centerY.equalTo(self.describeTitleLabel);
            
        }];
        
        
        
        
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
           
            make.left.right.bottom.equalTo(self.contentView);
            make.height.equalTo(@(ScaleW(0.5)));
        }];
        
        
        
        
    }
    return self;
}


-(UIView *)lineView
{
    if (nil == _lineView)
    {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}

- (UILabel *)addressTitleLabel
{
    if (nil == _addressTitleLabel)
    {
        _addressTitleLabel = [[UILabel alloc]init];
        [_addressTitleLabel setFont:systemFont(ScaleW(14))];
        [_addressTitleLabel setText:SSKJLanguage(@"充币地址")];
        [_addressTitleLabel setTextColor:kSubTitleColor];
    }
    return _addressTitleLabel;
}


- (UILabel *)addressLabel
{
    if (nil == _addressLabel)
    {
        _addressLabel = [[UILabel alloc]init];
        [_addressLabel setFont:systemFont(ScaleW(14))];
        [_addressLabel setTextColor:kTitleColor];
        [_addressLabel setNumberOfLines:0];

    }
    return _addressLabel;
}


- (UILabel *)numberTitleLabel
{
    if (nil == _numberTitleLabel) {
        _numberTitleLabel = [[UILabel alloc]init];
        [_numberTitleLabel setFont:systemFont(ScaleW(14))];
        [_numberTitleLabel setText:SSKJLanguage(@"充币数量")];
        [_numberTitleLabel setTextColor:kSubTitleColor];
    }
    return _numberTitleLabel;
}


- (UILabel *)numberLabel
{
    if (nil == _numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        [_numberLabel setFont:systemFont(ScaleW(14))];
        [_numberLabel setTextColor:kTitleColor];
    }
    return _numberLabel;
}


- (UILabel *)timeTitleLabel
{
    if (nil == _timeTitleLabel) {
        _timeTitleLabel = [[UILabel alloc]init];
        [_timeTitleLabel setFont:systemFont(ScaleW(14))];
        [_timeTitleLabel setText:SSKJLanguage(@"充币时间")];
        [_timeTitleLabel setTextColor:kSubTitleColor];
    }
    return _timeTitleLabel;
}


- (UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        [_timeLabel setFont:systemFont(ScaleW(14))];
        [_timeLabel setTextColor:kTitleColor];
    }
    return _timeLabel;
}



- (UILabel *)describeTitleLabel
{
    if (nil == _describeTitleLabel)
    {
        _describeTitleLabel = [[UILabel alloc]init];
        [_describeTitleLabel setFont:systemFont(ScaleW(14))];
        [_describeTitleLabel setText:SSKJLanguage(@"描述")];
        [_describeTitleLabel setTextColor:kSubTitleColor];
    }
    return _describeTitleLabel;
}


- (UILabel *)describeLabel
{
    if (nil == _describeLabel)
    {
        _describeLabel = [[UILabel alloc]init];
        [_describeLabel setFont:systemFont(ScaleW(14))];
        [_describeLabel setTextColor:kTitleColor];
    }
    return _describeLabel;
}




-(void)setCellWithModel:(ATEX_Charge_IndexModel *)model
{
    
    NSInteger type = model.type.integerValue;
    if (type == 1)
    {
        self.describeLabel.text = SSKJLocalized(@"后台充值", nil);

    }
    else if (type == 2)
    {
        self.describeLabel.text = SSKJLocalized(@"在线充值", nil);
    }
    
    
    self.numberLabel.text = [NSString stringWithFormat:@"%@%@",[WLTools noroundingStringWith:model.money.doubleValue afterPointNumber:2],model.code];
    self.timeLabel.text = model.created_at;
    [self.addressLabel setText:model.wallet_address];

    
}




@end
