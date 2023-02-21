//
//  NetworkManager.m
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/19.
//

#import "NetworkManager.h"
#import "DefineHeader.h"
#import "FriendHandler.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NetworkManager

- (instancetype) init{
  if (self == nil) {
    self = [super init];
  }
  
  if (apiQueue == nil) {
    apiQueue = [[NSOperationQueue alloc] init];
    [apiQueue setMaxConcurrentOperationCount:10];
  }
  
  [self addSingleObserver];
  
  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NetworkResponse" object:nil];
}

+ (NetworkManager *) shared {
  static dispatch_once_t once;
  static NetworkManager * sharedInstance;
  dispatch_once(&once, ^{
    sharedInstance = [[super allocWithZone:nil] init];
  });
  return sharedInstance;
}

+ (id) allocWithZone:(NSZone *)zone {
  NSString *reason = [NSString stringWithFormat:@"Attempt to allocate a second instance of the singleton %@", [self class]];
  NSException *exception = [NSException exceptionWithName:@"Multiple singletons"
                                                   reason:reason
                                                 userInfo:nil];
  [exception raise];
  
  return nil;
}

- (void) addSingleObserver {
  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NetworkResponse" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(waitForNetworkResponse:) name:@"NetworkResponse" object:nil];
}

- (void) sendResponsePostWithApi:(int)api status:(int)status params:(NSDictionary*)dict {
  NSDictionary * apiRespToupleDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      [NSString stringWithFormat:@"%d", api], @"apiTopic",
                                      [NSString stringWithFormat:@"%d", status], @"apiStatus",
                                      dict, @"apiDict",
                                      nil];
                                       
  [[NSNotificationCenter defaultCenter] postNotificationName:@"NetworkResponse"
                                                      object:nil
                                                    userInfo:@{@"response": apiRespToupleDict}];
}

- (void) requestWithURL:(NSString *)url topic:(int)topic {
  NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                      cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                  timeoutInterval:10.0];
  [req setHTTPMethod:@"GET"];
  [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  
  [apiQueue addOperationWithBlock:^{
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      if (error != nil) {
        NSLog(@"api error, %@", error);
        [self sendResponsePostWithApi:topic status:APIStatus_ERROR params:[[NSDictionary alloc] init]];
        return;
      }
      
      if (data == nil) {
        [self sendResponsePostWithApi:topic status:APIStatus_ERROR params:[[NSDictionary alloc] init]];
        return;
      }
      
      NSError * decodeError;
      NSDictionary* jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&decodeError];
      
      if (decodeError != nil) {
        NSLog(@"decode error, %@", error);
        [self sendResponsePostWithApi:topic status:APIStatus_ERROR params:[[NSDictionary alloc] init]];
        return;
      }
      
      [self sendResponsePostWithApi:topic status:APIStatus_SUCCESS params:jsonObj];
      
    }] resume];
  }];
}

- (void) fetchManData {
  [self requestWithURL:@"https://dimanyen.github.io/man.json" topic:API_MAN];
}

- (void) fetchEmptyData {
  [self requestWithURL:@"https://dimanyen.github.io/friend4.json" topic:API_EMPTY];
}

- (void) fetchFriend1Data {
  [self requestWithURL:@"https://dimanyen.github.io/friend1.json" topic:API_FRIEND1];
}

- (void) fetchFriend2Data {
  [self requestWithURL:@"https://dimanyen.github.io/friend2.json" topic:API_FRIEND2];
}

- (void) fetchFriendAndInviteData {
  [self requestWithURL:@"https://dimanyen.github.io/friend3.json" topic:API_FRIEND_INVITE];
}

#pragma Network Response

- (void)waitForNetworkResponse:(NSNotification *)notification {
  NSDictionary * alteredDataDict = notification.userInfo;
  NSDictionary * responseDict = [alteredDataDict objectForKey:@"response"];
  NSLog(@"responseDict: %@", responseDict);
  
  switch ([[responseDict objectForKey:@"apiTopic"] intValue]) {
    case API_EMPTY: {
      // ignore
    }
      break;
      
    case API_FRIEND1: {
      NSDictionary * apiDict = [responseDict objectForKey:@"apiDict"];
      NSArray * responseArray = [apiDict objectForKey:@"response"];
      
      if ([responseArray count] < 1) {
        break;
      }
      
      for (NSDictionary * friendDict in responseArray) {
        dispatch_async(dispatch_get_main_queue(), ^{
          [FriendHandler updateFriendWithDict:friendDict];
        });
      }
    }
      break;
      
    case API_FRIEND2: {
      
    }
      break;
      
    case API_FRIEND_INVITE: {
      
    }
      break;
      
    default:
      break;
  }
}

@end

NS_ASSUME_NONNULL_END
