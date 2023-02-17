//
//  ViewController.m
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/16.
//

#import "ViewController.h"
#import "TabbarController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (IBAction)ttt:(id)sender {
  
//}
//
//- (void) showTabWithOptions:(int)option {
  
  
  UINavigationController * navC = [[UINavigationController alloc] initWithRootViewController:[[TabbarController alloc] initWithNibName:@"TabbarController" bundle:nil]];
  [navC.view setBackgroundColor:[UIColor colorNamed:@"ColorSilver"]];
  [self.navigationController setViewControllers:[NSArray arrayWithObject:navC] animated:NO];
  
}


@end
