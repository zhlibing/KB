//
//  BLAddAddressViewController.m
//  ZYW_MIT
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Mine_AddressManager_ViewController.h"
#import "Mine_AddAddress_ViewController.h"
#import "Mine_AddressList_TableViewCell.h"
#import "Login_Google_AlertView.h"

static NSString *cellID = @"Mine_AddressList_TableViewCell";

@interface Mine_AddressManager_ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *usdtLabel;
@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, strong) SSKJ_TableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemArray;





@property (nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic, strong) ExtractAddress_IndexModel *selectModel;
@end

@implementation Mine_AddressManager_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:kSubBgColor];
    self.title = SSKJLocalized(@"提币地址", nil);
    
    [self unit:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (kLogin)
    {
        [self requesAddressList];
    }
}


#pragma mark - 切换数据
-(void)setWalletType:(WalletType)walletType
{
    [self requesAddressList];
}


-(void)unit:(BOOL)unit
{
    if (unit)
    {
        [self.headerView addSubview:self.addButton];
        [self.headerView addSubview:self.usdtLabel];
        [self.view addSubview:self.tableView];
        [self.tableView setTableHeaderView:self.headerView];

        
        [self.usdtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.headerView.mas_left).offset(15);
            make.centerY.equalTo(self.headerView.mas_centerY);
            
        }];
        
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.headerView.mas_right).offset(-15);
            make.centerY.equalTo(self.headerView.mas_centerY);
            
        }];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(Height_NavBar, 0, 0, 0));
        }];
    }
}



#pragma mark - Getter / Setter
-(SSKJ_TableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[SSKJ_TableView alloc]initWitDeletage:self];
        [_tableView registerClass:[Mine_AddressList_TableViewCell class] forCellReuseIdentifier:@"Mine_AddressList_TableViewCell"];
    }
    return _tableView;
}


-(UIView *)headerView
{
    if (nil == _headerView)
    {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(45))];
        [_headerView setBackgroundColor:kBgColor];

    }
    return _headerView;
}





- (UIButton *)addButton
{
    if (_addButton == nil)
    {
        _addButton = [[UIButton alloc]init];
        [_addButton setImage:[UIImage imageNamed:@"tianjia"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}


-(UILabel *)usdtLabel
{
    if (!_usdtLabel)
    {
        _usdtLabel = [[UILabel alloc]init];
        [_usdtLabel setFont:systemFont(ScaleW(15))];
        [_usdtLabel setTextColor:kTitleColor];
        [_usdtLabel setText:@"USDT"];
    }
    return _usdtLabel;
}





-(NSMutableArray *)itemArray
{
    if (!_itemArray)
    {
        _itemArray = [[NSMutableArray alloc]init];
    }
    return _itemArray;
}




/**
 添加地址
 */
- (void)addAddress
{
    Mine_AddAddress_ViewController *addressVC = [[Mine_AddAddress_ViewController alloc] init];
    [self.navigationController pushViewController:addressVC animated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    [SSKJ_NoDataView showNoData:self.itemArray.count toView:self.tableView offY:Height_NavBar];
    
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    Mine_AddressList_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    [cell setValueWithData:self.itemArray[indexPath.row]];
    WS(weakSelf);
     cell.deleBlock = ^{
         weakSelf.selectModel = self.itemArray[indexPath.row];
         [SSKJ_Default_AlertView showWithTitle:SSKJLocalized(@"删除地址", nil) message:SSKJLocalized(@"确认删除该地址吗？", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确定", nil) confirmBlock:^{
             [weakSelf deleteAddress];
         }];
     };
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScaleW(84);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.getAddressBlock)
    {
        self.getAddressBlock(self.itemArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


#pragma mark - 请求提币地址
- (void)requesAddressList
{
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *type = @"2";
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_AddressList_URL RequestType:RequestTypeGet Parameters:@{@"type":type} Success:^(NSInteger statusCode, id responseObject)
    {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [weakSelf.tableView.mj_header endRefreshing];
        
        if (netModel.status.integerValue == SUCCESSED)
        {
            [weakSelf handleAddressListWithModel:netModel];
            [weakSelf.HUD hideAnimated:YES];
        }
        else
        {
            [MBProgressHUD showError:responseObject[@"msg"]];
            [weakSelf.HUD hideAnimated:YES];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
        [MBProgressHUD showError:SSKJLocalized(@"服务器请求异常", nil)];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.HUD hideAnimated:YES];
    }];

}

-(void)handleAddressListWithModel:(WL_Network_Model *)netModel
{
    
    NSArray *itemArray = [ExtractAddress_IndexModel mj_objectArrayWithKeyValuesArray:[netModel.data objectForKey:@"USDT"]];
    [self.itemArray setArray:itemArray];
    [self.tableView reloadData];

}

#pragma mark - 删除地址
- (void)deleteAddress{
    //删除

    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"address_id"]  = self.selectModel.ID;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_DeleteAddress_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED) {
            [MBProgressHUD showSuccess:netModel.msg];
            [weakSelf requesAddressList];
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];

}




@end
