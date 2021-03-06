//
//  HEYue_ViewController.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "HEYue_ViewController.h"

#import "UIViewController+CWLateralSlide.h"

#import "HeYue_LeftViewController.h"//合约左边选择币种试图

#import "Heyue_WeiTuo_Order_Cell.h"//委托订单CELL

#import "Heyue_Nodata_Cell.h"//暂无数居cell

#import "HeYue_Root_HeaderView.h"//头部试图

#import "Heyue_root_OrderSectionView.h"//订单 Section

#import "Heyue_OrderDetail_ViewController.h"//订单详情

#import "HeYue_BaoCang_AlertView.h"//爆仓弹框

#import "HeYue_CheDan_AlertView.h"//撤单弹框

#import "Heyue_Leverage_Model.h"//显示数据model


#import "SSKJ_Market_Index_Model.h"//行情model(现有)

#import "PanKou_Socket_Model.h"//盘口model

#import "Heyue_OrderDdetail_Model.h"//订单Model

#import "SSKJ_NoDataView.h"//暂无数据
#import "SSKJ_Default_ActionsheetView.h"//币种切换弹框
#import "LoginViewController.h"
#import "SSKJ_BaseNavigationController.h"

//#import "JB_BBTrade_MarketDetail_ViewController.h"
#import "HeYue_KlineViewController.h"

#import "Lion_Assets_new_Model.h"

#import "SSKJ_Nav_SegmentView.h"

#import "UIImage+RoundedRectImage.h"


#import "SSKJ_UserInfo_Model.h"

#define PankouSocket @"pankou"

#define CoinMarketSocket @"CoinSocket"

#define ShenduSocket @"Shendu"


static NSString * WeiTuoCellID = @"WeiTuoCell";
static NSString * NodataCellID = @"NodataCell";



#define kPageSize @"50"

@interface HEYue_ViewController ()<UITableViewDelegate,UITableViewDataSource,ManagerSocketDelegate>


@property (nonatomic,strong) SSKJ_TableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataSource;

@property (nonatomic,strong) HeYue_Root_HeaderView *headerView;

@property (nonatomic,strong) HeYue_BaoCang_AlertView *baocangAlertView;

@property (nonatomic, strong) HeYue_CheDan_AlertView *chedanAlertView;

@property (nonatomic,strong) Heyue_Leverage_Model *leverageModel;//显示数据model


@property (nonatomic,strong) PanKou_Socket_Model *pankouModel;//行情model

@property (nonatomic,strong) SSKJ_UserInfo_Model *userInfoModel;

@property (nonatomic,strong) NSDictionary * shenduDic;//深度数据

@property (nonatomic,strong) ManagerSocket * pankouSocket;//盘口Socket

@property (nonatomic,strong) ManagerSocket * coinSocket;//币种Socket

@property (nonatomic,strong) ManagerSocket * shenDuSocket;//币种深度


@property(nonatomic, strong) Heyue_root_OrderSectionView *sectionView;
@end

@implementation HEYue_ViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(instancetype)init
{
    if (self = [super init])
    {
        
        //监听token是否过期
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginToken:) name:@"LoginToken" object:nil];
        
        return self;
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addLeftNavItemWithImage:[UIImage imageWithOriginalName:@"hy_unShow"]];
    [self addRightNavgationItemWithImage:[UIImage imageWithOriginalName:@"hy_list"]];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    //初始化默认USDT合约
    [self requestMarketList];
}


-(SSKJ_Market_Index_Model *)model
{
    if (!_model)
    {
        _model = [[SSKJ_Market_Index_Model alloc]init];
        [_model setCode:@"btc_usdt"];
    }
    return _model;
}



-(void)loginToken:(NSNotification *)notifa
{
    self.headerView.wallone_usdt = @"0";
    [self presentLoginController];
    
}

#pragma mark - 通知（进入后台，进入后台）

-(void)applicationDidBecomeActive:(NSNotification *)notification
{
    [self openSocket];
    
}

-(void)applicationDidEnterBackground:(NSNotification *)notification
{
    [self closeSocket];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
   //开启推送
   if (self.model.code > 0)
   {
//       [self openSocket];
   }
   else
   {
       self.model.code = @"btc_usdt";
   }
   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];

    self.sectionView.allOrderBtn.hidden = !kLogin;
    self.sectionView.imageView.hidden = !kLogin;
    [self refreshCodeDate];
}




- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];

    [self closeSocket];
    
}


#pragma mark - 更新币种
- (void)refreshCodeDate
{
    //请求个人中心
//    self.title = _model.code;
    self.title = [[self.model.code uppercaseString] stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    
    if (kLogin)
    {
        [self requestAssetInfo];
    }
    
    self.headerView.model = self.model;
    //获取币种资料（杠杆倍数）
    [self requestGetLeverageURLURL];
    //深度
    [self requestGet_shendu_URL];
//    盘口
    [self request_Getdepth_URL];

    //开启推送
    [self openSocket];
    [self.headerView changeUI];
}



-(void)setItemArray:(NSArray*)array
{
    [self.dataSource setArray:array];
    [self.tableView reloadData];
}




-(ManagerSocket *)coinSocket
{
    if (nil == _coinSocket) {
        _coinSocket =  [[ManagerSocket alloc]initWithUrl:MarketSocketUrl identifier:CoinMarketSocket];
    }
    return _coinSocket;
}

-(ManagerSocket *)shenDuSocket
{
    if (nil == _shenDuSocket) {
        _shenDuSocket =  [[ManagerSocket alloc]initWithUrl:MarketSocketUrl identifier:ShenduSocket];
    }
    return _shenDuSocket;
}

-(ManagerSocket *)pankouSocket
{
    if (nil == _pankouSocket) {
        _pankouSocket =  [[ManagerSocket alloc]initWithUrl:MarketSocketUrl identifier:PankouSocket];
    }
    return _pankouSocket;
}


#pragma mark -- Socket --
//打开推送
- (void)openSocket{
    
    WS(weakSelf);
    
    //成交
    //SocketUrl
    self.coinSocket.delegate = self;
    [self.coinSocket openConnectSocketWithConnectSuccess:^{
        NSString *string = [NSString stringWithFormat:@"ticker@%@",weakSelf.model.code];
        
        NSString *type = [WLTools wlDictionaryToJson:@{@"sub":string}];
        [weakSelf.coinSocket socketSendMsg:type];
        [weakSelf.coinSocket startSendHeartTimer];

    }];
    //盘口
    //kWllSocketURL
    self.pankouSocket.delegate = self;
    [self.pankouSocket openConnectSocketWithConnectSuccess:^{
        
        NSString *string = [NSString stringWithFormat:@"depth@%@",weakSelf.model.code];
        
        NSString *type = [WLTools wlDictionaryToJson:@{@"sub":string}];
        [weakSelf.pankouSocket socketSendMsg:type];
        [weakSelf.pankouSocket startSendHeartTimer];

    }];
    
    //深度
//    shenDuSocketUrl
    self.shenDuSocket.delegate = self;
    [self.shenDuSocket openConnectSocketWithConnectSuccess:^{
        NSString *string = [NSString stringWithFormat:@"pct@%@",weakSelf.model.code];
        
        NSString *type = [WLTools wlDictionaryToJson:@{@"sub":string}];
        [weakSelf.shenDuSocket socketSendMsg:type];
        [weakSelf.shenDuSocket startSendHeartTimer];
    }];
    
}
//关闭推送
- (void)closeSocket{
    self.coinSocket.delegate = nil;
    [self.coinSocket closeConnectSocket];
    //盘口
    self.pankouSocket.delegate = nil;
    [self.pankouSocket closeConnectSocket];
    
    self.shenDuSocket.delegate = nil;
    [self.shenDuSocket closeConnectSocket];
    
}

#pragma mark - 推送返回的数据
//接收推送数据
-(void)socketDidReciveData:(id)data identifier:(NSString *)identifier
{
    
    if (![data[@"code"] isEqualToString:self.model.code])
    {
        return;
    }
    if ([identifier isEqualToString:PankouSocket])
    {

        self.pankouModel = [PanKou_Socket_Model mj_objectWithKeyValues:data];
        self.headerView.pankouModel = self.pankouModel;
    }
    else if ([identifier isEqualToString:ShenduSocket])
    {
        
        NSDictionary *pushGoodsInfoDatas = nil;
        if ([data isKindOfClass:[NSString class]]){
            pushGoodsInfoDatas = [WLTools dictionaryWithJsonString:data];
        }
        else if ([data isKindOfClass:[NSDictionary class]]){
            pushGoodsInfoDatas = data;
        }

        self.shenduDic = pushGoodsInfoDatas;
        
        self.headerView.shenduDic = self.shenduDic;
    }
    else
    {
        
        NSDictionary *pushGoodsInfoDatas = nil;
        if ([data isKindOfClass:[NSString class]]){
            pushGoodsInfoDatas = [WLTools dictionaryWithJsonString:data];
        }
        else if ([data isKindOfClass:[NSDictionary class]]){
            pushGoodsInfoDatas = data;
        }
        SSKJ_Market_Index_Model *socketModel = [SSKJ_Market_Index_Model mj_objectWithKeyValues:data];
        self.headerView.model = socketModel;
        self.model = socketModel;
    }
}


#pragma mark -- 导航 --
- (void)setNavItem{
    
    
    
   
}

- (void)leftBtnAction:(id)sender{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    HeYue_LeftViewController *vc = [[HeYue_LeftViewController alloc]init];
       CWLateralSlideConfiguration *config = [[CWLateralSlideConfiguration alloc]initWithDistance:ScreenWidth * 0.8 maskAlpha:0.6 scaleY:1 direction:CWDrawerTransitionFromLeft backImage:nil];
       WS(weakSelf);
       vc.selectCoinBlock = ^(SSKJ_Market_Index_Model * _Nonnull coinModel) {
           weakSelf.model = coinModel;
           [weakSelf refreshCodeDate];
           
       };
       [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeDefault configuration:config];
}

//- (void)leftBtnAction:(id)sender{
//    HeYue_LeftViewController *vc = [[HeYue_LeftViewController alloc]init];
//    CWLateralSlideConfiguration *config = [[CWLateralSlideConfiguration alloc]initWithDistance:ScreenWidth * 0.8 maskAlpha:0.6 scaleY:1 direction:CWDrawerTransitionFromLeft backImage:nil];
//    WS(weakSelf);
//    vc.selectCoinBlock = ^(SSKJ_Market_Index_Model * _Nonnull coinModel) {
//        weakSelf.model = coinModel;
//        [weakSelf refreshCodeDate];
//
//    };
//    [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeDefault configuration:config];
//}

-(void)rigthBtnAction:(id)sender{
//    if (!self.model.code.length) {
//        return;
//    }
    HeYue_KlineViewController *vc = [[HeYue_KlineViewController alloc]init];
    vc.isNeedPop = YES;
    vc.coinModel = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -- 建表 --
- (SSKJ_TableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[SSKJ_TableView alloc]initWitDeletage:self];
        [_tableView registerClass:[Heyue_WeiTuo_Order_Cell class] forCellReuseIdentifier:WeiTuoCellID];
        [_tableView registerClass:[Heyue_Nodata_Cell class] forCellReuseIdentifier:NodataCellID];
        _tableView.tableHeaderView = self.headerView;
        [self.view addSubview:_tableView];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    }
    return _tableView;
}


//下拉刷新
- (void)refreshHeader
{
    [self requestGetLeverageURLURL];
}




- (HeYue_Root_HeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [[HeYue_Root_HeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(523))];
        WS(weakSelf);
        _headerView.HeyueBaoCangBlock = ^{
            [weakSelf.view endEditing:YES];
            [weakSelf createbaocangAlertView];
        };
        _headerView.HeyueCreateOrderBlock = ^(NSDictionary * _Nonnull params) {
             [weakSelf.view endEditing:YES];
            [weakSelf request_CreateOrder_URL:params];
        };
        _headerView.HeyuegLoginBlock = ^{
             [weakSelf.view endEditing:YES];
            [weakSelf login];
        };
    }
    return _headerView;
}
#pragma mark -- UITableViewDelegate --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.dataSource.count == 0) {
        return 1;
    }
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ScaleW(50);
}


- (Heyue_root_OrderSectionView *)sectionView
{
    if (!_sectionView) {
        Heyue_root_OrderSectionView *view = [[Heyue_root_OrderSectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(50))];
        view.isTimeHeyue = NO;
            WS(weakSelf);
            view.AllOrderBlock = ^{
                if (kLogin != 1) {
                    [weakSelf login];
                    return ;
                }
                Heyue_OrderDetail_ViewController *vc = [[Heyue_OrderDetail_ViewController alloc]init];
                vc.seletedIndex = 0;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
        _sectionView = view;
    }
    return _sectionView;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.sectionView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataSource.count == 0) {
        return ScaleW(300);
    }
    return ScaleW(205);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSource.count == 0) {
        Heyue_Nodata_Cell *cell = [tableView dequeueReusableCellWithIdentifier:NodataCellID forIndexPath:indexPath];
        return cell;
    }else{
        Heyue_WeiTuo_Order_Cell *cell = [tableView dequeueReusableCellWithIdentifier:WeiTuoCellID forIndexPath:indexPath];
        WS(weakSelf);
    cell.bottomGrayView.hidden = NO;
    if (indexPath.row == self.dataSource.count - 1) {
        cell.bottomGrayView.hidden = YES;

    }
        //撤单
        cell.HeyueCheDanBlock = ^{
            [weakSelf.chedanAlertView initDataWithWeituoModel:self.dataSource[indexPath.row]];
            [weakSelf.chedanAlertView showAlertView];
        };
        cell.weituoModel = self.dataSource[indexPath.row];
        return cell;
    }
    
}

#pragma mark  请求资产信息
- (void)requestAssetInfo
{
    
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:Lion_Asset_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netWorkModel.status.integerValue == SUCCESSED )
        {
            
            Lion_Assets_new_Model *assetModel = [Lion_Assets_new_Model mj_objectWithKeyValues:netWorkModel.data];
            
            weakSelf.headerView.wallone_usdt = assetModel.balance;
        }
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD showError:SSKJLanguage(@"网络异常")];

    }];
}


#pragma mark - 网络请求 请求行情列表  下拉数据
-(void)requestMarketList
{
    
    WS(weakSelf);
    //kMarketURL
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_BBCoinList_URL RequestType:RequestTypeGet Parameters:@{@"code":@"/USDT"} Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if (network_Model.status.integerValue == SUCCESSED)
         {
             [weakSelf handleMarketListWith:network_Model];
         }
         else
         {
             [MBProgressHUD showError:network_Model.msg];
         }
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         //[MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         
         [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
     }];
}

-(void)handleMarketListWith:(WL_Network_Model *)network_model
{
    NSArray *array = [SSKJ_Market_Index_Model mj_objectArrayWithKeyValuesArray:network_model.data];
    
    
    
    
    if (array.count > 0)
    {
        if (![self hasCurrentModel:array])
        {
            self.model = array.firstObject;
        }
        [self refreshCodeDate];
    }
    
}
- (BOOL) hasCurrentModel:(NSArray *)array
{
    for (SSKJ_Market_Index_Model *model in array)
    {
        if ([self.model.code isEqualToString:model.code])
        {
            return YES;
        }
    }
    return NO;
}


#pragma mark -- 网络请求 --

#pragma mark -- 加载不同币种的杠杆和最小购买数 --
- (void)requestGetLeverageURLURL
{
    if (self.model.code.length < 1)
    {
        [self endRefresh];
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *params = @{@"code":self.model.code};
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_HEYUE_Setting_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
        [hud hideAnimated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200)
        {

            
            weakSelf.leverageModel = [Heyue_Leverage_Model mj_objectWithKeyValues:netModel.data];
            weakSelf.leverageModel.code = weakSelf.model.code;
            weakSelf.headerView.leverageModel = weakSelf.leverageModel;
            //change
            weakSelf.headerView.baoCang = [NSString stringWithFormat:@"%@%@",[SSTool disposePname:@"2" price:[NSString stringWithFormat:@"%.9f", weakSelf.leverageModel.bc_rate.doubleValue]],@"%"];
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }
        
        [self endRefresh];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
    {
        [self endRefresh];
        [hud hideAnimated:YES];
    }];
}
#pragma mark -- 盘口请求 --
- (void)request_Getdepth_URL{
    
    if (self.model.code.length < 1) {
        return;
    }
    WS(weakSelf);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *params = @{@"code":self.model.code,@"type":@"depth"};
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_BBCoinPankou_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
        [hud hideAnimated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200)
        {
            weakSelf.pankouModel = [PanKou_Socket_Model mj_objectWithKeyValues:[netModel.data firstObject]];
            weakSelf.pankouModel.code = weakSelf.model.code;
            weakSelf.headerView.pankouModel = weakSelf.pankouModel;
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
    }];
}
#pragma mark 深度图首次加载
- (void)requestGet_shendu_URL{
    
    if (self.model.code.length < 1) {
        return;
    }
    MBProgressHUD *hud;
    if (self.dataSource.count == 0){
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    NSDictionary * params = @{@"code":self.model.code,@"type":@"pct"};
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_BBCoinDeep_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        WL_Network_Model *netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netWorkModel.status.integerValue == 200) {

            self.headerView.shenduDic = [netWorkModel.data firstObject];
        }else{
            [MBProgressHUD showError:netWorkModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
    }];

}

#pragma mark -- 合约下单 --
- (void)request_CreateOrder_URL:(NSDictionary *)params{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    //Heyue_CreateOrder_URL
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_HEYUE_CreateOrder_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == 200) {
            Heyue_OrderDetail_ViewController *vc = [[Heyue_OrderDetail_ViewController alloc]init];
            if ([params[@"type"] integerValue] == 1) {
                vc.seletedIndex = 0;
            }else{
                vc.seletedIndex = 1;
            }
//            vc.model = weakSelf.model;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
    }];
}

#pragma mark 委托单请求
- (void)requestWeiTuoOrder_URL_Pull
{
    if (!kLogin)
    {
        [self endRefresh];
        return;
    }
    if (!self.model.code.length)
    {
        [self endRefresh];
        return;
    }
    NSDictionary *params = @{
                            @"data_type":@"2",
                             @"page":@"1",
                            @"code":self.model.code
                             };
    WS(weakSelf);
    
    //Heyue_Weituo_Api
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_HEYUE_List_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200)
        {
            [weakSelf handleExchangeListWithModel:netModel];
        }
        [weakSelf endRefresh];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
    {
        [weakSelf endRefresh];
    }];
}

-(void)handleExchangeListWithModel:(WL_Network_Model *)net_model
{
    
    NSMutableArray *array = [Heyue_OrderDdetail_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"data"]];
    [self.dataSource setArray:array];

    [self.tableView reloadData];
}



-(void)endRefresh
{
    if (self.tableView.mj_header.state == MJRefreshStateRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    
    if (self.tableView.mj_footer.state == MJRefreshStateRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}


#pragma mark -- 委托撤单 --
- (void)request_CheDan_URL:(Heyue_OrderDdetail_Model *)model{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = @{
                             @"order_id":model.ID
                            };
    //Heyue_Chedan_Api
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_HEYUE_RevokeOrder_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200)
        {
            [self requestWeiTuoOrder_URL_Pull];
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
    }];
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark -- 弹框懒加载 --
#pragma mark -  风险率弹框 --
- (void)createbaocangAlertView{
    
    if (self.leverageModel.bc_rate.length == 0) {
        return;
    }
    
    [SSKJ_Default_AlertView showWithTitle:SSKJLocalized(@"风险率提醒", nil) message:[NSString stringWithFormat:SSKJLocalized(@"当风险率小于等于%@%%时，系统将自动平仓", nil),self.leverageModel.bc_rate] cancleTitle:nil confirmTitle:SSKJLocalized(@"确定", nil) confirmBlock:^{
        
    }];
}

#pragma mark - 撤单弹框 --
- (HeYue_CheDan_AlertView *)chedanAlertView{
    if (_chedanAlertView == nil) {
        _chedanAlertView = [[HeYue_CheDan_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        WS(weakSelf);
        _chedanAlertView.CheDanBlock = ^(Heyue_OrderDdetail_Model * _Nonnull weituoModel) {
            [weakSelf request_CheDan_URL:weituoModel];
        };
        
    }
    return _chedanAlertView;
}


#pragma mark - login
-(void)login
{
    [self presentLoginController];
}


@end
