//
//  Mine_informationTableViewCell.m
//  SSKJ
//
//  Created by 姚立志 on 2020/8/12.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "Mine_informationTableViewCell.h"

@interface Mine_informationTableViewCell ()

@property (nonatomic, strong) UIView *lineView;


@end

@implementation Mine_informationTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.descLabel];
        [self.contentView addSubview:self.lineView];
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView.mas_left).offset(ScaleW(15));
            make.centerY.equalTo(self.contentView.mas_centerY);
            
        }];
        
        
        
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.contentView.mas_right).offset(-ScaleW(15));
            make.centerY.equalTo(self.contentView.mas_centerY);
            
        }];
        
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.titleLabel);
            make.right.equalTo(self.descLabel);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.equalTo(@(ScaleW(0.5)));
        }];
        
        
        
        
    }
    return self;
}



#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:systemFont(ScaleW(16))];
        [_titleLabel setTextColor:kSubTitleColor];
    }
    return _titleLabel;
}


-(UILabel *)descLabel
{
    if (!_descLabel)
    {
        _descLabel = [[UILabel alloc]init];
        [_descLabel setFont:systemFont(ScaleW(16))];
        [_descLabel setTextColor:kSubTitleColor];
    }
    return _descLabel;
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
