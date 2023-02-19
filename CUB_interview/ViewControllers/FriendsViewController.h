//
//  FriendsViewController.h
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/17.
//

#import <UIKit/UIKit.h>
#import "DefineHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate> {
  __weak IBOutlet UILabel *nameLabel;
  __weak IBOutlet UILabel *kokoIdLabel;
  __weak IBOutlet UIButton *setKokoIdButton;
  __weak IBOutlet UIView *noticeView;
  __weak IBOutlet UICollectionView *inviteCollectionView;
  __weak IBOutlet UICollectionViewFlowLayout *inviteCollectionViewFlowLayout;
  __weak IBOutlet NSLayoutConstraint *inviteCollectionViewHeightConstraint;
  __weak IBOutlet UICollectionView *menuCollectionView;
  __weak IBOutlet UICollectionViewFlowLayout *menuCollectionViewFlowLayout;
  __weak IBOutlet NSLayoutConstraint *menuCollectionViewHeightConstrraint;
  __weak IBOutlet UITableView *friendTableView;
  __weak IBOutlet UIView *emptyView;
  __weak IBOutlet UIButton *addFriendButton;
  __weak IBOutlet UILabel *setKoKoIdHintLabel;
  
  int uiOption;
  NSMutableArray * messageTitleArray;
  NSMutableArray * messageCountArray;
}
@end

NS_ASSUME_NONNULL_END
