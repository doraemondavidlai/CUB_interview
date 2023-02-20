//
//  NetworkManager.h
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject {
  NSOperationQueue * apiQueue;
}
+ (NetworkManager *) shared;

- (void) fetchManData;
- (void) fetchEmptyData;
- (void) fetchFriend1Data;
- (void) fetchFriend2Data;
- (void) fetchFriendAndInviteData;

@end

NS_ASSUME_NONNULL_END
