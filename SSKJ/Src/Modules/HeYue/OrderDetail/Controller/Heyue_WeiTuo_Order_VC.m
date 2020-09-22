//
//  Heyue_WeiTuo_Order_VC.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/8/3.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_WeiTuo_Order_VC.h"

#import "Heyue_WeiTuo_Order_Cell.h"

#import "HeYue_CheDan_AlertView.h"//撤单弹框

#import "Heyue_OrderDdetail_Model.h"
#import "Heyue_AllPingCang_AlertView.h"
#import "SSKJ_NoDataView.h"



#define kPageSize @"50"

static NSString *WeiTuoOrderID = @"WeiTuoOrderID";

@interface Heyue_WeiTuo_Order_VC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) CGPoint begin;
@property (nonatomic,strong) SSKJ_TableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataSource;

@property (nonatomic, strong) HeYue_CheDan_AlertView *chedanAlertView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UIButton *allBtn;
@property (nonatomic, strong) Heyue_AllPingCang_AlertView *allPingCangAlertView;



@end

@implementation Heyue_WeiTuo_Order_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBgColor;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.allBtn];
    [self requestWeiTuoOrder_URL];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(@(ScaleW(5)));
        make.left.bottom.right.equalTo(@(ScaleW(0)));
    }];
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.equalTo(@(ScaleW(-16)));
       make.bottom.equalTo(@(ScaleW(-100)));
       make.width.height.equalTo(@(ScaleW(56)));
        
    }];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];    
}


-(void)setItemArry:(NSArray*)array
{
    [self.dataSource setArray:array];
    [self.tableView reloadData];
}






#pragma mark - Getter / Setter
- (SSKJ_TableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[SSKJ_TableView alloc]initWitDeletage:self];
        [_tableView registerClass:[Heyue_WeiTuo_Order_Cell class] forCellReuseIdentifier:WeiTuoOrderID];
    }
    return _tableView;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self.allBtn setHidden:!self.dataSource.count];
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
    return self.dataSource.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(205);
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Heyue_WeiTuo_Order_Cell *cell = [tableView dequeueReusableCellWithIdentifier:WeiTuoOrderID forIndexPath:indexPath];
    WS(weakSelf);
    
    cell.bottomGrayView.hidden = NO;
    if (indexPath.row == self.dataSource.count - 1) {
        cell.bottomGrayView.hidden = YES;
    }
    
    //撤单
    cell.HeyueCheDanBlock = ^{
        [weakSelf.chedanAlertView initDataWithWeituoModel:weakSelf.dataSource[indexPath.row]];
        [weakSelf.chedanAlertView showAlertView];
    };
    cell.weituoModel = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark 委托网络请求
- (void)requestWeiTuoOrder_URL
{
    WS(weakSelf);
    NSDictionary *params = @{@"data_type":@"2",
                             @"page":@"1"};
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_HEYUE_List_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200)
        {
            [weakSelf handleExchangeListWithModel:netModel];
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }

    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {}];
}

-(void)handleExchangeListWithModel:(WL_Network_Model *)net_model
{
    NSMutableArray *array = [Heyue_OrderDdetail_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"data"]];
    [self.dataSource setArray:array];
    [self.tableView reloadData];
    
}

#pragma mark 委托撤单
- (void)request_CheDan_URL:(Heyue_OrderDdetail_Model *)model
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *params = @{@"order_id":model.ID};
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_HEYUE_RevokeOrder_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        [hud hideAnimated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == 200)
        {
            [self requestWeiTuoOrder_URL];
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
        [hud hideAnimated:YES];
    }];
}


#pragma mark 撤单弹框
- (HeYue_CheDan_AlertView *)chedanAlertView
{
    if (_chedanAlertView == nil) {
        _chedanAlertView = [[HeYue_CheDan_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        WS(weakSelf);
        _chedanAlertView.CheDanBlock = ^(Heyue_OrderDdetail_Model * _Nonnull weituoModel) {
            [weakSelf request_CheDan_URL:weituoModel];
        };
    }
    return _chedanAlertView;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark  全部平仓按钮
- (UIButton *)allBtn
{
    if (_allBtn == nil)
    {
        _allBtn = [WLTools allocButton:nil textColor:nil nom_bg:nil hei_bg:nil frame:CGRectZero];
        [_allBtn setTag:123];
        _allBtn.cornerRadius = ScaleW(28);
        [_allBtn addTarget:self action:@selector(allAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_allBtn setBackgroundImage:UIImageNamed(SSKJLanguage(@"hy_pingcang")) forState:UIControlStateNormal];
    }
    return _allBtn;
}

#pragma mark 一键平仓 全部平仓 点击事件
- (void)allAction
{
    [self.allPingCangAlertView showWithMessage:SSKJLocalized(@"是否确认要全部平仓?", nil)];
}

#pragma mark 键平仓
- (Heyue_AllPingCang_AlertView *)allPingCangAlertView
{
    if (_allPingCangAlertView == nil) {
        _allPingCangAlertView = [[Heyue_AllPingCang_AlertView alloc]initWithFrame:self.view.bounds];
        WS(weakSelf);
        self.allPingCangAlertView.AllPingCangBlock = ^{
            [weakSelf allPingCangRequstion];
        };
    }
    return _allPingCangAlertView;
}


#pragma mark - 一键平仓请求
- (void)allPingCangRequstion{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WS(weakSelf);
    //Heyue_AllPingcang_Api
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_HEYUE_DoneAll_URL RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject)
    {
        [hud hideAnimated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200)
        {
            [weakSelf.allPingCangAlertView removeFromSuperview];
            [MBProgressHUD showError:SSKJLocalized(@"平仓成功", nil)];
            [weakSelf requestWeiTuoOrder_URL];
        }
        else
        {
            [MBProgressHUD showError:SSKJLocalized(@"平仓失败", nil)];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
    {
        [hud hideAnimated:YES];
    }];
}












@end
