//
//  Heyue_OrderDetail_ViewController.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_OrderDetail_ViewController.h"

#import "Heyue_orderDetail_headerView.h"


#import "Heyue_ChiCang_Order_VC.h"

#import "Heyue_WeiTuo_Order_VC.h"

#import "Heyue_CengJiao_Order_VC.h"

#import "Heyue_OrderInfo_Model.h"
#import "ProfitWeiTuoChiCangHelper.h"


@interface Heyue_OrderDetail_ViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) Heyue_orderDetail_headerView *headerView;

@property (nonatomic, strong) Home_Segment_View *segmentControl;
@property (nonatomic, strong) SSKJ_ScrollView *scrollView;
@property (nonatomic, strong) Heyue_ChiCang_Order_VC *chicangVC;

@property (nonatomic, strong) Heyue_WeiTuo_Order_VC *weituoVC;

@property (nonatomic, strong) Heyue_CengJiao_Order_VC *chengjiaoVC;


@end

@implementation Heyue_OrderDetail_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = SSKJLocalized(@"订单明细", nil);
    self.view.backgroundColor = kBgColor;
    [self.navigationItem setTitleView:self.segmentControl];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.scrollView];
    
    
    WS(weakSelf);
    [[ProfitWeiTuoChiCangHelper shareHelper] setGetProfitWeiTuoChiCangBlock:^(Heyue_OrderInfo_Model * _Nonnull profitModel, NSArray * _Nonnull weituoArray, NSArray * _Nonnull chicangArray)
    {
        [weakSelf.headerView setModel:profitModel];
        [weakSelf.weituoVC setItemArry:chicangArray];
        [weakSelf.chicangVC setItemArry:weituoArray];
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}






#pragma mark - Getter / Setter
- (Heyue_orderDetail_headerView *)headerView
{
    if (_headerView == nil)
    {
        _headerView = [[Heyue_orderDetail_headerView alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth,175)];
    }
    return _headerView;
}


- (void)ninaCurrentPageIndex:(NSInteger)currentPage currentObject:(id)currentObject lastObject:(id)lastObject
{
    
    switch (currentPage)
    {
        case 2:
        {
            [self.chengjiaoVC beginrefreashData];
        }
            break;
    }
}


-(Home_Segment_View *)segmentControl
{
    if (nil == _segmentControl) {
        
        _segmentControl = [[Home_Segment_View alloc]initWithFrame:CGRectMake(0, self.headerView.bottom + ScaleW(10), ScreenWidth-150, ScaleW(40)) titles:@[SSKJLocalized(@"委托",nil),SSKJLocalized(@"持仓", nil), SSKJLocalized(@"成交", nil)] normalColor:kTitleColor selectedColor:kBlueColor fontSize:ScaleW(15)];
        
        WS(weakSelf);
        _segmentControl.selectedIndexBlock = ^(NSInteger index) {
            
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.scrollView.contentOffset = CGPointMake(ScreenWidth * index, 0);
            }];
            [weakSelf setCurrentIndex:index];
            return YES;
        };
        
    }
    return _segmentControl;
}


- (SSKJ_ScrollView *)scrollView
{
    if (!_scrollView)
    {
        self.scrollView = [[SSKJ_ScrollView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom , ScreenWidth, ScreenHeight - self.headerView.bottom) withDeletage:self];
        _scrollView.contentSize = CGSizeMake(ScreenWidth * 3, 0);
        _scrollView.backgroundColor = kBgColor;
        
        
        self.weituoVC= [[Heyue_WeiTuo_Order_VC alloc]init];
        [self addChildViewController:self.weituoVC];
        [self.scrollView addSubview:self.weituoVC.view];
        self.weituoVC.view.frame = CGRectMake(0, 0, ScreenWidth, self.scrollView.height);
        
        
        //委托
        self.chicangVC = [[Heyue_ChiCang_Order_VC alloc]init];
        [self addChildViewController:self.chicangVC];
        [self.scrollView addSubview:self.chicangVC.view];
        self.chicangVC.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, self.scrollView.height);

        
        
        //成交
        self.chengjiaoVC = [[Heyue_CengJiao_Order_VC alloc]init];
        [self.scrollView addSubview:self.chengjiaoVC.view];
        [self addChildViewController:self.chengjiaoVC];
        self.chengjiaoVC.view.frame = CGRectMake(ScreenWidth * 2, 0, ScreenWidth, self.scrollView.height);
        
    }
    return _scrollView;
}





#pragma mark - scroll delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    
    if (offset.x < 0) {
        return;
    }

    self.segmentControl.selectedIndex = offset.x/ScreenWidth;
    
    [self setCurrentIndex:self.segmentControl.selectedIndex];
}


-(void)setCurrentIndex:(NSInteger)index
{
    switch (index)
    {
        case 2:
        {
            [self.chengjiaoVC beginrefreashData];
        }
            break;
    }
}


@end
