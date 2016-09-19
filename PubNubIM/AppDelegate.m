//
//  AppDelegate.m
//  PubNubIM
//
//  Created by rc on 16/8/29.
//  Copyright © 2016年 rc. All rights reserved.
//

#import "AppDelegate.h"
#import "CMethods.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    PNConfiguration *configuration = [PNConfiguration configurationWithPublishKey:@"pub-c-59022be4-3c21-4f9f-ae0f-98bce9122f4e" subscribeKey:@"sub-c-77af983c-6dd6-11e6-9259-0619f8945a4f"];
    self.client = [PubNub clientWithConfiguration:configuration];
    [self.client addListener:self];
    [self.client subscribeToChannels:@[@"my_channel12"] withPresence:YES];
//    [self.client subscribeToChannelGroups:@[@"channelGroup_22"] withPresence:NO];

    self.userId = getUniqueStrByUUID();
    
    NSLog(@"代理里的uuid%@",self.userId);

    return YES;
    
}


#pragma mark -- pubdelegate
//接收到信息


- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    
    // Handle new message stored in message.data.message
    if (message.data.actualChannel) {
        
        // Message has been received on channel group stored in message.data.subscribedChannel.
    }
    else {
        
        // Message has been received on channel stored in message.data.subscribedChannel.
    }
    
   
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"RESAVEMESSAGE" object:message.data.message];
    
    NSLog(@"嘿嘿Received message: %@ on channel %@ at %@", message.data.message,
          message.data.subscribedChannel, message.data.timetoken);
    
    NSString *MSG = message.data.message[@"text"];

    NSLog(@"哈哈哈%@",MSG);
}


- (NSString *)randomString {
    return [NSString stringWithFormat:@"%d", arc4random_uniform(74)];
}



@end
