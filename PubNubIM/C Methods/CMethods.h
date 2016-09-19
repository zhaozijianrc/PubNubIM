//
//  CMethods.h
//  TaxiTest
//
//  Created by Xiaohui Guo  on 13-3-13.
//  Copyright (c) 2013年 FJKJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "MBProgressHUD.h"
//#include <stdio.h>

//用户当前的语言环境
#define CURR_LANG   ([[NSLocale preferredLanguages] objectAtIndex:0])

@interface CMethods : NSObject
{
    
}

//十六进制颜色值
UIColor* colorWithHexString(NSString *stringToConvert);
//当前应用的版本
NSString *appVersion();
//统一使用它做 应用本地化 操作
NSString *LocalizedString(NSString *translation_key, id none);
BOOL IOS9();
BOOL IOS9_1();
//获取设备型号
NSString *doDevicePlatform();
NSString*  DeviceDetailInfo();
NSString *stringFromDate(NSDate *date);

NSString *fullStringFromDate(NSDate *date);

void showLabelHUD(NSString *content,CGFloat sleepTime);

UIImage *getViewImage(UIView *view);

//MBProgressHUD * showMBProgressHUD(NSString *content,BOOL showView);
void hideMBProgressHUD();

NSString *getUniqueStrByUUID();

CGPoint getPointWithpoint(CGFloat x,CGFloat y);
CGFloat getFontWithSize(CGFloat size);
CGFloat getLength(CGFloat length);
CGRect getFrameWithRect(CGFloat x,CGFloat y,CGFloat width,CGFloat height);
CGFloat fontSizeFromPX(CGFloat pxSize);

CGSize getTextLabelRectWithContentAndFont(NSString *content ,UIFont *font);

void saveImageToPath(UIImage *image,NSString *filePath);
UIImage *getImageWihtLocalPath(NSString *filePath);

@end
