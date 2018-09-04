//
//  UIFont+ZMPX.h
//  Sierra
//
//  Created by 刘卓明 on 16/12/5.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFontSizeWithpx(px) px / 96 * 72
#define kFontSizeWithps(ps) kFontSizeWithpx(ps / 2)
#define DCSystemFontWithpx(px) [UIFont systemFontOfSize:kFontSizeWithpx(px)]
#define DCSystemFontWithps(ps) [UIFont systemFontOfSize:kFontSizeWithpx(ps / 2)]




@interface UIFont (ZMPX)

+ (UIFont *)ZM_systemFontOfPx:(float)px;

@end
