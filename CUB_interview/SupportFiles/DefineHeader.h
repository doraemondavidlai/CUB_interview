//
//  DefineHeader.h
//  CUB_interview
//
//  Created by 賴永峰 on 2023/2/18.
//

#ifndef DefineHeader_h
#define DefineHeader_h

typedef enum {
  UI_OPTIONS_NO_FRIEND,
  UI_OPTIONS_ONLY_FRIEND,
  UI_OPTIONS_FRIEND_AND_INVITE,
} UI_OPTIONS;


typedef enum {
  API_MAN,
  API_EMPTY,
  API_FRIEND1,
  API_FRIEND2,
  API_FRIEND_INVITE,
} APIs;

typedef enum {
  APIStatus_ERROR,
  APIStatus_SUCCESS,
} APIStatus;

#endif /* DefineHeader_h */
