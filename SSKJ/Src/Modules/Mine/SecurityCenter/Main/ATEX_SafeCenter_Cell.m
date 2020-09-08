//
//  ATEX_SafeCenter_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/14.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "ATEX_SafeCenter_Cell.h"

@implementation ATEX_SafeCenter_Cell





- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView setBackgroundColor:kBgColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.cellTitleLabel];
        [self.contentView addSubview:self.statusLabel];
        [self.contentView addSubview:self.accoryImageView];
        [self.contentView addSubview:self.markImageView];
        [self.contentView addSubview:self.lineView];
        
        [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView.mas_left).offset(ScaleW(15));
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [self.accoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.contentView.mas_right).offset(-ScaleW(15));
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        
        [self.markImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.statusLabel.mas_left).offset(-ScaleW(10));
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.accoryImageView.mas_left).offset(-ScaleW(10));
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cellTitleLabel.mas_left);
            make.right.equalTo(self.accoryImageView.mas_right);
            make.height.equalTo(@(ScaleW(0.5)));
            make.bottom.equalTo(self.contentView.mas_bottom);
            
        }];
    }
    return self;
}



#pragma mark - Getter / Setter
- (UILabel *)cellTitleLabel
{
    if (!_cellTitleLabel)
    {
        _cellTitleLabel = [[UILabel alloc]init];
        [_cellTitleLabel setFont:systemFont(ScaleW(14))];
        [_cellTitleLabel setTextColor:kTitleColor];
    }
    return _cellTitleLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel)
    {
        _statusLabel = [[UILabel alloc]init];
        [_statusLabel setFont:systemFont(ScaleW(14))];
        [_statusLabel setTextColor:kSubTitleColor];
    }
    return _statusLabel;
}




-(UIImageView *)accoryImageView
{
    if (!_accoryImageView)
    {
        _accoryImageView = [[UIImageView alloc]init];
        [_accoryImageView setImage:[UIImage imageNamed:@"Mime_levelmore"]];
    }
    return _accoryImageView;
}

-(UIImageView *)markImageView
{
    if (!_markImageView)
    {
        _markImageView = [[UIImageView alloc]init];
        [_markImageView setImage:[UIImage imageNamed:@"Mine_exclamatory"]];
    }
    return _markImageView;
}




- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:kSubTitleColor];
    }
    return _lineView;
}



@end
