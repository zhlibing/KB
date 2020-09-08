//
//  VPay_Shop_Notice_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/8/23.
//  Copyright © 2018年 James. All rights reserved.
//

#import "SSKJ_ScrollNotice_View.h"
#import "XBTextLoopView.h"
#define kTimeInterval 3

@interface SSKJ_ScrollNotice_View()
{
    NSInteger _currentNoticeIndex;
    dispatch_source_t _dispath_timer;
}
@property (nonatomic, strong) UIImageView *imageView;


@property (nonatomic, strong) NSMutableArray *noticeLabelArray;
@property (nonatomic, strong) XBTextLoopView *textLoopView;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, assign) BOOL reStart;

@end

@implementation SSKJ_ScrollNotice_View

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        
        self.layer.masksToBounds = YES;
        [self addSubview:self.imageView];
        [self addSubview:self.moreButton];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.mas_left).offset(ScaleW(8));
            make.centerY.equalTo(self.mas_centerY);
            
        }];
        
        
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.mas_right).offset(-ScaleW(8));
            make.centerY.equalTo(self.mas_centerY);
            
        }];
        
        
    }
    return self;
}

- (void)configureModels:(NSArray *)models
{
    [self.textLoopView removeFromSuperview];
    NSMutableArray *contentsArray = [[NSMutableArray alloc]init];
    for (NSString *notice in models)
    {
        
        [contentsArray addObject:notice];
    }
    WS(weakSelf);
    self.textLoopView = [XBTextLoopView textLoopViewWith:contentsArray loopInterval:2 initWithFrame:CGRectMake(0, ScaleW(0), ScaleW(200), ScaleW(40)) selectBlock:^(NSString *selectString, NSInteger index) {
        if (weakSelf.clickBlock)
        {
            weakSelf.clickBlock(index);
        }
    }];
    self.textLoopView.contentColor = kTitleColor;
    self.textLoopView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.textLoopView];
    
    [self.textLoopView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.imageView.mas_right).offset(ScaleW(8));
        make.right.equalTo(self.mas_right).offset(-ScaleW(50));
        make.top.bottom.equalTo(self);
    }];
}

-(NSMutableArray *)noticeLabelArray
{
    if (nil == _noticeLabelArray) {
        _noticeLabelArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _noticeLabelArray;
}







#pragma mark - Private Method
-(void)moreEvent
{
    if (self.moreBlock) {
        self.moreBlock();
    }
}




#pragma mark - Getter / Setter
-(UIImageView *)imageView
{
    if (nil == _imageView)
    {
        UIImage *image = [UIImage imageNamed:@"home_notice"];
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(15), ScaleW(image.size.width), ScaleW(image.size.height))];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        [_imageView setImage:image];
        _imageView.centerY = self.height / 2;
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreEvent)];
        [_imageView addGestureRecognizer:tap];
    }
    return _imageView;
}






-(UIButton *)moreButton
{
    if (nil == _moreButton) {
        _moreButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_moreButton setImage:[UIImage imageNamed:@"home_more"] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}


@end
