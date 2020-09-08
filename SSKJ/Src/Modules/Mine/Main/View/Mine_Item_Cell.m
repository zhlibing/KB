//
//  MineTableCell.m
//  SSKJ
//
//  Created by apple on 2019/8/16.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Mine_Item_Cell.h"

@interface Mine_Item_Cell ()

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UIImageView *accessories;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIView *lineView;

@end



@implementation Mine_Item_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.descriptionLabel];
        [self.contentView addSubview:self.accessories];
        [self.contentView addSubview:self.lineView];
        
        
        [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make)
         {
            
            make.left.equalTo(@(ScaleW(20)));
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.left.equalTo(self.iconImg.mas_right).offset(ScaleW(10));
            make.centerY.equalTo(self.contentView.mas_centerY);
            
        }];
        
        [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.right.equalTo(self.contentView.mas_right).offset(-ScaleW(50));
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [self.accessories mas_makeConstraints:^(MASConstraintMaker *make)
         {
           
            make.right.equalTo(self.contentView.mas_right).offset(-ScaleW(20));
            make.centerY.equalTo(self.contentView.mas_centerY);
            
        }];
        
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.left.right.bottom.equalTo(@(0));
            make.height.equalTo(@(0.5));
        }];
        
        
        
        
        
        
        
        
    }
    return self;
    
}

#pragma mark - Private Method
-(void)setIconName:(NSString*)icon title:(NSString*)title desc:(NSString*)desc
{
    [self.iconImg setImage:[UIImage imageNamed:icon]];
    [self.titleLabel setText:title];
    [self.descriptionLabel setText:desc];
}



#pragma mark - Getter / Setter
-(UIImageView *)iconImg
{
    if (!_iconImg)
    {
        _iconImg = [[UIImageView alloc]init];
    }
    return _iconImg;
}

-(UIImageView *)accessories
{
    if (!_accessories)
    {
        _accessories = [[UIImageView alloc]init];
        [_accessories setImage:[UIImage imageNamed:@"root_next"]];
    }
    return _accessories;
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


-(UILabel *)descriptionLabel
{
    if (!_descriptionLabel)
    {
        _descriptionLabel = [[UILabel alloc]init];
        [_descriptionLabel setTextColor:kSubTitleColor];
        [_descriptionLabel setFont:systemFont(ScaleW(12))];
    }
    return _descriptionLabel;
}


-(UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:kLineColor];
    }
    return _lineView;
}


@end
