//
//  EmptyViewController.h
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/17.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmptyViewController : ViewController
@property (weak, nonatomic) IBOutlet UILabel * hintLabel;
@property (weak, nonatomic) IBOutlet NSString * hintWord;
- (void) setHintWithMsg:(NSString *)msg;
@end

NS_ASSUME_NONNULL_END
