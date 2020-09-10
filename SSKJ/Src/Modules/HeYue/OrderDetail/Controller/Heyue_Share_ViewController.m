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
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UILabel * incomeTitleLabel;
@property (nonatomic, strong) UILabel *incomeLabel;

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *openPriceLabel;
@property (nonatomic, strong) UILabel *closePriceLabel;

@property (nonatomic, strong) UIView *bottomBackView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *bottomLabel;
@property (nonatomic, strong) UIImageView *qrCodeImageView;
@end

@implementation Heyue_Share_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColorFromRGB(0x0d0d2a);
    [self addRightNavItemWithTitle:SSKJLocalized(@"保存图片", nil) color:kWhiteColor font:systemFont(ScaleW(15))];
    [self setTitleColor:kWhiteColor];
    [self addLeftNavItemWithImage:[UIImage imageNamed:@"root_back_w"]];
    [self setNavgationBackgroundColor:[UIColor whiteColor] alpha:1];
    self.title = SSKJLocalized(@"分享", nil);
    
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestLink];
}

-(void)setUI
{
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.incomeTitleLabel];
    [self.view addSubview:self.incomeLabel];
    
    [self addLabels];
    
    [self.view addSubview:self.bottomBackView];

    [self.imageView addSubview:self.qrCodeImageView];
    
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(Height_NavBar, 0, 0, 0));
    }];
    
    [self.qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.imageView.mas_bottom).offset(-ScaleW(120));
        make.centerX.equalTo(self.imageView.mas_centerX);
        make.width.height.equalTo(@(ScaleW(80)));
        
    }];
}

- (UIImageView *)imageView
{
    if (nil == _imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setImage:[UIImage imageNamed:@"shareSuccess"]];
    }
    return _imageView;
}

-(UILabel *)messageLabel
{
    if (nil == _messageLabel)
    {
        _messageLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(17)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15),ScaleW(240), ScreenWidth - ScaleW(30), ScaleW(17)) textAlignment:NSTextAlignmentCenter];
        
        if (self.chengjiaoModel.profit.doubleValue < 0)
        {
            _messageLabel.text = SSKJLocalized(@"再接再厉", nil);

        }
        else
        {
            _messageLabel.text = SSKJLocalized(@"小试牛刀", nil);

        }
        
    }
    return _messageLabel;
}


-(UILabel *)incomeTitleLabel
{
    if (nil == _incomeTitleLabel) {
        _incomeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"收益", nil) font:systemFont(ScaleW(15)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.messageLabel.bottom + ScaleW(50), ScreenWidth - ScaleW(30), ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _incomeTitleLabel;
}

-(UILabel *)incomeLabel
{
    if (nil == _incomeLabel) {
        _incomeLabel = [WLTools allocLabel:SSKJLocalized(@"15.4", nil) font:systemFont(ScaleW(25)) textColor:[UIColor blackColor] frame:CGRectMake(ScaleW(15), self.incomeTitleLabel.bottom + ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(25)) textAlignment:NSTextAlignmentCenter];
        _incomeLabel.text =  [SSTool HeyuePname:self.chengjiaoModel.code price:self.chengjiaoModel.profit];
        
        if (self.chengjiaoModel.profit.doubleValue < 0) {
            _incomeLabel.textColor = RED_HEX_COLOR;
        }else{
            _incomeLabel.textColor = GREEN_HEX_COLOR;
        }

    }
    return _incomeLabel;
}


-(void)addLabels
{
    NSArray *array = @[[NSString stringWithFormat:@"%@%@",[self.chengjiaoModel.code uppercaseString],SSKJLocalized(@"永续", nil)],SSKJLocalized(@"开仓价格", nil),SSKJLocalized(@"当前价格", nil)];
    
    CGFloat startX = ScaleW(30);
    
    CGFloat startY = self.incomeLabel.bottom + ScaleW(50);
    
    CGFloat width = (ScreenWidth - 2 * startX) / 3;
    
    for (int i = 0; i < array.count; i++)
    {
        
        CGFloat newWidth = width;
        if (i == 0)
        {
            newWidth = width + ScaleW(30);
        }
        else
        {
            newWidth = width - ScaleW(15);
        }
        
        
        UILabel *titleLabel = [WLTools allocLabel:array[i] font:systemFont(ScaleW(15)) textColor:kSubTitleColor frame:CGRectMake(startX, startY, newWidth, ScaleW(15)) textAlignment:NSTextAlignmentLeft];
        [self.view addSubview:titleLabel];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        UILabel *valueLabel = [WLTools allocLabel:array[i] font:systemFont(ScaleW(15)) textColor:[UIColor blackColor] frame:CGRectMake(startX , titleLabel.bottom + ScaleW(5), newWidth, ScaleW(15)) textAlignment:NSTextAlignmentLeft];
        [self.view addSubview:valueLabel];
        
        startX += newWidth;
        if (i == 0)
        {
            self.typeLabel = valueLabel;
            if (self.chengjiaoModel.otype.integerValue == 1)
            {
                self.typeLabel.text = SSKJLocalized(@"做多", nil);
                self.typeLabel.textColor = GREEN_HEX_COLOR;
            }
            else
            {
                self.typeLabel.text = SSKJLocalized(@"做多", nil);
                self.typeLabel.textColor = RED_HEX_COLOR;
            }
        }
        else if (i == 1)
        {
            self.openPriceLabel = valueLabel;
            self.openPriceLabel.text = [SSTool HeyueCoin:self.chengjiaoModel.code price:self.chengjiaoModel.buyprice];
        }
        else  if (i == 2)
        {
            self.closePriceLabel = valueLabel;
            titleLabel.textAlignment = valueLabel.textAlignment = NSTextAlignmentRight;
            if ([self.chengjiaoModel.type integerValue] == 1)
            {
                self.closePriceLabel.text = SSKJLanguage(@"市价");
            }
            else if ([self.chengjiaoModel.type integerValue] == 2)
            {
                self.closePriceLabel.text = [SSTool HeyueCoin:self.chengjiaoModel.code price:self.chengjiaoModel.marketPrice];
            }
        }
            
    }
    
}




- (UIImageView *)qrCodeImageView
{
    if (nil == _qrCodeImageView)
    {
        _qrCodeImageView = [[UIImageView alloc]init];
    }
    return _qrCodeImageView;
}



-(void)requestLink
{
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_Qrcode_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {
            [weakSelf.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:@"qrcode"]];
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



-(void)rigthBtnAction:(id)sender
{
    UIImage *image = [self screenShot];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
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
