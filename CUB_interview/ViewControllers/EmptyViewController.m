//
//  EmptyViewController.m
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/17.
//

#import "EmptyViewController.h"

@interface EmptyViewController ()

@end

@implementation EmptyViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view setBackgroundColor:[UIColor grayColor]];
  
  [_hintLabel setText:_hintWord];
}

- (void) setHintWithMsg:(NSString *)msg {
  [_hintLabel setText:msg];
}

@end
