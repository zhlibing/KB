//
//  BI_MainMarket_Root_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/6/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "Home_Root_ViewController.h"
#import "Market_KeyBuyCoin_VC.h"
#import "SSKJ_TabbarController.h"



// controller
#import "Home_NoticeList_ViewController.h"
#import "SystemNoticeViewController.h"
#import "SSKJ_BaseNavigationController.h"
#import "SY_InviteViewController.h"

// view
#import "Home_Market_HeaderView.h"
#import "Home_Market_Cell.h"
#import "SSKJ_Market_Index_Model.h"
#import "Mine_Version_AlertView.h"
#import "Nodata_Cell.h"
// model
#import "Mine_Version_Model.h"
#import "Home_NoticeIndex_Model.h"

#import "LoginViewController.h"
#import "HeYue_KlineViewController.h"

#import "SSKJ_Socket_Tool.h"
#import "RightImageView.h"

#import "News_TradingGuide_VC.h"
#import "My_Generalize_RootViewController.h"

static NSString *cellId = @"Home_News_Cell";
static NSString *nodaCellId = @"nodaCellId";


@interface Home_Root_ViewController ()<UITableViewDelegate,UITableViewDataSource,ManagerSocketDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) Home_Market_HeaderView *headerView;
@property (nonatomic, strong) UIView *sectionHeaderView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) ManagerSocket *marketSocket;


@property (nonatomic, strong) NSArray<Home_MarketBanner_Model *> *bannerArray;

@property (nonatomic, strong) Mine_Version_Model *versionModel;

@property (nonatomic, strong) NSArray *noticeArray;


@end

@implementation Home_Root_ViewController

#pragma mark - 初始化

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.marketSocket = [[ManagerSocket alloc]initWithUrl:MarketSocketUrl identifier:@"market"];
    
    [self.view addSubview:self.tableView];
    
    [self checkVersion];
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
#pragma mark - 页面即将显示
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:![SSTool isRoot]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];

    [self headerRefresh];

}

#pragma mark - 页面即将消失
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];

    [self closeSocket];
}


-(NSMutableArray *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataSource;
}


#pragma mark - UI
-(UITableView *)tableView
{
    if (nil == _tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_TabBar) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerClass:[Home_Market_Cell class] forCellReuseIdentifier:cellId];

        [_tableView registerClass:[Nodata_Cell class] forCellReuseIdentifier:nodaCellId];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = kSubBgColor;
        WS(weakSelf);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
        
    }
    return _tableView;
}

#pragma mark - 用户操作
-(Home_Market_HeaderView *)headerView
{
    if (nil == _headerView)
    {
        _headerView = [[Home_Market_HeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 540)];
        WS(weakSelf);
        _headerView.bannerBlock = ^(NSInteger index)
        {
            
        };
        _headerView.noticeBlock = ^(NSInteger index) {
            if (weakSelf.noticeArray.count == 0) {
                return ;
            }
            Home_NewsDetail_ViewController *vc = [[Home_NewsDetail_ViewController alloc]init];
            vc.detailType = DetailTypeNotice;
            Home_NoticeIndex_Model *noticeModel = weakSelf.noticeArray[index];
            vc.model = noticeModel;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        _headerView.noticeMoreBlock = ^{
            Home_NoticeList_ViewController *vc = [[Home_NoticeList_ViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        _headerView.hotCoinBlock = ^(SSKJ_Market_Index_Model * _Nonnull coinModel) {

            if (!coinModel) {
                return;
            }
            HeYue_KlineViewController *vc = [[HeYue_KlineViewController alloc]init];
            vc.coinModel = coinModel;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };

        
        _headerView.invicateBlock = ^(NSInteger index) {
            
            if (kLogin)
            {
               switch (index)
               {
#pragma mark case 1 用户资产
                   case 1:
                   {
                       SSKJ_TabbarController *tabbar = [[SSKJ_TabbarController alloc]init];
                       [tabbar setSelectedIndex:3];
                       [AppWindow setRootViewController:tabbar];
                   }
                       break;
#pragma mark case 2 快捷买币
                   case 2:
                   {
                       Market_KeyBuyCoin_VC *vc = [[Market_KeyBuyCoin_VC alloc]init];
                       [weakSelf.navigationController pushViewController:vc animated:YES];
                       
                   }
                       break;
                   case 3:
                   {
                       SY_InviteViewController *vc = [SY_InviteViewController new];
                       [weakSelf.navigationController pushViewController:vc animated:YES];
                   }
                       break;
               }
            }
            else
            {
                [weakSelf presentLoginController];
            }
        };
    
        
        
       
    }
    return _headerView;
}


-(UIView *)sectionHeaderView
{
    if (nil == _sectionHeaderView) {
        _sectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(40))];
        _sectionHeaderView.backgroundColor = kBgColor;
        

    
    
        UILabel *name = [[UILabel alloc]init];
        [name setFont:systemFont(ScaleW(14))];
        [name setText:SSKJLanguage(@"名称")];
        [name setTextColor:kGrayColor];
        [_sectionHeaderView addSubview:name];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(15)));
            make.height.equalTo(@(ScaleW(40)));
            make.centerY.equalTo(_sectionHeaderView.mas_centerY);
        }];
        
        
        UILabel *price = [[UILabel alloc]init];
        [price setFont:systemFont(ScaleW(14))];
        [price setText:SSKJLanguage(@"价格")];
        [price setTextColor:kGrayColor];
        [_sectionHeaderView addSubview:price];
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_sectionHeaderView.mas_centerX);
            make.height.centerY.equalTo(name);
        }];
        
        
        UILabel *rate = [[UILabel alloc]init];
        [rate setFont:systemFont(ScaleW(14))];
        [rate setText:SSKJLanguage(@"涨跌幅")];
        [rate setTextColor:kGrayColor];
        [_sectionHeaderView addSubview:rate];
        [rate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(ScaleW(-15)));
            make.centerY.equalTo(name);
        }];

        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = kLineColor;
        [_sectionHeaderView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_sectionHeaderView);
            make.top.equalTo(_sectionHeaderView.mas_bottom);
            make.height.equalTo(@(0.5));
        }];
    }
    return _sectionHeaderView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.sectionHeaderView.height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.sectionHeaderView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource.count != 0) {
        return self.dataSource.count;//
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count != 0) {
        return ScaleW(60);
    }else{
        return ScaleW(400);
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.dataSource.count > 0) {
        Home_Market_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        SSKJ_Market_Index_Model *model = self.dataSource[indexPath.row];
        [cell setCellWithModel:model];

        return cell;
    }else{
        Nodata_Cell *cell = [tableView dequeueReusableCellWithIdentifier:nodaCellId];
        [cell setCellWithTitle:SSKJLocalized(@"暂无记录", nil)];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count == 0) {
        return;
    }
    HeYue_KlineViewController *vc = [[HeYue_KlineViewController alloc]init];
    vc.coinModel = self.dataSource[indexPath.row];
//    vc.isFromHome = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 刷新页面

-(void)headerRefresh
{
    
    [self requestMainCoinList];
    [self requestNoticeList];

    if (kLogin) {
        [self loadUserInfo];
    }
}


-(void)endRefresh
{
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - WebSocket
-(void)openSocket
{
    WS(weakSelf);
    self.marketSocket.delegate = self;
    [self.marketSocket openConnectSocketWithConnectSuccess:^{
        NSArray *array = [weakSelf getCurrentCoinList];
        NSString *codeString = @"ticker@";
        for (NSString *code in array) {
            if ([codeString hasSuffix:@"@"]) {
                codeString = [codeString stringByAppendingString:code];
            }else{
                codeString = [codeString stringByAppendingFormat:@"|%@",code];
            }
        }
        
        NSString *type = [WLTools convertToJson:@{@"sub":codeString}];
        
        [weakSelf.marketSocket socketSendMsg:type];
        
        [weakSelf.marketSocket startSendHeartTimer];
    }];
}

-(void)closeSocket
{
    [self.marketSocket closeConnectSocket];
}

#pragma mark - 当前列表币种
- (NSArray *)getCurrentCoinList{
    NSMutableArray *array = [NSMutableArray array];

    for (SSKJ_Market_Index_Model *model in self.dataSource) {
        [array addObject:model.code];
    }
    
    return [array copy];
}

#pragma mark - 网络请求 行情

-(void)requestMainCoinList
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_BBCoinList_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         [weakSelf.tableView.mj_header endRefreshing];
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
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         [weakSelf.tableView.mj_header endRefreshing];
         [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
     }];
}


-(void)handleMarketListWith:(WL_Network_Model *)network_model
{
    NSArray *array = [SSKJ_Market_Index_Model mj_objectArrayWithKeyValuesArray:network_model.data];
    
    if (self.dataSource.count == 0) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"didGetCoinModel" object:array.firstObject];
    }

    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:array];
    [self.tableView reloadData];
    
  
    self.headerView.coinArray = array;
    
    [self openSocket];
    
    
    
}

#pragma mark - 轮播图
-(void)requestBanner
{
    
    NSDictionary *params = @{@"position":@"2",
                             @"type":@"1"
                             };
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JBWallet_NewsHeader_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        
        WL_Network_Model *netmodel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netmodel.status.integerValue == SUCCESSED)
        {
            NSArray *array = [[netmodel.data firstObject] objectForKey:@"image"];
            NSMutableArray *itemArray = [NSMutableArray array];
            for (NSString * url in array)
            {
                Home_MarketBanner_Model *model = [[Home_MarketBanner_Model alloc]init];
                [model setImage:url];
                [itemArray addObject:model];
            }
            
            
            [weakSelf setBannerArray:itemArray];
            [weakSelf.headerView setBannerArray:itemArray];
            
        }
        else
        {
            [MBProgressHUD showError:netmodel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
    
    
}

#pragma mark - 系统公告
-(void)requestNoticeList
{
    
    NSDictionary *params = @{
                             @"page":@1,
                             @"type":@"2"
                             };
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JBWallet_NoticeList_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model *netmodel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netmodel.status.integerValue == SUCCESSED)
        {
            [weakSelf handleNoticeListWithModel:netmodel];
        }
        else
        {
            [MBProgressHUD showError:netmodel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
    
    
}

-(void)handleNoticeListWithModel:(WL_Network_Model *)net_model
{
    NSArray *array = [Home_NoticeIndex_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"data"]];
    self.noticeArray = array;
    
    [self.headerView setNoticeArray:self.noticeArray];
    
}

#pragma mark - 请求弹窗公告

-(void)requestNoticeAlert
{
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JBWallet_NoticeList_URL RequestType:RequestTypeGet Parameters:@{@"type":@4} Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model *netmodel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netmodel.status.integerValue == SUCCESSED)
        {
   
            NSString *title = netmodel.data[@"title"];
    
            NSString *detail = [WLTools filterHTML:netmodel.data[@"content"]];
            
            if (title.length != 0 && detail.length !=0)
            {
                SystemNoticeViewController* vc = [[SystemNoticeViewController alloc]init];
                vc.content = detail;
                vc.titleString = title;
                vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
                
                [self.navigationController presentViewController:vc animated:NO completion:^{
                    vc.view.superview.backgroundColor = [UIColor clearColor];
                    }];
            }
        }
        else
        {
            [MBProgressHUD showError:netmodel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
}

#pragma mark - 检测版本更新
-(void)checkVersion
{
    NSDictionary *dict=@{
                            @"type":@"2",
                            @"version":kAppVersion
                         };
    
    SSLog(@"\r版本->请求参数：%@",dict);
    
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_CheckVersion_URL RequestType:RequestTypeGet Parameters:dict Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {
            weakSelf.versionModel=[Mine_Version_Model mj_objectWithKeyValues:network_Model.data];
            
            if (weakSelf.versionModel == nil || [weakSelf.versionModel.vercode compare:kAppVersion] == kCFCompareLessThan || [weakSelf.versionModel.vercode isEqualToString:kAppVersion])
            {
                [weakSelf requestNoticeAlert];
                return ;
            }
            else
            {
                [Mine_Version_AlertView showWithModel:weakSelf.versionModel confirmBlock:^{
                    [weakSelf upgrade_Button_Event];
                } cancleBlock:^{
                    [weakSelf requestNoticeAlert];
                    
                }];

            }
            
            
        }
        else
        {
            [weakSelf requestNoticeAlert];

        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
    {
        [weakSelf requestNoticeAlert];

    }];
    
}


#pragma mark - 版本更新控制 立即更新 事件
-(void)upgrade_Button_Event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.versionModel.address]];
}
#pragma mark - SocketmanagerDelegate

- (void)socketDidReciveData:(NSDictionary *)dic identifier:(NSString *)identifier{
    
    if (![identifier isEqualToString:@"market"]) {
        return;
    }
    
    SSKJ_Market_Index_Model *model = [SSKJ_Market_Index_Model mj_objectWithKeyValues:dic];
    for (int i = 0; i < self.dataSource.count; i++) {
        SSKJ_Market_Index_Model *indexModel = self.dataSource[i];
        if ([indexModel.code isEqualToString:model.code]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            model.image = indexModel.image;
            [self.dataSource replaceObjectAtIndex:i withObject:model];

           Home_Market_Cell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            [cell setCellWithModel:model];
            if (i < 3) {
                self.headerView.coinArray = self.dataSource;
            }
        }
    }

}


#pragma mark 请求用户信息
- (void)loadUserInfo
{
            
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_UserInfo_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {
            SSKJ_UserInfo_Model *userModel = [SSKJ_UserInfo_Model mj_objectWithKeyValues:network_Model.data];
            [[SSKJ_User_Tool sharedUserTool] setUserInfoModel:userModel];
        }
        else
        {
            [MBProgressHUD showError:network_Model.msg];
        }
        
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
    
}


@end
