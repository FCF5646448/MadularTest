//
//  UIView+ZMFrame.h
//  Sierra
//
//  Created by 刘卓明 on 16/12/7.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZMFrame)
// shortcuts for frame properties
@property (nonatomic, assign) CGPoint zm_origin;
@property (nonatomic, assign) CGSize zm_size;

// shortcuts for positions
@property (nonatomic) CGFloat zm_centerX;
@property (nonatomic) CGFloat zm_centerY;


@property (nonatomic) CGFloat zm_top;
@property (nonatomic) CGFloat zm_bottom;
@property (nonatomic) CGFloat zm_right;
@property (nonatomic) CGFloat zm_left;

@property (nonatomic) CGFloat zm_width;
@property (nonatomic) CGFloat zm_height;

@end
