//
//  MenuCollectionViewCell.h
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageCountLabelWidthConstraint;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *underlineView;
@end

NS_ASSUME_NONNULL_END
