//
//  MenuCollectionViewCell.m
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/18.
//

#import "MenuCollectionViewCell.h"

@implementation MenuCollectionViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  
  [_underlineView.layer setCornerRadius:2.0];
  [_underlineView.layer setMasksToBounds:YES];
  [_underlineView.layer setBorderWidth:0];
  
  [_messageCountLabel.layer setCornerRadius:9.0];
  [_messageCountLabel.layer setMasksToBounds:YES];
  [_messageCountLabel.layer setBorderWidth:0];
}

- (void) setSelect:(BOOL)isSelect {
    [_underlineView setHidden:!isSelect];
}


@end
