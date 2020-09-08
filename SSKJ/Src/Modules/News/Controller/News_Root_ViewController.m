//
//  GoCoin_ZiXun_ViewController.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/3/28.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "News_Root_ViewController.h"

#import "News_SystemConsult_VC.h"//系统资讯

#import "News_TradingGuide_VC.h"//交易指南

#import "SSKJ_Nav_SegmentView.h"


@interface News_Root_ViewController ()<UIScrollViewDelegate>


@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) News_SystemConsult_VC *newsVc;

@property (nonatomic,strong) News_TradingGuide_VC *noticeVc;


@property (nonatomic, strong) Home_Segment_View *segmentControl;


@end

@implementation News_Root_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)setUI
{
    self.navigationItem.titleView = self.segmentControl;
    [self scrollView];
}


- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(@0);
            make.top.equalTo(@(Height_NavBar));
            make.bottom.equalTo(@0);
        }];
        
        if (@available(iOS 11.0, *)){
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }

        _scrollView.contentSize = CGSizeMake(ScreenWidth * 2, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = kBgColor;
        
        self.newsVc = [[News_SystemConsult_VC alloc]init];
        [self addChildViewController:self.newsVc];
        [_scrollView addSubview:self.newsVc.view];
        
        self.noticeVc = [[News_TradingGuide_VC alloc]init];
        [self addChildViewController:self.noticeVc];
        [_scrollView addSubview:self.noticeVc.view];
        
        
        [self.newsVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(@0);
            make.width.equalTo(@(ScreenWidth));
            make.height.equalTo(@(ScreenHeight - Height_NavBar - Height_TabBar));
        }];
        
        [self.noticeVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.newsVc.view);
            make.left.equalTo(self.newsVc.view.mas_right);
            make.width.height.equalTo(self.newsVc.view);
        }];
        
        
    }
    return _scrollView;
}


-(Home_Segment_View *)segmentControl
{
    if (nil == _segmentControl)
    {
        _segmentControl = [[Home_Segment_View alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - ScaleW(150), ScaleW(40)) titles:@[SSKJLocalized(@"快讯", nil),SSKJLocalized(@"交易指南", nil)] normalColor:kSubTitleColor selectedColor:kTitleColor fontSize:ScaleW(15)];
        
        WS(weakSelf);
        _segmentControl.selectedIndexBlock = ^(NSInteger index)
        {
            weakSelf.scrollView.contentOffset = CGPointMake(ScreenWidth * index, 0);
            [weakSelf setIndex:index];

            return YES;
        };
    }
    return _segmentControl;
}



#pragma mark - scroll delegate
-(void)setIndex:(NSInteger)index
{
    switch (index)
    {
        case 0:
        {
            [self.newsVc viewWillAppear:YES];
        }
            break;
        case 1:
        {
            [self.noticeVc viewWillAppear:YES];
        }
            break;
    }
}





#pragma mark - scroll delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    
    if (offset.x < 0) {
        return;
    }

    self.segmentControl.selectedIndex = offset.x/ScreenWidth;

    [self setIndex:self.segmentControl.selectedIndex];
}





@end
