//
//  MineHeaderView.h
//  SSKJ
//
//  Created by 姚立志 on 2020/8/7.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface MineHeaderView : UIView

@property (nonatomic, strong) UIButton *promoteBtn; //!< 推广按钮

@property (nonatomic,copy) void (^loginblock)(BOOL login);






-(void)setTitle:(NSString*)title uuid:(NSString*)uuid;


@end

NS_ASSUME_NONNULL_END
