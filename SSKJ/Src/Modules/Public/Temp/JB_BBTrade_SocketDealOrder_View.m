//
//  JB_BBTrade_SocketDealOrder_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_BBTrade_SocketDealOrder_View.h"
#import "JB_SocketDealOrder_Cell.h"
#import "JB_BBTrade_SocketDealOrder_HeaderView.h"

static NSString *cellid = @"JB_SocketDealOrder_Cell";

@interface JB_BBTrade_SocketDealOrder_View ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) JB_BBTrade_SocketDealOrder_HeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation JB_BBTrade_SocketDealOrder_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:UIColorFromRGB(0x131E31)];
        [self addSubview:self.tableView];
    }
    return self;
}


-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.tableHeaderView = self.headerView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[JB_SocketDealOrder_Cell class] forCellReuseIdentifier:cellid];
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        _tableView.scrollEnabled = NO;
       
    }
    return _tableView;
}

-(JB_BBTrade_SocketDealOrder_HeaderView *)headerView
{
    if (nil == _headerView) {
        _headerView = [[JB_BBTrade_SocketDealOrder_HeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(40))];
    }
    return _headerView;
}


#pragma mark - UITableViewDelegate UITableViewDatasource


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(37);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JB_SocketDealOrder_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    JB_BBTrade_SocketDealOrder_Model *model = self.dataSource[indexPath.row];
    [cell setCellWithModel:model coinCode:self.coinModel.code];
    return cell;
    
}

-(void)setCoinModel:(SSKJ_Market_Index_Model *)coinModel
{
    if (coinModel)
    {
        _coinModel = coinModel;
        [self.headerView setCoinModel:coinModel];
    }
}

-(void)setDataSource:(NSArray<JB_BBTrade_SocketDealOrder_Model *> *)dataSource
{
    if ([dataSource count])
    {
        _dataSource = dataSource;
        [self.tableView reloadData];
        self.tableView.height = ScaleW(37) * dataSource.count + ScaleW(40) + ScaleW(50);
        self.height = self.tableView.height;
    }
    
}

@end
