//
//  Market_NoticeList_ViewController.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/4/8.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "Home_NoticeList_ViewController.h"

#import "Home_Notice_Cell.h"

#import "Home_NewsDetail_ViewController.h"

#import "News_TradingGuide_Model.h"

#import "Home_NoticeIndex_Model.h"

#define kPage_Size @"10"

@interface Home_NoticeList_ViewController ()<UITableViewDelegate,UITableViewDataSource>
    
@property (nonatomic,strong) SSKJ_TableView *tableView;
    
@property (nonatomic,strong) NSMutableArray *dataSource;
    
@property (nonatomic, assign) NSInteger page;


@end

@implementation Home_NoticeList_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = SSKJLocalized(@"公告列表", nil);
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(Height_NavBar, 0, 0, 0));
    }];
    self.page = 1;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self headerRefresh];
}
    
    
#pragma mark - 列表表格视图
-(SSKJ_TableView *)tableView
{
    if (_tableView==nil)
    {
        _tableView=[[SSKJ_TableView alloc] initWitDeletage:self];
        [_tableView registerClass:[Home_Notice_Cell class] forCellReuseIdentifier:@"Home_Notice_Cell"];
        
        _tableView.mj_header=[MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        
        WS(weakSelf);
        
        _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [weakSelf footerRefresh];
        }];
        
    }
    
    return _tableView;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(80);
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Home_Notice_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Home_Notice_Cell"];
    [cell setModel:self.dataSource[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Home_NoticeIndex_Model *model = self.dataSource[indexPath.row];
    Home_NewsDetail_ViewController *vc = [[Home_NewsDetail_ViewController alloc]init];
    vc.detailType = DetailTypeNotice;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - 系统公告
-(void)requestNoticeList
{
    
    NSDictionary *params = @{
                             @"page":@(self.page),
                             @"type":@"2"
                             };
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JBWallet_NoticeList_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        WL_Network_Model *netmodel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netmodel.status.integerValue == SUCCESSED)
        {
            [weakSelf handleListWithModel:netmodel];
        }
        else
        {
            [MBProgressHUD showError:netmodel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }];
    
    
}



    
-(void)handleListWithModel:(WL_Network_Model *)model
{
    NSArray * array = [Home_NoticeIndex_Model mj_objectArrayWithKeyValuesArray:model.data[@"data"]];
    
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
    }
    
    
    if (array.count != kPage_Size.integerValue) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
    
    self.page++;
    
    [self endRefresh];
    
    [self.tableView reloadData];
    
}
    
- (void)headerRefresh
{
    self.page = 1;
    
    [self requestNoticeList];
    
}
    
- (void)footerRefresh
{
    [self requestNoticeList];
    
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

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
