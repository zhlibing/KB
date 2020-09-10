
//
//  ETF_BBTrade_IntroductHeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/8.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "ETF_BBTrade_IntroductHeaderView.h"

@interface ETF_BBTrade_IntroductHeaderView ()
@property (nonatomic, strong) UIButton *dealButton;     // 成交
@property (nonatomic, strong) UIButton *deepButton; // 深度
@property (nonatomic, strong) UIButton *introductButton;    // 简介
@property (nonatomic, strong) UIView *segmentLineView;


@end

@implementation ETF_BBTrade_IntroductHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0x131E31);
        [self addSubview:self.dealButton];
        [self addSubview:self.deepButton];
        [self addSubview:self.introductButton];
        [self addSubview:self.segmentLineView];
    }
    return self;
}


-(UIButton *)deepButton
{
    if (nil == _deepButton) {
        _deepButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.width / 3, self.height)];
        [_deepButton setTitle:SSKJLocalized(@"深度", nil) forState:UIControlStateNormal];
        [_deepButton setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        [_deepButton setTitleColor:kWhiteColor forState:UIControlStateSelected];
        _deepButton.titleLabel.font = systemFont(ScaleW(15));
        _deepButton.selected = YES;
        [_deepButton addTarget:self action:@selector(deepEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deepButton;
}


-(UIButton *)dealButton
{
    if (nil == _dealButton) {
        _dealButton = [[UIButton alloc]initWithFrame:CGRectMake(self.deepButton.right, 0, self.width / 3, self.height)];
        [_dealButton setTitle:SSKJLocalized(@"成交", nil) forState:UIControlStateNormal];
        [_dealButton setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        [_dealButton setTitleColor:kWhiteColor forState:UIControlStateSelected];
        _dealButton.titleLabel.font = systemFont(ScaleW(15));
        _dealButton.selected = NO;
        [_dealButton addTarget:self action:@selector(dealEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dealButton;
}




-(UIButton *)introductButton
{
    if (nil == _introductButton) {
        _introductButton = [[UIButton alloc]initWithFrame:CGRectMake(self.dealButton.right, 0, self.width / 3, self.height)];
        [_introductButton setTitle:SSKJLocalized(@"简介", nil) forState:UIControlStateNormal];
        [_introductButton setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        [_introductButton setTitleColor:kWhiteColor forState:UIControlStateSelected];
        _introductButton.titleLabel.font = systemFont(ScaleW(15));
        _introductButton.selected = NO;
        [_introductButton addTarget:self action:@selector(introductEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _introductButton;
}

-(UIView *)segmentLineView
{
    if (nil == _segmentLineView) {
        _segmentLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 2, ScaleW(30), 2)];
        _segmentLineView.backgroundColor = kWhiteColor;
        _segmentLineView.centerX = self.deepButton.centerX;
    }
    return _segmentLineView;
}



-(void)dealEvent
{
    self.dealButton.selected = YES;
    self.deepButton.selected = NO;
    self.introductButton.selected = NO;
    self.segmentLineView.centerX = self.dealButton.centerX;
    self.selectedIndex = 1;
    if (self.segmentSelectBlock) {
        self.segmentSelectBlock(1);
    }
}

-(void)deepEvent
{
    self.deepButton.selected = YES;
    self.dealButton.selected = NO;
    self.introductButton.selected = NO;
    self.segmentLineView.centerX = self.deepButton.centerX;
    self.selectedIndex = 0;
    if (self.segmentSelectBlock) {
        self.segmentSelectBlock(0);
    }
}

-(void)introductEvent
{
    self.introductButton.selected = YES;
    self.dealButton.selected = NO;
    self.deepButton.selected = NO;

    self.segmentLineView.centerX = self.introductButton.centerX;
    self.selectedIndex = 2;

    if (self.segmentSelectBlock) {
        self.segmentSelectBlock(2);
    }
}


- (void)changeUI
{
       
    _segmentLineView.hidden = NO;
    _dealButton.hidden = NO;
    _introductButton.hidden = NO;
    
}
@end
