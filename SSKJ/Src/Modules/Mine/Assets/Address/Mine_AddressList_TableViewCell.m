//
//  BFEXMoneyEdtingTableViewCell.m
//  ZYW_MIT
//
//  Created by 张本超 on 2018/7/17.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Mine_AddressList_TableViewCell.h"


@interface Mine_AddressList_TableViewCell()

@property (nonatomic, strong) UIView *lineView;
//描述
@property (nonatomic, strong) UILabel *descrptionLabel;
//地址
@property (nonatomic, strong) UILabel *addressLabel;
//删除
@property (nonatomic, strong) UIButton *deleBtn;
@end
@implementation Mine_AddressList_TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = kBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        

        [self.contentView addSubview:self.deleBtn];
        [self.contentView addSubview:self.descrptionLabel];
        [self.contentView addSubview:self.addressLabel];
        [self.contentView addSubview:self.lineView];
        
        
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView.mas_left).offset(ScaleW(15));
            make.bottom.equalTo(self.contentView.mas_centerY);
            make.height.equalTo(@(ScaleW(30)));
        }];
        
        [self.descrptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.addressLabel.mas_left);
            make.height.equalTo(@(ScaleW(20)));
        }];
        
        [self.deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.contentView.mas_right).offset(-ScaleW(15));
            make.centerY.equalTo(self.addressLabel.mas_centerY);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.bottom.right.equalTo(self.contentView);
            make.height.equalTo(@(ScaleW(0.5)));
            
        }];
        
        
    }
    return self;
}



- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:kLineColor];
    }
    return _lineView;
}


-(UIButton *)deleBtn
{
    if (!_deleBtn) {
        _deleBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_deleBtn setTitle:SSKJLanguage(@"删除") forState:UIControlStateNormal];
        [_deleBtn.titleLabel setFont:systemFont(ScaleW(14))];
        [_deleBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
        [_deleBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleBtn;
}

-(void)deleteAction
{
    if (self.deleBlock) {
        self.deleBlock();
    }
}
-(UILabel *)descrptionLabel
{
    if (!_descrptionLabel)
    {
        _descrptionLabel = [[UILabel alloc]init];
        [self.contentView label:_descrptionLabel font:ScaleW(15) textColor:kTitleColor text:@"-----"];
        
    }
    return _descrptionLabel;
}

-(UILabel *)addressLabel
{
    if (!_addressLabel)
    {
        _addressLabel = [[UILabel alloc]init];
        [self.contentView label:_addressLabel font:ScaleW(12) textColor:kSubTitleColor text:@"----"];
    }
    return _addressLabel;
}


-(void)setValueWithData:(ExtractAddress_IndexModel *)model
{
    self.descrptionLabel.text = model.notes;
    self.addressLabel.text = model.address;
}

@end
