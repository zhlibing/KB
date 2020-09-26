//
//  ExtractRecord_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/16.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "ExtractRecord_Cell.h"
@interface ExtractRecord_Cell ()


@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *addressTitleLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *numberTitleLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *feeTitleLabel;
@property (nonatomic, strong) UILabel *feeLabel;
@property (nonatomic, strong) UILabel *timeTitleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *checkTitleLabel; // 审核时间
@property (nonatomic, strong) UILabel *checkLabel;



@property (nonatomic, strong) UIImageView *refuseImageView;
@property (nonatomic, strong) UILabel *refuseLabel;
@property (nonatomic, strong) UIView *lineView;





@end
@implementation ExtractRecord_Cell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.backView];
        [self.backView addSubview:self.addressTitleLabel];
        [self.backView addSubview:self.addressLabel];
        [self.backView addSubview:self.numberTitleLabel];
        [self.backView addSubview:self.numberLabel];
        [self.backView addSubview:self.feeTitleLabel];
        [self.backView addSubview:self.feeLabel];
        [self.backView addSubview:self.timeTitleLabel];
        [self.backView addSubview:self.timeLabel];
        [self.backView addSubview:self.checkTitleLabel];
        [self.backView addSubview:self.checkLabel];
        [self.backView addSubview:self.lineView];
        [self.backView addSubview:self.refuseImageView];
        [self.backView addSubview:self.statusLabel];
        [self.backView addSubview:self.refuseLabel];

    }
    return self;
}


-(UIView *)backView
{
    if (nil == _backView)
    {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth , ScaleW(185))];
        _backView.backgroundColor = kBgColor;
    }
    return _backView;
}

- (UILabel *)addressTitleLabel
{
    if (nil == _addressTitleLabel) {
        
        NSString *lan = [[SSKJLocalized sharedInstance]currentLanguage];
        CGFloat width = ScaleW(60);
        if ([lan containsString:@"en"]) {
            width = ScaleW(100);
        }
        
        _addressTitleLabel = [WLTools allocLabel:SSKJLocalized(@"提币地址", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), ScaleW(15), width, ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        _addressTitleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _addressTitleLabel;
}


- (UILabel *)addressLabel
{
    if (nil == _addressLabel) {
        _addressLabel = [WLTools allocLabel:SSKJLocalized(@"----", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.addressTitleLabel.right + ScaleW(10),self.addressTitleLabel.y, self.backView.width - ScaleW(25) - self.addressTitleLabel.right, ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        _addressLabel.centerY = self.addressTitleLabel.centerY;
        _addressLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _addressLabel;
}


- (UILabel *)numberTitleLabel
{
    if (nil == _numberTitleLabel) {
        _numberTitleLabel = [WLTools allocLabel:SSKJLocalized(@"提币数量", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.addressTitleLabel.bottom + ScaleW(13), self.addressTitleLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _numberTitleLabel.adjustsFontSizeToFitWidth = YES;

    }
    return _numberTitleLabel;
}


- (UILabel *)numberLabel
{
    if (nil == _numberLabel) {
        _numberLabel = [WLTools allocLabel:SSKJLocalized(@"----", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.addressLabel.x, self.numberTitleLabel.y, self.addressLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _numberLabel.centerY = self.numberTitleLabel.centerY;
    }
    return _numberLabel;
}



- (UILabel *)feeTitleLabel
{
    if (nil == _feeTitleLabel) {
        _feeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"手续费", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.numberTitleLabel.bottom + ScaleW(13), self.numberTitleLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _feeTitleLabel.adjustsFontSizeToFitWidth = YES;

    }
    return _feeTitleLabel;
}


- (UILabel *)feeLabel
{
    if (nil == _feeLabel) {
        _feeLabel = [WLTools allocLabel:SSKJLocalized(@"----", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.addressLabel.x, self.feeTitleLabel.y, self.addressLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _feeLabel.centerY = self.feeTitleLabel.centerY;
    }
    return _feeLabel;
}


- (UILabel *)timeTitleLabel
{
    if (nil == _timeTitleLabel) {
        _timeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"提币时间", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.feeTitleLabel.bottom + ScaleW(13), self.numberTitleLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _timeTitleLabel.adjustsFontSizeToFitWidth = YES;

    }
    return _timeTitleLabel;
}


- (UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [WLTools allocLabel:SSKJLocalized(@"----", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.addressLabel.x, self.timeTitleLabel.y, self.addressLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _timeLabel.centerY = self.timeTitleLabel.centerY;
    }
    return _timeLabel;
}


- (UILabel *)checkTitleLabel
{
    if (nil == _checkTitleLabel)
    {
        _checkTitleLabel = [WLTools allocLabel:SSKJLocalized(@"审核时间", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.timeTitleLabel.bottom + ScaleW(13), self.numberTitleLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _checkTitleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _checkTitleLabel;
}


- (UILabel *)checkLabel
{
    if (nil == _checkLabel) {
        _checkLabel = [WLTools allocLabel:SSKJLocalized(@"--", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.addressLabel.x, self.timeTitleLabel.y, self.addressLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _checkLabel.centerY = self.checkTitleLabel.centerY;
    }
    return _checkLabel;
}


-(UILabel *)statusLabel
{
    if (nil == _statusLabel)
    {
        _statusLabel = [WLTools allocLabel:SSKJLocalized(@"提币成功", nil) font:systemFont(ScaleW(14)) textColor:kBlueColor frame:CGRectMake(self.checkTitleLabel.left, self.checkTitleLabel.bottom+ScaleW(13), 80, ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        
    }
    return _statusLabel;
}

-(UIImageView *)refuseImageView
{
    if (nil == _refuseImageView)
    {
        _refuseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.checkTitleLabel.left, self.checkTitleLabel.bottom+ScaleW(13),20, 20)];
        _refuseImageView.image = [UIImage imageNamed:@"mine_error"];
    }
    return _refuseImageView;
}

-(UILabel *)refuseLabel
{
    if (nil == _refuseLabel)
    {
        _refuseLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
    }
    return _refuseLabel;
}


-(UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.backView.bottom, ScreenWidth, ScaleW(0.5))];
        [_lineView setBackgroundColor:kLineColor];
    }
    return _lineView;
}

-(void)setCellWithModel:(ATEX_Extract_IndexModel *)model
{
    self.addressLabel.text = model.address;
    self.numberLabel.text = [NSString stringWithFormat:@"%@ USDT",[WLTools noroundingStringWith:model.money.doubleValue afterPointNumber:2]];
    self.feeLabel.text = [NSString stringWithFormat:@"%@ USDT",[WLTools noroundingStringWith:model.handling_fee.doubleValue afterPointNumber:2]];
    self.timeLabel.text = model.created_at;
    if (model.updated_at.length != 0)
    {
        self.checkLabel.text = model.updated_at;
    }
    else
    {
        self.checkLabel.text = @"--";
    }
    
    NSInteger status = model.status.integerValue;
    [self.statusLabel setFrame:CGRectMake(self.checkTitleLabel.left, self.checkTitleLabel.bottom+ScaleW(13), self.statusLabel.width, ScaleW(20))];
    if (status == 0 || status == 1)
    {
        self.statusLabel.text = SSKJLocalized(@"审核中", nil);
        self.statusLabel.textColor = UIColorFromRGB(0x2FE091);
    }
    else  if (status == 3 || status == 5)
    {
        self.statusLabel.text = SSKJLocalized(@"审核失败", nil);
        self.statusLabel.textColor = UIColorFromRGB(0xFF5E66);
        [self.statusLabel setFrame:CGRectMake((self.refuseImageView.right+5), self.checkTitleLabel.bottom+ScaleW(13), self.statusLabel.width, ScaleW(20))];
    }
    else if (status == 4)
    {
        self.statusLabel.text = SSKJLocalized(@"提币成功", nil);
        self.statusLabel.textColor = kBlueColor;
    }
    
    
    
    [self.refuseLabel setFrame:CGRectMake(self.statusLabel.right, self.statusLabel.top,   (ScreenWidth/2.0),ScaleW(20))];
    if (status == 3 || status == 5)
    {
        [self.refuseLabel setText:model.refuse_reason];
        [self.refuseImageView setHidden:NO];
        [self.refuseLabel setHidden:NO];
    }
    else
    {
        [self.refuseLabel setHidden:YES];
        [self.refuseImageView setHidden:YES];
    }
    
}


@end
