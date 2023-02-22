//
//  FriendHandler.h
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Friend+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendHandler : NSObject
+ (NSFetchedResultsController *) fetchNormalFriendFRC;
+ (NSMutableArray<Friend *> *) fetchAllFriends;
+ (void) updateFriendWithDict:(NSDictionary *)srcDict;
+ (void) deleteAllFriend;
@end



NS_ASSUME_NONNULL_END
