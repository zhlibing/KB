//
//  Market_Notice_Cell.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/4/26.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "Home_Notice_Cell.h"

@interface Home_Notice_Cell()


@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIView *lineView;


@end








@implementation Home_Notice_Cell


#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self.contentView setBackgroundColor:kBgColor];
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
    

        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.lineView];
        
        
             
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left).offset(ScaleW(15));
            
            make.top.equalTo(self.contentView.mas_top).offset(ScaleW(5));
            make.height.equalTo(@(ScaleW(40)));
            make.right.equalTo(self.contentView.mas_right).offset(-ScaleW(15));
            
            
        }];
        
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.titleLabel);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-ScaleW(14));
        }];
        
        
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView.mas_left).offset(ScaleW(15));
            make.right.equalTo(self.contentView.mas_right).offset(-ScaleW(15));
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.equalTo(@(ScaleW(0.5)));
            
        }];
       
    }
    
    return self;
}


- (UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:systemFont(ScaleW(15))];
        [_titleLabel setTextColor:kTitleColor];
        [_titleLabel setNumberOfLines:0];
    }
    return _titleLabel;
}


- (UILabel *)dateLabel
{
    if (_dateLabel == nil)
    {
        _dateLabel = [[UILabel alloc]init];
        [_dateLabel setFont:systemFont(ScaleW(12))];
        [_dateLabel setTextColor:kSubTitleColor];

    }
    return _dateLabel;
}


- (void)setModel:(Home_NoticeIndex_Model *)model
{
    _model = model;
    [self.titleLabel setText:model.title];
    [self.dateLabel setText:model.created_at];
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
