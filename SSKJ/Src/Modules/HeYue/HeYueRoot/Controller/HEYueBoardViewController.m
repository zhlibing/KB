//
//  HEYueBoardViewController.m
//  SSKJ
//
//  Created by 姚立志 on 2020/8/11.
//  Copyright © 2020 刘小雨. All rights reserved.
//


#import "HEYueBoardViewController.h"
#import "UIImage+RoundedRectImage.h"
#import "UIViewController+CWLateralSlide.h"

#import "HEYue_ViewController.h"
#import "Heyue_ChiCang_Order_VC.h"
#import "HeYue_LeftViewController.h"
#import "HeYue_KlineViewController.h"


#import "HEYueBoardHeaderView.h"
#import "Home_Segment_View.h"
#import "Heyue_OrderInfo_Model.h"
#import "Heyue_Leverage_Model.h"



@interface HEYueBoardViewController ()


@property (nonatomic, strong) HEYueBoardHeaderView *headerView;
@property (nonatomic, strong) Home_Segment_View *segmentControl;
@property (nonatomic, strong) SSKJ_ScrollView *scrollView;
@property (nonatomic, strong) HEYue_ViewController *heyueVC;
@property (nonatomic, strong) Heyue_ChiCang_Order_VC *chiCangVC;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) Heyue_Leverage_Model *leverage_Model;
@property (nonatomic, strong) SSKJ_Market_Index_Model *model;



@end

@implementation HEYueBoardViewController


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetCoinModel:) name:@"didGetCoinModel" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addLeftNavItemWithImage:[UIImage imageWithOriginalName:@"hy_unShow"]];
    [self addRightNavgationItemWithImage:[UIImage imageWithOriginalName:@"hy_list"]];
    
    self.title = @"BTC/USDT";
    [self.view setBackgroundColor:kSubBgColor];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.scrollView];
    
    
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.f target:self selector:@selector(timerRefreash:) userInfo:nil repeats:YES];
    [self setNavigationBarHidden:NO];
    [self requestGetLeverageURLURL];
}


-(void)didGetCoinModel:(NSNotification *)notification
{
    SSKJ_Market_Index_Model *model = notification.object;
    [self refreshModel:model];
}




-(void)refreshModel:(SSKJ_Market_Index_Model*)model
{
    [self setModel:model];
    [self.heyueVC setModel:model];
    [self.heyueVC refreshCodeDate];
    self.title = [[model.code uppercaseString] stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
}












- (HEYueBoardHeaderView *)headerView
{
    if (_headerView == nil)
    {
        _headerView = [[HEYueBoardHeaderView alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth,70)];
//        [_headerView setBackgroundColor:[UIColor redColor]];
    }
    return _headerView;
}


-(Home_Segment_View *)segmentControl
{
    if (nil == _segmentControl) {
        
        _segmentControl = [[Home_Segment_View alloc]initWithFrame:CGRectMake(0, self.headerView.bottom+10, ScreenWidth, 45) titles:@[SSKJLocalized(@"交易", nil),SSKJLocalized(@"持仓", nil)] normalColor:kTitleColor selectedColor:kBlueColor fontSize:ScaleW(15) lineWidth:(ScreenWidth/2.0)];
        [_segmentControl setBackgroundColor:kBgColor];
        
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
        self.scrollView = [[SSKJ_ScrollView alloc] initWithFrame:CGRectMake(0, self.segmentControl.bottom , ScreenWidth, ScreenHeight-(self.segmentControl.bottom+Height_TabBar)) withDeletage:self];
        
        _scrollView.contentSize = CGSizeMake(ScreenWidth * 2, 0);
        _scrollView.backgroundColor = kBgColor;
        
        self.heyueVC= [[HEYue_ViewController alloc]init];
        [self addChildViewController:self.heyueVC];
        [self.scrollView addSubview:self.heyueVC.view];
        self.heyueVC.view.frame = CGRectMake(0, 0, ScreenWidth, (self.scrollView.height));
        
        //委托
        self.chiCangVC = [[Heyue_ChiCang_Order_VC alloc]init];
        [self addChildViewController:self.chiCangVC];
        [self.scrollView addSubview:self.chiCangVC.view];
        self.chiCangVC.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, (self.scrollView.height));
        
    }
    return _scrollView;
}

#pragma mark - Private Method
- (void)leftBtnAction:(id)sender
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    HeYue_LeftViewController *vc = [[HeYue_LeftViewController alloc]init];
       CWLateralSlideConfiguration *config = [[CWLateralSlideConfiguration alloc]initWithDistance:ScreenWidth * 0.8 maskAlpha:0.6 scaleY:1 direction:CWDrawerTransitionFromLeft backImage:nil];
       WS(weakSelf);
       vc.selectCoinBlock = ^(SSKJ_Market_Index_Model * _Nonnull coinModel)
    {
           [weakSelf refreshModel:coinModel];
           
       };
       [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeDefault configuration:config];
}


-(void)rigthBtnAction:(id)sender
{
    HeYue_KlineViewController *vc = [[HeYue_KlineViewController alloc]init];
    vc.isNeedPop = YES;
    vc.coinModel = self.heyueVC.model;
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)timerRefreash:(NSTimer *)timer
{
    if (kLogin)
    {
        [self request_Tongji_URL];
    }
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}



#pragma mark - NetWork Method 网络请求
#pragma mark 网络请求 浮动盈亏 爆仓率 --
- (void)request_Tongji_URL
{
    
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_HEYUE_Info_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject)
    {
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == 200)
        {
            Heyue_OrderInfo_Model *model = [Heyue_OrderInfo_Model mj_objectWithKeyValues:netModel.data];
            [weakSelf.headerView setModel:model];
            
            
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
    }];
}


- (void)requestGetLeverageURLURL
{
    if (self.model.code.length < 1)
    {
        return;
    }
    NSDictionary *params = @{@"code":self.model.code};
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_HEYUE_Setting_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200)
        {
            weakSelf.leverage_Model = [Heyue_Leverage_Model mj_objectWithKeyValues:netModel.data];
            
            [weakSelf.headerView setLeverageModel:weakSelf.leverage_Model];
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
    {
        
    }];
}



#pragma mark - scroll delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    
    if (offset.x < 0)
    {
        return;
    }
    
    
    

    self.segmentControl.selectedIndex = offset.x/ScreenWidth;
    [self setCurrentIndex:self.segmentControl.selectedIndex];

}


-(void)setCurrentIndex:(NSInteger)index
{
    switch (index)
    {
        case 0:
        {
            [self.heyueVC refreshCodeDate];
            //[self.weituoVC closetimer];
        }
            break;
        case 1:
        {
//            [self.weituoVC openTimer];
        }
            break;
    }
}

@end
