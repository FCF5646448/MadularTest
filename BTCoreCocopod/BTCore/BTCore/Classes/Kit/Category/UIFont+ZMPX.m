//
//  UIFont+ZMPX.m
//  Sierra
//
//  Created by 刘卓明 on 16/12/5.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import "UIFont+ZMPX.h"

@implementation UIFont (ZMPX)
+ (UIFont *)ZM_systemFontOfPx:(float)px
{
    
    CGFloat pt = kFontSizeWithps(px);
    return [UIFont systemFontOfSize:pt];
}
@end
