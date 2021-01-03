//
//  Home_Coin_View.m
//  SSKJ
//
//  Created by zpz on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Home_Coin_View.h"

#import "Home_Coin_CollectionViewCell.h"

@interface Home_Coin_View() <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic)NSInteger totalNum;


@end

@implementation Home_Coin_View

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layouts = [[UICollectionViewFlowLayout alloc] init];
    layouts.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self = [super initWithFrame:frame collectionViewLayout:layouts];
    if (self)
    {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[Home_Coin_CollectionViewCell class] forCellWithReuseIdentifier:@"Home_Coin_CollectionViewCell"];
        self.scrollEnabled = NO;
        self.backgroundColor = kBgColor;
    }
    return self;
}





- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return MIN(self.array.count, 3);
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Home_Coin_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Home_Coin_CollectionViewCell" forIndexPath:indexPath];
    cell.model = self.array[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectBlock) {
        self.selectBlock(indexPath.row);
    }
}


#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth-ScaleW(24))/3.0, 100);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}


- (void)setArray:(NSArray *)array
{
    _array = array;
    [self reloadData];
}

@end
