
//
//  My_Charge_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "Mine_Recharge_ViewController.h"
#import "Mine_RechargeTop_View.h"
#import "Home_Segment_View.h"
#import "Mine_BindGoogle_AlertView.h"
#import "ATEX_AssetRecord_ViewController.h"
#import "RechargeModel.h"





@interface Mine_Recharge_ViewController ()

@property (nonatomic, strong) Mine_RechargeTop_View *chargeView;  //!< 充币地址，上部分内容
 
@property (nonatomic, strong) UILabel *warnTitleLabel;
@property (nonatomic, strong) UILabel *warnLabel;
@property (nonatomic, strong) UIView *segmentView;
@property (nonatomic, strong) UILabel *segmentleftLabel;
@property (nonatomic, strong) UILabel *segmentrightLabel;
@property (nonatomic, strong) UIImageView *accessoryImageView;


@property (nonatomic, strong) NSMutableArray *rechargeArray; //!< 充值数组



@end

@implementation Mine_Recharge_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kSubBgColor;
    self.title = SSKJLanguage(@"充币");
    [self addRightNavgationItemWithImage:UIImageNamed(@"Recharge")];
    [self unit:YES];
    [self requestAddress];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)rigthBtnAction:(id)sender
{
    ATEX_AssetRecord_ViewController *vc = [ATEX_AssetRecord_ViewController new];
    vc.assetType = AssetTypeCharge;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - setUI
-(void)unit:(BOOL)unit
{
    if (unit)
    {
        [self.view addSubview:self.segmentView];
        [self.segmentView addSubview:self.segmentleftLabel];
        [self.segmentView addSubview:self.segmentrightLabel];
        [self.segmentView addSubview:self.accessoryImageView];
        [self.view addSubview:self.chargeView];
        [self.view addSubview:self.warnTitleLabel];
        [self.view addSubview:self.warnLabel];
        
        
        [self.segmentleftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.segmentView.mas_left).offset(15);
            make.centerY.equalTo(self.segmentView.mas_centerY);
        }];
        
        [self.accessoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.segmentView.mas_right).offset(-15);
            make.centerY.equalTo(self.segmentView.mas_centerY);
            
        }];
        
        
        [self.segmentrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.accessoryImageView.mas_left).offset(-5);
            make.centerY.equalTo(self.segmentView.mas_centerY);
            
        }];
        
        
        [self.warnTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
     
            make.top.equalTo(self.chargeView.mas_bottom).offset(25);
            make.left.right.equalTo(self.chargeView);
        }];
        
        [self.warnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.warnTitleLabel.mas_bottom).offset(2);
            make.left.right.equalTo(self.warnTitleLabel);
            
        }];
        
    }
}


#pragma mark - Getter / Setter
-(Mine_RechargeTop_View *)chargeView
{
    if (nil == _chargeView)
    {
        _chargeView = [[Mine_RechargeTop_View alloc]initWithFrame:CGRectMake(ScaleW(15), self.segmentView.bottom + ScaleW(15), ScreenWidth - ScaleW(30), ScaleW(400))];
        [_chargeView setBackgroundColor:kWhiteColor];
    }
    return _chargeView;
}

-(UILabel *)warnTitleLabel
{
    if (nil == _warnTitleLabel)
    {
        _warnTitleLabel  = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLanguage(@"1.请勿向上述地址充值任何非USDT资产，否则资产将不可找回。") textColor:kSubTitleColor font:systemFont(ScaleW(14))];
        [_warnTitleLabel setNumberOfLines:0];
    }
    return _warnTitleLabel;
}


-(UILabel *)warnLabel
{
    if (nil == _warnLabel)
    {
        _warnLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLanguage(@"2.平台支持ERC20类型钱包充币。") textColor:kSubTitleColor font:systemFont(ScaleW(14))];
        [_warnLabel setNumberOfLines:0];
    }
    return _warnLabel;
}




-(UIView *)segmentView
{
    if (!_segmentView)
    {
        _segmentView = [[UIView alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, 50)];
        [_segmentView setBackgroundColor:kBgColor];
    }
    return _segmentView;
}


-(UILabel *)segmentleftLabel
{
    if (!_segmentleftLabel)
    {
        _segmentleftLabel = [[UILabel alloc]init];
        [_segmentleftLabel setTextColor:kTitleColor];
        [_segmentleftLabel setFont:systemFont(ScaleW(15))];
        [_segmentleftLabel setText:SSKJLanguage(@"钱包类型")];
    }
    return _segmentleftLabel;
}


-(UILabel *)segmentrightLabel
{
    if (!_segmentrightLabel)
    {
        _segmentrightLabel = [[UILabel alloc]init];
        [_segmentrightLabel setTextColor:kTitleColor];
        [_segmentrightLabel setFont:systemFont(ScaleW(15))];
        [_segmentrightLabel setText:@"ERC20"];
    }
    return _segmentrightLabel;
}


-(UIImageView *)accessoryImageView
{
    if (!_accessoryImageView)
    {
        _accessoryImageView = [[UIImageView alloc]init];
        [_accessoryImageView setImage:[UIImage imageNamed:@"accessory"]];
    }
    return _accessoryImageView;
}

-(NSMutableArray <RechargeModel*> *)rechargeArray
{
    if (!_rechargeArray)
    {
        _rechargeArray = [[NSMutableArray alloc]init];
    }
    return _rechargeArray;
}






- (void)requestAddress
{
    #pragma mark 处理
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);

    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_RechargeAddr_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject)
    {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if ([responseObject[@"code"] integerValue] == 200)
        {
            NSArray *itemArray = [responseObject objectForKey:@"data"];
            
            for (NSDictionary *object in itemArray)
            {
                RechargeModel *model = [[RechargeModel alloc]init];
                [model setAddress:[object objectForKey:@"address"]];
                [model setCode:[object objectForKey:@"code"]];
                [model setQrcode:[object objectForKey:@"qrcode"]];
                [weakSelf.rechargeArray addObject:model];
            }
            
            
            [weakSelf.rechargeArray enumerateObjectsUsingBlock:^(RechargeModel *obj, NSUInteger idx, BOOL * _Nonnull stop)
             {
                NSString *code = [obj.code lowercaseString];
                if ([code containsString:@"erc20"])
                {
                    [weakSelf.chargeView setAddress:obj.address];
                    [weakSelf.chargeView.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:obj.qrcode]];
                    *stop = YES;
                }
            }];
        }
        else
        {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"加载失败", nil)];
    }];
}


@end
