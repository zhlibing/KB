//
//  My_Generalize_RootViewController.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#pragma mark 返佣
#import "SSKJ_BaseViewController.h"



typedef NS_ENUM(NSUInteger, MyAssetType) {
    MyAssetTypeCharge,
    MyAssetTypeExtract,
    MyAssetTypeOther,
};



NS_ASSUME_NONNULL_BEGIN

@interface My_Generalize_RootViewController : SSKJ_BaseViewController

@property (nonatomic, assign) MyAssetType assetType;

@end

NS_ASSUME_NONNULL_END
