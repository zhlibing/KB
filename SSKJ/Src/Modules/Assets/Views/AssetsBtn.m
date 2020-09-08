//
//  AssetsBtn.m
//  SSKJ
//
//  Created by 姚立志 on 2020/8/9.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "AssetsBtn.h"

@interface AssetsBtn ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;




@end



@implementation AssetsBtn

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.mas_top).offset(5);
            make.centerX.equalTo(self.mas_centerX);
            
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.imageView.mas_bottom).offset(9);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        
        
        
    }
    return self;
}



#pragma mark - Public Method
-(void)setTitle:(NSString*)title imageName:(NSString*)name
{
    [self.imageView setImage:[UIImage imageNamed:name]];
    [self.titleLabel setText:SSKJLanguage(title)];
}




#pragma mark - Getter / Setter
-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
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



@end
