//
//  EmptyViewController.h
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmptyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel * hintLabel;
@property (weak, nonatomic) NSString * hintWord;
@end

NS_ASSUME_NONNULL_END
