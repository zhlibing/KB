//
//  Heyue_ChiCang_Order_VC.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/8/3.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_ChiCang_Order_VC.h"

#import "Heyue_ChiCang_Order_Cell.h"

#import "Heyue_AllPingCang_AlertView.h"//一键平仓 弹框

#import "HeYue_PingCang_AlertView.h"//平仓弹框

#import "HeYue_EditWinLoss_AlertView.h"//修改止盈止损

#import "Heyue_OrderWinLoss_Model.h"//最大最小止盈止损Model

#import "Heyue_OrderDdetail_Model.h"

#import "SSKJ_NoDataView.h"

#import "Heyue_Done_AlertView.h"

#import "Heyue_Leverage_Model.h"





static NSString *ChiCangOrderID = @"ChiCangOrderID";

#define kPageSize @"50"
#define CoinMarketSocket @"CoinSocket"

@interface Heyue_ChiCang_Order_VC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataSource;

@property (nonatomic,strong) UIButton * allBtn;

@property (nonatomic,strong) Heyue_AllPingCang_AlertView *allPingCangAlertView;

@property (nonatomic,strong) HeYue_PingCang_AlertView *pingCangAlertView;

@property (nonatomic,strong) HeYue_EditWinLoss_AlertView *editWinLossAlertView;

@property (nonatomic,assign) NSInteger seletedIndex;//标记选中个那个Cell  止盈止损时用

@property (nonatomic,strong) Heyue_OrderWinLoss_Model * winLossmodel;//止盈止损Model

@property (nonatomic, strong) Heyue_OrderDdetail_Model *curredntModel;
@property(nonatomic, strong)Heyue_Leverage_Model *leverageModel;

@end

@implementation Heyue_ChiCang_Order_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBgColor;

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.allBtn];
    [self requestChiCangOrder_URL];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(ScaleW(5)));
        make.left.bottom.right.equalTo(@(ScaleW(0)));
    }];
    
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.equalTo(@(ScaleW(-30)));
       make.bottom.equalTo(@(ScaleW(-100)));
       make.width.height.equalTo(@(ScaleW(56)));
    }];
}



-(void)setItemArry:(NSArray*)array
{
    [self.dataSource setArray:array];
    [self.tableView reloadData];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}




- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kBgColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(150))];
        if (@available(iOS 11.0, *)){
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerClass:[Heyue_ChiCang_Order_Cell class] forCellReuseIdentifier:ChiCangOrderID];
        
    }
    return _tableView;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.allBtn.hidden = ![self.dataSource count];
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
    return self.dataSource.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(240);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Heyue_ChiCang_Order_Cell *cell = [tableView dequeueReusableCellWithIdentifier:ChiCangOrderID];
    WS(weakSelf);
    
    cell.bottomlineView.hidden = NO;
    if (indexPath.row == self.dataSource.count - 1) {
        cell.bottomlineView.hidden = YES;
    }
    //编辑（修改）
    cell.HeyueEditBlock = ^{
        
        weakSelf.seletedIndex = indexPath.row;
        weakSelf.curredntModel = weakSelf.dataSource[indexPath.row];
//        [weakSelf requestSettingInfoWith:weakSelf.dataSource[indexPath.row]];
        [weakSelf.editWinLossAlertView setViewWithOrderDic:weakSelf.curredntModel];
        [weakSelf.editWinLossAlertView showAlertView];
        
        
    };
    //平仓
    cell.HeyuePingCangBlock = ^{
        weakSelf.curredntModel = weakSelf.dataSource[indexPath.row];
//                [self.doneAlertView initDataWithWeituoModel:weakSelf.dataSource[indexPath.row]];
//                [weakSelf.doneAlertView showAlertView];
       
        [self.pingCangAlertView initDataWithDic:weakSelf.dataSource[indexPath.row]];
        [weakSelf.pingCangAlertView showAlertView];
    };
    cell.chicangModel = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark 持仓网络请求
- (void)requestChiCangOrder_URL
{
    
    [[WLHttpManager shareManager] cancleAllTask];
    NSDictionary *params = @{
                            @"data_type":@"1",
                             @"page":@"1",
                             };
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_HEYUE_DoingList_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200)
        {
            [weakSelf handleExchangeListWithModel:netModel];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {}];
}

-(void)handleExchangeListWithModel:(WL_Network_Model *)net_model
{
    NSArray *array = [Heyue_OrderDdetail_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"data"]];
    
    [self.dataSource setArray:array];
    WS(weakSelf);
    [UIView performWithoutAnimation:^{
        [weakSelf.tableView reloadData];
    }];
    
    for (Heyue_OrderDdetail_Model *model in self.dataSource) {
        if ([model.ID isEqualToString:self.curredntModel.ID] && self.pingCangAlertView.superview != nil) {
            [self.pingCangAlertView setMarketPriceView:model.marketPrice];
        }
        
        if ([model.ID isEqualToString:self.curredntModel.ID] && self.editWinLossAlertView.superview != nil)
        {
            [self.editWinLossAlertView updateNowPriceUI:model nowPrice:model.marketPrice];
        }
    }
    
}

#pragma mark 手动平仓网络请求
- (void)request_currentPingcang_URL:(Heyue_OrderDdetail_Model *)model number:(NSString *)number
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = @{
                             @"order_id":model.ID,
                             @"hands":number
                             };
    WS(weakSelf);
    //Heyue_currentPingcang_Api
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_HEYUE_Done_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        [hud hideAnimated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200)
        {
            [MBProgressHUD showError:netModel.msg];
            [weakSelf requestChiCangOrder_URL];
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
    }];
}



#pragma mark 修改止盈止损请求
- (void)requestEditWinLossWithWinStr:(NSString *)winStr lossStr:(NSString *)lossStr{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = @{
                            @"hold_id":self.curredntModel.ID,
                             @"zy":winStr,
                             @"zs":lossStr
                            };
    
    //Heyue_setPoitLossWin_Api
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_HEYUE_StopPrice_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == 200)
        {
            [MBProgressHUD showError:SSKJLocalized(@"修改成功", nil)];
            [self requestChiCangOrder_URL];
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
    }];
}


- (NSMutableArray *)dataSource
{
    if (_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


#pragma mark -- 修改止盈止损 --
- (HeYue_EditWinLoss_AlertView *)editWinLossAlertView
{
    if (_editWinLossAlertView == nil)
    {
        _editWinLossAlertView = [[HeYue_EditWinLoss_AlertView alloc]initWithFrame:self.view.bounds];
        WS(weakSelf);
        _editWinLossAlertView.EditWinLossBlock = ^(NSString * _Nonnull winstr, NSString * _Nonnull lossStr)
        {
            [weakSelf requestEditWinLossWithWinStr:winstr lossStr:lossStr];
        };
    }
    return _editWinLossAlertView;
}



#pragma mark -- 平仓 --
- (HeYue_PingCang_AlertView *)pingCangAlertView{
    if (_pingCangAlertView == nil)
    {
        _pingCangAlertView = [[HeYue_PingCang_AlertView alloc]initWithFrame:self.view.bounds];
        WS(weakSelf);
        
        _pingCangAlertView.PingCangBlock = ^(NSString * sheets) {
            [weakSelf request_currentPingcang_URL:weakSelf.curredntModel number:sheets];
        };
    }
    return _pingCangAlertView;
}


#pragma mark  全部平仓按钮
- (UIButton *)allBtn
{
    if (_allBtn == nil)
    {
        _allBtn = [WLTools allocButton:nil textColor:nil nom_bg:nil hei_bg:nil frame:CGRectZero];
        _allBtn.cornerRadius = ScaleW(28);
        [_allBtn addTarget:self action:@selector(allAction) forControlEvents:UIControlEventTouchUpInside];
        [_allBtn setBackgroundImage:UIImageNamed(SSKJLanguage(@"hy_pingcang")) forState:UIControlStateNormal];
    }
    return _allBtn;
}

#pragma mark 全部平仓 点击事件
- (void)allAction
{
    [self.allPingCangAlertView showWithMessage:SSKJLocalized(@"是否确认要全部平仓?", nil)];
}

#pragma mark 键平仓 
- (Heyue_AllPingCang_AlertView *)allPingCangAlertView
{
    if (_allPingCangAlertView == nil)
    {
        _allPingCangAlertView = [[Heyue_AllPingCang_AlertView alloc]initWithFrame:self.view.bounds];
        WS(weakSelf);
        _allPingCangAlertView.AllPingCangBlock = ^{
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
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_HEYUE_DoneAll_URL RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200)
        {
            [weakSelf.allPingCangAlertView removeFromSuperview];
            [MBProgressHUD showError:SSKJLocalized(@"平仓成功", nil)];
            [weakSelf requestChiCangOrder_URL];
        }
        else
        {
            [MBProgressHUD showError:SSKJLocalized(@"平仓失败", nil)];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
    }];
}

@end
