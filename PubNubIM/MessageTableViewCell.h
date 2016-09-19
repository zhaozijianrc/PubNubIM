//
//  MessageTableViewCell.h
//  PubNubIM
//
//  Created by guester on 16/8/30.
//  Copyright © 2016年 rc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UILabel *textLable;
@property (nonatomic,weak) IBOutlet UIImageView *iconImage;
@end
