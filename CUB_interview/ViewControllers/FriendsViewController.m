//
//  FriendsViewController.m
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/17.
//

#import "FriendsViewController.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view setBackgroundColor:[UIColor colorNamed:@"ColorWhite"]];
  [self.navigationController.navigationBar setBackgroundColor:[UIColor colorNamed:@"ColorSilver"]];
  [self.navigationController.navigationBar setTintColor:[UIColor colorNamed:@"ColorHotPink"]];
  
  [self setNavigationItems];
  
  uiOption = [[[NSUserDefaults standardUserDefaults] objectForKey:@"uiOption"] intValue];
  
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


@end
