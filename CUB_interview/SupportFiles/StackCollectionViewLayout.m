//
//  StackCollectionViewLayout.m
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/22.
//

#import "StackCollectionViewLayout.h"

NS_ASSUME_NONNULL_BEGIN

@implementation StackCollectionViewLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
  return YES;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
  NSMutableArray<__kindof UICollectionViewLayoutAttributes *> * attrArray = [[NSMutableArray alloc] init];
  
  int itemCount = (int)[self.collectionView numberOfItemsInSection:0];
  
  for (int i = 0; i < itemCount; i++) {
    UICollectionViewLayoutAttributes * attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
    [attrArray addObject:attr];
  }
  
  return attrArray;
}

// https://www.hangge.com/blog/cache/detail_1605.html
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
  [attr setSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 60.0 - (indexPath.row == 0 ? 0.0 : 20.0), 70.0)];
  [attr setCenter:CGPointMake(self.collectionView.bounds.size.width / 2,
                              60.0 + (indexPath.row == 0 ? 0.0 : 10.0))];
  attr.zIndex = [self.collectionView numberOfItemsInSection:0] - indexPath.item;
  return attr;
}

@end

NS_ASSUME_NONNULL_END
