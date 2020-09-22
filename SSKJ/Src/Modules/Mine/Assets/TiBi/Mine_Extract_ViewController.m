//
//  Mine_Extract_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/15.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "Mine_Extract_ViewController.h"
#import "Mine_AddressManager_ViewController.h"
#import "Mine_QRScan_ViewController.h"
#import "AddressManager_HeaderView.h"
#import <AVFoundation/AVFoundation.h>
#import "ATEX_AssetRecord_ViewController.h"
#import <Photos/Photos.h>//相册

#import "Mine_AssetTiBiInfo_Model.h"
#import "UITextField+Helper.h"
#import "LA_Extract_SafeVerify_AlertView.h"

@interface Mine_Extract_ViewController ()<UITextFieldDelegate>



@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *usableTipLabel; //!< 可用提示
@property (nonatomic, strong) UILabel *usableLabel; //!<

@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UITextField *addressTextField;
@property (nonatomic, strong) UIButton *scanButton;
@property (nonatomic, strong) UIButton *addressButton;


@property (nonatomic, strong) UIView *numberBgView;
@property (nonatomic, strong) UILabel *numberLabel; //!< 数量
@property (nonatomic, strong) UITextField *numberTextField;
@property (nonatomic, strong) UILabel *unitLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *allButton;

@property (nonatomic, strong) UILabel *pwdtipLabel;
@property (nonatomic, strong) UITextField *pwdTextField; //!< 资金密码
@property (nonatomic, strong) UILabel *feedLabel; //!< 手续费
@property (nonatomic, strong) UILabel *daozhangLabel;// 到账数量
@property (nonatomic, strong) UIButton *tibiButton;



@property (nonatomic, strong) Mine_AssetTiBiInfo_Model *infoModel;
@end

@implementation Mine_Extract_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = SSKJLocalized(@"提币", nil);
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"Recharge"]];
    [self.view setBackgroundColor:kSubBgColor];
    [self unit:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestExtractInfo];
    
}

- (void)rigthBtnAction:(id)sender{
    ATEX_AssetRecord_ViewController *vc = [ATEX_AssetRecord_ViewController new];
    vc.assetType = AssetTypeExtract;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)unit:(BOOL)unit
{
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.usableTipLabel];
    [self.backView addSubview:self.usableLabel];
    [self.backView addSubview:self.addressLabel];
    [self.backView addSubview:self.addressTextField];
    [self.backView addSubview:self.addressButton];
    [self.backView addSubview:self.scanButton];
    

    
    [self.view addSubview:self.numberBgView];
    [self.numberBgView addSubview:self.numberLabel];
    [self.numberBgView addSubview:self.numberTextField];
    [self.numberBgView addSubview:self.allButton];
    [self.numberBgView addSubview:self.lineView];
    [self.numberBgView addSubview:self.feedLabel];
    [self.numberBgView addSubview:self.unitLabel];
    [self.numberBgView addSubview:self.pwdtipLabel];
    [self.numberBgView addSubview:self.pwdTextField];
    
    [self.view addSubview:self.tibiButton];
    [self.view addSubview:self.daozhangLabel];

    
    
    
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view).offset(Height_NavBar+10);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(170));
    }];
    
    [self.usableTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.equalTo(self.backView).offset(15);
        
    }];
    
    
    [self.usableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.usableTipLabel.mas_bottom).offset(15);
        make.left.equalTo(self.usableTipLabel.mas_left);
        
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.usableLabel.mas_bottom).offset(30);
        make.left.equalTo(self.usableTipLabel);
    }];
    
    [self.addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.addressLabel.mas_bottom).offset(5);
        make.left.equalTo(self.usableTipLabel);
        make.height.equalTo(@(30));
        make.width.equalTo(@(250));
    }];
    
    
    [self.addressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.backView.mas_right).offset(-15);
        make.centerY.equalTo(self.addressTextField.mas_centerY);
        make.width.height.equalTo(@(16));
    }];
    
    [self.scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.addressButton.mas_left).offset(-30);
        make.centerY.equalTo(self.addressTextField.mas_centerY);
        make.width.height.equalTo(@(16));
        
    }];
    
    
    [self.numberBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.backView.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(220));
        
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.numberBgView.mas_top).offset(20);
        make.left.equalTo(self.numberBgView.mas_left).offset(15);
        
    }];
    
    [self.numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.numberLabel.mas_bottom).offset(5);
        make.left.equalTo(self.numberLabel);
        make.width.height.equalTo(self.addressTextField);
    }];
    
    [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.numberBgView.mas_right).offset(-15);
        make.centerY.equalTo(self.numberTextField.mas_centerY);
        
    }];
    
    
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.allButton.mas_left).offset(-20);
        make.centerY.equalTo(self.numberTextField.mas_centerY);
    }];
    
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.numberTextField.mas_bottom).offset(10);
        make.left.right.equalTo(self.numberBgView);
        make.height.equalTo(@(40));
    }];
    
    [self.feedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.numberLabel.mas_left);
        make.centerY.equalTo(self.lineView.mas_centerY);
    }];
    
    [self.pwdtipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.lineView.mas_bottom).offset(20);
        make.left.equalTo(self.numberLabel);
    }];
    
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.pwdtipLabel.mas_bottom).offset(5);
        make.left.equalTo(self.numberLabel);
        make.width.height.equalTo(self.addressTextField);
    }];
    
    [self.daozhangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view.mas_left).offset(15);
        make.top.equalTo(self.numberBgView.mas_bottom).offset(70);
    }];
    
    [self.tibiButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.daozhangLabel.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@(45));
    }];
    
}





-(UIView *)backView
{
    if (nil == _backView)
    {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = kBgColor;
    }
    return _backView;
}



-(UILabel *)addressLabel
{
    if (nil == _addressLabel)
    {
        _addressLabel = [WLTools allocLabel:SSKJLocalized(@"提币地址", nil) font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
    }
    return _addressLabel;
}

-(UITextField *)addressTextField
{
    if (nil == _addressTextField)
    {
        _addressTextField = [[UITextField alloc]init];
        _addressTextField.textColor = kTitleColor;
        _addressTextField.placeholder = SSKJLocalized(@"输入或长按粘贴地址", nil);
        _addressTextField.font = systemFont(ScaleW(12));
    }
    return _addressTextField;
}

-(UIButton *)addressButton
{
    if (nil == _addressButton)
    {
        _addressButton = [[UIButton alloc]init];
        [_addressButton setImage:[UIImage imageNamed:@"mine_tibi_address"] forState:UIControlStateNormal];
        [_addressButton addTarget:self action:@selector(selectAddress) forControlEvents:UIControlEventTouchUpInside];

    }
    return _addressButton;
}


-(UIButton *)scanButton
{
    if (nil == _scanButton)
    {
        _scanButton = [[UIButton alloc]init];
        [_scanButton setImage:[UIImage imageNamed:@"saoma"] forState:UIControlStateNormal];
        [_scanButton addTarget:self action:@selector(scanEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanButton;
}


-(UILabel *)usableTipLabel
{
    if (nil == _usableTipLabel)
    {
        _usableTipLabel = [[UILabel alloc]init];
        [_usableTipLabel setText:SSKJLanguage(@"可用")];
        [_usableTipLabel setTextColor:kTitleColor];
        [_usableTipLabel setFont:systemFont(ScaleW(14))];
    }
    return _usableTipLabel;
}




-(UILabel *)usableLabel
{
    if (nil == _usableLabel)
    {
        _usableLabel = [[UILabel alloc]init];
        [_usableLabel setTextColor:kTitleColor];
        [_usableLabel setFont:systemFont(ScaleW(14))];
        [_usableLabel setText:@"0.00 USDT"];
    }
    return _usableLabel;
}

-(UIView *)numberBgView
{
    if (!_numberBgView)
    {
        _numberBgView = [[UIView alloc]init];
        [_numberBgView setBackgroundColor:kBgColor];
    }
    return _numberBgView;
}

-(UILabel *)numberLabel
{
    if (nil == _numberLabel)
    {
        _numberLabel = [[UILabel alloc]init];
        [_numberLabel setTextColor:kTitleColor];
        [_numberLabel setFont:systemFont(ScaleW(14))];
        [_numberLabel setText:SSKJLanguage(@"数量")];
    }
    return _numberLabel;
}



-(UITextField *)numberTextField
{
    if (nil == _numberTextField) {
        _numberTextField = [[UITextField alloc]init];
        _numberTextField.textColor = kTitleColor;
        _numberTextField.placeholder = SSKJLocalized(@"输入提币数量", nil);
        _numberTextField.font = systemFont(ScaleW(12));
        [_numberTextField setKeyboardType:UIKeyboardTypeNumberPad];
        _numberTextField.delegate = self;
        [_numberTextField addTarget:self action:@selector(inputChanged) forControlEvents:UIControlEventEditingChanged];
    }
    return _numberTextField;
}

-(UIButton *)allButton
{
    if (nil == _allButton)
    {
        _allButton = [[UIButton alloc]init];
        [_allButton setTitle:SSKJLanguage(@"全部") forState:UIControlStateNormal];
        [_allButton.titleLabel setFont:systemFont(ScaleW(14))];
        [_allButton addTarget:self action:@selector(allEvent) forControlEvents:UIControlEventTouchUpInside];
        [_allButton setTitleColor:kBlueColor forState:UIControlStateNormal];
    }
    return _allButton;
}

-(UIView *)lineView
{
    if (nil == _lineView)
    {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}


- (UILabel *)unitLabel
{
    if (nil == _unitLabel)
    {
        _unitLabel = [[UILabel alloc]init];
        [_unitLabel setFont:systemFont(ScaleW(14))];
        [_unitLabel setTextColor:kSubTitleColor];
        [_unitLabel setText:@"USDT"];
    }
    return _unitLabel;
}

-(UILabel *)feedLabel
{
    if (nil == _feedLabel)
    {
        _feedLabel = [[UILabel alloc]init];
        [_feedLabel setFont:systemFont(ScaleW(13))];
        [_feedLabel setTextColor:kTitleColor];
        [_feedLabel setText:[NSString stringWithFormat:@"%@:0.00 USDT/%@",SSKJLanguage(@"手续费"),SSKJLanguage(@"次")]];
    }
    return _feedLabel;
}


-(UILabel *)pwdtipLabel
{
    if (nil == _pwdtipLabel)
    {
        _pwdtipLabel = [[UILabel alloc]init];
        [_pwdtipLabel setFont:systemFont(ScaleW(15))];
        [_pwdtipLabel setTextColor:kTitleColor];
        [_pwdtipLabel setText:SSKJLanguage(@"资金密码")];
    }
    return _pwdtipLabel;
}


-(UITextField *)pwdTextField
{
    if (nil == _pwdTextField)
    {
        _pwdTextField = [[UITextField alloc]init];
        _pwdTextField.textColor = kTitleColor;
        _pwdTextField.placeholder = SSKJLanguage(@"请输入资金密码");
        _pwdTextField.font = systemFont(ScaleW(12));
        [_pwdTextField setSecureTextEntry:YES];
        _pwdTextField.delegate = self;
        [_pwdTextField addTarget:self action:@selector(inputChanged) forControlEvents:UIControlEventEditingChanged];
    }
    return _pwdTextField;
}






- (UIButton *)tibiButton
{
    if (_tibiButton == nil)
    {
        _tibiButton = [[UIButton alloc]init];
        [_tibiButton setTitle:SSKJLanguage(@"提币") forState:UIControlStateNormal];
        [_tibiButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_tibiButton setBackgroundColor:kBlueColor];
        [_tibiButton setCornerRadius:5];
        [_tibiButton addTarget:self action:@selector(tibiEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tibiButton;
}



-(UILabel *)daozhangLabel
{
    if (nil == _daozhangLabel)
    {
        _daozhangLabel = [[UILabel alloc]init];
        [_daozhangLabel setText:SSKJLanguage(@"到账数量:0.00 USDT")];
        [_daozhangLabel setTextColor:kTitleColor];
        [_daozhangLabel setFont:systemFont(ScaleW(17))];
    }
    return _daozhangLabel;
}




#pragma mark - 用户操作

// 点击全部
-(void)allEvent
{
    double allTibi = self.infoModel.balance.doubleValue - self.infoModel.fee.doubleValue;
    
    if (allTibi < 0) {
        allTibi = 0;
    }
    
    self.numberTextField.text = [WLTools noroundingStringWith:allTibi afterPointNumber:2];
    
    [self inputChanged];
    
}

// 选择提币地址
-(void)selectAddress
{
    Mine_AddressManager_ViewController *vc = [[Mine_AddressManager_ViewController alloc]init];
    WS(weakSelf);
    vc.getAddressBlock = ^(ExtractAddress_IndexModel *addressModel)
    {
        weakSelf.addressTextField.text = addressModel.address;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

// 扫描
-(void)scanEvent
{
        [self videoAuthAction];

       
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
       //NSString *tips = @"您没有权限访问相机,请去设置中开启！";
       if(status == AVAuthorizationStatusAuthorized)
       {
           Mine_QRScan_ViewController *scan = [[Mine_QRScan_ViewController alloc]init];
           WS(weakSelf);
           scan.codeScaningString = ^(NSString *string) {
               weakSelf.addressTextField.text = string;
           };
           [self.navigationController pushViewController:scan animated:YES];
           
       }
}


//授权相机
- (void)videoAuthAction
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        SSLog(@"%@",granted ? @"相机准许":@"相机不准许");
        [self checkVideoStatus];
    }];
}

//检查相机权限
- (void)checkVideoStatus
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            //没有询问是否开启相机
            //self.videoStatus = @"AVAuthorizationStatusNotDetermined";
            break;
        case AVAuthorizationStatusRestricted:
            //未授权，家长限制
            //self.videoStatus = @"AVAuthorizationStatusRestricted";
            break;
        case AVAuthorizationStatusDenied:
            //未授权
           // self.videoStatus = @"AVAuthorizationStatusDenied";
            break;
        case AVAuthorizationStatusAuthorized:
            //玩家授权
           // self.videoStatus = @"AVAuthorizationStatusAuthorized";
            break;
        default:
            break;
    }
    
}


// 提币操作
-(void)tibiEvent
{
    if (self.addressTextField.text.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入或长按粘贴地址", nil)];
        return;
    }
    
    if (self.numberTextField.text.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入提币数量", nil)];
        return;
    }
    
    if (self.numberTextField.text.doubleValue < self.infoModel.min.doubleValue)
    {
        [MBProgressHUD showError:[NSString stringWithFormat:SSKJLocalized(@"最小提币数量%@ USDT", nil),[WLTools noroundingStringWith:self.infoModel.min.doubleValue afterPointNumber:2]]];
        return;
    }
    
    if (self.numberTextField.text.doubleValue > self.infoModel.max.doubleValue)
    {
        [MBProgressHUD showError:[NSString stringWithFormat:SSKJLocalized(@"最大提币数量%@ USDT", nil),[WLTools noroundingStringWith:self.infoModel.max.doubleValue afterPointNumber:2]]];
        return;
    }
    
    
    if (self.pwdTextField.text.length  == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入资金密码", nil)];
        return;
    }
    
    
    
    WS(weakSelf);
    [LA_Extract_SafeVerify_AlertView showsubmitBlock:^(NSString *code) {
      
        [weakSelf requestExtractWithCode:code];
        
    }];
    
}


#pragma mark - 网络请求

-(void)requestExtractInfo
{
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_ExtractInfo_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject)
    {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED)
        {
            weakSelf.infoModel = [Mine_AssetTiBiInfo_Model mj_objectWithKeyValues:[net_model.data firstObject]];
            [weakSelf reset:weakSelf.infoModel];
        }
        else
        {
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

-(void)reset:(Mine_AssetTiBiInfo_Model*)model
{
    [self.usableLabel setText:[NSString stringWithFormat:@"%@ USDT",model.balance]];
    [self.feedLabel setText:[NSString stringWithFormat:@"%@:%@ USDT/%@",model.fee,SSKJLanguage(@"手续费"),SSKJLanguage(@"次")]];
    
}


#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.numberTextField)
    {
        return [textField textFieldShouldChangeCharactersInRange:range replacementString:string dotNumber:2];
    }
    else
    {
        return YES;
    }
}


-(void)inputChanged
{
    self.numberTextField.text = [self deleteFirstZero:self.numberTextField.text];
    
    NSString *shijiString = self.numberTextField.text;
    
    NSString *string = [NSString stringWithFormat:SSKJLocalized(@"到账数量:%@ USDT", nil),shijiString];
    
    self.daozhangLabel.attributedText = [WLTools setAttributeTextWithString:string colorString:shijiString color:kBlueColor];
    
}

// 出去首位0
-(NSString *)deleteFirstZero:(NSString *)string
{
    if (![string hasPrefix:@"0"] || [string isEqualToString:@"0"] || [string hasPrefix:@"0."]) {
        
        return string;
    }else{
        return [self deleteFirstZero:[string substringFromIndex:1]];
    }
}




#pragma mark - 提币

-(void)requestExtractWithCode:(NSString *)code
{
    NSDictionary *params = @{
                            @"money":self.numberTextField.text,
                            @"payment_password":self.pwdTextField.text,
                            @"code":code,
                            @"address":self.addressTextField.text,
                            @"type":@"1"
                            };
    
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_ConfirmExtract_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED)
        {
            [weakSelf clearView];
            [weakSelf rigthBtnAction:nil];
        }
        else
        {
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

-(void)clearView
{
    self.numberTextField.text = nil;
    self.addressTextField.text = nil;

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
