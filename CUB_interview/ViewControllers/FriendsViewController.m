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
#import "NetworkManager.h"
#import "FriendHandler.h"

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
  
  flowLayout = [[UICollectionViewFlowLayout alloc] init];
  stackLayout = [[StackCollectionViewLayout alloc] init];
  
  [inviteCollectionView registerNib:[UINib nibWithNibName:@"InviteCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"InviteCollectionViewCell"];
  [inviteCollectionView setDataSource:self];
  [inviteCollectionView setDelegate:self];
  [inviteCollectionView setBackgroundColor:[UIColor colorNamed:@"ColorSilver"]];
  [inviteCollectionView setScrollEnabled:NO];
  [inviteCollectionView setShowsVerticalScrollIndicator:NO];
  
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
  [friendTableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, CGFLOAT_MIN)]];
  [friendTableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
  [friendTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  
  searchBar = [[UISearchBar alloc] init];
  [searchBar setPlaceholder:@"想轉一筆給誰呢？"];
  [searchBar setTranslatesAutoresizingMaskIntoConstraints:NO];
  [searchBar.layer setBorderWidth:1.0];
  [searchBar.layer setBorderColor:[[UIColor whiteColor] CGColor]];
  [searchBar setDelegate:self];
  
  isExpand = YES;
  
  uiOption = [[[NSUserDefaults standardUserDefaults] objectForKey:@"uiOption"] intValue];
  NSLog(@"ui option: %d", uiOption);
  
  friendFRC = [FriendHandler fetchNormalFriendFRC];
  [friendFRC setDelegate:self];
  
  inviteFRC = [FriendHandler fetchInviteFRC];
  [inviteFRC setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(waitForNetworkResponse:) name:@"NetworkResponse" object:nil];
  
  [nameLabel setText:@""];
  [kokoIdLabel setText:@"KOKO ID："];
  
  switch (uiOption) {
    case UI_OPTIONS_NO_FRIEND: {
      [noticeView setHidden:NO];
      messageCountArray = [NSMutableArray arrayWithObjects:@"0", @"0", nil];
    }
      break;
      
    case UI_OPTIONS_ONLY_FRIEND: {
      [noticeView setHidden:YES];
      messageCountArray = [NSMutableArray arrayWithObjects:@"0", @"99+", nil];
    }
      break;
      
    case UI_OPTIONS_FRIEND_AND_INVITE: {
      [noticeView setHidden:YES];
      messageCountArray = [NSMutableArray arrayWithObjects:@"0", @"99+", nil];
    }
      break;
      
    default:
      break;
  }
  [self sendAPI];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
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

- (void) sendAPI {
  switch (uiOption) {
    case UI_OPTIONS_NO_FRIEND: {
      [[NetworkManager shared] fetchManData];
      [[NetworkManager shared] fetchEmptyData];
    }
      break;
      
    case UI_OPTIONS_ONLY_FRIEND: {
      [[NetworkManager shared] fetchManData];
      [[NetworkManager shared] fetchFriend1Data];
      [[NetworkManager shared] fetchFriend2Data];
    }
      break;
      
    case UI_OPTIONS_FRIEND_AND_INVITE: {
      [[NetworkManager shared] fetchManData];
      [[NetworkManager shared] fetchFriendAndInviteData];
    }
      break;
      
    default:
      break;
  }
}

- (void) updateInviteCollectionViewHeight {
  CGFloat height = 40.0;
  
  if (isExpand) {
    height = height + [inviteFRC.fetchedObjects count] * 70.0 + ([inviteFRC.fetchedObjects count] > 1 ? ([inviteFRC.fetchedObjects count] - 1) * 10.0 : 0.0);
  } else {
    height = height + ([inviteFRC.fetchedObjects count] > 1 ? 85.0 : 70.0);
  }
  
  [inviteCollectionViewHeightConstraint setConstant:height];
}

#pragma mark - UICollectionView
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
    InviteCollectionViewCell * inviteCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"InviteCollectionViewCell" forIndexPath:indexPath];
    [inviteCell setBackgroundColor:[UIColor whiteColor]];
    
    Friend * friend = [inviteFRC.fetchedObjects objectAtIndex:indexPath.row];
    [inviteCell.nameLabel setText:friend.name];
    
    [inviteCell.layer setCornerRadius:6.0];
    [inviteCell.layer setBorderWidth:0];
    [inviteCell.layer setMasksToBounds:YES];
    [inviteCell.layer setMasksToBounds:NO];
    [inviteCell.layer setShadowColor:[UIColor blackColor].CGColor];
    [inviteCell.layer setShadowOffset:CGSizeMake(0.0, 4.0)];
    [inviteCell.layer setShadowOpacity:0.1];
    [inviteCell.layer setShadowRadius:8.0];
    return inviteCell;
  }
  
  return UICollectionViewCell.new;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if ([collectionView isEqual:inviteCollectionView]) {
    isExpand = !isExpand;
    
    [inviteCollectionView.collectionViewLayout invalidateLayout];
    UICollectionViewLayout * newLayout = isExpand ? flowLayout : stackLayout;
    [inviteCollectionView setCollectionViewLayout:newLayout];
    [self updateInviteCollectionViewHeight];
  }
  
  return;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  if ([collectionView isEqual:menuCollectionView]) {
    return 2;
  }
  
  if ([collectionView isEqual:inviteCollectionView]) {
    return [inviteFRC.fetchedObjects count];
  }
  
  return 0;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  if ([collectionView isEqual:menuCollectionView]) {
    return UIEdgeInsetsMake(0, 20, 0, 20);
  }
  
  if ([collectionView isEqual:inviteCollectionView]) {
    return UIEdgeInsetsMake(25, 0, 15, 0);
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
    return CGSizeMake([UIScreen mainScreen].bounds.size.width - 60.0,
                      70.0);
  }
  
  return CGSizeMake(0.0, 0.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  if ([collectionView isEqual:menuCollectionView]) {
    return 12.0;
  }
  
  if ([collectionView isEqual:inviteCollectionView]) {
    return 10.0;
  }
  
  return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  if ([collectionView isEqual:menuCollectionView]) {
    return 12.0;
  }

  if ([collectionView isEqual:inviteCollectionView]) {
    return 10.0;
  }

  return 0;
}

#pragma mark - UITableView
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  FriendStatusTableViewCell * friendCell = [tableView dequeueReusableCellWithIdentifier:@"FriendStatusTableViewCell"];
  
  Friend * friend = isSearching ? [searchFriends objectAtIndex:indexPath.row] : [friendFRC.fetchedObjects objectAtIndex:indexPath.row];
  [friendCell.nameLabel setText:friend.name];
  [friendCell setShowStar:(friend.isTop == 1)];
  [friendCell setIsInviting:(friend.status == 2)];
  
  [friendCell setSelectionStyle:UITableViewCellSelectionStyleNone];
  return friendCell; 
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return isSearching ? [searchFriends count] : [friendFRC.fetchedObjects count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 60.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  UIView * sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                        0,
                                                                        [UIScreen mainScreen].bounds.size.width,
                                                                        [self tableView:tableView heightForHeaderInSection:section])];
  [sectionHeaderView setBackgroundColor:[UIColor whiteColor]];
  
  [sectionHeaderView addSubview:searchBar];
  
  UIButton * addFriendButton = [[UIButton alloc] init];
  [addFriendButton setTranslatesAutoresizingMaskIntoConstraints:NO];
  [addFriendButton setTintColor:[UIColor colorNamed:@"ColorHotPink"]];
  [addFriendButton setImage:[[UIImage imageNamed:@"icBtnAddFriends"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
  [sectionHeaderView addSubview:addFriendButton];
  
  [NSLayoutConstraint activateConstraints:@[
    [NSLayoutConstraint constraintWithItem:searchBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:sectionHeaderView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0],
    [NSLayoutConstraint constraintWithItem:searchBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:sectionHeaderView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0],
    [NSLayoutConstraint constraintWithItem:searchBar attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:sectionHeaderView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0],
    [NSLayoutConstraint constraintWithItem:searchBar attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:sectionHeaderView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-60.0],
    [NSLayoutConstraint constraintWithItem:addFriendButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:sectionHeaderView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.0],
    [NSLayoutConstraint constraintWithItem:addFriendButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:sectionHeaderView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5.0],
    [NSLayoutConstraint constraintWithItem:addFriendButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:sectionHeaderView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-15.0],
    [NSLayoutConstraint constraintWithItem:addFriendButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.0],
    [NSLayoutConstraint constraintWithItem:addFriendButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.0]
  ]];
  
  return sectionHeaderView;
}

#pragma mark - Network
- (void)waitForNetworkResponse:(NSNotification *)notification {
  NSDictionary * alteredDataDict = notification.userInfo;
  NSDictionary * responseDict = [alteredDataDict objectForKey:@"response"];
  
  switch ([[responseDict objectForKey:@"apiTopic"] intValue]) {
    case API_MAN: {
      NSDictionary * apiDict = [responseDict objectForKey:@"apiDict"];
      NSArray * responseArray = [apiDict objectForKey:@"response"];
      
      if ([responseArray count] < 1) {
        break;
      }
      
      NSDictionary * responseDict = [responseArray objectAtIndex:0];
      NSString * name = [responseDict objectForKey:@"name"];
      
      if (name != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
          [self->nameLabel setText:name];
        });
      }
      
      if (uiOption != UI_OPTIONS_NO_FRIEND) {
        NSString * kokoid = [responseDict objectForKey:@"kokoid"];
        
        if (kokoid != nil) {
          dispatch_async(dispatch_get_main_queue(), ^{
            [self->kokoIdLabel setText:[NSString stringWithFormat:@"KOKO ID：%@", kokoid]];
          });
        }
      }
    }
      break;
      
    default:
      break;
  }
}

#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
//  if ([inviteFRC.fetchedObjects count] < 1) {
  if (uiOption == UI_OPTIONS_ONLY_FRIEND || [inviteFRC.fetchedObjects count] < 1) {
    [inviteCollectionViewHeightConstraint setConstant:0.0];
  } else {
    [self updateInviteCollectionViewHeight];
    [inviteCollectionView reloadData];
  }
  
  int friendCount = 0;
  
  for (Friend * friend in friendFRC.fetchedObjects) {
    if (friend.status == 2) {
      friendCount++;
    }
  }
  
  [messageCountArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d", friendCount]];
  [menuCollectionView reloadData];
  
  [emptyView setHidden:[friendFRC.fetchedObjects count] > 0];
  [friendTableView setHidden:[friendFRC.fetchedObjects count] < 1];
  [friendTableView reloadData];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
  if (searchBar.text == nil || [searchBar.text isEqualToString:@""]) {
    isSearching = false;
    [friendTableView reloadData];
  } else {
    isSearching = true;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(name CONTAINS[c] %@)", searchText];
    searchFriends = [[friendFRC.fetchedObjects filteredArrayUsingPredicate:predicate] mutableCopy];
    
    [friendTableView reloadData];
  }
}

@end
