//
//  SSKJ_ScrollView.m
//  SSKJ
//
//  Created by 姚立志 on 2020/8/11.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "SSKJ_ScrollView.h"

@implementation SSKJ_ScrollView



- (instancetype)initWithFrame:(CGRect)frame withDeletage:(UIViewController*)deletage
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setDelegate:(id)deletage];
        [self setPagingEnabled:YES];
        [self setBounces:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        
        
        if (@available(iOS 11.0, *))
        {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        else
        {
            deletage.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return self;
}

@end
