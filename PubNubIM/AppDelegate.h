//
//  AppDelegate.h
//  PubNubIM
//
//  Created by rc on 16/8/29.
//  Copyright © 2016年 rc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PubNub.h"
#import "chatMessage.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate,PNObjectEventListener>



@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) PubNub *client;
@property (nonatomic,strong) chatMessage *message;
@property (nonatomic,strong) NSString *userId;
@end

