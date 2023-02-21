//
//  FriendStatusTableViewCell.h
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendStatusTableViewCell : UITableViewCell {
  double subBtnWidthTemp;
}
@property (weak, nonatomic) IBOutlet UIImageView *starImageView;
@property (weak, nonatomic) IBOutlet UIImageView *avatorImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *transferLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *transferLabelWidthConstraint;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subLabelWidthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *transferButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *transferButtonWidthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *subButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subButtonWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subButtonTrailingConstraint;
- (void) setShowStar:(BOOL)isShow;
- (void) setIsInviting:(BOOL)isInviting;
@end

NS_ASSUME_NONNULL_END
