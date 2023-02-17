//
//  TabbarController.m
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/17.
//

#import "TabbarController.h"
#import "EmptyViewController.h"
#import "FriendsViewController.h"

@interface TabbarController ()

@end

@implementation TabbarController

const CGFloat kBarHeight = 120;

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tabBar setBackgroundColor:[UIColor whiteColor]];
  
  EmptyViewController * productsVC = [[EmptyViewController alloc] initWithNibName:@"EmptyViewController" bundle:nil];
  [productsVC setHintWord:@"錢錢 頁面"];
  productsVC.tabBarItem = [self settingTabBarItemWithImageName:@"icTabbarProductsOff" tag:0];
  
  FriendsViewController * friendsVC = [[FriendsViewController alloc] initWithNibName:@"FriendsViewController" bundle:nil];
  UINavigationController * navC = [[UINavigationController alloc] initWithRootViewController:friendsVC];
  navC.tabBarItem = [self settingTabBarItemWithImageName:@"icTabbarFriendsOn" tag:1];
  
  EmptyViewController * mainVC = [[EmptyViewController alloc] initWithNibName:@"EmptyViewController" bundle:nil];
  [mainVC setHintWord:@"KOKO 頁面"];
  mainVC.tabBarItem = [self settingTabBarItemWithImageName:@"iconTabbarHomeOff" tag:2];
  
  EmptyViewController * manageVC = [[EmptyViewController alloc] initWithNibName:@"EmptyViewController" bundle:nil];
  [manageVC setHintWord:@"記帳 頁面"];
  manageVC.tabBarItem = [self settingTabBarItemWithImageName:@"icTabbarManageOff" tag:3];
  
  EmptyViewController * settingVC = [[EmptyViewController alloc] initWithNibName:@"EmptyViewController" bundle:nil];
  [settingVC setHintWord:@"設定 頁面"];
  settingVC.tabBarItem = [self settingTabBarItemWithImageName:@"icTabbarSettingOff" tag:4];
  
  [self setViewControllers:[NSArray arrayWithObjects:productsVC, navC, mainVC, manageVC, settingVC, nil]];
  
  [self setSelectedIndex:1];
}

- (UITabBarItem *) settingTabBarItemWithImageName:(NSString *)imageName tag:(int)tag {
  return [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:tag];
}

@end
