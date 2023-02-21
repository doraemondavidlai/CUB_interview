//
//  FriendHandler.m
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/21.
//

#import "FriendHandler.h"
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@implementation FriendHandler

+ (NSMutableArray<Friend *> *) fetchAllFriends {
  NSMutableArray<Friend *> * friends = [[NSMutableArray alloc] init];
  
  AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
  NSManagedObjectContext * context = delegate.managedObjectContext;
  
  NSFetchRequest * request = [[NSFetchRequest alloc] init];
  NSEntityDescription * entity = [NSEntityDescription entityForName:@"Friend" inManagedObjectContext:context];
  [request setEntity:entity];
  
  NSError * error;
  NSMutableArray * fetchedObjects = [[context executeFetchRequest:request error:&error] mutableCopy];
  
  if (fetchedObjects == nil) {
    NSLog(@"Fetch error, something's wrong. %@",error);
    return friends;
  }
  
  for (Friend * friend in fetchedObjects){
    [friends addObject:friend];
  }
  
  return friends;
}

+ (void) updateFriendWithDict:(NSDictionary *)srcDict {
  NSString * fid = [srcDict objectForKey:@"fid"];
  
  if (fid == nil) {
    NSLog(@"updateFriendWithDict failed, srcDict fid nil");
    return;
  }
  
  AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
  NSManagedObjectContext * context = delegate.managedObjectContext;
  
  NSFetchRequest * request = [[NSFetchRequest alloc] init];
  NSEntityDescription * entity = [NSEntityDescription entityForName:@"Friend" inManagedObjectContext:context];
  [request setEntity:entity];
  [request setPredicate:[NSPredicate predicateWithFormat:@"fid == %@", fid]];
  
  NSError * error;
  NSMutableArray * fetchedObjects = [[context executeFetchRequest:request error:&error] mutableCopy];
  
  if (fetchedObjects == nil) {
    NSLog(@"Fetch error, something's wrong. %@",error);
    return;
  }
  
  if ([fetchedObjects count] > 0) {
    // update
    Friend * friend = [fetchedObjects objectAtIndex:0];
    
    
#warning need to compare updateDate then update
    
    
    [context performBlockAndWait:^{
      [friend setIsTop:[[srcDict objectForKey:@"isTop"] intValue]];
      [friend setName:[srcDict objectForKey:@"name"]];
      [friend setStatus:[[srcDict objectForKey:@"status"] intValue]];
      [friend setUpdateDate:[self stringToDateWithStr:[srcDict objectForKey:@"updateDate"]]];
      [delegate saveContext];
    }];
    
  } else {
    // insert
    [context performBlockAndWait:^{
      Friend * friend = [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:context];
      [friend setFid:[srcDict objectForKey:@"fid"]];
      [friend setIsTop:[[srcDict objectForKey:@"isTop"] intValue]];
      [friend setName:[srcDict objectForKey:@"name"]];
      [friend setStatus:[[srcDict objectForKey:@"status"] intValue]];
      [friend setUpdateDate:[self stringToDateWithStr:[srcDict objectForKey:@"updateDate"]]];
      [delegate saveContext];
    }];
  }
}

+ (void) deleteAllFriend {
  AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
  NSManagedObjectContext * context = delegate.managedObjectContext;
  
  NSFetchRequest * request = [[NSFetchRequest alloc] init];
  NSEntityDescription * entity = [NSEntityDescription entityForName:@"Friend" inManagedObjectContext:context];
  [request setEntity:entity];
  
  NSError * error;
  NSMutableArray * fetchedObjects = [[context executeFetchRequest:request error:&error] mutableCopy];
  
  if (fetchedObjects == nil) {
    NSLog(@"Fetch error, something's wrong. %@",error);
    return;
  }
  
  [context performBlockAndWait:^{
    for (NSManagedObject * friend in fetchedObjects){
      [context deleteObject:friend];
    }
    
    [delegate saveContext];
  }];
}

+ (NSDate *) stringToDateWithStr:(NSString *)src {
  // Convert string to date object
  NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
  
  if ([src containsString:@"/"]) {
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
  } else {
    [dateFormat setDateFormat:@"yyyyMMdd"];
  }
  
  return [dateFormat dateFromString:src];
}

@end

NS_ASSUME_NONNULL_END
