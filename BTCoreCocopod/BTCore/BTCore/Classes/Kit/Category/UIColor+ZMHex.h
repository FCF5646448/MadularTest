//
//  UIColor+ZMHex.h
//  Sierra
//
//  Created by 刘卓明 on 16/12/5.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZMHex)
+ (UIColor *)zm_colorWithHex:(UInt32)hex;
+ (UIColor *)zm_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)zm_colorWithHexString:(NSString *)hexString;
- (NSString *)zm_HEXString;

+ (UIColor *)zm_colorWithWholeRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue
                            alpha:(CGFloat)alpha;

+ (UIColor *)zm_colorWithWholeRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue;

@end
