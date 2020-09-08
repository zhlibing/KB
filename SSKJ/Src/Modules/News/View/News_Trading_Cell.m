//
//  GoCoin_Trading_Cell.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/3/29.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "News_Trading_Cell.h"

@interface News_Trading_Cell()

@property (nonatomic, strong) UIView *cycleView;

@property (nonatomic,strong) UILabel * contentLabel;

@property (nonatomic,strong) UIView * lineview;

@property (nonatomic,strong) UIImageView * imageV;


@end

@implementation News_Trading_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kBgColor;
        [self contentLabel];
        [self lineview];
    }
    
    return self;
}


- (UILabel *)contentLabel
{
    if (_contentLabel == nil)
    {
        
        _contentLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kTitleColor font:systemFont(ScaleW(14))];
        _contentLabel.numberOfLines = 2;
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(ScaleW(15));
            make.right.equalTo(self.contentView.mas_right).offset(-ScaleW(15));
        }];
    }
    return _contentLabel;
}



- (UIView *)lineview
{
    if (_lineview == nil) {
        
        
        _lineview = [FactoryUI createViewWithFrame:CGRectZero Color:kLineColor];
        
        [self.contentView addSubview:_lineview];
        
        [_lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.right.equalTo(@0);
            make.left.right.equalTo(self.contentLabel);
            make.height.equalTo(@(ScaleW(0.5)));
            
            
        }];
    }
    return _lineview;
}

- (void)initDataWithModel:(Home_NoticeIndex_Model *)Model
{
    
    self.contentLabel.text = Model.title;
        
}

@end
