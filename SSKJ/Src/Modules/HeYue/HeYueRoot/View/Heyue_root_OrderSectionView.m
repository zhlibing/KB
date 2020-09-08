//
//  Heyue_root_OrderSectionView.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/29.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_root_OrderSectionView.h"

@interface Heyue_root_OrderSectionView()

@property (nonatomic,strong) UILabel * bottomLabel;
@property (nonatomic,strong) UIView * lineView;



@end

@implementation Heyue_root_OrderSectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = kBgColor;
        
        [self addSubview:self.bottomLabel];
        [self addSubview:self.allOrderBtn];
        [self addSubview:self.imageView];
        [self addSubview:self.lineView];
        
        
        [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make){
           make.left.equalTo(@(ScaleW(18)));
           make.top.equalTo(@(ScaleW(0)));
           make.bottom.equalTo(@(ScaleW(0)));
           make.width.equalTo(@(200));
        }];
        
        
        [self.allOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.mas_right);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo(@(50));
            
        }];
        
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.right.equalTo(self.allOrderBtn.mas_left);
            make.centerY.equalTo(self.allOrderBtn);
            
        }];
        
        
        
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.mas_bottom);
            make.left.right.bottom.equalTo(@(ScaleW(0)));
            make.height.equalTo(@(ScaleW(0.5)));
       }];
        
    }
    return self;
}

- (UILabel *)bottomLabel{
    if (_bottomLabel == nil) {
        _bottomLabel = [UILabel new];
        _bottomLabel.text = SSKJLocalized(@"当前委托", nil);
        _bottomLabel.font = systemFont(ScaleW(16));
        _bottomLabel.textColor = kTitleColor;
        
    }
    return _bottomLabel;
}

- (UIButton *)allOrderBtn
{
    if (_allOrderBtn == nil)
    {
        _allOrderBtn = [WLTools allocButton:SSKJLocalized(@"全部", nil) textColor:kTitleColor nom_bg:nil hei_bg:nil frame:CGRectZero];
        _allOrderBtn.titleLabel.font = systemFont(ScaleW(14));
        [_allOrderBtn addTarget:self action:@selector(allOrderBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_allOrderBtn];
    }
    return _allOrderBtn;
}

-(UIImageView*)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setImage:[UIImage imageNamed:@"allorder"]];
    }
    return _imageView;
}






- (UIView *)lineView
{
    if (_lineView == nil)
    {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}




- (void)allOrderBtnAction{
    if (self.AllOrderBlock) {
        self.AllOrderBlock();
    }
}



- (void)setIsTimeHeyue:(BOOL)isTimeHeyue
{
    _isTimeHeyue = isTimeHeyue;
    if (isTimeHeyue)
    {
        self.bottomLabel.text = SSKJLocalized(@"当前持仓", nil);
    }
    else
    {
        self.bottomLabel.text = SSKJLocalized(@"当前委托", nil);
    }
}




@end
