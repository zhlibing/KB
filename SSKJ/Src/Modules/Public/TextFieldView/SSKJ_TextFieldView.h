//
//  SSKJ_TextFieldView.h
//  SSKJ
//
//  Created by zpz on 2019/6/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_TextFieldView : UIView


@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITextField *field;
@property(nonatomic, copy) NSString *valueString;

- (instancetype)initWithType:(NSInteger)type;


- (void)setTitle:(NSString *)title placeholder:(NSString *)placeholder secureTextEntry:(BOOL)secureTextEntry;
- (void)setImageName:(NSString*)name placeholder:(NSString *)placeholder secureTextEntry:(BOOL)secureTextEntry;

- (void)setPlaceholder:(NSString *)placeholder secureTextEntry:(BOOL)secureTextEntry;




@end

NS_ASSUME_NONNULL_END
