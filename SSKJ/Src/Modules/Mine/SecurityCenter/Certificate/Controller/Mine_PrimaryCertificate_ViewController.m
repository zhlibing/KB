//
//  My_PrimaryCertificate_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "Mine_PrimaryCertificate_ViewController.h"
#import "SSKJ_TextFieldView.h"
#import "Mine_ImagePicker_ViewController.h"
#import "IdverificationControl.h"


typedef NS_ENUM(NSUInteger, PhotoType)
{
    PhotoTypeFront = 1,
    PhotoTypeBack = 2,
};



@interface Mine_PrimaryCertificate_ViewController ()<Mine_ImagePickerControllerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) SSKJ_TextFieldView *nameView;  //!< 用户名视图
@property (nonatomic, strong) SSKJ_TextFieldView *idView;  //!< 身份证视图
@property (nonatomic, strong) IdverificationControl *frontControl;  //!< 正面
@property (nonatomic, strong) IdverificationControl *backControl;  //!< 正面


@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, assign) PhotoType photoType;


@end

@implementation Mine_PrimaryCertificate_ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = SSKJLocalized(@"身份认证", nil);
        
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}




#pragma mark - Getter / Setter
-(void)setUI
{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.nameView];
    [self.scrollView addSubview:self.idView];
    [self.scrollView addSubview:self.frontControl];
    [self.scrollView addSubview:self.backControl];
    [self.scrollView addSubview:self.submitButton];
    
    [self.scrollView setContentSize:CGSizeMake(ScreenWidth, self.submitButton.bottom+ScaleW(30))];
        
}

-(UIScrollView *)scrollView
{
    if (nil == _scrollView)
    {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    return _scrollView;
}




-(SSKJ_TextFieldView *)nameView
{
    if (nil == _nameView)
    {
        _nameView = [[SSKJ_TextFieldView alloc]init];
        [_nameView setFrame:CGRectMake(0, ScaleW(30), ScreenWidth, ScaleW(70))];
        [_nameView setTitle:SSKJLanguage(@"姓名") placeholder:SSKJLanguage(@"请输入您的姓名") secureTextEntry:NO];
    }
    return _nameView;
}


-(SSKJ_TextFieldView *)idView
{
    if (!_idView)
    {
        _idView = [[SSKJ_TextFieldView alloc]init];
        [_idView setFrame:CGRectMake(0, self.nameView.bottom+ScaleW(20), ScreenWidth, self.nameView.height)];
        [_idView setTitle:SSKJLanguage(@"证件号码") placeholder:SSKJLanguage(@"请输入您的证件号码") secureTextEntry:NO];
    }
    return _idView;
}


-(IdverificationControl *)frontControl
{
    if (!_frontControl)
    {
        _frontControl = [[IdverificationControl alloc]initWithFrame:CGRectMake(ScaleW(15),self.idView.bottom+ScaleW(30), ScreenWidth-ScaleW(30), ScaleW(230))];
        [_frontControl setImageName:@"idfront" title:SSKJLanguage(@"请上传身份证正面") tiptitle:SSKJLanguage(@"身份证正面确保无水印无污渍，身份信息清晰，非文字反向照片，请勿进行PS处理")];
        [_frontControl addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [_frontControl setTag:1];
    }
    return _frontControl;
}



-(IdverificationControl *)backControl
{
    if (!_backControl)
    {
        _backControl = [[IdverificationControl alloc]initWithFrame:CGRectMake(self.frontControl.left, self.frontControl.bottom, self.frontControl.width, self.frontControl.height)];
        [_backControl setImageName:@"idback" title:SSKJLanguage(@"请上传身份证背面") tiptitle:SSKJLanguage(@"身份证背面确保无水印无污渍，身份信息清晰，非文字反向照片，请勿进行PS处理")];
        [_backControl addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [_backControl setTag:2];
    }
    return _backControl;
}



-(UIButton *)submitButton
{
    if (nil == _submitButton)
    {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.backControl.bottom + ScaleW(50), ScreenWidth - ScaleW(30), ScaleW(45))];
        _submitButton.layer.cornerRadius = 4.0f;
        _submitButton.backgroundColor = kBlueColor;
        [_submitButton setTitle:SSKJLocalized(@"提交", nil)  forState:UIControlStateNormal];
        [_submitButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

-(void)submitEvent
{
    
    NSString *name = self.nameView.valueString;
    NSString *idNumber = self.idView.valueString;
    if (name.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入您的姓名", nil)];
        return;
    }
    
    if (idNumber.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入您的证件号码", nil)];
        return;
    }
    
    if (!self.frontControl.image)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请上传身份证正面", nil)];
        return;
    }
    
    if (!self.backControl.image)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请上传身份证背面", nil)];
        return;
    }
    
    
    [self requestPrimaryCertificate:name withIDentity:idNumber];
}


#pragma mark - NetWork Method 网络请求
- (void)requestPrimaryCertificate:(NSString*)name withIDentity:(NSString*)identity
{
    
    [MBHUD showHUDAddedTo:self.view];
    
    NSDictionary *params = @{
                            @"name":name,
                             @"card_id":identity,
                            @"front_img":UIImageJPEGRepresentation(self.frontControl.image, 0.5),
                            @"back_img":UIImageJPEGRepresentation(self.backControl.image, 0.5),
                            };
    
    NSDictionary *picDic = @{
        @"front_img":UIImageJPEGRepresentation(self.frontControl.image, 0.5),
        @"back_img":UIImageJPEGRepresentation(self.backControl.image, 0.5),

    };
    
    WS(weakSelf);
    [[WLHttpManager shareManager] upLoadImageByUrl:BI_BaseAuth_URL Params:params imageDic:picDic CallBack:^(id responseObject) {
         [MBHUD hideHUDForView:self.view];
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];

           if (netWorkModel.status.integerValue == SUCCESSED )
            {
                [MBHUD showSuccess:netWorkModel.msg];
                [SSKJ_User_Tool sharedUserTool].userInfoModel.authentication = @"2";
                if (weakSelf.isReCertificate) {
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }
            else
            {
                [MBProgressHUD showError:netWorkModel.msg];
            }

    } Failure:^(NSError *error) {
        [MBHUD hideHUDForView:self.view];

    }];
}


#pragma mark - 用户操作

-(void)selectPhoto:(UIControl*)control
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    
    [self setPhotoType:(PhotoType)control.tag];
    
    
    
    [SSKJ_Default_ActionsheetView showWithItems:@[SSKJLocalized(@"相机",nil),SSKJLocalized(@"相册",nil)] title:@"" selectedIndexBlock:^(NSInteger selectIndex)
     {
         switch (selectIndex)
         {
             case 0:
             {
                 Mine_ImagePicker_ViewController *image = [[Mine_ImagePicker_ViewController alloc] initWithType:1 witDelegate:self];
                 image.modalPresentationStyle = 0;
                 [self presentViewController:image animated:YES completion:^{}];
             }
                 break;
             case 1:
             {
                  Mine_ImagePicker_ViewController *image = [[Mine_ImagePicker_ViewController alloc] initWithType:2 witDelegate:self];
                 image.modalPresentationStyle = 0;
                 [self presentViewController:image animated:YES completion:^{}];
             }
                 break;
         }
         
     } cancleBlock:^{}];
    
    
}



#pragma mark - Deletage Method
#pragma mark Mine_ImagePicker_ViewControllerDelegate
-(void)didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)editingInfo
{
    
    
    switch (self.photoType)
    {
        case PhotoTypeFront:
        {
            [self.frontControl setImage:image];
        }
            break;
        case PhotoTypeBack:
        {
            [self.backControl setImage:image];
        }
            break;
    }
}




@end
