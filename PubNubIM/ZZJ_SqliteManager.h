//
//  ZZJ_SqliteManager.h
//  PubNubIM
//
//  Created by rc on 16/8/29.
//  Copyright © 2016年 rc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "chatMessage.h"
#import "ZZJ_SqliteManager.h"
@interface ZZJ_SqliteManager : NSObject

+ (ZZJ_SqliteManager *)shareManager;


- (BOOL)addMessage:(chatMessage*)message;
- (NSMutableArray *)getAllChatMsgWithTargetUserId:(NSString *)targetUserId;
- (NSString *)getLastChatMsgWithTargetUserId:(NSString *)targetUserId;

@end
