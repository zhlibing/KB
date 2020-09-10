//
//  Heyue_orderDetail_headerView.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/30.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_orderDetail_headerView.h"
#import "Heyue_OrderDdetail_Model.h"

@interface Heyue_orderDetail_headerView()

@property (nonatomic,strong) UIView *topLineView;

@property (nonatomic,strong) UILabel *dongtaiquanyiTitle;

@property (nonatomic,strong) UILabel *dongtaiquanyiLabel;

@property (nonatomic,strong) UILabel *keyongTitle;

@property (nonatomic,strong) UILabel *keyongLabel;

@property (nonatomic,strong) UILabel *dongjieTitle;

@property (nonatomic,strong) UILabel *dongjieLabel;

@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) UILabel *fudongyingkuiTitle;

@property (nonatomic,strong) UILabel *fudongyingkuiLabel;

@property (nonatomic,strong) UILabel *fengxianlvTitle;

@property (nonatomic,strong) UILabel *fengxianlvLabel;

@property (nonatomic,strong) UIView *yingKuiBgView;


@end

@implementation Heyue_orderDetail_headerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBgColor;
        
        
        [self addSubview:self.topLineView];
        [self.topLineView addSubview:self.dongtaiquanyiLabel];
        [self.topLineView addSubview:self.dongtaiquanyiTitle];
        [self.topLineView addSubview:self.keyongLabel];
        [self.topLineView addSubview:self.keyongTitle];
        [self.topLineView addSubview:self.dongjieLabel];
        [self.topLineView addSubview:self.dongjieTitle];
        
        
        [self addSubview:self.yingKuiBgView];
        [self.yingKuiBgView addSubview:self.fudongyingkuiLabel];
        [self.yingKuiBgView addSubview:self.fudongyingkuiTitle];
        [self addSubview:self.fengxianlvLabel];
        [self addSubview:self.fengxianlvTitle];
        [self addSubview:self.lineView];
        
        

        [self serUIFrame];
    }
    return self;
}

- (void)serUIFrame{
    
    
    
    
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.equalTo(@(75));
    }];
    
    
    [self.dongtaiquanyiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(19));
        make.height.equalTo(@((15)));
        make.width.equalTo(@(ScreenWidth / 3));
    }];
    
    [self.dongtaiquanyiTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(self.dongtaiquanyiLabel.mas_bottom).offset((10));
        make.height.equalTo(@((15)));
        make.width.equalTo(@(ScreenWidth / 3));
    }];
    
    [self.keyongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScreenWidth / 3));
        make.top.equalTo(@((19)));
        make.height.equalTo(@((15)));
        make.width.equalTo(@(ScreenWidth / 3));
    }];
    
    [self.keyongTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScreenWidth / 3));
        make.top.equalTo(self.dongtaiquanyiLabel.mas_bottom).offset((10));
        make.height.equalTo(@((15)));
        make.width.equalTo(@(ScreenWidth / 3));
    }];
    
    [self.dongjieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.top.equalTo(@((19)));
        make.height.equalTo(@((15)));
        make.width.equalTo(@(ScreenWidth / 3));
    }];
    
    [self.dongjieTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.top.equalTo(self.dongtaiquanyiLabel.mas_bottom).offset((10));
        make.height.equalTo(@((15)));
        make.width.equalTo(@(ScreenWidth / 3));
    }];
    
    [self.yingKuiBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLineView.mas_bottom).offset((10));
        make.left.equalTo(self.mas_left).offset((23));
        make.size.mas_equalTo(CGSizeMake((139), (57)));
    }];
    
    self.yingKuiBgView.clipsToBounds = true;
    self.yingKuiBgView.layer.cornerRadius = (5);
    [self.fudongyingkuiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.yingKuiBgView);
        make.top.equalTo(self.yingKuiBgView.mas_top).offset((8));
    }];

    [self.fudongyingkuiTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.yingKuiBgView);
        make.bottom.equalTo(self.yingKuiBgView.mas_bottom).offset((-8));
    }];

    [self.fengxianlvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fudongyingkuiLabel.mas_centerY);
        make.centerX.equalTo(self.yingKuiBgView.mas_centerX).offset(ScreenWidth / 2);
    }];

    [self.fengxianlvTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.fengxianlvLabel.mas_centerX);
        make.centerY.equalTo(self.fudongyingkuiTitle.mas_centerY);
        make.width.equalTo(@(ScreenWidth / 2 - (20)));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(@(0));
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@(0.5));
    }];
    
}

- (UIView *)topLineView
{
    if (_topLineView==nil)
    {
        _topLineView = [[UIView alloc]init];
        _topLineView.backgroundColor = kSubBgColor;
    }
    return _topLineView;
}

- (UIView *)yingKuiBgView{
    if (_yingKuiBgView==nil)
    {
        _yingKuiBgView = [[UIView alloc]init];
        _yingKuiBgView.backgroundColor = kMarketUp;
    }
    return _yingKuiBgView;
}
- (UILabel *)dongtaiquanyiTitle{
    if (_dongtaiquanyiTitle == nil) {
        _dongtaiquanyiTitle = [WLTools allocLabel:SSKJLocalized(@"动态权益", nil) font:systemFont((13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _dongtaiquanyiTitle.numberOfLines = 1;
        _dongtaiquanyiTitle.adjustsFontSizeToFitWidth = YES;
    }
    return _dongtaiquanyiTitle;
}

- (UILabel *)dongtaiquanyiLabel{
    if (_dongtaiquanyiLabel == nil) {
        _dongtaiquanyiLabel = [WLTools allocLabel:@"0.0000" font:systemFont((13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _dongtaiquanyiLabel.numberOfLines = 1;

    }
    return _dongtaiquanyiLabel;
}

- (UILabel *)keyongTitle{
    if (_keyongTitle == nil) {
        _keyongTitle = [WLTools allocLabel:[NSString stringWithFormat:@"%@%@",SSKJLocalized(@"可用", nil),@"USDT"] font:systemFont((13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];

        _keyongTitle.numberOfLines = 1;

    }
    return _keyongTitle;
}

- (UILabel *)keyongLabel{
    if (_keyongLabel == nil) {
        _keyongLabel = [WLTools allocLabel:@"0.0000" font:systemFont((13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _keyongLabel.numberOfLines = 1;

    }
    return _keyongLabel;
}


- (UILabel *)dongjieTitle{
    if (_dongjieTitle == nil) {
        _dongjieTitle = [WLTools allocLabel:[NSString stringWithFormat:@"%@%@",SSKJLocalized(@"冻结", nil),@"USDT"] font:systemFont((13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        


        _dongjieTitle.numberOfLines = 1;

    }
    return _dongjieTitle;
}

- (UILabel *)dongjieLabel{
    if (_dongjieLabel == nil) {
        _dongjieLabel = [WLTools allocLabel:@"0.0000" font:systemFont((13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _dongjieLabel.numberOfLines = 1;

    }
    return _dongjieLabel;
}

- (UIView *)lineView
{
    if (_lineView==nil)
    {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kSubBgColor;
    }
    return _lineView;
}

- (UILabel *)fudongyingkuiTitle
{
    if (_fudongyingkuiTitle == nil)
    {
        _fudongyingkuiTitle = [WLTools allocLabel:SSKJLocalized(@"浮动盈亏", nil) font:systemFont((13)) textColor:kWhiteColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _fudongyingkuiTitle.numberOfLines = 1;

    }
    return _fudongyingkuiTitle;
}

- (UILabel *)fudongyingkuiLabel{
    if (_fudongyingkuiLabel == nil) {
        _fudongyingkuiLabel = [WLTools allocLabel:@"0.0000" font:systemFont((16)) textColor:kWhiteColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _fudongyingkuiLabel.numberOfLines = 1;

    }
    return _fudongyingkuiLabel;
}

- (UILabel *)fengxianlvTitle{
    if (_fengxianlvTitle == nil) {
        _fengxianlvTitle = [WLTools allocLabel:SSKJLocalized(@"风险率", nil) font:systemFont((13)) textColor:kMarketDown frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _fengxianlvTitle.numberOfLines = 1;

    }
    return _fengxianlvTitle;
}

- (UILabel *)fengxianlvLabel{
    if (_fengxianlvLabel == nil) {
        _fengxianlvLabel = [WLTools allocLabel:@"0.0000" font:systemFont((15)) textColor:kMarketDown frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _fengxianlvLabel.numberOfLines = 1;

    }
    return _fengxianlvLabel;
}


- (void)setModel:(Heyue_OrderInfo_Model *)model
{
    _model = model;
    
    self.dongtaiquanyiLabel.text = [SSTool HeyuePname:@"USDT" price:model.totalusdt];
    self.keyongLabel.text = [SSTool HeyuePname:@"USDT" price:model.keyong_price];
    self.dongjieLabel.text = [SSTool HeyuePname:@"USDT" price:model.totaldeposit];
    self.fudongyingkuiLabel.text = [SSTool HeyuePname:@"USDT" price:model.yingkui];
    self.fengxianlvLabel.text = [NSString stringWithFormat:@"%@%@",[SSTool disposePname:@"2" price:[NSString stringWithFormat:@"%.9f", model.risk.doubleValue]],@"%"];
    
    if ([self.fudongyingkuiLabel.text containsString:@"-"])
    {
        self.yingKuiBgView.backgroundColor = kMarketDown;
    }
    else
    {
        self.yingKuiBgView.backgroundColor = kMarketUp;
    }
}




@end
