//
//  FriendTableViewCell.h
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *starImageView;
@property (weak, nonatomic) IBOutlet UIImageView *avatorImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *transferButton;
@property (weak, nonatomic) IBOutlet UIButton *subButton;

@end

NS_ASSUME_NONNULL_END
