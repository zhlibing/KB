//
//  HomeHeaderItemControl.m
//  SSKJ
//
//  Created by 姚立志 on 2020/8/8.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "HomeHeaderItemControl.h"


@interface HomeHeaderItemControl ()

@property (nonatomic, strong)  UILabel *titleLabel; //!< 主标题
@property (nonatomic, strong)  UILabel *descLabel; //!< 副标题
@property (nonatomic, strong)  UIImageView *imageView; //!< 背景颜色



@end

@implementation HomeHeaderItemControl


- (instancetype)initWithType:(NSInteger)type
{
    self = [super init];
    if (self)
    {
        switch (type)
        {
            case 1:
            {
                [self addSubview:self.imageView];
                [self addSubview:self.titleLabel];
                [self addSubview:self.descLabel];
                [self.titleLabel setTextColor:kTitleColor];
            
                
                
                [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
                    make.bottom.equalTo(self.mas_centerY);
                    make.left.equalTo(self.mas_left).offset(ScaleW(15));
                }];
                
                
                [self.descLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(self.titleLabel.mas_bottom).offset(ScaleW(5));
                    make.left.equalTo(self.titleLabel.mas_left);
                }];
            }
                break;
            case 2:
            {
                [self addSubview:self.imageView];
                [self addSubview:self.titleLabel];
                [self.titleLabel setTextColor:kWhiteColor];
                
                [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                        make.bottom.equalTo(self.mas_centerY);
                        make.left.equalTo(self.mas_left).offset(ScaleW(15));
                    }];
                
            }
                break;
        }
        
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            
        }];
        
    }
    return self;
}

-(void)setTitle:(NSString*)title desc:(NSString*)desc imageName:(NSString*)name
{
    [self.titleLabel setText:SSKJLanguage(title)];
    [self.descLabel setText:SSKJLanguage(desc)];
    [self.imageView setImage:[UIImage imageNamed:name]];
}



-(void)setTitle:(NSString*)title imageName:(NSString*)name
{
    [self.titleLabel setText:SSKJLanguage(title)];
    [self.imageView setImage:[UIImage imageNamed:name]];
}




#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:systemBoldFont(ScaleW(17))];
    }
    return _titleLabel;
}


-(UILabel *)descLabel
{
    if (!_descLabel)
    {
        _descLabel = [[UILabel alloc]init];
        [_descLabel setFont:systemBoldFont(ScaleW(12))];
        [_descLabel setTextColor:UIColorFromRGB(0xBBBBBB)];
    }
    return _descLabel;
}

-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView.layer setMasksToBounds:YES];
    }
    return _imageView;
}




@end
