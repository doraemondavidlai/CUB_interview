//
//  FirstpageViewController.m
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/17.
//

#import "FirstpageViewController.h"
#import "TabbarController.h"
#import "DefineHeader.h"

@interface FirstpageViewController ()

@end

@implementation FirstpageViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (IBAction)noFriendAction:(id)sender {
  [self openTabControllerWithOption:UI_OPTIONS_NO_FRIEND];
}


- (IBAction)onlyFriendAction:(id)sender {
  [self openTabControllerWithOption:UI_OPTIONS_ONLY_FRIEND];
}


- (IBAction)friendAndInviteAction:(id)sender {
  [self openTabControllerWithOption:UI_OPTIONS_FRIEND_AND_INVITE];
}

- (void) openTabControllerWithOption:(int)option {
  TabbarController * tabbarVC = [[TabbarController alloc] initWithNibName:@"TabbarController" bundle:nil];
  [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:option] forKey:@"uiOption"];
  [[NSUserDefaults standardUserDefaults] synchronize];
  [[UIApplication sharedApplication].windows.firstObject setRootViewController:tabbarVC];
}

@end
