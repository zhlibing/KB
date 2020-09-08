//
//  Lion_AssetsHeaderView.m
//  SSKJ
//
//  Created by mac on 2020/3/12.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "Lion_AssetsHeaderView.h"
#import "AssetsBtn.h"


@interface Lion_AssetsHeaderView ()
@property (nonatomic ,strong) UIImageView *bgImgView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *usdtLabel;
@property (nonatomic, strong) UILabel *cnyLabel;
@property (nonatomic, strong) UILabel *unitLabel;

@property (nonatomic ,strong) UIButton *eyeBtn;
@property (nonatomic ,strong) AssetsBtn *cbButton;
@property (nonatomic ,strong) AssetsBtn *tbButton;
@property (nonatomic, strong) UIView *bottomView;


 


@end




@implementation Lion_AssetsHeaderView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        [self addSubview:self.bgImgView];
        [self.bgImgView addSubview:self.tipLabel];
        [self.bgImgView addSubview:self.usdtLabel];
        [self.bgImgView addSubview:self.unitLabel];
        [self.bgImgView addSubview:self.cnyLabel];
        [self.bgImgView addSubview:self.eyeBtn];
        [self addSubview:self.cbButton];
        [self addSubview:self.tbButton];
        [self addSubview:self.bottomView];
        
        
        [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(0));
            make.left.equalTo(self.mas_left).offset(13);
            make.right.equalTo(self.mas_right).offset(-13);
            make.height.equalTo(@(150));
        }];
        
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.equalTo(self.bgImgView.mas_top).offset(22);
            make.left.equalTo(self.bgImgView.mas_left).offset(15);
            
        }];
        
        [self.usdtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(self.bgImgView.mas_centerY);
            make.left.equalTo(self.tipLabel);
        }];
        
        [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.usdtLabel.mas_right).offset(5);
            make.bottom.equalTo(self.usdtLabel.mas_bottom);
        }];
        
        
        [self.cnyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.tipLabel.mas_left);
            make.top.equalTo(self.usdtLabel.mas_bottom).offset(19);
        }];
        
        
        [self.eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.tipLabel.mas_top);
            make.right.equalTo(self.bgImgView.mas_right).offset(-15);
            
        }];
        
        
        [self.cbButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.bgImgView.mas_bottom).offset(10);
            make.left.equalTo(self.bgImgView.mas_left);
            make.right.equalTo(self.bgImgView.mas_centerX);
            make.height.equalTo(@(60));
        }];
        
        
        [self.tbButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.height.top.equalTo(self.cbButton);
            make.left.equalTo(self.cbButton.mas_right);
            make.right.equalTo(self.bgImgView.mas_right);
       }];
        
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(self.mas_bottom);
            make.left.right.equalTo(@(0));
            make.height.equalTo(@(10));
            
        }];
        
        
        
        
        
        
    }
    return self;
}


- (void)clearData
{
    self.usdtLabel.text = @"0";
    self.cnyLabel.text  = @"0";
    [self.model setBalance:@"0"];
    [self.model setTotal_rmb:@"0"];
    [self.model setFrost:@"0"];
    
}




- (void)setModel:(Lion_Assets_new_Model *)model
{
    _model = model;
    
    
    [self.usdtLabel setText:model.balance];
    [self.cnyLabel setText:[NSString stringWithFormat:@"≈%@CNY",model.total_rmb]];
}



#pragma mark - Public Method
-(void)eyeBtnAction:(UIButton*)sender
{
    switch (sender.tag)
    {
        case 1:
        {
            [sender setTag:2];
            [sender setImage:[UIImage imageNamed:@"eyehidden"] forState:UIControlStateNormal];
            
            [self.usdtLabel setText:@"******"];
            [self.unitLabel setText:@"***"];
            [self.cnyLabel setText:@"******"];
        }
            break;
        case 2:
        {
            [sender setTag:1];
            [sender setImage:[UIImage imageNamed:@"eyeshow"] forState:UIControlStateNormal];
            
            [self.usdtLabel setText:self.model.balance];
            [self.cnyLabel setText:[NSString stringWithFormat:@"≈%@CNY",self.model.total_rmb]];
            [self.unitLabel setText:@"USDT"];
        }
            break;
    }
}



-(void)btnAction:(UIControl*)sender
{
    if (self.actionBlock)
    {
        self.actionBlock(sender.tag);
    }
}




#pragma mark - Getter / Setter
-(UIImageView *)bgImgView
{
    if (!_bgImgView)
    {
        _bgImgView = [[UIImageView alloc]init];
        [_bgImgView setContentMode:UIViewContentModeScaleAspectFill];
        [_bgImgView setCornerRadius:ScaleW(5)];
        [_bgImgView setImage:[UIImage imageNamed:@"assetsbg"]];
        [_bgImgView setUserInteractionEnabled:YES];
    }
    return _bgImgView;
}
-(UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc]init];
        [_tipLabel setFont:systemFont(ScaleW(12))];
        [_tipLabel setTextColor:kWhiteColor];
        [_tipLabel setText:SSKJLanguage(@"账户资产")];
    }
    return _tipLabel;
}


-(UILabel *)usdtLabel
{
    if (!_usdtLabel)
    {
        _usdtLabel = [[UILabel alloc]init];
        [_usdtLabel setFont:systemBoldFont(ScaleW(30))];
        [_usdtLabel setTextColor:kWhiteColor];
        [_usdtLabel setText:@"0.00"];
    }
    return _usdtLabel;
}

-(UILabel *)cnyLabel
{
    if (!_cnyLabel)
    {
        _cnyLabel = [[UILabel alloc]init];
        [_cnyLabel setFont:systemFont(ScaleW(14))];
        [_cnyLabel setTextColor:kWhiteColor];
        [_cnyLabel setText:@"≈00.00CNY"];
    }
    return _cnyLabel;
}

-(UILabel *)unitLabel
{
    if (!_unitLabel)
    {
        _unitLabel = [[UILabel alloc]init];
        [_unitLabel setFont:systemFont(ScaleW(14))];
        [_unitLabel setTextColor:kWhiteColor];
        [_unitLabel setText:@"USDT"];
    }
    return _unitLabel;
}



- (UIButton *)eyeBtn
{
    if (!_eyeBtn)
    {
        _eyeBtn = [[UIButton alloc]init];
        [_eyeBtn setImage:[UIImage imageNamed:@"eyeshow"] forState:UIControlStateNormal];
        [_eyeBtn setTag:1];
        [_eyeBtn addTarget:self action:@selector(eyeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eyeBtn;
}


-(AssetsBtn *)cbButton
{
    if (!_cbButton)
    {
        _cbButton = [[AssetsBtn alloc]init];
        [_cbButton setTitle:@"充币" imageName:@"chongbi"];
        [_cbButton setTag:1];
        [_cbButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cbButton;
}


-(AssetsBtn *)tbButton
{
    if (!_tbButton)
    {
        _tbButton = [[AssetsBtn alloc]init];
        [_tbButton setTitle:@"提币" imageName:@"tibi"];
        [_tbButton setTag:2];
        [_tbButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tbButton;
}

-(UIView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[UIView alloc]init];
        [_bottomView setBackgroundColor:kLineColor];
    }
    return _bottomView;
}





@end
