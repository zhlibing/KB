//
//  BLSafeCenterViewController.m
//  BiLe
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 LS. All rights reserved.
//

#import "Mine_SafeCenter_ViewController.h"
#import "Mine_ChangePWD_ViewController.h"   //!< 设置登录密码
#import "Lion_Forget_SetViewController.h"
#import "Mine_SetFundPwd_ViewController.h"  //!< 设置资金密码
#import "Mine_BindPhone_ViewController.h"  //!< 绑定手机号
#import "Mine_BindEmail_ViewController.h"   //!< 绑定邮箱
#import "My_GoogleVerify_ViewController.h"  //!< 开启谷歌验证
#import "Mine_PrimaryCertificate_ViewController.h"  //!< 身份认证
  




#import "Login_Google_AlertView.h"
#import "Mine_BindGoogle_AlertView.h"
#import "MineSafeCenterHeaderView.h"
#import "MineSafeCenterFooterView.h"
#import "My_BindGoogle_AlertView.h"




// view
#import "ATEX_SafeCenter_Cell.h"
#import "SSKJ_TableView.h"


static NSString *safeCell = @"safeCell";

@interface Mine_SafeCenter_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) SSKJ_TableView *tableView;

@property (nonatomic, strong) NSArray *cellTitleArr;

@property (nonatomic, strong) MineSafeCenterHeaderView *headerView;
@property (nonatomic, strong) MineSafeCenterFooterView *footerView;



@property (nonatomic, strong) My_BindGoogle_AlertView *googleAlertView;

@property (nonatomic,strong) Login_Google_AlertView *certificationGoogleView;


@end

@implementation Mine_SafeCenter_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = SSKJLocalized(@"安全中心", nil);
    [self.view addSubview:self.tableView];
    
}


- (void)reloadBankList
{
    
}


- (NSArray *)cellTitleArr
{
    if (!_cellTitleArr)
    {
        _cellTitleArr = @[SSKJLanguage(@"手机"),
        SSKJLanguage(@"邮箱"),SSKJLanguage(@"身份认证")];
    }
    
    return _cellTitleArr;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestUserInfoURL];
    
    [self.headerView setUserInfo:[SSKJ_User_Tool sharedUserTool].userInfoModel];
}

#pragma mark - Getter / Setter
- (SSKJ_TableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[SSKJ_TableView alloc]initWitDeletage:self];
        [self.view addSubview:_tableView];
        [_tableView registerClass:[ATEX_SafeCenter_Cell class] forCellReuseIdentifier:@"ATEX_SafeCenter_Cell"];
        [_tableView setFrame:CGRectMake(0, Height_NavBar, ScreenWidth, (ScreenHeight - Height_TabBar - Height_NavBar))];


        [_tableView setTableHeaderView:self.headerView];
        [_tableView setTableFooterView:self.footerView];

        WS(weakSelf);
        _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
    }
    return _tableView;
}

- (void)headerRefresh
{
    [self requestUserInfoURL];
}




- (MineSafeCenterHeaderView *)headerView
{
    if (_headerView == nil)
    {
        _headerView = [[MineSafeCenterHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(140))];
    }
    return _headerView;
}


- (MineSafeCenterFooterView *)footerView
{
    if (_footerView == nil)
    {
        _footerView = [[MineSafeCenterFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(200))];
        [_footerView.loginPwdView addTarget:self action:@selector(setLoginPwdAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView.payPwdView addTarget:self action:@selector(setPayPwdAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}



#pragma mark - Private Method
#pragma mark 设置登录密码
-(void)setLoginPwdAction:(UIControl*)sender
{
    Mine_ChangePWD_ViewController *resetPwdVC = [[Mine_ChangePWD_ViewController alloc] init];
    [resetPwdVC setPhoneNumber:kAccount];
    [self.navigationController pushViewController:resetPwdVC animated:YES];
    
}

#pragma mark 设置资金密码
-(void)setPayPwdAction:(UIControl*)sender
{
    Mine_SetFundPwd_ViewController *setTPWD = [[Mine_SetFundPwd_ViewController alloc]init];
    [setTPWD setPhoneNumber:kAccount];
    switch ([[SSKJ_User_Tool sharedUserTool].userInfoModel.config.payment_password_set integerValue])
    {
        case 1:
        {
            [setTPWD setIsEdit:YES];
        }
            break;
        default:
        {
            [setTPWD setIsEdit:NO];
        }
            break;
    }
    [self.navigationController pushViewController:setTPWD animated:YES];
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellTitleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ATEX_SafeCenter_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"ATEX_SafeCenter_Cell"];
    cell.cellTitleLabel.text =  self.cellTitleArr[indexPath.row];
    cell.statusLabel.text = [self statusWithModel:[SSKJ_User_Tool sharedUserTool].userInfoModel indexPath:indexPath];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(56);
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
    switch (indexPath.row)
    {
#pragma mark case 0 绑定手机
        case 0:
        {
            if ([SSKJ_User_Tool sharedUserTool].userInfoModel.config.phone_bind.integerValue == 1)
            {
                [MBProgressHUD showError:SSKJLocalized(@"手机号已开启", nil)];
            }
            else
            {
                
                Mine_BindPhone_ViewController *vc = [[Mine_BindPhone_ViewController alloc]init];
                [vc setSuccessBlock:^(NSString * _Nonnull account) {
                    
                    [[SSKJ_User_Tool sharedUserTool].userInfoModel.config setPhone_bind:@"1"];
                    [weakSelf.tableView reloadData];
                }];
                [self.navigationController pushViewController:vc animated:YES];;
            }
            
        }
            break;
#pragma mark case 1 绑定邮箱
        case 1:
        {
            if ([SSKJ_User_Tool sharedUserTool].userInfoModel.config.email_bind.integerValue == 1)
            {
                [MBProgressHUD showError:SSKJLocalized(@"邮箱已开启", nil)];
            }
            else
            {
                Mine_BindEmail_ViewController *vc = [[Mine_BindEmail_ViewController alloc]init];
                [vc setSuccessBlock:^(NSString * _Nonnull account) {
                    
                    [[SSKJ_User_Tool sharedUserTool].userInfoModel.config setEmail_bind:@"1"];
                    [weakSelf.tableView reloadData];
                }];
                
                [self.navigationController pushViewController:vc animated:YES];;
            }
        }
            break;
#pragma mark case 20 绑定谷歌认证
        case 20:
        {
            if ([SSKJ_User_Tool sharedUserTool].userInfoModel.config.google_bind.integerValue == 1)
            {
                if (([SSKJ_User_Tool sharedUserTool].userInfoModel.config.payment_password_set.integerValue == 1))
                {
                    if ([SSKJ_User_Tool sharedUserTool].userInfoModel.config.google_verify.integerValue == 1)
                    {
                        [self.googleAlertView setShowWithType:MyGOOGLETYPEDELETE];
                    }
                    else
                    {
                        [self.googleAlertView setShowWithType:MyGOOGLETYPEOPEN];
                    }
                }
                else
                {
                    [MBProgressHUD showError:SSKJLanguage(@"请先设置资金密码")];
                }
            }
            else
            {
                My_GoogleVerify_ViewController *vc = [[My_GoogleVerify_ViewController alloc]init];
                WS(weakSelf);
                vc.addGoogleBlock = ^{
                    
                    [[SSKJ_User_Tool sharedUserTool].userInfoModel.config setGoogle_bind:@"1"];
                    [weakSelf.tableView reloadData];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
            break;
#pragma mark case 2 身份认证
        case 2:
        {
            [self judgeFristCertificate];
        }
            break;
    }
}

#pragma mark  设置不同状态
- (NSString *)statusWithModel:(SSKJ_UserInfo_Model *)model indexPath:(NSIndexPath *)indexPath
{
    NSString *status;
    if (indexPath.row == 0)
    {
        status = (model.config.phone_bind.integerValue == 1) ? SSKJLocalized(@"已开启", nil)  : SSKJLocalized(@"未绑定", nil);
    }
    else if (indexPath.row == 1)
    {
        status = (model.config.email_bind.integerValue == 1) ? SSKJLocalized(@"已开启", nil)   : SSKJLocalized(@"未绑定", nil);
    }
    else if (indexPath.row == 2)
    {
        //!<（0未认证 1初级认证 2高级认证待审核 3高级认证通过 4高级认证拒绝）
        switch (model.authentication.integerValue)
        {
            case 0:
            {
                status = SSKJLocalized(@"初级未认证", nil);
            }
                break;
            case 1:
            {
                status = SSKJLocalized(@"初级认证", nil);
            }
                break;
            case 2:
            {
                status = SSKJLocalized(@"高级认证待审核", nil);
            }
                break;
            case 3:
            {
                status = SSKJLocalized(@"高级认证通过", nil);
            }
                break;
            case 4:
            {
                status = SSKJLocalized(@"高级认证拒绝", nil);
            }
                break;
        }
    }
    
    return status;
}


// 设置不同状态
- (BOOL )hiddenWithModel:(SSKJ_UserInfo_Model *)model indexPath:(NSIndexPath *)indexPath
{
    BOOL hidden = false;
    switch (indexPath.row)
    {
        case 0:
        {
            hidden = (model.config.phone_bind.integerValue == 1) ? YES: NO;
        }
            break;
        case 1:
        {
            hidden = (model.config.email_bind.integerValue == 1) ? YES: NO;
        }
            break;
        case 2:
        {
            if (model.config.google_verify.integerValue == 1)
            {  // 已认证
                hidden = YES;
            }
            else
            {
                hidden = NO;
            }
        }
    }
    return hidden;
}
// 设置不同状态
- (UIColor *)colorWithModel:(SSKJ_UserInfo_Model *)model indexPath:(NSIndexPath *)indexPath
{
    UIColor *color;
    if (indexPath.row == 0)
    {
        color = (model.config.phone_bind.integerValue == 1) ? kBlueColor: RED_HEX_COLOR ;
    }
    else if (indexPath.row == 1)
    {
        color = (model.config.email_bind.integerValue == 1) ? kBlueColor : RED_HEX_COLOR;
    }
    else if (indexPath.row == 2)
    {
        if (model.config.google_verify.integerValue == 1)
        {  // 已认证
            color = kBlueColor;
        }
        else
        {
            color = RED_HEX_COLOR;
        }
    }
    else if (indexPath.row == 3)
    {
        color = [[SSKJ_User_Tool sharedUserTool].userInfoModel.config.payment_password_set integerValue] == 1 ? kBlueColor : RED_HEX_COLOR;
    }
    else if (indexPath.row == 4)
    {
        if ([model.authentication integerValue] == 1)
        {  // 未认证
            color = RED_HEX_COLOR;
        }
        else if ([model.authentication integerValue] == 2)
        {
            color = kBlueColor;
        }
        else if ([model.authentication integerValue] == 3)
        {
            if (model.authentication.integerValue == 1)
            {
                color = kBlueColor;
            }
            else if (model.authentication.integerValue == 2)
            {
                color = kBlueColor;
            }
            else if (model.authentication.integerValue == 3)
            {
                color = kBlueColor;
            }
            else if (model.authentication.integerValue == 4)
            {
                color = kBlueColor;
            }
        }
        else if ([model.authentication integerValue] == 4)
        {
            color = kBlueColor;
        }
    }
    else if (indexPath.row == 6)
    {
        if (model.config.google_verify.integerValue == 1)
        {  // 已认证
            color = kBlueColor;
        }
        else
        {
            color = kSubTitleColor;
        }
    }
    else
    {
        color = kSubTitleColor;
    }
     return color;
}




#pragma mark - NetWork Method 网络请求
#pragma mark  请求个人信息
- (void)requestUserInfoURL
{
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_UserInfo_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200)
        {
            SSKJ_UserInfo_Model *userModel = [SSKJ_UserInfo_Model mj_objectWithKeyValues:netModel.data];
            [[SSKJ_User_Tool sharedUserTool] setUserInfoModel:userModel];
            [weakSelf.headerView setUserInfo:userModel];
            [weakSelf.footerView setUserInfo:userModel];
            [weakSelf.tableView reloadData];
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
    {
        [self.tableView.mj_header endRefreshing];
    }];
}


#pragma mark  取消谷歌绑定
-(void)requestDeleteGoogleWithCode:(NSString *)smsCode googleCode:(NSString *)googleCode type:(NSString*)type
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = @{
                             @"key":type,
                             @"google_code":googleCode,
                             @"payment_password":[WLTools md5:smsCode]
                             };
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:Set_google_state RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WS(weakSelf);
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == 200)
        {
            [MBProgressHUD showError:netModel.msg];
            [weakSelf.tableView.mj_header beginRefreshing];
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
    }];
}


-(My_BindGoogle_AlertView *)googleAlertView
{
    if (nil == _googleAlertView) {
        _googleAlertView = [[My_BindGoogle_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        WS(weakSelf);
        _googleAlertView.submitBlock = ^(NSString * googleCode, NSString * smsCode,NSString *type)
        {

            [weakSelf requestDeleteGoogleWithCode:smsCode googleCode:googleCode type:type];
        };
    }
    return _googleAlertView;
}

#pragma mark 谷歌验证
-(void)requestGoogleWith:(NSString *)code
{
    NSDictionary *prams = @{
                            @"dyGoodleCommand":code
                            };
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:Check_google_code RequestType:RequestTypePost Parameters:prams Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == 200) {
            
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
    }];
}


- (Login_Google_AlertView *)certificationGoogleView{
    if (_certificationGoogleView == nil) {
        _certificationGoogleView = [[Login_Google_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        WS(weakSelf);
        _certificationGoogleView.confirmBlock = ^(NSString * _Nonnull code) {
            [weakSelf requestGoogleWith:code];
        };
    }
    return _certificationGoogleView;
}


@end

