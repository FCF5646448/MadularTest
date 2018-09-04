//
//  UIkit_Factory.h
//  Sierra
//
//  Created by 刘卓明 on 16/12/11.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIkit_Factory : NSObject


+ (UIButton *)zm_makeButtonWithTitle:(NSString *)title
                                font:(UIFont *)font
                              corner:(CGFloat)corner
                       bgNormalColor:(UIColor *)bgNormalColor
                       bgSelectColor:(UIColor *)bgSelectColor
                    titleNormalColor:(UIColor *)normalColor
                    titleSelectColor:(UIColor *)selectColor;
/**
 ** lineView:	   需要绘制成虚线的view
 ** lineLength:	 虚线的宽度
 ** lineSpacing:	虚线的间距
 ** lineColor:	  虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
@end
