//
//  IdverificationControl.m
//  SSKJ
//
//  Created by 姚立志 on 2020/8/7.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "IdverificationControl.h"


@interface IdverificationControl ()

@property (nonatomic, strong) UIImageView *imageView; //!< 身份证
@property (nonatomic, strong) UILabel *titleLabel; //!< 标题
@property (nonatomic, strong) UILabel *tipLabel;  //!< 提示









@end




@implementation IdverificationControl

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self unit:YES];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self unit:YES];
    }
    return self;
}



-(void)setImage:(UIImage*)image
{
    _image = image;
    [self.imageView setImage:image];
}



-(void)setImageName:(NSString *)imageName title:(NSString*)title tiptitle:(NSString*)tiptitle
{
    [self.imageView setImage:[UIImage imageNamed:imageName]];
    [self.titleLabel setText:title];
    [self.tipLabel setText:tiptitle];
    
}


-(void)unit:(BOOL)unit
{
    if (unit)
    {
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.tipLabel];
        
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.equalTo(@(0));
            make.left.right.equalTo(@(0));
            make.height.equalTo(@(ScaleW(110)));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.equalTo(self.imageView.mas_bottom).offset(ScaleW(15));
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(@(ScaleW(20)));
        }];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(ScaleW(23));
            make.left.right.equalTo(@(0));
            make.centerX.equalTo(self.mas_centerX);
            
        }];
    }
}





#pragma mark - Getter / Setter
-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _imageView;
}


-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextColor:kTitleColor];
        [_titleLabel setFont:systemFont(ScaleW(14))];
    }
    return _titleLabel;
}


-(UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc]init];
        [_tipLabel setTextColor:kSubTitleColor];
        [_tipLabel setFont:systemFont(ScaleW(12))];
        [_tipLabel setNumberOfLines:0];
    }
    return _tipLabel;
}

@end
