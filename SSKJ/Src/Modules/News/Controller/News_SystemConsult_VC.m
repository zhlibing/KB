//
//  GoCoin_SystemConsult_VC.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/3/29.
//  Copyright © 2019 Wang. All rights reserved.
//


#import "News_SystemConsult_VC.h"

#import "News_System_Cell.h"

#import "Home_NewsDetail_ViewController.h"

#import "Market_Index_Banner_Model.h"

#import "News_Zizun_Index_Model.h"

#import "SDCycleScrollView.h"


#define kPage_Size @"10"

@interface News_SystemConsult_VC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) SSKJ_TableView *tableView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger page;





@end

@implementation News_SystemConsult_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self headerRefresh];
}

#pragma mark - 列表表格视图
-(SSKJ_TableView *)tableView
{
    if (_tableView==nil)
    {
        _tableView=[[SSKJ_TableView alloc] initWitDeletage:self];
        [_tableView registerClass:[News_System_Cell class] forCellReuseIdentifier:@"News_System_Cell"];
        _tableView.backgroundColor=kBgColor;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.top.bottom.equalTo(@0);
            make.width.equalTo(@(ScreenWidth));
        }];
        

        WS(weakSelf);

        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
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
    [self requestGetincomeUrl];
}

-(void)footerRefresh
{
    [self requestGetincomeUrl];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(130);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    News_System_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"News_System_Cell"];
    [cell initDataWithModel:self.dataSource[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    News_Zizun_Index_Model *model = self.dataSource[indexPath.row];
    Home_NewsDetail_ViewController *vc = [[Home_NewsDetail_ViewController alloc]init];
    vc.detailType = DetailTypeNews;
    vc.newsModel = model;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark -- 获取系统资讯 --
- (void)requestGetincomeUrl
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = @{
                             @"type":@(2),
                             @"page":@(self.page),
                             };
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JBWallet_ZixunList_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netWorkModel.status.integerValue == SUCCESSED ) {
            [weakSelf handleListWith:netWorkModel];
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

-(void)handleListWith:(WL_Network_Model *)net_model
{
    NSArray * array = [News_Zizun_Index_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"data"]];
    
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
    }
    
    
    if (array.count != kPage_Size.integerValue) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:Height_NavBar];
    
    self.page++;
    
    [self endRefresh];

    
    [self.tableView reloadData];
    
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
