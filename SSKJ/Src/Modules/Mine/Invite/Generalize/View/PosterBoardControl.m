//
//  PosterBoardControl.m
//  SSKJ
//
//  Created by 姚立志 on 2020/8/10.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "PosterBoardControl.h"

@interface PosterBoardControl ()

@property (nonatomic, strong) UIView *boardView;
@property (nonatomic, strong) UILabel *titLabel;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *leftCodeImageView;

@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *rightCodeImageView;
@property (nonatomic, strong) UILabel *rightCodeLabel;
@property (nonatomic, strong) UILabel *rightTipLabel;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIImageView *leftselectImageView;
@property (nonatomic, strong) UIImageView *rightselectImageView;

@property (nonatomic, assign) NSInteger type;
 




@end



@implementation PosterBoardControl

+(void)showType:(NSInteger)type withCode:(NSString*)code withCodeUrl:(NSString*)codeUrl
{
    PosterBoardControl *poster = [[PosterBoardControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [poster setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    
    
    [poster.leftCodeImageView sd_setImageWithURL:[NSURL URLWithString:codeUrl]];
    [poster.rightCodeImageView sd_setImageWithURL:[NSURL URLWithString:codeUrl]];
    [poster.rightCodeLabel setText:code];
    
    
    [poster  setType:type];
    [poster show];
}


-(void)setType:(NSInteger)type
{
    [self.leftselectImageView setHidden:YES];
    [self.rightselectImageView setHidden:YES];
    _type = type;
    switch (type)
    {
        case 1:
        {
            [self.leftselectImageView setHidden:NO];
        }
            break;
        case 2:
        {
            [self.rightselectImageView setHidden:NO];
        }
            break;
    }
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        [self addSubview:self.boardView];
        [self.boardView addSubview:self.titLabel];
        [self.boardView addSubview:self.leftImageView];
        [self.boardView addSubview:self.rightImageView];
        [self.boardView addSubview:self.tipLabel];
        [self.leftImageView addSubview:self.leftCodeImageView];
        [self.leftImageView addSubview:self.leftselectImageView];
        
        [self.rightImageView addSubview:self.rightCodeImageView];
        [self.rightImageView addSubview:self.rightselectImageView];
        [self.rightImageView addSubview:self.rightCodeLabel];
        [self.rightImageView addSubview:self.rightTipLabel];
        
        [self addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.titLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.boardView.mas_top).offset(24);
            make.centerX.equalTo(self.boardView.mas_centerX);
        }];
        
        
        [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.boardView.mas_left).offset(10);
            make.top.equalTo(self.titLabel.mas_bottom).offset(20);
            make.right.equalTo(self.boardView.mas_centerX).offset(-7.5);
            make.width.equalTo(@(((ScreenWidth-35)/2.0)));
            make.height.equalTo(@(((ScreenWidth-35)/2.0)*1.77));
        }];
        
        [self.leftCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(self.leftImageView.mas_bottom).offset(-35);
            make.centerX.equalTo(self.leftImageView.mas_centerX);
            make.width.height.equalTo(@(50));
            
            
        }];
        
        [self.leftselectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.top.right.equalTo(self.leftImageView);
            
        }];
        
        
        
        
        
        [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.boardView.mas_centerX).offset(7.5);
            make.top.equalTo(self.titLabel.mas_bottom).offset(20);
            make.right.equalTo(self.boardView.mas_right).offset(-10);
            make.width.height.equalTo(self.leftImageView);
        }];
        
        [self.rightselectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.top.right.equalTo(self.rightImageView);
            
        }];
        
        
        [self.rightCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(self.rightImageView.mas_bottom).offset(-8);
            make.right.equalTo(self.rightImageView.mas_right).offset(-5);
            make.width.height.equalTo(@(50));
            
            
        }];
        
        [self.rightCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(self.rightImageView.mas_bottom).offset(-30);
            make.left.equalTo(self.rightImageView.mas_left).offset(5);
            
        }];
        
        [self.rightTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.rightCodeLabel.mas_bottom).offset(10);
            make.left.equalTo(self.rightCodeLabel.mas_left);
            
        }];
        
        
        
        
        
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.leftImageView.mas_bottom).offset(25);
            make.centerX.equalTo(self.boardView.mas_centerX);
            
        }];
        
        
        
        
        
        

    }
    return self;
}








-(void)show
{
    
    [AppWindow addSubview:self];
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.boardView setY:(ScreenHeight - 490)];
    }];
}

-(void)hide
{
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        
        [weakSelf.boardView setY:ScreenHeight];
        
    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
    }];
}


-(void)leftTap:(UIGestureRecognizer*)object
{
    [self setType:1];
}


-(void)rightTap:(UIGestureRecognizer*)object
{
    [self setType:2];
}

-(void)leftLongPress:(UIGestureRecognizer*)object
{
    [self setType:1];
    
    [self saveImage:object];
}


-(void)rightLongPress:(UIGestureRecognizer*)object
{
    [self setType:2];
    
    [self saveImage:object];
}






-(void)saveImage:(UIGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        WS(weakSelf);
        [SSKJ_Default_AlertView showWithTitle:SSKJLocalized(@"保存二维码", nil)  message:SSKJLocalized(@"保存二维码到相册", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"保存", nil) confirmBlock:^{
            
            
            
            UIImage *img = [UIView captureWithView:weakSelf.leftImageView];
            switch (weakSelf.type)
            {
                case 1:
                {
                    [weakSelf.leftImageView setCornerRadius:0];
                    [weakSelf.leftselectImageView setHidden:YES];
                    img = [UIView captureWithView:weakSelf.leftImageView];
                }
                    break;
                case 2:
                {
                    [weakSelf.rightImageView setCornerRadius:0];
                    [weakSelf.rightselectImageView setHidden:YES];
                    img = [UIView captureWithView:weakSelf.rightImageView];
                }
                    break;;
            }
            
            UIImageWriteToSavedPhotosAlbum(img, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:),nil);
        }];
    }
}


// 需要实现下面的方法,或者传入三个参数即可
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    [self hide];
    if (error)
    {
        [MBProgressHUD showError:SSKJLocalized(@"保存失败", nil)];
    }
    else
    {
        [MBProgressHUD showError:SSKJLocalized(@"保存成功", nil)];
    }
}




#pragma mark - Getter / Setter
-(UIView *)boardView
{
    if (!_boardView)
    {
        _boardView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 490)];
        [_boardView setBackgroundColor:kBgColor];
    }
    return _boardView;
}

-(UILabel *)titLabel
{
    if (!_titLabel)
    {
        _titLabel = [[UILabel alloc]init];
        [_titLabel setFont:systemFont(ScaleW(16))];
        [_titLabel setTextColor:kTitleColor];
        [_titLabel setText:SSKJLanguage(@"选择海报")];
    }
    return _titLabel;
}


-(UILabel *)rightTipLabel
{
    if (!_rightTipLabel)
    {
        _rightTipLabel = [[UILabel alloc]init];
        [_rightTipLabel setFont:systemFont(ScaleW(8))];
        [_rightTipLabel setTextColor:kTitleColor];
        [_rightTipLabel setText:SSKJLanguage(@"邀请你加入，长按识别二维码")];
    }
    return _rightTipLabel;
}

-(UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc]init];
        [_tipLabel setFont:systemFont(ScaleW(14))];
        [_tipLabel setTextColor:kTitleColor];
        [_tipLabel setText:SSKJLanguage(@"选择推广海报长按保存到本地")];
    }
    return _tipLabel;
}


-(UIImageView *)leftImageView
{
    if (!_leftImageView)
    {
        _leftImageView = [[UIImageView alloc]init];
        [_leftImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_leftImageView setImage:[UIImage imageNamed:@"posterleft"]];
        [_leftImageView setCornerRadius:ScaleW(10)];
        [_leftImageView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftTap:)];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(leftLongPress:)];
        
        [_leftImageView addGestureRecognizer:tap];
        [_leftImageView addGestureRecognizer:longPress];
    }
    return _leftImageView;
}

-(UIImageView *)leftCodeImageView
{
    if (!_leftCodeImageView)
    {
        _leftCodeImageView = [[UIImageView alloc]init];
        [_leftCodeImageView setBackgroundColor:[UIColor orangeColor]];
    }
    return _leftCodeImageView;
}


-(UIImageView *)rightImageView
{
    if (!_rightImageView)
    {
        _rightImageView = [[UIImageView alloc]init];
        [_rightImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_rightImageView setImage:[UIImage imageNamed:@"posterright"]];
        [_rightImageView setCornerRadius:ScaleW(10)];
        
        [_rightImageView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightTap:)];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(rightLongPress:)];
        
        [_rightImageView addGestureRecognizer:tap];
        [_rightImageView addGestureRecognizer:longPress];
    }
    return _rightImageView;
}

-(UIImageView *)rightCodeImageView
{
    if (!_rightCodeImageView)
    {
        _rightCodeImageView = [[UIImageView alloc]init];
        [_rightCodeImageView setBackgroundColor:[UIColor redColor]];
    }
    return _rightCodeImageView;
}


-(UILabel *)rightCodeLabel
{
    if (!_rightCodeLabel)
    {
        _rightCodeLabel = [[UILabel alloc]init];
        [_rightCodeLabel setFont:systemBoldFont(ScaleW(10))];
        [_rightCodeLabel setTextColor:kTitleColor];
    }
    return _rightCodeLabel;
}


-(UIImageView *)leftselectImageView
{
    if (!_leftselectImageView)
    {
        _leftselectImageView = [[UIImageView alloc]init];
        [_leftselectImageView setImage:[UIImage imageNamed:@"Poster"]];
    }
    return _leftselectImageView;
}

-(UIImageView *)rightselectImageView
{
    if (!_rightselectImageView)
    {
        _rightselectImageView = [[UIImageView alloc]init];
        [_rightselectImageView setImage:[UIImage imageNamed:@"Poster"]];
    }
    return _rightselectImageView;
}






@end
