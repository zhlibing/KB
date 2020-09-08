//
//  Hebi_Market_HeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/9.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "Home_Market_HeaderView.h"
#import "SDCycleScrollView.h"
#import "SSKJ_Market_Index_Model.h"
#import "Home_Coin_View.h"
#import "HomeHeaderItemControl.h"



@interface Home_Market_HeaderView ()<SDCycleScrollViewDelegate>



@property(nonatomic, strong)  UIView *coinView;
@property (nonatomic, strong) UIImageView *bannerView;    // 轮播图
@property(nonatomic, strong)  Home_Coin_View *coinContentView;
@property (nonatomic, strong) UIView *lineView; //!< 分割线
@property (nonatomic, strong) HomeHeaderItemControl *assetsControl;
@property (nonatomic, strong) HomeHeaderItemControl *quicklyControl;
@property (nonatomic, strong) HomeHeaderItemControl *dividendsControl;
@property (nonatomic, strong) UIView *bottomLineView; //!< 分割线



@end

@implementation Home_Market_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:kBgColor];
        
        [self addSubview:self.bannerView];
        [self addSubview:self.coinView];
        [self.coinView addSubview:self.coinContentView];
        [self.coinView addSubview:self.noticeView];
        [self addSubview:self.lineView];
        
        [self addSubview:self.assetsControl];
        [self addSubview:self.quicklyControl];
        [self addSubview:self.dividendsControl];
        [self addSubview:self.bottomLineView];
        
        
        [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.top.right.equalTo(self);
            make.height.equalTo(@(230));
            
        }];
        
        [self.coinView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.bannerView.mas_top).offset(180);
            make.left.equalTo(self.mas_left).offset(ScaleW(12));
            make.right.equalTo(self.mas_right).offset(-ScaleW(12));
            make.height.equalTo(@(160));
        }];
        
        
        [self.coinContentView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.equalTo(@(ScaleW(0)));
            make.left.right.equalTo(self.coinView);
            make.height.equalTo(@(110));
        }];
        
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make)
        {
           
            make.top.equalTo(self.coinContentView.mas_bottom);
            make.left.equalTo(self.mas_left).offset(ScaleW(10));
            make.right.equalTo(self.mas_right).offset(-ScaleW(10));
            make.height.equalTo(@(0.3));
            
        }];
        
        [self.noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(42));
            make.left.bottom.right.equalTo(self.coinView);
        }];
        
        
        WS(weakSelf);
        self.coinContentView.selectBlock = ^(NSInteger index)
        {
            if (weakSelf.hotCoinBlock)
            {
                weakSelf.hotCoinBlock(weakSelf.coinArray[index]);
            }
        };
        
        
        [self.assetsControl mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.coinView.mas_bottom).offset(10);
            make.left.equalTo(self.coinView.mas_left);
            make.right.equalTo(self.mas_centerX).offset(-7.5);
            make.height.equalTo(@(80));
        }];
        
        [self.quicklyControl mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.assetsControl.mas_top);
            make.left.equalTo(self.mas_centerX).offset(7.5);
            make.right.equalTo(self.coinView.mas_right);
            make.height.equalTo(self.assetsControl);
        }];
        
        
        [self.dividendsControl mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.assetsControl.mas_bottom).offset(12);
            make.left.right.equalTo(self.coinView);
            make.height.equalTo(@(77));
        }];
        
        
        [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            
            make.left.right.equalTo(self);
            make.bottom.equalTo(self.mas_bottom);
            make.height.equalTo(@(10));
            
        }];
        
    }
    return self;
}

#pragma mark - 播视图
-(UIImageView *)bannerView
{
    if (_bannerView==nil)
    {
        _bannerView=[[UIImageView alloc]init];
        [_bannerView setImage:[UIImage imageNamed:@"banner_default"]];
        [_bannerView.layer setMasksToBounds:YES];
    }
    return _bannerView;
}

-(UIView *)coinView
{
    if (nil == _coinView)
    {
        _coinView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(0), self.noticeView.bottom, ScreenWidth, ScaleW(120))];
        [_coinView setBackgroundColor:kBgColor];
        [_coinView setCornerRadius:ScaleW(5)];
    }
    return _coinView;
}


-(Home_Coin_View *)coinContentView
{
    if (!_coinContentView)
    {
        _coinContentView = [[Home_Coin_View alloc] initWithFrame:CGRectZero];
    }
    return _coinContentView;
}






-(SSKJ_ScrollNotice_View *)noticeView
{
    if (nil == _noticeView)
    {
        _noticeView = [[SSKJ_ScrollNotice_View alloc]initWithFrame:CGRectZero];
        WS(weakSelf);
        _noticeView.clickBlock = ^(NSInteger index)
        {
            if (weakSelf.noticeBlock) {
                weakSelf.noticeBlock(index);
            }
        };
        
        _noticeView.moreBlock = ^{
            if (weakSelf.noticeMoreBlock) {
                weakSelf.noticeMoreBlock();
            }
        };
    }
    return _noticeView;
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

-(UIView *)bottomLineView
{
    if (!_bottomLineView)
    {
        _bottomLineView = [[UIView alloc]init];
        [_bottomLineView setBackgroundColor:kLineColor];
    }
    return _bottomLineView;
}





-(HomeHeaderItemControl *)assetsControl
{
    if (!_assetsControl)
    {
        _assetsControl = [[HomeHeaderItemControl alloc]initWithType:1];
        [_assetsControl setTitle:@"账户资产" desc:@"总账户管理" imageName:@"assets"];
        [_assetsControl addTarget:self action:@selector(invicateEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_assetsControl setTag:1];
    }
    return _assetsControl;
}





-(HomeHeaderItemControl *)quicklyControl
{
    if (!_quicklyControl)
    {
        _quicklyControl = [[HomeHeaderItemControl alloc]initWithType:1];
        [_quicklyControl setTitle:@"快捷买币" desc:@"进入便捷交易" imageName:@"quickly"];
        [_quicklyControl addTarget:self action:@selector(invicateEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_quicklyControl setTag:2];
    }
    return _quicklyControl;
}


-(HomeHeaderItemControl *)dividendsControl
{
    if (!_dividendsControl)
    {
        _dividendsControl = [[HomeHeaderItemControl alloc]initWithType:2];
        [_dividendsControl setTitle:@"进入全球团队分红模式" imageName:@"dividends"];
        [_dividendsControl addTarget:self action:@selector(invicateEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_dividendsControl setTag:3];
    }
    return _dividendsControl;
}



#pragma mark  SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.bannerBlock) {
        self.bannerBlock(index);
    }
}

#pragma mark  用户操作 资产账户 快捷买币  分享
-(void)invicateEvent:(UIControl*)sender
{
    if (self.invicateBlock)
    {
        self.invicateBlock(sender.tag);
    }
}



#pragma mark - 推送数据

-(void)setCoinArray:(NSArray *)coinArray
{
    _coinArray = coinArray;
    self.coinContentView.array = coinArray;
}

-(void)setBannerArray:(NSArray *)bannerArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    
    for (Home_MarketBanner_Model *model in bannerArray)
    {
        [array addObject:model.image];
    }
}

-(void)setNoticeArray:(NSArray *)noticeArray
{
    
    NSMutableArray *array = [NSMutableArray array];
    for (Home_NoticeIndex_Model *noticeModel in noticeArray) {
        
        [array addObject:noticeModel.title];

    }
    
    [self.noticeView configureModels:array];
}




@end
