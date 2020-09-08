//
//  Mine_information_ViewController.m
//  SSKJ
//
//  Created by 姚立志 on 2020/8/12.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "Mine_information_ViewController.h"
#import "Mine_informationTableViewCell.h"


@interface Mine_information_ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) SSKJ_TableView *tableView;


@end

@implementation Mine_information_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:SSKJLanguage(@"个人资料")];
    [self.view addSubview:self.tableView];
    
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(Height_NavBar, 0, 0, 0));
    }];
    
    
}



#pragma mark - Deletage Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Mine_informationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Mine_informationTableViewCell"];
    if (indexPath.row == 0)
    {
        [cell.titleLabel setText:SSKJLanguage(@"手机号")];
        [cell.descLabel setText:([SSKJ_User_Tool sharedUserTool].userInfoModel.phone.length == 0 ? @"--" : [WLTools hidePhoneMiddleNumberWithMobile:[SSKJ_User_Tool sharedUserTool].userInfoModel.phone])];
        
        
    }
    else if (indexPath.row == 1)
    {
        [cell.titleLabel setText:SSKJLanguage(@"邮箱地址")];
        [cell.descLabel setText:([SSKJ_User_Tool sharedUserTool].userInfoModel.email.length == 0 ? @"--" : [WLTools hideEmailWithEmail:[SSKJ_User_Tool sharedUserTool].userInfoModel.email])];
        
        
    }
    else if (indexPath.row == 2)
    {
        [cell.titleLabel setText:SSKJLanguage(@"UID")];
        [cell.descLabel setText:([SSKJ_User_Tool sharedUserTool].userInfoModel.account.length == 0 ? @"--" :[SSKJ_User_Tool sharedUserTool].userInfoModel.account)];
    }
    else if (indexPath.row == 3)
    {
        [cell.titleLabel setText:SSKJLanguage(@"姓名")];
        [cell.descLabel setText:([SSKJ_User_Tool sharedUserTool].userInfoModel.name.length == 0 ? @"--" : [SSKJ_User_Tool sharedUserTool].userInfoModel.name)];
    }
    else if (indexPath.row == 4)
    {
        [cell.titleLabel setText:SSKJLanguage(@"身份证号")];
        [cell.descLabel setText:([SSKJ_User_Tool sharedUserTool].userInfoModel.card_id.length == 0 ? @"--" : [SSKJ_User_Tool sharedUserTool].userInfoModel.card_id)];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(55);
}




#pragma mark - Getter / Setter
-(SSKJ_TableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[SSKJ_TableView alloc]initWitDeletage:self];
        [_tableView registerClass:[Mine_informationTableViewCell class] forCellReuseIdentifier:@"Mine_informationTableViewCell"];
    }
    return _tableView;
}







@end
