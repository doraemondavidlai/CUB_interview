//
//  AppDelegate.h
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/16.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end
