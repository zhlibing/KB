//
//  SSKJ_UserInfo_Model.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2020/3/25.
//  Copyright © 2020 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoAssetModel.h"
#import "UserInfoConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_UserInfo_Model : NSObject

@property (nonatomic, copy) NSString *account;  // account
@property (nonatomic, copy) NSString *UID;  // UID
@property (nonatomic, copy) NSString *area_code;  // 国家代码
@property (nonatomic, copy) NSString *phone;  // 手机号
@property (nonatomic, copy) NSString *email;  // 邮箱
@property (nonatomic, copy) NSString *name;  // 姓名
@property (nonatomic, copy) NSString *nickname;  // 昵称
@property (nonatomic, copy) NSString *avatar;  // 头像
@property (nonatomic, copy) NSString *is_bull;  // 是否为大V 0为否 1为是
@property (nonatomic, copy) NSString *stoped;  // 用户状态 0为正常1为冻结
@property (nonatomic, copy) NSString *refuse_reason;  // 高级认证拒绝原因
@property (nonatomic, copy) NSString *card_id;  // 身份证号

@property (nonatomic, copy) NSString *authentication;  //认证状态 0未认证 2待审核 3通过 4拒绝
@property (nonatomic, strong) UserInfoAssetModel *assets;  // 账户资产信息
@property (nonatomic, strong) UserInfoConfigModel *config;  // 安全信息

@property (nonatomic, copy) NSString *is_agent;  // 是否是经纪人 1是 


@property (nonatomic, copy) NSString *level;  //  会员等级

@property (nonatomic, copy) NSString *experience;   // 体验金

@end

NS_ASSUME_NONNULL_END
