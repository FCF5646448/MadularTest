//
//  MMCouponAlert.h
//  Sierra
//
//  Created by 卓明 on 2017/3/23.
//  Copyright © 2017年 zhuoming. All rights reserved.
//

#import "MMPopupView.h"

/**
 优惠券
 */
typedef void(^MMCouponAlertBlock)(NSString * code);

@interface MMCouponAlert : MMPopupView

@property (strong, nonatomic) UILabel * lbtitle;
@property (strong, nonatomic) UILabel * lbLeft;
@property (strong, nonatomic) UILabel * lbnoti;
@property (strong, nonatomic) UITextField * tfContent;
@property (strong, nonatomic) UIButton * btnUnlock;
@property (strong, nonatomic) UIButton * btnGetCode;// 获取优惠码

@property (strong, nonatomic) UIView * middleView;
@property (copy, nonatomic) MMCouponAlertBlock unlockCallback;
@property (copy, nonatomic) MMCouponAlertBlock getCodeCallback;

@property (assign, nonatomic) BOOL  useable;
- (void)showErrorWith:(NSString *)str;
@end
