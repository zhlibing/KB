//
//  SSKJ_TextFieldView.m
//  SSKJ
//
//  Created by zpz on 2019/6/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_TextFieldView.h"
@interface SSKJ_TextFieldView()

@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;


@end

@implementation SSKJ_TextFieldView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self unit:YES];
    }
    return self;
}


- (instancetype)initWithType:(NSInteger)type
{
    self = [super init];
    if (self)
    {
        [self unitTypes:type];
    }
    return self;
}





-(void)unit:(BOOL)unit
{
    if (unit)
    {
        [self setBackgroundColor:kBgColor];
        [self addSubview:self.titlelabel];
        [self addSubview:self.backView];
        [self.backView addSubview:self.field];
        [self.backView addSubview:self.rightBtn];
        
        [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left).offset(ScaleW(15));
            make.right.equalTo(self.mas_right).offset(-ScaleW(15));
            make.height.equalTo(@(20));
        }];
        
        
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.equalTo(self.titlelabel.mas_bottom).offset(ScaleW(6));
            make.left.right.equalTo(self.titlelabel);
            make.height.equalTo(@(44));
        }];
        
        
        
        
        [self.field mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(self.backView.mas_left).offset(ScaleW(10));
            make.centerY.equalTo(self.backView.mas_centerY);
            make.right.equalTo(self.backView.mas_right).offset(-ScaleW(10));
        }];
        
        
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.right.equalTo(self.backView.mas_right).offset(-ScaleW(9));
            make.centerY.equalTo(self.backView.mas_centerY);
            make.height.width.equalTo(@(ScaleW(44)));
        }];
    }
}


-(void)unitType:(BOOL)unit
{
    if (unit)
    {
        [self setBackgroundColor:kBgColor];
        [self addSubview:self.backView];
        [self.backView addSubview:self.leftBtn];
        [self.backView addSubview:self.field];
        [self.backView addSubview:self.rightBtn];
        
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(ScaleW(15));
            make.right.equalTo(self.mas_right).offset(-ScaleW(15));
            make.height.equalTo(self);
        }];
        
        
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(self.backView.mas_left).offset(ScaleW(15));
            make.centerY.equalTo(self.backView.mas_centerY);
            make.height.width.equalTo(@(ScaleW(22)));
        }];
        
        
        [self.field mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(self.leftBtn.mas_right).offset(ScaleW(9));
            make.centerY.equalTo(self.backView.mas_centerY);
            make.right.equalTo(self.backView.mas_right).offset(-ScaleW(10));
        }];

        
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.right.equalTo(self.backView.mas_right).offset(-ScaleW(9));
            make.centerY.equalTo(self.backView.mas_centerY);
            make.height.width.equalTo(@(ScaleW(44)));
        }];
    }
}


-(void)unitTypes:(NSInteger)type
{
    switch (type)
    {
        case 1:
        {
            [self unit:YES];
        }
            break;
        case 2:
        {
            [self unitType:YES];
        }
            break;
    }
}



- (void)setTitle:(NSString *)title placeholder:(NSString *)placeholder secureTextEntry:(BOOL)secureTextEntry
{
    [self.titlelabel setText:title];
    [self.field setPlaceholder:placeholder];
    [self.field setSecureTextEntry:secureTextEntry];
    [self.rightBtn setHidden:(!secureTextEntry)];
}


- (void)setImageName:(NSString*)name placeholder:(NSString *)placeholder secureTextEntry:(BOOL)secureTextEntry
{
    [self.leftBtn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [self.field setPlaceholder:placeholder];
    [self.field setSecureTextEntry:secureTextEntry];
    [self.rightBtn setHidden:(!secureTextEntry)];
}


- (void)setPlaceholder:(NSString *)placeholder secureTextEntry:(BOOL)secureTextEntry
{
    [self.field setPlaceholder:placeholder];
    [self.field setSecureTextEntry:secureTextEntry];
    [self.rightBtn setHidden:(!secureTextEntry)];
}





#pragma mark - Getter / Setter


-(UIView *)backView
{
    if (!_backView)
    {
        _backView = [[UIView alloc]init];
        [_backView setBackgroundColor:kSubBgColor];
    }
    return _backView;
}



-(UILabel *)titlelabel
{
    if (!_titlelabel)
    {
        _titlelabel = [[UILabel alloc]init];
        [_titlelabel setTextColor:kTitleColor];
        [_titlelabel setFont:[UIFont systemFontOfSize:ScaleW(14)]];
    }
    return _titlelabel;
}



- (UITextField *)field
{
    if (_field == nil)
    {
        _field = [UITextField new];
        _field.font = kFont(15);
        _field.textColor = kTitleColor;
        [_field setPlaceHolderColor:kSubTitleColor];
    }
    return _field;
}

- (UIButton *)leftBtn
{
    if (_leftBtn == nil)
    {
        _leftBtn = [[UIButton alloc]init];
    }
    return _leftBtn;
}


- (UIButton *)rightBtn
{
    if (_rightBtn == nil)
    {
        _rightBtn = [WLTools allocButton:nil textColor:nil nom_bg:nil hei_bg:nil frame:CGRectZero];
        [_rightBtn setImage:[UIImage imageNamed:@"login_hide"] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"login_show"] forState:UIControlStateSelected];
        [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (void)rightBtnAction
{
    self.rightBtn.selected = !self.rightBtn.isSelected;
    self.field.secureTextEntry = !self.rightBtn.isSelected;
}




- (NSString *)valueString
{
    return self.field.text;
}






@end
