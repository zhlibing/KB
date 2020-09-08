//
//  LA_Extract_SafeVerify_AlertView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/7/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LA_Extract_SafeVerify_AlertView : UIControl


+(void)showsubmitBlock:(void(^)(NSString *code))submitBlcok;

-(void)hide;



@end
