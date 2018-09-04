//
//  UIView+ZMVisuals.h
//  Sierra
//
//  Created by 刘卓明 on 16/12/5.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import <UIKit/UIKit.h>

// 750 --> 640
#define W750To640(x) ((x) * 640 / 750.0)


@interface UIView (ZMVisuals)
/*
 *  Sets a corners with radius, given stroke size & color
 */
-(void)zm_cornerRadius: (CGFloat)radius
            strokeSize: (CGFloat)size
                 color: (UIColor *)color;
/*
 *  Sets a corners
 */
-(void)zm_setRoundedCorners:(UIRectCorner)corners
                     radius:(CGFloat)radius;

/*
 *  Draws shadow with properties
 */
-(void)zm_shadowWithColor: (UIColor *)color
                   offset: (CGSize)offset
                  opacity: (CGFloat)opacity
                   radius: (CGFloat)radius;

/*
 *  Removes from superview with fade
 */
-(void)zm_removeFromSuperviewWithFadeDuration: (NSTimeInterval)duration;

/*
 *  Adds a subview with given transition & duration
 */
-(void)zm_addSubview: (UIView *)view withTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration;

/*
 *  Removes view from superview with given transition & duration
 */
-(void)zm_removeFromSuperviewWithTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration;

/*
 *  Rotates view by given angle. TimingFunction can be nil and defaults to kCAMediaTimingFunctionEaseInEaseOut.
 */
-(void)zm_rotateByAngle: (CGFloat)angle
               duration: (NSTimeInterval)duration
            autoreverse: (BOOL)autoreverse
            repeatCount: (CGFloat)repeatCount
         timingFunction: (CAMediaTimingFunction *)timingFunction;

/*
 *  Moves view to point. TimingFunction can be nil and defaults to kCAMediaTimingFunctionEaseInEaseOut.
 */
-(void)zm_moveToPoint: (CGPoint)newPoint
             duration: (NSTimeInterval)duration
          autoreverse: (BOOL)autoreverse
          repeatCount: (CGFloat)repeatCount
       timingFunction: (CAMediaTimingFunction *)timingFunction;

@end
