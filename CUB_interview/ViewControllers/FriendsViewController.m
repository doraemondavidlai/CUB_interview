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
    
    switch (indexPath.row) {
      case 0:
        [menuCell.titleLabel setText:@"好友"];
        [menuCell.messageCountLabel setText:@"2"];
        break;
        
      case 1:
        [menuCell.titleLabel setText:@"聊天"];
        [menuCell.messageCountLabel setText:@"99+"];
        break;
        
      default:
        break;
    }
    
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
    return UIEdgeInsetsMake(0, 10, 0, 10);
  }
  
  if ([collectionView isEqual:inviteCollectionView]) {
#warning implement
    return UIEdgeInsetsMake(0, 10, 0, 10);
  }
  
  return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  if ([collectionView isEqual:menuCollectionView]) {
    NSString * titleStr = @"";
    
    switch (indexPath.row) {
      case 0:
        titleStr = @"好友";
        break;
        
      case 1:
        titleStr = @"聊天";
        break;
        
      default:
        break;
    }
    
    double cellWidth = [titleStr sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular]}].width + 14;
    
    return CGSizeMake(cellWidth > 100.0 ? 100.0 : cellWidth, 50.0);
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
  
  return friendCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 60.0;
}

@end
