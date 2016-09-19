//
//  chatMessage.h
//  PubNubIM
//
//  Created by rc on 16/8/29.
//  Copyright © 2016年 rc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(int, MessageDirection) {
    Incoming,
    Outgoing,
};
@interface chatMessage :NSObject
@property (nonatomic,assign) MessageDirection direction;

@property (nonatomic,strong) NSString *megText;
//@property (nonatomic,strong) NSString *OutGoing;
@end
