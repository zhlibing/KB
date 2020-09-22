//
//  Heyue_Share_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/17.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "Heyue_Share_ViewController.h"




@interface Heyue_Share_ViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *incomeTitleLabel;
@property (nonatomic, strong) UILabel *incomeLabel;
@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *openTipLabel;
@property (nonatomic, strong) UILabel *openPriceLabel;
@property (nonatomic, strong) UILabel *numberTipLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *codeTipLabel;
@property (nonatomic, strong) UILabel *codeLabel;



@property (nonatomic, strong) UIImageView *qrCodeImageView;

@end

@implementation Heyue_Share_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUI];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, Height_NavBar-40, 20, 20)];
    [backBtn setImage:[UIImage imageNamed:@"mine_hack"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-55, backBtn.top, 40, 20)];
    [saveBtn setTitle:SSKJLanguage(@"保存") forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(rigthBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBarHidden:YES];
    /**
     [self requestLink];
     */
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setNavigationBarHidden:NO];
}



-(void)setUI
{
    [self.view addSubview:self.imageView];
    [self.imageView addSubview:self.incomeTitleLabel];
    [self.imageView addSubview:self.incomeLabel];
    [self.imageView addSubview:self.typeLabel];
    [self.imageView addSubview:self.codeTipLabel];
    [self.imageView addSubview:self.codeLabel];
    [self.imageView addSubview:self.numberTipLabel];
    [self.imageView addSubview:self.numberLabel];
    [self.imageView addSubview:self.openTipLabel];
    [self.imageView addSubview:self.openPriceLabel];
    

    [self.imageView addSubview:self.qrCodeImageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    [self.incomeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.imageView.mas_top).offset(200);
        make.centerX.equalTo(self.imageView.mas_centerX);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.incomeTitleLabel.mas_centerY);
        make.left.equalTo(self.incomeTitleLabel.mas_right).offset(10);
        make.height.equalTo(@(20));
        make.width.equalTo(@(35));
        
    }];
    
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.incomeTitleLabel.mas_bottom).offset(15);
        make.centerX.equalTo(self.imageView.mas_centerX);
        
    }];
    
    [self.codeTipLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
       make.right.equalTo(self.numberTipLabel.mas_left).offset(-ScaleW(80));
       make.centerY.equalTo(self.numberTipLabel.mas_centerY);
    }];
       
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      
       make.centerX.equalTo(self.codeTipLabel.mas_centerX);
       make.centerY.equalTo(self.numberLabel.mas_centerY);
       
    }];
    
    
    [self.numberTipLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.incomeLabel.mas_bottom).offset(40);
        make.centerX.equalTo(self.imageView.mas_centerX);
    }];
    
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.numberTipLabel.mas_bottom).offset(ScaleW(15));
        make.centerX.equalTo(self.imageView.mas_centerX);
        
    }];
    
    
    [self.openTipLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
       make.left.equalTo(self.numberTipLabel.mas_right).offset(ScaleW(80));
       make.centerY.equalTo(self.numberTipLabel.mas_centerY);
    }];
       
    [self.openPriceLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
      
       make.centerX.equalTo(self.openTipLabel.mas_centerX);
       make.centerY.equalTo(self.numberLabel.mas_centerY);
       
    }];
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    [self.qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.imageView.mas_bottom).offset(-ScaleW(120));
        make.centerX.equalTo(self.imageView.mas_centerX);
        make.width.height.equalTo(@(ScaleW(80)));
        
    }];
}





-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)rigthBtnAction
{
    UIImage *image = [self screenShot];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
}

- (void)setChengjiaoModel:(Heyue_Order_ChengjiaoModel *)chengjiaoModel
{
    _chengjiaoModel = chengjiaoModel;
    [self.codeLabel setText:[[chengjiaoModel.code stringByReplacingOccurrencesOfString:@"_" withString:@"/"] uppercaseString]];
    [self.numberLabel setText:chengjiaoModel.buynum];
    [self.incomeLabel setText:[SSTool HeyuePname:chengjiaoModel.code price:chengjiaoModel.profit]];
    
     if (chengjiaoModel.profit.doubleValue < 0)
     {
        self.incomeLabel.textColor = RED_HEX_COLOR;
         
     }
     else
     {
        self.incomeLabel.textColor = GREEN_HEX_COLOR;
     }
    
    if (chengjiaoModel.otype.integerValue == 1)
    {
        self.typeLabel.text = SSKJLocalized(@"做多", nil);
        [self.typeLabel setBackgroundColor:GREEN_HEX_COLOR];
    }
    else
    {
        self.typeLabel.text = SSKJLocalized(@"做空", nil);
        [self.typeLabel setBackgroundColor:RED_HEX_COLOR];
    }
    
    
    [self.openPriceLabel setText:[SSTool HeyuePname:chengjiaoModel.code price:chengjiaoModel.buyprice]];
    
    
}





#pragma mark - Getter / Setter
- (UIImageView *)imageView
{
    if (nil == _imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setImage:[UIImage imageNamed:@"shareSuccess"]];
    }
    return _imageView;
}



-(UILabel *)incomeTitleLabel
{
    if (nil == _incomeTitleLabel)
    {
        _incomeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"盈利金额", nil) font:systemFont(ScaleW(15)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
    }
    return _incomeTitleLabel;
}

-(UILabel *)typeLabel
{
    if (nil == _typeLabel)
    {
        _typeLabel = [[UILabel alloc]init];
        [_typeLabel setFont:systemFont(12)];
        [_typeLabel setTextColor:kWhiteColor];
        [_typeLabel setTextAlignment:NSTextAlignmentCenter];
        [_typeLabel.layer setCornerRadius:3];
        [_typeLabel.layer setMasksToBounds:YES];
    }
    return _typeLabel;
}






-(UILabel *)incomeLabel
{
    if (nil == _incomeLabel)
    {
        _incomeLabel = [WLTools allocLabel:SSKJLocalized(@"15.4", nil) font:systemBoldFont(ScaleW(20)) textColor:[UIColor blackColor] frame:CGRectZero textAlignment:NSTextAlignmentCenter];
    }
    return _incomeLabel;
}

-(UILabel *)codeTipLabel
{
    if (!_codeTipLabel)
    {
        _codeTipLabel = [[UILabel alloc]init];
        [_codeTipLabel setTextColor:kSubTitleColor];
        [_codeTipLabel setFont:systemFont(ScaleW(14))];
        [_codeTipLabel setText:SSKJLanguage(@"USDT合约")];
    }
    return _codeTipLabel;
}


- (UILabel *)codeLabel
{
    if (!_codeLabel)
    {
        _codeLabel = [[UILabel alloc]init];
        [_codeLabel setTextColor:[UIColor blackColor]];
        [_codeLabel setFont:systemFont(ScaleW(17))];
    }
    return _codeLabel;
}


-(UILabel *)numberTipLabel
{
    if (!_numberTipLabel)
    {
        _numberTipLabel = [[UILabel alloc]init];
        [_numberTipLabel setTextColor:kSubTitleColor];
        [_numberTipLabel setFont:systemFont(ScaleW(14))];
        [_numberTipLabel setText:SSKJLanguage(@"数量")];
    }
    return _numberTipLabel;
}


- (UILabel *)numberLabel
{
    if (!_numberLabel)
    {
        _numberLabel = [[UILabel alloc]init];
        [_numberLabel setTextColor:[UIColor blackColor]];
        [_numberLabel setFont:systemFont(ScaleW(17))];
    }
    return _numberLabel;
}


-(UILabel *)openTipLabel
{
    if (!_openTipLabel)
    {
        _openTipLabel = [[UILabel alloc]init];
        [_openTipLabel setTextColor:kSubTitleColor];
        [_openTipLabel setFont:systemFont(ScaleW(14))];
        [_openTipLabel setText:SSKJLanguage(@"开仓价")];
    }
    return _openTipLabel;
}


- (UILabel *)openPriceLabel
{
    if (!_openPriceLabel)
    {
        _openPriceLabel = [[UILabel alloc]init];
        [_openPriceLabel setTextColor:[UIColor blackColor]];
        [_openPriceLabel setFont:systemFont(ScaleW(17))];
    }
    return _openPriceLabel;
}





- (UIImageView *)qrCodeImageView
{
    if (nil == _qrCodeImageView)
    {
        _qrCodeImageView = [[UIImageView alloc]init];
        [_qrCodeImageView setHidden:YES];
    }
    return _qrCodeImageView;
}



#pragma mark 获取分享二维码
-(void)requestLink
{
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_Qrcode_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {
            [weakSelf.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:[network_Model.data objectForKey:@"qrcode"]]];
        }
        else
        {
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
    {
    
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网错出错", nil)];
    }];
}






// 需要实现下面的方法,或者传入三个参数即可
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [MBProgressHUD showError:SSKJLocalized(@"保存失败", nil)];
    } else {
        [MBProgressHUD showError:SSKJLocalized(@"保存成功", nil)];
    }
}

// 截屏
- (UIImage *)screenShot {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ScreenWidth, ScreenHeight), NO, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenShotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShotImage;
}



@end
