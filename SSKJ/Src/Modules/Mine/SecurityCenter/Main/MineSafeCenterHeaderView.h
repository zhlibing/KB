//
//  MineSafeCenterHeaderView.h
//  SSKJ
//
//  Created by SSKJ on 2020/2/21.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineSafeCenterHeaderView : UIView

/// 设置用户信息
/// @param userinfo SSKJ_UserInfo_Model 用户对象
-(void)setUserInfo:(SSKJ_UserInfo_Model*)userinfo;


@end

NS_ASSUME_NONNULL_END
