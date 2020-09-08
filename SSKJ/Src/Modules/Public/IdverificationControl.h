//
//  IdverificationControl.h
//  SSKJ
//
//  Created by 姚立志 on 2020/8/7.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IdverificationControl : UIControl


@property (nonatomic, strong) UIImage *image;


-(void)setImageName:(NSString *)imageName title:(NSString*)title tiptitle:(NSString*)tiptitle;

@end

NS_ASSUME_NONNULL_END
