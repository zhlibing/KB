//
//  HEYue_ViewController.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HEYue_ViewController : SSKJ_BaseViewController

@property (nonatomic,strong) SSKJ_Market_Index_Model *model;//行情model

#pragma mark - 更新币种
- (void)refreshCodeDate;


@end

NS_ASSUME_NONNULL_END
