//
//  UIView+ZMCustromBorder.h
//  Sierra
//
//  Created by 刘卓明 on 16/12/6.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSUInteger, ZMExcludePoint) {
    ZMExcludeStartPoint = 1 << 0,
    ZMExcludeEndPoint = 1 << 1,
    ZMExcludeAllPoint = ~0UL
};




@interface UIView (ZMCustromBorder)

- (void)zm_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)zm_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth;
- (void)zm_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)zm_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
/*
 lineType:传入一个数组代表 虚线  @[@3,@1]  --> 代表 3个实心线 1个空白
 */
- (void)zm_addAllBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth cornerRadius:(CGFloat) cornerRadius lineType:(NSArray<NSNumber*> *)lineType;

/**
 画一条线段
 */
- (void)zm_addlineWithColor:(UIColor *)color width:(CGFloat)borderWidth startPoint:(CGPoint )start endPoint:(CGPoint )end lineType:(NSArray<NSNumber *> *)lineType;

- (void)zm_removeTopBorder;
- (void)zm_removeLeftBorder;
- (void)zm_removeBottomBorder;
- (void)zm_removeRightBorder;
- (void)zm_removeAllBorder;

- (void)zm_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(ZMExcludePoint)edge;
- (void)zm_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(ZMExcludePoint)edge;
- (void)zm_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(ZMExcludePoint)edge;
- (void)zm_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(ZMExcludePoint)edge;





@end
