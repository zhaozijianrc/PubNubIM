//
//  CMethods.m
//  TaxiTest
//
//  Created by Xiaohui Guo  on 13-3-13.
//  Copyright (c) 2013年 FJKJ. All rights reserved.
//

#import "CMethods.h"
//#import <stdlib.h>
//#import <time.h>
//#include <mach/mach.h>
#import "sys/utsname.h"
#import <SystemConfiguration/CaptiveNetwork.h>
//#import "NSObject+Extention.h"
#import <sys/sysctl.h>

@implementation CMethods

UIColor* colorWithHexString(NSString *stringToConvert)
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];//字符串处理
    //例子，stringToConvert #ffffff
    if ([cString length] < 6)
        return [UIColor whiteColor];//如果非十六进制，返回白色
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];//去掉头
    if ([cString length] != 6)//去头非十六进制，返回白色
        return [UIColor whiteColor];
    //分别取RGB的值
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];

    range.location = 2;
    NSString *gString = [cString substringWithRange:range];

    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    unsigned int r, g, b;
    //NSScanner把扫描出的制定的字符串转换成Int类型
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //转换为UIColor
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

NSString *appVersion(){
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

NSString *LocalizedString(NSString *translation_key, id none){

    return NSLocalizedString(translation_key, none);
//    NSString *language = @"en";
//    
//    //只适配这么些种语言，其余一律用en
//    if([CURR_LANG isEqualToString:@"zh-Hans"] ||
//       [CURR_LANG isEqualToString:@"zh-Hant"] ||
//       [CURR_LANG isEqualToString:@"de"] ||
//       [CURR_LANG isEqualToString:@"es"] ||
//       [CURR_LANG isEqualToString:@"fr"] ||
//       [CURR_LANG isEqualToString:@"it"] ||
//       [CURR_LANG isEqualToString:@"ko"] ||
//       [CURR_LANG isEqualToString:@"ja"] ||
//       [CURR_LANG isEqualToString:@"pt"] ||
//       [CURR_LANG isEqualToString:@"pt-PT"] ||
//       [CURR_LANG isEqualToString:@"ru"] ||
//       [CURR_LANG isEqualToString:@"ar"] ||
//       [CURR_LANG isEqualToString:@"id"] ||
//       [CURR_LANG isEqualToString:@"th"] ){
//        language = CURR_LANG;
//    }
//    NSString * path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
//    NSBundle * languageBundle = [NSBundle bundleWithPath:path];
//    return [languageBundle localizedStringForKey:translation_key value:@"" table:nil];
}

BOOL IOS9(){
    float firstF = 9.0;
    //    float secondF = 9.0;
    return [[UIDevice currentDevice].systemVersion floatValue] >= firstF? YES : NO;
}

BOOL IOS9_1(){
    BOOL is9_1 = NO;
    float iOS9_1f = 9.1;
    float iOS9_2f = 9.2;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= iOS9_1f) {
        if ([[UIDevice currentDevice].systemVersion floatValue] < iOS9_2f) {
            is9_1 = YES;
        }
    }
    return is9_1;
}

NSString *doDevicePlatform()
{
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    NSDictionary *devModeMappingMap = @{
        @"x86_64"    :@"Simulator",
        @"iPod1,1"   :@"iPod Touch",      // (Original)
        @"iPod2,1"   :@"iPod Touch",      // (Second Generation)
        @"iPod3,1"   :@"iPod Touch",      // (Third Generation)
        @"iPod4,1"   :@"iPod Touch",      // (Fourth Generation)
        @"iPod5,1"   :@"iPod Touch",
        @"iPhone1,1" :@"iPhone",          // (Original)
        @"iPhone1,2" :@"iPhone",          // (3G)
        @"iPhone2,1" :@"iPhone",          // (3GS)
        @"iPhone3,1" :@"iPhone 4",        //
        @"iPhone4,1" :@"iPhone 4S",       //
        @"iPhone5,1" :@"iPhone 5",        // (model A1428, AT&T/Canada)
        @"iPhone5,2" :@"iPhone 5",        // (model A1429, everything else)
        @"iPhone5,3" :@"iPhone 5c",       // (model A1456, A1532 | GSM)
        @"iPhone5,4" :@"iPhone 5c",       // (model A1507, A1516, A1526 (China), A1529 | Global)
        @"iPhone6,1" :@"iPhone 5s",       // (model A1433, A1533 | GSM)
        @"iPhone6,2" :@"iPhone 5s",       // (model A1457, A1518, A1528 (China), A1530 | Global)
        @"iPad1,1"   :@"iPad",            // (Original)
        @"iPad2,1"   :@"iPad 2",          //
        @"iPad2,2"   :@"iPad 2",
        @"iPad2,3"   :@"iPad 2",
        @"iPad2,4"   :@"iPad 2",
        @"iPad2,5"   :@"iPad Mini",       // (Original)
        @"iPad2,6"   :@"iPad Mini",
        @"iPad2,7"   :@"iPad Mini",
        @"iPad3,1"   :@"iPad 3",          // (3rd Generation)
        @"iPad3,2"   :@"iPad 3",
        @"iPad3,3"   :@"iPad 3",
        @"iPad3,4"   :@"iPad 4",          // (4th Generation)
        @"iPad3,5"   :@"iPad 4",
        @"iPad3,6"   :@"iPad 4",
        @"iPad4,1"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Wifi
        @"iPad4,2"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Cellular
        @"iPad4,4"   :@"iPad Mini 2",     // (2nd Generation iPad Mini - Wifi)
        @"iPad4,5"   :@"iPad Mini 2"      // (2nd Generation iPad Mini - Cellular)
    };

    NSString *devModel = [devModeMappingMap valueForKeyPath:platform];
    return (devModel) ? devModel : platform;
}


NSString *stringFromDate(NSDate *date)
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat: @"HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}

NSString *fullStringFromDate(NSDate *date)
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [dateFormatter setDateFormat: @"yyyyMMdd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}


UIImage *getViewImage(UIView *view)
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

NSString *getUniqueStrByUUID()
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
    
    //get the string representation of the UUID
    
    NSString  *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    
    return uuidString;
    
}

//CGPoint getPointWithpoint(CGFloat x,CGFloat y)
//{
//    if (ScreenHeight > 480) {
//        x = (x*ScreenWidth)/320.0;
//        y = (y*ScreenHeight)/568.0;
//    }
//    CGPoint point = CGPointMake(x, y);
//    return point;
//}
//CGFloat getFontWithSize(CGFloat size)
//{
//    if (ScreenHeight > 480) {
//        size = (size*ScreenWidth)/320.0;
//    }
//    return size;
//}
//CGFloat getLength(CGFloat length)
//{
//    if (ScreenHeight > 480) {
//        length = (length*ScreenWidth)/320.0;
//    }
//    return length;
//}

//CGRect getFrameWithRect(CGFloat x,CGFloat y,CGFloat width,CGFloat height)
//{
//    if (ScreenHeight > 480) {
//        x = (x*ScreenWidth)/320.0;
//        width = (width*ScreenWidth)/320.0;
//        y = (y*ScreenHeight)/568.0;
//        height = (height*ScreenHeight)/568.0;
//    }
//    CGRect rect = CGRectMake(x, y, width, height);
//    return rect;
//}


CGFloat fontSizeFromPX(CGFloat pxSize){
    return (pxSize / 96.0) * 72 * 0.65;
}

CGSize getTextLabelRectWithContentAndFont(NSString *content ,UIFont *font)
{
    CGSize size = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    
    CGRect returnRect = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil];
    
    return returnRect.size;
}

void saveImageToPath(UIImage *image,NSString *filePath)
{
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    NSData *imageData;
    if (UIImagePNGRepresentation(image) == nil) {
        imageData = UIImageJPEGRepresentation(image, 1);
    } else {
        imageData = UIImagePNGRepresentation(image);
    }
    [imageData writeToFile:filePath atomically:YES];
}

UIImage *getImageWihtLocalPath(NSString *filePath)
{
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        return image;
    }
    return nil;
}

@end
