//
//  BI_MineRoot_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/6/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "Mine_Root_ViewController.h"
#import "Mine_Setting_ViewController.h"   // 设置
#import "Mine_SafeCenter_ViewController.h" //!< 安全中心
#import "Home_NoticeList_ViewController.h" //!< 公告
#import "SSKJ_Protocol_ViewController.h"    //!< 关于我们
#import "Mine_Recharge_ViewController.h"
#import "Mine_AddressManager_ViewController.h"
#import "My_Generalize_RootViewController.h"
#import "Mine_PrimaryCertificate_ViewController.h"
#import "Mine_CertificationState_ViewController.h"
#import "SY_InviteViewController.h"
#import "Mine_information_ViewController.h"




#import "Mine_Version_AlertView.h"
#import "SSKJ_Default_AlertView.h"      // 通用弹框
#import "Mine_Item_Cell.h" //!<我的列表cell
#import "LoginAlertView.h"
#import "Mine_Item_CollectionViewCell.h"

#import "Mine_Item_Model.h"
#import "Mine_Version_Model.h"

#import "Lion_AboutUsVC.h"
#import "Market_KeyBuyCoin_VC.h"
#import "MineHeaderView.h"






@interface Mine_Root_ViewController ()







@property (nonatomic,strong) UILabel *userUsdtLabel;//用户资产USDT
@property (nonatomic,strong) UILabel *moneyLabel;//用户资产CNY
@property(nonatomic, strong)UILabel *uidLabel;

@property(nonatomic, strong)UIButton *show;

@property(nonatomic, strong)UICollectionView *collectionView;
//配置参数
@property(nonatomic)CGFloat itemWidth;
@property(nonatomic)CGFloat itemHeight;

@property (nonatomic, strong) UIView *loginView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic ,strong) UIImageView *headerImageV;
@property (nonatomic ,strong) UIImageView *leveImgV;
@property (nonatomic ,strong) UILabel *userIdLb;
@property (nonatomic ,strong) UIButton *settingBtn;
@property (nonatomic ,strong) UIView *topItemsView;
@property (nonatomic ,strong) UIButton *userIdcopyBtn;
@property (nonatomic ,strong) UILabel *noLoginLb;
@property (nonatomic ,assign) BOOL showType;

@property (nonatomic, strong) SSKJ_TableView *tableView;
@property (nonatomic, strong) MineHeaderView *headerView;





@end

@implementation Mine_Root_ViewController

 #pragma mark - LifeCycle Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    //是否展示 时间合约
    self.showType = (self.tabBarController.childViewControllers.count == 4) ? NO : YES;

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    
    
    WS(weakSelf);
    [self.headerView setLoginblock:^(BOOL login) {
       
        if (!login)
        {
            
            [weakSelf presentLoginController];
        }
    }];
}


-(void)viewWillAppear:(BOOL)animated
{
//    [kUserDefaults setObject:@"1" forKey:@"kLogin"];
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:![SSTool isRoot]];//

    if (kLogin) // 已登录，显示用户信息
    {
        [self loadUserInfo];
        self.userIdcopyBtn.hidden = NO;
    }
    else
    {
        self.userIdcopyBtn.hidden = YES;
    }
    
    if (!kLogin)
    {
        //未登录
        self.userIdcopyBtn.hidden = self.leveImgV.hidden = self.userIdLb.hidden = YES;
        self.noLoginLb.hidden = NO;
    }
    else
    {
        self.userIdcopyBtn.hidden = self.leveImgV.hidden  = self.userIdLb.hidden = NO;
        self.noLoginLb.hidden = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



#pragma mark - Private Method
- (void) copyBtnClick
{
    if (self.userIdLb.text.length != 0)
    {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [SSKJ_User_Tool sharedUserTool].userInfoModel.account;
        [MBProgressHUD showError:SSKJLocalized(@"复制成功", nil)];
    }
}


- (void) timeHyBtnClick
{
    
    if (!kLogin)
    {
        [self presentLoginController];
        return;
    }
    
    Market_KeyBuyCoin_VC *vc = [[Market_KeyBuyCoin_VC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
//    self.tabBarController.selectedIndex = 2;
}


- (void)topItemsBtnClick:(UIButton *)sender{
    NSInteger index = sender.tag - 99;
    NSLog(@"%ld", (long)index);
    if (!kLogin)
    {
        [self presentLoginController];
        return;
    }
    {
        
        NSInteger status = [SSKJ_User_Tool sharedUserTool].userInfoModel.authentication.integerValue;
        switch (status)
        {
            case 2:
            {
                 Mine_PrimaryCertificate_ViewController *vc = [[Mine_PrimaryCertificate_ViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            case 4:
            {
                Mine_CertificationState_ViewController *vc = [[Mine_CertificationState_ViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
            {
                [MBProgressHUD showError:SSKJLocalized(@"您的身份认证正在审核，请耐心等待！", nil)];
            }
                break;;
        }
    }
    
}
//设置
- (void) settingBtnClick{;
}
- (void)loginAction{
    if (!kLogin) {
        [self presentLoginController];
    }
}



-(void)promoteBtnAcrion:(UIButton*)sender
{
    SY_InviteViewController *invite = [[SY_InviteViewController alloc]init];
    [self.navigationController pushViewController:invite animated:YES];
}



#pragma mark - Getter / Setter
-(SSKJ_TableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[SSKJ_TableView alloc]initWitDeletage:self];
        [_tableView registerClass:[Mine_Item_Cell class] forCellReuseIdentifier:@"Mine_Item_Cell"];
        [_tableView setTableHeaderView:self.headerView];
    }
    return _tableView;
}

-(MineHeaderView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[MineHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(265))];
        [_headerView.promoteBtn addTarget:self action:@selector(promoteBtnAcrion:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}










#pragma mark - 地址管理

- (void)goAddress{
    if (!kLogin) {
        [self presentLoginController];
        return;
    }
    Mine_AddressManager_ViewController *vc = [[Mine_AddressManager_ViewController alloc]init];    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 联系客服
- (void)contactService{
    
    [self requestEmail];
}

#pragma mark - 登录注册
-(void)userNameTap{
    [self presentLoginController];
}


#pragma mark 请求用户信息
- (void)loadUserInfo
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_UserInfo_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject)
    {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {
                SSKJ_UserInfo_Model *userModel = [SSKJ_UserInfo_Model mj_objectWithKeyValues:network_Model.data];
                [[SSKJ_User_Tool sharedUserTool] setUserInfoModel:userModel];
                [weakSelf setUSerModel:userModel];
                
        }
        else
        {
            [MBProgressHUD showError:network_Model.msg];
        }
        
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
    
}



#pragma mark - 联系我们（获取客服邮箱）

-(void)requestEmail
{
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_TouchMe_URL RequestType:RequestTypeGet Parameters:@{@"key":@"contactemail"} Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == SUCCESSED) {
            NSString *email = netModel.data[@"content"];
            if (!email.length) {
                           return;
                       }
            LoginAlertView *Show=[[[LoginAlertView alloc]init] showLogInState:email cancle:@"取消" sure:@"复制"];
            
            Show.sureCallback = ^{
                if (!email.length) {
                    return;
                }
                
                [MBProgressHUD showSuccess:SSKJLocalized(@"复制成功", nil)];
                UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = email;
            };
            
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
}







#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleW(10);
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *hf = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    [hf setBackgroundColor:kSubBgColor];
 
    return hf;
}




#pragma mark  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 2;
        }
            break;
        case 1:
        {
            return 2;
        }
            break;
        case 2:
        {
            return 3;
        }
            break;
    }
    return 0;
}





- (Mine_Item_Cell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Mine_Item_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Mine_Item_Cell"];
    if (indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                [cell setIconName:@"usericon" title:SSKJLanguage(@"个人资料") desc:@""];
            }
                break;
            case 1:
            {
                [cell setIconName:@"aqsz" title:SSKJLanguage(@"安全设置") desc:@""];
            }
                break;
        }
    }
    else if (indexPath.section == 1)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                [cell setIconName:@"tbdz" title:SSKJLanguage(@"提币地址") desc:@""];
            }
                break;
            case 1:
            {
                [cell setIconName:@"tuandui" title:SSKJLanguage(@"团队推广") desc:@""];
            }
                break;
        }
    }
    else if (indexPath.section == 2)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                [cell setIconName:@"about" title:SSKJLanguage(@"关于我们") desc:@""];
            }
                break;
            case 1:
            {
                [cell setIconName:@"lxwm" title:SSKJLanguage(@"联系客服") desc:SSKJLanguage(@"24小时在线客服")];
            }
                break;
            case 2:
            {
                [cell setIconName:@"shezhi" title:SSKJLanguage(@"设置") desc:@""];
            }
                break;
        }
    }
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        
        if (!kLogin)
        {
            [self presentLoginController];
            return;
        }
        
        switch (indexPath.row)
        {
#pragma mark - case 0 -> 0 个人资料
            case 0:
            {
                Mine_information_ViewController *info = [[Mine_information_ViewController alloc]init];
                [self.navigationController pushViewController:info animated:YES];
            }
                break;
#pragma mark - case 0 -> 1 安全中心
            case 1:
            {
                
                Mine_SafeCenter_ViewController *safeCenterVC = [[Mine_SafeCenter_ViewController alloc] init];
                [self.navigationController pushViewController:safeCenterVC animated:YES];
            }
                break;
        }
        
    }
    else if (indexPath.section == 1)
    {
        if (!kLogin)
        {
            [self presentLoginController];
            return;
        }
        
        switch (indexPath.row)
        {
#pragma mark case 1 -> 0 提币地址
            case 0:
            {
                [self goAddress];
            }
                break;
#pragma mark case 1 -> 1 团队推广
            case 1:
            {
                My_Generalize_RootViewController *protocol = [[My_Generalize_RootViewController alloc]init];
                [self.navigationController pushViewController:protocol animated:YES];
            }
                break;
        }
        
    }
    else if (indexPath.section == 2)
    {
        switch (indexPath.row)
        {
#pragma mark case 2 -> 0 关于我们
            case 0:
            {
                Lion_AboutUsVC *protocol = [[Lion_AboutUsVC alloc]init];
                [self.navigationController pushViewController:protocol animated:YES];
            }
                break;
#pragma mark case 2 -> 1 联系客服
            case 1:
            {
                [self contactService];
            }
                break;
#pragma mark case 2 -> 2 设置
            case 2:
            {
                Mine_Setting_ViewController *vc = [[Mine_Setting_ViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
        }
    }
}













#pragma mark - 更新用户信息
-(void)setUSerModel:(SSKJ_UserInfo_Model*)userModel
{
    if (userModel.phone.length != 0)
    {
        [self.headerView setTitle:[WLTools hidePhoneMiddleNumberWithMobile:userModel.phone] uuid:userModel.account];
    }
    else
    {
        [self.headerView setTitle:[WLTools hideEmailWithEmail:userModel.email] uuid:userModel.account];
    }
}

@end
