//
//  ViewController.h
//  PubNubIM
//
//  Created by rc on 16/8/29.
//  Copyright © 2016年 rc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PubNub.h"
#import "AppDelegate.h"
@interface ViewController : UIViewController<PNObjectEventListener>
@property (nonatomic) PubNub *client;
@property (nonatomic,strong) NSString *userId;

@end

