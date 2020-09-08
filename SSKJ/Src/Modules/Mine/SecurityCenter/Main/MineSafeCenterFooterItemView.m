//
//  MineSafeCenterFooterItemView.m
//  SSKJ
//
//  Created by SSKJ on 2020/2/21.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "MineSafeCenterFooterItemView.h"

@implementation MineSafeCenterFooterItemView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.cellTitleLabel];
        [self addSubview:self.statusLabel];
        [self addSubview:self.accoryImageView];
        [self addSubview:self.lineView];
        
        [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.mas_left).offset(ScaleW(15));
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [self.accoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.mas_right).offset(-ScaleW(15));
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.accoryImageView.mas_left).offset(-ScaleW(10));
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cellTitleLabel.mas_left);
            make.right.equalTo(self.accoryImageView.mas_right);
            make.height.equalTo(@(ScaleW(0.5)));
            make.bottom.equalTo(self.mas_bottom);
            
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
