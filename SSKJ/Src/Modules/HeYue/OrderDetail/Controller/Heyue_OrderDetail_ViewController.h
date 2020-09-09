//
//  Heyue_OrderDetail_ViewController.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
#import "SSKJ_Market_Index_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface Heyue_OrderDetail_ViewController : SSKJ_BaseViewController

@property (nonatomic,assign) NSInteger seletedIndex;


#pragma mark 关闭定时器
-(void)stopRuntimer;
#pragma mark 开启定时器
-(void)startRuntimer;


@end

NS_ASSUME_NONNULL_END
