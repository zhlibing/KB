//
//  GoCoin_TradingGuide_VC.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/3/29.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "News_TradingGuide_VC.h"

#import "News_Trading_Cell.h"

#import "News_TradingGuide_Model.h"

#import "SSKJ_NoDataView.h"

#import "Home_NewsDetail_ViewController.h"

#import "Market_Index_Banner_Model.h"
#import "SDCycleScrollView.h"


#define kPage_Size @"10"

@interface News_TradingGuide_VC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic,strong) SSKJ_TableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;


@end

@implementation News_TradingGuide_VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = SSKJLanguage(@"交易指南");
    
    [self tableView];
    [self headerRefresh];
}


#pragma mark - 列表表格视图
-(SSKJ_TableView *)tableView
{
    if (_tableView==nil)
    {
        _tableView=[[SSKJ_TableView alloc] initWitDeletage:self];
        [_tableView registerClass:[News_Trading_Cell class] forCellReuseIdentifier:@"News_Trading_Cell"];
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.top.bottom.equalTo(@0);
            make.width.equalTo(@(ScreenWidth));
        }];
        
        WS(weakSelf);
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
        
        _tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf footerRefresh];
        }];
        
    }
    
    return _tableView;
}

- (void)headerRefresh
{
    self.page = 1;
    
    [self requestGetjyznGUrl];
}



- (void)footerRefresh
{
    [self requestGetjyznGUrl];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(55);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    News_Trading_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"News_Trading_Cell"];
    [cell initDataWithModel:self.dataSource[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Home_NewsDetail_ViewController *vc = [[Home_NewsDetail_ViewController alloc]init];
    
    Home_NoticeIndex_Model *model = self.dataSource[indexPath.row];
    
    vc.model = model;
    
    [self.navigationController pushViewController:vc animated:YES];
}





- (NSMutableArray *)dataSource
{
    if (_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}



#pragma mark -- 获取交易指南 --
- (void)requestGetjyznGUrl
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = @{
                             @"page":@(self.page),
                             @"type":@"12"
                             };
    
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_Protocol_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netWorkModel.status.integerValue == SUCCESSED ) {

            [weakSelf handleListWithModel:netWorkModel];
            
        }
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];
            [weakSelf endRefresh];
            
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        [weakSelf endRefresh];
    }];
}


-(void)handleListWithModel:(WL_Network_Model *)model
{
    NSArray * array = [Home_NoticeIndex_Model mj_objectArrayWithKeyValuesArray:model.data[@"data"]];
    
    if (self.page == 1)
    {
        [self.dataSource removeAllObjects];
    }
    
    
    if (array.count != kPage_Size.integerValue)
    {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
    else
    {
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:ScaleW(Height_NavBar)];
    
    self.page++;
    
    [self endRefresh];
    
    [self.tableView reloadData];
    
}




@end
