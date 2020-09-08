//
//  My_BindGoogle_AlertView.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MyGOOGLETYPE) {
    MyGOOGLETYPEADD,//绑定
    MyGOOGLETYPEDELETE,//关闭
    MyGOOGLETYPEOPEN,//开启
};

NS_ASSUME_NONNULL_BEGIN

@interface My_BindGoogle_AlertView : UIView

@property (nonatomic, copy) void (^submitBlock)(NSString *googleCode,NSString *smsCode,NSString *type);

@property (nonatomic, assign) MyGOOGLETYPE showWithType;
-(void)hide;
@end

NS_ASSUME_NONNULL_END
