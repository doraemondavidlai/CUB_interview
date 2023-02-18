//
//  FriendsViewController.h
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate> {
  __weak IBOutlet UICollectionView *inviteCollectionView;
  __weak IBOutlet UICollectionViewFlowLayout *inviteCollectionViewFlowLayout;
  __weak IBOutlet NSLayoutConstraint *inviteCollectionViewHeightConstraint;
  __weak IBOutlet UICollectionView *menuCollectionView;
  __weak IBOutlet UICollectionViewFlowLayout *menuCollectionViewFlowLayout;
  __weak IBOutlet NSLayoutConstraint *menuCollectionViewHeightConstrraint;
  __weak IBOutlet UITableView *friendTableView;
  int uiOption;
}
@end

NS_ASSUME_NONNULL_END
