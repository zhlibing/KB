//
//  AssetsTableViewCell.m
//  SSKJ
//
//  Created by 姚立志 on 2020/8/9.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "AssetsTableViewCell.h"

@interface AssetsTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *coinLabel; //!< 币种
@property (nonatomic, strong) UILabel *availableLabel;
@property (nonatomic, strong) UILabel *freezebleLabel;
@property (nonatomic, strong) UILabel *availableNumLabel;
@property (nonatomic, strong) UILabel *freezebleNumLabel;
@property (nonatomic, strong) UIImageView *accessoryImageView;
@property (nonatomic, strong) UIView *lineView;




@end



@implementation AssetsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.coinLabel];
        [self.contentView addSubview:self.availableLabel];
        [self.contentView addSubview:self.availableNumLabel];
        [self.contentView addSubview:self.freezebleLabel];
        [self.contentView addSubview:self.freezebleNumLabel];
        [self.contentView addSubview:self.accessoryImageView];
        [self.contentView addSubview:self.lineView];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(@(17));
            make.width.height.equalTo(@(30));
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        
        [self.availableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.contentView.mas_centerX).offset(15);
            make.height.equalTo(@(20));
            make.bottom.equalTo(self.contentView.mas_centerY);
        }];
        
        [self.availableNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.height.equalTo(self.availableLabel);
            make.top.equalTo(self.contentView.mas_centerY);
        }];
        
        
        [self.freezebleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                 
            make.right.equalTo(self.contentView.mas_right).offset(-40);
            make.bottom.height.equalTo(self.availableLabel);
            
        }];
      
        [self.freezebleNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         
            make.right.height.equalTo(self.freezebleLabel);
            make.top.equalTo(self.availableNumLabel);

        }];
        
        
        [self.accessoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.iconImageView.mas_left);
            make.right.equalTo(self.accessoryImageView.mas_right);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.equalTo(@(0.5));
            
            
        }];
        
        
            
    }
    return self;
}



- (void)setModel:(Lion_Assets_new_Model *)model
{
    [self.availableNumLabel setText:model.balance];
    [self.freezebleNumLabel setText:model.frost];
}






#pragma mark - Getter / Setter
-(UIImageView *)iconImageView
{
    if (!_iconImageView)
    {
        _iconImageView = [[UIImageView alloc]init];
        [_iconImageView setCornerRadius:15.0];
        [_iconImageView setImage:[UIImage imageNamed:@"USDT"]];
    }
    return _iconImageView;
}

-(UILabel *)coinLabel
{
    if (!_coinLabel)
    {
        _coinLabel = [[UILabel alloc]init];
        [_coinLabel setTextColor:kTitleColor];
        [_coinLabel setFont:systemFont(16)];
        [_coinLabel setText:@"USDT"];
    }
    return _coinLabel;
}

-(UILabel *)availableLabel
{
    if (!_availableLabel)
    {
        _availableLabel = [[UILabel alloc]init];
        [_availableLabel setTextColor:kSubTitleColor];
        [_availableLabel setFont:systemFont(12)];
        [_availableLabel setText:SSKJLanguage(@"可用")];
    }
    return _availableLabel;
}

-(UILabel *)availableNumLabel
{
    if (!_availableNumLabel)
    {
        _availableNumLabel = [[UILabel alloc]init];
        [_availableNumLabel setTextColor:kTitleColor];
        [_availableNumLabel setFont:systemFont(13)];
        [_availableNumLabel setText:@"0.00"];
    }
    return _availableNumLabel;
}



-(UILabel *)freezebleLabel
{
    if (!_freezebleLabel)
    {
        _freezebleLabel = [[UILabel alloc]init];
        [_freezebleLabel setTextColor:kSubTitleColor];
        [_freezebleLabel setFont:systemFont(12)];
        [_freezebleLabel setText:SSKJLanguage(@"冻结")];
    }
    return _freezebleLabel;
}

-(UILabel *)freezebleNumLabel
{
    if (!_freezebleNumLabel)
    {
        _freezebleNumLabel = [[UILabel alloc]init];
        [_freezebleNumLabel setTextColor:kTitleColor];
        [_freezebleNumLabel setFont:systemFont(13)];
        [_freezebleNumLabel setText:@"0.00"];
    }
    return _freezebleNumLabel;
}


-(UIImageView *)accessoryImageView
{
    if (!_accessoryImageView)
    {
        _accessoryImageView = [[UIImageView alloc]init];
        [_accessoryImageView setImage:[UIImage imageNamed:@"accessory"]];
    }
    return _accessoryImageView;
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
