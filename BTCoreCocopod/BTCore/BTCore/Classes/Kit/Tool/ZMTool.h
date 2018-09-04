//
//  ZMTool.h
//  Sierra
//
//  Created by 刘卓明 on 16/12/6.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMTool : NSObject
/*
 判断手机号码格式是否正确
 */
+ (BOOL)isValiMobile:(NSString *)mobile;
// 获取文字宽高
+ (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font;

+ (void)LogAllMethodsFromClass:(id)obj;
+ (NSArray *)getAllProperties:(id)obj;


//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string;
//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string;


/**
 将秒数转化成字符串
 */
+ (NSString *)formatSecondsToString:(NSInteger)seconds;

+ (NSString*)deviceVersion;
@end
