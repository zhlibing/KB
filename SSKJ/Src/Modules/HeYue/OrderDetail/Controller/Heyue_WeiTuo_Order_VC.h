//
//  Heyue_WeiTuo_Order_VC.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/8/3.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
#import "SSKJ_Market_Index_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface Heyue_WeiTuo_Order_VC : SSKJ_BaseViewController

#pragma mark 关闭定时器

/// 关闭定时器
-(void)stopRuntimer;

#pragma mark 开启定时器
/// 开启定时器
-(void)startRuntimer;


@end

NS_ASSUME_NONNULL_END
