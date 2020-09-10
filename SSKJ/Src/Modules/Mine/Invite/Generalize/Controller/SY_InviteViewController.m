//
//  SY_InviteViewController.m
//  SSKJ
//
//  Created by zpz on 2019/11/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SY_InviteViewController.h"
#import "ImaginaryLineView.h"
#import "PosterBoardControl.h"

@interface SY_InviteViewController ()


@property (nonatomic, strong) UILabel *backTopLabel;
@property (nonatomic, strong) UILabel *backBottomLabel;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *leftTopLabel;
@property (nonatomic, strong) UILabel *leftBottomLabel;
@property (nonatomic, strong) UILabel *middleTopLabel;
@property (nonatomic, strong) UILabel *middleBootomLabel;
@property (nonatomic, strong) UILabel *rightTopLabel;
@property (nonatomic, strong) UILabel *rightBootomLabel;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UILabel *tipLabel; //!< 加入经纪人享更多收益，详情联系平台客服


@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *bottomTipLabel; //!< 我的邀请链接
@property (nonatomic, strong) UILabel *invitationAddressLabel; //!< 邀请注册地址
@property (nonatomic, strong) UILabel *invitationTipLabel; //!< 我的邀请提示
@property (nonatomic, strong) UILabel *invitationCodeLabel; //!< 我的邀请码

@property (nonatomic, strong) UIButton *submitBtn; //!< 生产海报按钮


@property (nonatomic, copy) NSString *code;  //!< 分享码
@property (nonatomic, copy) NSString *url;


@end

@implementation SY_InviteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:kSubBgColor];
    
    self.title = SSKJLocalized(@"推广海报", nil);
    [self getinfo];
    
    
    [self unit:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}
#pragma mark - 用户操作
- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)inviteClick{
    [self copyEvent];
}






-(void)copyEvent
{
    if (!self.tipLabel.text.length)
    {
        return;
    }
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.tipLabel.text;
    [MBProgressHUD showError:SSKJLocalized(@"复制成功", nil)];
}


#pragma mark 生成海报
-(void)submitBtnACtion:(UIButton*)sender
{
    [PosterBoardControl showType:1 withCode:self.code withCodeUrl:self.url];
        
}



#pragma mark - NetWork Method 网络请求
- (void)getinfo
{
    [MBHUD showHUDAddedTo:self.view];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_Qrcode_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBHUD hideHUDForView:self.view];

        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {
            [weakSelf setUrl:network_Model.data[@"qrcode"]];
            [weakSelf setCode:network_Model.data[@"account"]];
            weakSelf.invitationCodeLabel.text = network_Model.data[@"account"];
            [NSURL URLWithString:network_Model.data[@"qrcode"]];
            [weakSelf.invitationAddressLabel setText:network_Model.data[@"url"]];
        }
        else
        {
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBHUD hideHUDForView:self.view];
        [MBHUD showError:SSKJLocalized(@"网错出错", nil)];
    }];
    

}







#pragma mark - Private Method
#pragma mark UI布局
-(void)unit:(BOOL)unit
{
    [self.view addSubview:self.backImageView];
    [self.backImageView addSubview:self.backTopLabel];
    [self.backImageView addSubview:self.backBottomLabel];
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.leftTopLabel];
    [self.topView addSubview:self.leftBottomLabel];
    [self.topView addSubview:self.middleTopLabel];
    [self.topView addSubview:self.middleBootomLabel];
    [self.topView addSubview:self.rightTopLabel];
    [self.topView addSubview:self.rightBootomLabel];
    [self.topView addSubview:self.leftImageView];
    [self.topView addSubview:self.rightImageView];
    
    
    [self.view addSubview:self.tipLabel];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.bottomTipLabel];
    [self.bottomView addSubview:self.invitationAddressLabel];
    [self.bottomView addSubview:self.invitationTipLabel];
    [self.bottomView addSubview:self.invitationCodeLabel];

    
    [self.view addSubview:self.submitBtn];

    
    
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(@(Height_NavBar));
        make.left.right.equalTo(@(0));
        make.height.equalTo(@(ScaleW(266)));
    }];
    
    
    [self.backTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.backImageView.mas_top).offset(35);
        make.centerX.equalTo(self.backImageView.mas_centerX);
    }];
    
    
    [self.backBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.backTopLabel.mas_bottom).offset(15);
        make.centerX.equalTo(self.backImageView.mas_centerX);
    }];
    
    
    
    
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.top.equalTo(self.backImageView.mas_bottom).offset(-ScaleW(47));
        make.left.equalTo(self.view).offset(ScaleW(15));
        make.right.equalTo(self.view).offset(-ScaleW(15));
        make.height.equalTo(@(ScaleW(72)));
    }];
    
    [self.leftTopLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.left.equalTo(self.topView.mas_left).offset(ScaleW(15));
        make.bottom.equalTo(self.topView.mas_centerY);
        make.width.equalTo(@(ScaleW(60)));
    }];
    
    [self.leftBottomLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.top.equalTo(self.topView.mas_centerY);
        make.left.equalTo(self.leftTopLabel.mas_left);
        make.width.equalTo(self.leftTopLabel);
    }];
    
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.centerY.equalTo(self.topView.mas_centerY);
        make.right.equalTo(self.topView.mas_centerX).offset(-ScaleW(53));
        make.width.equalTo(@(ScaleW(44)));
    }];
    
    
    [self.middleTopLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.centerX.equalTo(self.topView.mas_centerX);
        make.bottom.equalTo(self.topView.mas_centerY);
    }];
    
    [self.middleBootomLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.top.equalTo(self.topView.mas_centerY);
        make.centerX.equalTo(self.topView.mas_centerX);
    }];
    
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.centerY.equalTo(self.topView.mas_centerY);
        make.left.equalTo(self.topView.mas_centerX).offset(ScaleW(53));
        make.width.equalTo(@(ScaleW(44)));
    }];
    
    [self.rightTopLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.right.equalTo(self.topView.mas_right).offset(-ScaleW(13));
        make.bottom.equalTo(self.topView.mas_centerY);
    }];
    
    [self.rightBootomLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.top.equalTo(self.topView.mas_centerY);
        make.right.equalTo(self.rightTopLabel);
    }];
    
    
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.top.equalTo(self.topView.mas_bottom);
        make.height.equalTo(@(40));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.top.equalTo(self.tipLabel.mas_bottom);
        make.left.right.equalTo(self.topView);
        make.height.equalTo(@(165));
    }];
    
    
    [self.bottomTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.bottomView.mas_top).offset(ScaleW(19));
        make.left.equalTo(self.bottomView.mas_left).offset(ScaleW(15));
    }];
    
    [self.invitationAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.bottomTipLabel.mas_bottom).offset(ScaleW(5));
        make.left.equalTo(self.bottomTipLabel);
        make.right.equalTo(self.bottomView.mas_right).offset(-10);
    }];
    
    
    [self.invitationTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.bottomView.mas_centerY).offset(ScaleW(5));
        make.left.equalTo(self.bottomTipLabel);
    }];
    
    
    [self.invitationCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.invitationTipLabel.mas_bottom).offset(ScaleW(10));
        make.left.equalTo(self.bottomTipLabel);
    }];
    
    
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        
        make.top.equalTo(self.bottomView.mas_bottom).offset(ScaleW(50));
        make.left.right.equalTo(self.bottomView);
        make.height.equalTo(@(ScaleW(45)));
    }];
    
    
    
    
    
}




#pragma mark - Getter / Setter
-(UILabel *)backTopLabel
{
    if (!_backTopLabel)
    {
        _backTopLabel = [[UILabel alloc]init];
        [_backTopLabel setFont:systemBoldFont(ScaleW(27))];
        [_backTopLabel setTextColor:kWhiteColor];
        [_backTopLabel setText:SSKJLanguage(@"邀请好友共享收益")];
    }
    return _backTopLabel;
}

-(UILabel *)backBottomLabel
{
    if (!_backBottomLabel)
    {
        _backBottomLabel = [[UILabel alloc]init];
        [_backBottomLabel setFont:systemFont(ScaleW(14))];
        [_backBottomLabel setTextColor:kWhiteColor];
        [_backBottomLabel setText:SSKJLanguage(@"轻松获得持续奖励")];
    }
    return _backBottomLabel;
}






-(UIImageView *)backImageView
{
    if (!_backImageView)
    {
        _backImageView = [[UIImageView alloc]init];
        [_backImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_backImageView setImage:[UIImage imageNamed:@"invitationbg"]];
    }
    return _backImageView;
}

-(UIView *)topView
{
    if (!_topView)
    {
        _topView = [[UIView alloc]init];
        [_topView setBackgroundColor:kWhiteColor];
        [_topView setCornerRadius:ScaleW(5)];
    }
    return _topView;
}


-(UILabel *)leftTopLabel
{
    if (!_leftTopLabel)
    {
        _leftTopLabel = [[UILabel alloc]init];
        [_leftTopLabel setFont:systemFont(ScaleW(13))];
        [_leftTopLabel setTextColor:kSubTitleColor];
        [_leftTopLabel setText:SSKJLanguage(@"发送邀请")];
    }
    return _leftTopLabel;
}


-(UILabel *)leftBottomLabel
{
    if (!_leftBottomLabel)
    {
        _leftBottomLabel = [[UILabel alloc]init];
        [_leftBottomLabel setFont:systemFont(ScaleW(13))];
        [_leftBottomLabel setTextColor:kSubTitleColor];
        [_leftBottomLabel setText:SSKJLanguage(@"给好友")];
    }
    return _leftBottomLabel;
}

-(UILabel *)middleTopLabel
{
    if (!_middleTopLabel)
    {
        _middleTopLabel = [[UILabel alloc]init];
        [_middleTopLabel setFont:systemFont(ScaleW(13))];
        [_middleTopLabel setTextColor:kSubTitleColor];
        [_middleTopLabel setText:SSKJLanguage(@"好友完成注册")];
    }
    return _middleTopLabel;
}


-(UILabel *)middleBootomLabel
{
    if (!_middleBootomLabel)
    {
        _middleBootomLabel = [[UILabel alloc]init];
        [_middleBootomLabel setFont:systemFont(ScaleW(13))];
        [_middleBootomLabel setTextColor:kSubTitleColor];
        [_middleBootomLabel setText:SSKJLanguage(@"成为你的下级")];
    }
    return _middleBootomLabel;
}


-(UILabel *)rightTopLabel
{
    if (!_rightTopLabel)
    {
        _rightTopLabel = [[UILabel alloc]init];
        [_rightTopLabel setFont:systemFont(ScaleW(13))];
        [_rightTopLabel setTextColor:kSubTitleColor];
        [_rightTopLabel setText:SSKJLanguage(@"获得相应")];
    }
    return _rightTopLabel;
}


-(UILabel *)rightBootomLabel
{
    if (!_rightBootomLabel)
    {
        _rightBootomLabel = [[UILabel alloc]init];
        [_rightBootomLabel setFont:systemFont(ScaleW(13))];
        [_rightBootomLabel setTextColor:kSubTitleColor];
        [_rightBootomLabel setText:SSKJLanguage(@"比例佣金")];
    }
    return _rightBootomLabel;
}


-(UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc]init];
        [_tipLabel setFont:systemFont(ScaleW(13))];
        [_tipLabel setTextColor:kSubTitleColor];
        [_tipLabel setText:SSKJLanguage(@"加入经纪人享更多收益，详情联系平台客服")];
    }
    return _tipLabel;
}



-(UIView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[UIView alloc]init];
        [_bottomView setBackgroundColor:kWhiteColor];
        [_bottomView setCornerRadius:ScaleW(5)];
    }
    return _bottomView;
}

-(UILabel *)bottomTipLabel
{
    if (!_bottomTipLabel)
    {
        _bottomTipLabel = [[UILabel alloc]init];
        [_bottomTipLabel setFont:systemFont(ScaleW(13))];
        [_bottomTipLabel setTextColor:kSubTitleColor];
        [_bottomTipLabel setText:SSKJLanguage(@"我的邀请链接")];
    }
    return _bottomTipLabel;
}


-(UILabel *)invitationAddressLabel
{
    if (!_invitationAddressLabel)
    {
        _invitationAddressLabel = [[UILabel alloc]init];
        [_invitationAddressLabel setFont:systemFont(ScaleW(16))];
        [_invitationAddressLabel setTextColor:kSubTitleColor];
        [_invitationAddressLabel setNumberOfLines:0];
    }
    return _invitationAddressLabel;
}





-(UILabel *)invitationTipLabel
{
    if (!_invitationTipLabel)
    {
        _invitationTipLabel = [[UILabel alloc]init];
        [_invitationTipLabel setFont:systemFont(ScaleW(13))];
        [_invitationTipLabel setTextColor:kSubTitleColor];
        [_invitationTipLabel setText:SSKJLanguage(@"我的邀请码")];
    }
    return _invitationTipLabel;
}


-(UILabel *)invitationCodeLabel
{
    if (!_invitationCodeLabel)
    {
        _invitationCodeLabel = [[UILabel alloc]init];
        [_invitationCodeLabel setFont:systemBoldFont(ScaleW(24))];
        [_invitationCodeLabel setTextColor:kTitleColor];
        [_invitationCodeLabel setText:@"123456"];
    }
    return _invitationCodeLabel;
}


-(UIButton *)submitBtn
{
    if (!_submitBtn)
    {
        _submitBtn = [[UIButton alloc]init];
        [_submitBtn setTitle:SSKJLanguage(@"生成邀请海报") forState:UIControlStateNormal];
        [_submitBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:kBlueColor];
        [_submitBtn setCornerRadius:ScaleW(5)];
        [_submitBtn addTarget:self action:@selector(submitBtnACtion:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}


- (UIImageView *)leftImageView
{
    if (!_leftImageView)
    {
        _leftImageView = [[UIImageView alloc]init];
        [_leftImageView setImage:[UIImage imageNamed:@"duijie"]];
    }
    return _leftImageView;
}

- (UIImageView *)rightImageView
{
    if (!_rightImageView)
    {
        _rightImageView = [[UIImageView alloc]init];
        [_rightImageView setImage:[UIImage imageNamed:@"duijie"]];
    }
    return _rightImageView;
}









@end
