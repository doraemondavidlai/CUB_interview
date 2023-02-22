//
//  InviteCollectionViewCell.m
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/17.
//

#import "InviteCollectionViewCell.h"

@implementation InviteCollectionViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  
  [_subTitleLable setText:@"邀請你成為好友：）"];
}

@end
