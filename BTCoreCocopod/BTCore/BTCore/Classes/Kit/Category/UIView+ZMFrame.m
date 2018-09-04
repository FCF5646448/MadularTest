//
//  UIView+ZMFrame.m
//  Sierra
//
//  Created by 刘卓明 on 16/12/7.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import "UIView+ZMFrame.h"

@implementation UIView (ZMFrame)

- (CGFloat)zm_top
{
    return self.frame.origin.y;
}

- (void)setZm_top:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)zm_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setZm_right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)zm_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setZm_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)zm_left
{
    return self.frame.origin.x;
}

- (void)setZm_left:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)zm_width
{
    return self.frame.size.width;
}

- (void)setZm_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)zm_height
{
    return self.frame.size.height;
}

- (void)setZm_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties

- (CGPoint)zm_origin {
    return self.frame.origin;
}

- (void)setZm_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)zm_size {
    return self.frame.size;
}

- (void)setZm_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
#pragma mark - Shortcuts for positions

- (CGFloat)zm_centerX {
    return self.center.x;
}

- (void)setZm_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)zm_centerY {
    return self.center.y;
}

- (void)setZm_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


@end
