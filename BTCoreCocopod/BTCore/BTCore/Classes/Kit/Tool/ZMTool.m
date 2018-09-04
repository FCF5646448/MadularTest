//
//  ZMTool.m
//  Sierra
//
//  Created by 刘卓明 on 16/12/6.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import "ZMTool.h"
#import <objc/message.h>
#import "sys/utsname.h"

@implementation ZMTool
//判断手机号码格式是否正确
+ (BOOL)isValiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        return YES;
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}




#pragma mark - hook
+ (void)LogAllMethodsFromClass:(id)obj
{
    u_int count;
    //class_copyMethodList 获取类的所有方法列表
    Method *mothList_f = class_copyMethodList([obj class],&count) ;
    for (int i = 0; i < count; i++) {
        Method temp_f = mothList_f[i];
        // method_getImplementation  由Method得到IMP函数指针
        IMP imp_f = method_getImplementation(temp_f);
        
        // method_getName由Method得到SEL
        SEL name_f = method_getName(temp_f);
        
        const char * name_s = sel_getName(name_f);
        // method_getNumberOfArguments  由Method得到参数个数
        int arguments = method_getNumberOfArguments(temp_f);
        // method_getTypeEncoding  由Method得到Encoding 类型
        const char * encoding = method_getTypeEncoding(temp_f);
        
        NSLog(@"方法名：%@\n,参数个数：%d\n,编码方式：%@\n",[NSString stringWithUTF8String:name_s],
              arguments,[NSString stringWithUTF8String:encoding]);
    }
    free(mothList_f);
    
}


+ (NSArray *)getAllProperties:(id)obj
{
    u_int count;
    
    //使用class_copyPropertyList及property_getName获取类的属性列表及每个属性的名称
    
    objc_property_t *properties  =class_copyPropertyList([obj class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        NSLog(@"属性%@\n",[NSString stringWithUTF8String: propertyName]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}


+ (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        //iOS 7
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
}


//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (NSString *)formatSecondsToString:(NSInteger)seconds
{
    NSString *hhmmss = nil;
    if (seconds < 0) {
        return @"00:00:00";
    }
    
    int h = (int)round(seconds/3600);
    int m = (int)round((seconds%3600)/60);
    int s = (int)round(seconds%60);
    
    hhmmss = [NSString stringWithFormat:@"%02d:%02d:%02d", h, m, s];
    
    return hhmmss;
}
+ (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
//    ZMLog(@"%@",deviceString);
    // 模拟器
    if ([deviceString isEqualToString:@"i386"])         return @"iPhone Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"iPhone Simulator";
    
    if ([deviceString hasPrefix:@"iPhone"]) {// iPhone
        if ([deviceString isEqualToString:@"iPhone10,1"])    return @"iPhone 8";
        if ([deviceString isEqualToString:@"iPhone10,1"])    return @"iPhone 8";
        if ([deviceString isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
        if ([deviceString isEqualToString:@"iPhone10,2"])    return @"iPhone 8 Plus";
        if ([deviceString isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
        if ([deviceString isEqualToString:@"iPhone10,3"])    return @"iPhone X";
        if ([deviceString isEqualToString:@"iPhone10,6"])    return @"iPhone X";
        if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
        if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
        if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
        if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
        if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
        if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
        if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
        if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
        if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
        if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
        if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
        if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
        if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
        if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
        if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
        if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
        if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
        if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
        if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
        if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
        if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    }else if ([deviceString hasSuffix:@"iPad"]){//iPad
        if ([deviceString isEqualToString:@"iPad7,1"])     return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
        if ([deviceString isEqualToString:@"iPad7,2"])     return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
        if ([deviceString isEqualToString:@"iPad7,3"])     return @"iPad Pro 10.5 inch (WiFi)";
        if ([deviceString isEqualToString:@"iPad7,4"])     return @"iPad Pro 10.5 inch (Cellular)";
        if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
        if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
        if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
        if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
        if ([deviceString isEqualToString:@"iPad6,11"])    return @"iPad 5 (WiFi)";
        if ([deviceString isEqualToString:@"iPad6,12"])    return @"iPad 5 (Cellular)";
        if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
        if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
        if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
        if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
        if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
        if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
        if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
        if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
        if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
        if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
        if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
        if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
        if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
        if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
        if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
        if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
        if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
        if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
        if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
        if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
        if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
        if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
        if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
        if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
        if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
        if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
        if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
        
    }
    
//    ZMLog(@"NOTE: Unknown device type: %@", deviceString);
    
    return deviceString;
}

// 获取设备型号然后手动转化为对应名称
- (NSString*)deviceName_chinese
{
    // 需要#import "sys/utsname.h"
    
    struct utsname systemInfo;
    uname(&systemInfo);
        NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"国行(A1863)、日行(A1906)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"美版(Global/A1905)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"国行(A1864)、日行(A1898)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"美版(Global/A1897)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"国行(A1865)、日行(A1902)iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"美版(Global/A1901)iPhone X";

    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";

    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,11"])    return @"iPad 5 (WiFi)";
    if ([deviceString isEqualToString:@"iPad6,12"])    return @"iPad 5 (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,1"])     return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,2"])     return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,3"])     return @"iPad Pro 10.5 inch (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,4"])     return @"iPad Pro 10.5 inch (Cellular)";

   if ([deviceString isEqualToString:@"AppleTV2,1"])    return @"Apple TV 2";
   if ([deviceString isEqualToString:@"AppleTV3,1"])    return @"Apple TV 3";
   if ([deviceString isEqualToString:@"AppleTV3,2"])    return @"Apple TV 3";
   if ([deviceString isEqualToString:@"AppleTV5,3"])    return @"Apple TV 4";

    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
        return deviceString;
}



@end
