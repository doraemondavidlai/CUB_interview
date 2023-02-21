//
//  FriendStatusTableViewCell.m
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/18.
//

#import "FriendStatusTableViewCell.h"

@implementation FriendStatusTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  [_transferButton setTitle:nil forState:UIControlStateNormal];
  [_subButton setTitle:nil forState:UIControlStateNormal];
  
  NSString * transferWord = @"轉帳";
  [_transferLabel setText:transferWord];
  double transferWordWidth = [transferWord sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular]}].width;
  [_transferLabelWidthConstraint setConstant:transferWordWidth + 20.0];
  [_transferLabel.layer setBorderColor:[[UIColor colorNamed:@"ColorHotPink"] CGColor]];
  [_transferLabel.layer setBorderWidth:1.2];
  [_transferButtonWidthConstraint setConstant:transferWordWidth + 20.0 + 10.0];
  
  NSString * inviteWord = @"邀請中";
  [_subLabel setText:inviteWord];
  double inviteWordWidth = [inviteWord sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular]}].width;
  [_subLabelWidthConstraint setConstant:inviteWordWidth + 20.0];
  [_subLabel.layer setBorderColor:[[UIColor colorNamed:@"ColorBrownGray"] CGColor]];
  [_subLabel.layer setBorderWidth:1.2];
  subBtnWidthTemp = inviteWordWidth + 20.0 + 10.0;
  
}

- (void) setShowStar:(BOOL)isShow {
  [_starImageView setHidden:!isShow];
}

- (void) setIsInviting:(BOOL)isInviting {
  if (isInviting) {
    [_subLabel setHidden:NO];
    [_subButtonWidthConstraint setConstant:subBtnWidthTemp];
    [_subButton setImage:nil forState:UIControlStateNormal];
    [_subButtonTrailingConstraint setConstant:15.0];
  } else {
    [_subLabel setHidden:YES];
    [_subButtonWidthConstraint setConstant:60.0];
    [_subButton setImage:[[UIImage imageNamed:@"icFriendsMore"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                forState:UIControlStateNormal];
    [_subButtonTrailingConstraint setConstant:10.0];
  }
}

@end
