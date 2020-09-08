//
//  HomeHeaderItemControl.h
//  SSKJ
//
//  Created by 姚立志 on 2020/8/8.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeHeaderItemControl : UIControl


-(void)setTitle:(NSString*)title desc:(NSString*)desc imageName:(NSString*)name;

-(void)setTitle:(NSString*)title imageName:(NSString*)name;


- (instancetype)initWithType:(NSInteger)type;




@end

NS_ASSUME_NONNULL_END
