//
//  FriendsViewController.m
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/17.
//

#import "FriendsViewController.h"
#import "MenuCollectionViewCell.h"
#import "InviteCollectionViewCell.h"
#import "FriendStatusTableViewCell.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view setBackgroundColor:[UIColor colorNamed:@"ColorWhite"]];
  [self.navigationController.navigationBar setBackgroundColor:[UIColor colorNamed:@"ColorSilver"]];
  [self.navigationController.navigationBar setTintColor:[UIColor colorNamed:@"ColorHotPink"]];
  
  [self setNavigationItems];

  messageTitleArray = [NSArray arrayWithObjects:@"好友", @"聊天", nil];
  messageCountArray = [[NSMutableArray alloc] init];
  
  
  [noticeView.layer setCornerRadius:5.0];
  [noticeView.layer setMasksToBounds:YES];
  [noticeView.layer setBorderWidth:0];
  
  CAGradientLayer * gradient = [CAGradientLayer layer];
  [gradient setColors:[NSArray arrayWithObjects:
                       (id)[UIColor colorWithRed:86.0/255.0 green:179.0/255.0 blue:11.0/255.0 alpha:1.0].CGColor,
                       (id)[UIColor colorWithRed:166.0/255.0 green:204.0/255.0 blue:66.0/255.0 alpha:1.0].CGColor,
                       nil]];
  [gradient setFrame:addFriendButton.bounds];
  gradient.startPoint = CGPointMake(0.0, 0.5);
  gradient.endPoint = CGPointMake(1.0, 0.5);
  gradient.cornerRadius = 20.0;
  [addFriendButton.layer insertSublayer:gradient atIndex:0];
  [addFriendButton.layer setMasksToBounds:YES];
  [addFriendButton.layer setCornerRadius:20.0];
  [addFriendButton.layer setBorderWidth:0];
  [addFriendButton.layer setMasksToBounds:NO];
  [addFriendButton.layer setShadowColor:[UIColor colorWithRed:121.0/255.0 green:196.0/255.0 blue:27.0/255.0 alpha:0.4].CGColor];
  [addFriendButton.layer setShadowOffset:CGSizeMake(0.0, 4.0)];
  [addFriendButton.layer setShadowOpacity:1.0];
  [addFriendButton.layer setShadowRadius:8.0];
  [addFriendButton setTintColor:[UIColor colorNamed:@"ColorWhite"]];
  
  NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] init];
  [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"幫助好友更快找到你？"
                                                                    attributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                                                                                 NSForegroundColorAttributeName:[UIColor colorNamed:@"ColorBrownGray"],
                                                                                 NSFontAttributeName:[UIFont systemFontOfSize:13]}]];
  [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"設定 KOKO ID"
                                                                    attributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                                                                                 NSForegroundColorAttributeName:[UIColor colorNamed:@"ColorHotPink"],
                                                                                 NSFontAttributeName:[UIFont systemFontOfSize:13]}]];
  [setKoKoIdHintLabel setAttributedText:attString];
  
  [inviteCollectionView registerNib:[UINib nibWithNibName:@"InviteCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"InviteCollectionViewCell"];
  [inviteCollectionView setDataSource:self];
  [inviteCollectionView setDelegate:self];
  [inviteCollectionView setBackgroundColor:[UIColor colorNamed:@"ColorSilver"]];
  
  [menuCollectionView registerNib:[UINib nibWithNibName:@"MenuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MenuCollectionViewCell"];
  [menuCollectionView setDataSource:self];
  [menuCollectionView setDelegate:self];
  [menuCollectionView setBackgroundColor:[UIColor colorNamed:@"ColorSilver"]];
  menuCollectionView.showsHorizontalScrollIndicator = NO;
  [menuCollectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
  
  [friendTableView registerNib:[UINib nibWithNibName:@"FriendStatusTableViewCell" bundle:nil] forCellReuseIdentifier:@"FriendStatusTableViewCell"];
  [friendTableView setDataSource:self];
  [friendTableView setDelegate:self];
  [friendTableView setTableFooterView:UIView.new];
  
  
  uiOption = [[[NSUserDefaults standardUserDefaults] objectForKey:@"uiOption"] intValue];
  NSLog(@"ui option: %d", uiOption);
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
    
  switch (uiOption) {
    case UI_OPTIONS_NO_FRIEND: {
      [nameLabel setText:@"紫晽"];
      [kokoIdLabel setText:@"設定 KOKO ID"];
      [noticeView setHidden:NO];
      [emptyView setHidden:NO];
      messageCountArray = [NSMutableArray arrayWithObjects:@"0", @"0", nil];
    }
      break;
      
    case UI_OPTIONS_ONLY_FRIEND: {
      [nameLabel setText:@"紫晽"];
      [kokoIdLabel setText:@"KOKO ID：olylinhuang"];
      [noticeView setHidden:YES];
      [emptyView setHidden:YES];
      messageCountArray = [NSMutableArray arrayWithObjects:@"0", @"99+", nil];
    }
      break;
      
    case UI_OPTIONS_FRIEND_AND_INVITE: {
      [nameLabel setText:@"紫晽"];
      [kokoIdLabel setText:@"KOKO ID：olylinhuang"];
      [noticeView setHidden:YES];
      [emptyView setHidden:YES];
      messageCountArray = [NSMutableArray arrayWithObjects:@"2", @"99+", nil];
    }
      break;
      
    default:
      break;
  }
}

-(void) setNavigationItems {
  UIBarButtonItem * atmItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icNavPinkWithdraw"]
                                                                      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:nil];
  UIBarButtonItem * transferItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icNavPinkTransfer"]
                                                                      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:nil];
  
  [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:atmItem, transferItem, nil]];
  
  UIBarButtonItem * scanItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icNavPinkScan"]
                                                                       imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:nil];
  
  [self.navigationItem setRightBarButtonItem:scanItem];
}

#pragma UICollectionView
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
  if ([collectionView isEqual:menuCollectionView]) {
    MenuCollectionViewCell * menuCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MenuCollectionViewCell" forIndexPath:indexPath];
    
    [menuCell.titleLabel setText:[messageTitleArray objectAtIndex:indexPath.row]];
    
    NSString * msgStr = [messageCountArray objectAtIndex:indexPath.row];
    [menuCell.messageCountLabel setHidden:[msgStr isEqualToString:@"0"]];
    [menuCell.messageCountLabel setText:msgStr];
    double msgStrWidth = [msgStr sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular]}].width + 8;
    [menuCell.messageCountLabelWidthConstraint setConstant:msgStrWidth < 18.0 ? 18.0 : msgStrWidth];
    [menuCell setSelect:indexPath.row == 0];
    return menuCell;
  }
  
  if ([collectionView isEqual:inviteCollectionView]) {
#warning implement
    InviteCollectionViewCell * inviteCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"InviteCollectionViewCell" forIndexPath:indexPath];
    
    
    return inviteCell;
  }
  
  return UICollectionViewCell.new;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  if ([collectionView isEqual:menuCollectionView]) {
    return 2;
  }
  
  if ([collectionView isEqual:inviteCollectionView]) {
#warning implement
    return 0;
  }
  
  return 0;
  
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  if ([collectionView isEqual:menuCollectionView]) {
    return UIEdgeInsetsMake(0, 20, 0, 20);
  }
  
  if ([collectionView isEqual:inviteCollectionView]) {
#warning implement
    return UIEdgeInsetsMake(0, 10, 0, 10);
  }
  
  return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  if ([collectionView isEqual:menuCollectionView]) {
    NSString * titleStr = [messageTitleArray objectAtIndex:indexPath.row];
    
    double titleWidth = [titleStr sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular]}].width;
    
    NSString * msgStr = [messageCountArray objectAtIndex:indexPath.row];
    
    if (![msgStr isEqualToString:@"0"]) {
      double msgStrWidth = [msgStr sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular]}].width + 8;
      msgStrWidth = msgStrWidth < 18.0 ? 18.0 : msgStrWidth;
      return CGSizeMake(10.0 + titleWidth + 6.0 + msgStrWidth + 10.0, 50.0);
    } else {
      return CGSizeMake(10.0 + titleWidth + 10.0, 50.0);
    }
  }
  
  if ([collectionView isEqual:inviteCollectionView]) {
#warning implement
    return CGSizeMake(20.0, 50.0);
  }
  
  return CGSizeMake(0.0, 0.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  if ([collectionView isEqual:menuCollectionView]) {
    return 12.0;
  }
  
  if ([collectionView isEqual:inviteCollectionView]) {
#warning implement
    return 20.0;
  }
  
  return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  if ([collectionView isEqual:menuCollectionView]) {
    return 12.0;
  }

  if ([collectionView isEqual:inviteCollectionView]) {
#warning implement
    return 20.0;
  }

  return 0;
}


#pragma UITableView

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  FriendStatusTableViewCell * friendCell = [tableView dequeueReusableCellWithIdentifier:@"FriendStatusTableViewCell"];
  
  [friendCell.nameLabel setText:[NSString stringWithFormat:@"friend %ld", (long)indexPath.row]];
  
  [friendCell setSelectionStyle:UITableViewCellSelectionStyleNone];
  [friendCell setSeparatorInset:UIEdgeInsetsMake(0, 105, 0, 30)];
  return friendCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 60.0;
}

@end
