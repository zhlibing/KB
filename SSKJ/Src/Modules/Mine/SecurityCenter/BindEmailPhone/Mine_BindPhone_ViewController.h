//
//  My_BindPhone_ViewController.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface Mine_BindPhone_ViewController : SSKJ_BaseViewController

@property (nonatomic, copy) void (^successBlock)(NSString *account);



@end

NS_ASSUME_NONNULL_END
