//
//  ATEX_SafeCenter_Cell.h
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/14.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATEX_SafeCenter_Cell : UITableViewCell

@property (strong, nonatomic) UILabel *cellTitleLabel;
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UIImageView *markImageView;

@property (strong, nonatomic) UIImageView *accoryImageView;
@property (strong, nonatomic) UIView *lineView;


@end

NS_ASSUME_NONNULL_END
