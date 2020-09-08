//
//  Market_KeyBuyCoin_VC.m
//  ZYW_MIT
//
//  Created by Tom on 2020/1/9.
//  Copyright © 2020 Wang. All rights reserved.
//

#import "Market_KeyBuyCoin_VC.h"

#import "BuyCoinRecord_ViewController.h"

#import "SSKJ_H5Web_ViewController.h"

#import "Mine_TitleAndInput_View.h"

#import "UITextField+Helper.h"

@interface Market_KeyBuyCoin_VC ()<UITextFieldDelegate>


@property (nonatomic,strong) UILabel * unitLabel;

@property (nonatomic, strong) Mine_TitleAndInput_View *numberView;
@property (nonatomic, strong) Mine_TitleAndInput_View *phoneView;
@property (nonatomic, strong) Mine_TitleAndInput_View *nameView;


@property (nonatomic,strong) UIButton * submitBtn;

@property (nonatomic,strong) UILabel * tipTitle;

@property (nonatomic,strong) UILabel * tipDetail;

@end

@implementation Market_KeyBuyCoin_VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kSubBgColor;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"Recharge"]];
    self.title = SSKJLocalized(@"快捷买币", nil);
    
    [self.view addSubview:self.numberView];
    
    [self.numberView addSubview:self.unitLabel];
    
    [self.view addSubview:self.nameView];

    [self.view addSubview:self.phoneView];

    
    
    [self.view addSubview:self.tipTitle];
    
    [self.view addSubview:self.tipDetail];
    
    
    [self.view addSubview:self.submitBtn];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view.mas_left).offset(ScaleW(15));
        make.right.equalTo(self.view.mas_right).offset(-ScaleW(15));
        make.height.equalTo(@(ScaleW(45)));
        make.bottom.equalTo(self.view.mas_bottom).offset(-ScaleW(30));
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


#pragma mark - 记录
-(void)rigthBtnAction:(id)sender
{
    BuyCoinRecord_ViewController *vc = [[BuyCoinRecord_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}







- (Mine_TitleAndInput_View *)numberView
{
    if (_numberView == nil)
    {
        _numberView = [[Mine_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, Height_NavBar + ScaleW(5), ScreenWidth, ScaleW(80)) title:SSKJLocalized(@"购入数量", nil) placeHolder:SSKJLocalized(@"请输入买入数量", nil) keyBoardType:UIKeyboardTypeDecimalPad isSecure:NO];
        _numberView.textField.delegate = self;
        [_numberView.textField addTarget:self action:@selector(inputChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _numberView;
}



- (UILabel *)unitLabel
{
    if (_unitLabel == nil)
    {
        _unitLabel = [FactoryUI createLabelWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(45), 0, ScaleW(45), ScaleW(20)) text:SSKJLocalized(@"USDT", nil) textColor:kTitleColor font:systemFont(ScaleW(15))];
        _unitLabel.centerY = self.numberView.textField.centerY;
    }
    return _unitLabel;
}


- (Mine_TitleAndInput_View *)nameView
{
    if (_nameView == nil) {
        _nameView = [[Mine_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.numberView.bottom+ScaleW(10), ScreenWidth, ScaleW(80)) title:SSKJLocalized(@"姓名", nil) placeHolder:SSKJLocalized(@"请输入您的真实姓名", nil) keyBoardType:UIKeyboardTypeDefault isSecure:NO];
    }
    return _nameView;
}



- (Mine_TitleAndInput_View *)phoneView
{
    if (_phoneView == nil) {
        _phoneView = [[Mine_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.nameView.bottom, ScreenWidth, ScaleW(80)) title:SSKJLocalized(@"手机号", nil) placeHolder:SSKJLocalized(@"请输入手机号", nil) keyBoardType:UIKeyboardTypeNumberPad isSecure:NO];
    }
    return _phoneView;
}



- (UILabel *)tipTitle
{
    if (_tipTitle == nil)
    {
        _tipTitle = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(15), self.phoneView.bottom + ScaleW(30),(ScreenWidth-ScaleW(30)), ScaleW(15)) text:SSKJLocalized(@"快捷买币说明：", nil) textColor:kTitleColor font:systemFont(ScaleW(15))];
    }
    return _tipTitle;
}

- (UILabel *)tipDetail
{
    if (_tipDetail == nil)
    {
        
        NSString *string = SSKJLocalized(@"1、行情火爆，购币人数过多，商家应接不暇，支付宝、微信转账如无法支付，请使用银行卡转账\n2、请提前做好购币准备，以免影响您的交易", nil);
        
        _tipDetail = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(15), self.tipTitle.bottom + ScaleW(10), self.tipTitle.width, ScaleW(50)) text:string textColor:kSubTitleColor font:systemFont(ScaleW(15))];
        _tipDetail.numberOfLines = 0;
        CGFloat height = [string boundingRectWithSize:CGSizeMake(_tipDetail.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_tipDetail.font} context:nil].size.height;
        _tipDetail.height = height;
    }
    return _tipDetail;
}


- (UIButton *)submitBtn
{
    if (_submitBtn == nil)
    {
        _submitBtn = [FactoryUI createButtonWithFrame:CGRectZero title:SSKJLocalized(@"确定买币", nil) titleColor:kWhiteColor imageName:@"" backgroundImageName:@"Btn_BgImg" target:self selector:@selector(submitBtnAction) font:systemFont(ScaleW(15))];
        _submitBtn.backgroundColor = kBlueColor;
        _submitBtn.layer.cornerRadius = ScaleW(5);
    }
    return _submitBtn;
}
                



#pragma mark - NetWork Method 网络请求
- (void)submitBtnAction{
    
    if (self.numberView.valueString.doubleValue == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入买入数量", nil)];
        return;
    }
    
    if (self.nameView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入您的真实姓名", nil)];
        return;
    }
    
    if (self.phoneView.valueString.length == 0) {
       [MBProgressHUD showError:SSKJLocalized(@"请输入手机号", nil)];
       return;
   }
    
    if (![RegularExpression validateMobile:self.phoneView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入正确的手机号", nil)];
        return;

    }
  
    WS(weakSelf);
    
    NSDictionary *params = @{
                            @"money":self.numberView.valueString,
                            @"phone":self.phoneView.valueString,
                            @"name":self.nameView.valueString
                            };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:URL_FastPay_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (net_model.status.integerValue == SUCCESSED)
        {
            [MBProgressHUD showError:net_model.msg];
            [weakSelf clearView];
            
            SSKJ_H5Web_ViewController *vc = [[SSKJ_H5Web_ViewController alloc]init];
            vc.url = net_model.data[@"link"];
            vc.title = SSKJLocalized(@"支付", nil);
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }
        else
        {
            [MBProgressHUD showError:net_model.msg];
        }
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"服务器请求异常", nil)];
        
    }];

        
}


-(void)clearView
{
    self.numberView.valueString = @"";
    self.nameView.valueString = @"";
    self.phoneView.valueString = @"";
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.numberView.textField) {
        return [textField textFieldShouldChangeCharactersInRange:range replacementString:string dotNumber:2];
    }
    
    return YES;
}

-(void)inputChanged:(UITextField *)textField
{
    textField.text = [self deleteFirstZero:textField.text];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
