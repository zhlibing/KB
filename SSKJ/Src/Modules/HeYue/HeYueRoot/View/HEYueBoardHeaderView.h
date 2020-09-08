//
//  HEYueBoardHeaderView.h
//  SSKJ
//
//  Created by 姚立志 on 2020/8/11.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Heyue_OrderInfo_Model.h"
#import "Heyue_Leverage_Model.h"


NS_ASSUME_NONNULL_BEGIN

@interface HEYueBoardHeaderView : UIView


@property (nonatomic, strong) Heyue_OrderInfo_Model *model;
@property (nonatomic, strong) Heyue_Leverage_Model *leverageModel;


@end

NS_ASSUME_NONNULL_END
