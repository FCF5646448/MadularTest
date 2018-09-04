//
//  HUBManager.h
//  Sierra
//
//  Created by 卓明 on 2017/2/16.
//  Copyright © 2017年 zhuoming. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 为了统一管理 各种样式 在调用SVHud
 */
@interface HUBManager : NSObject
@property (assign, nonatomic) BOOL isCustom;// 是否是自定义的loading 样式
@property (strong, nonatomic) UIImageView * imageview;
@property (assign, nonatomic) UIInterfaceOrientation orientation;// 是否转屏

+(instancetype)sharedManager;

/************************** V2.0 ************************/
+ (void)showWaterLoading;
+ (void)dismissWaterLoading;
+ (void)showWaterLoadingWithString:(NSString *)string;

/************************** V1.0 ************************/
/**
 显示小圆圈
 */
+ (void)showSmall;
+ (void)showStatu:(NSString *)statu;
+ (void)showSmallWithStatus:(NSString *)statu;
/**
 自己写的view  会主动消失
 @param imageName 图片名
 */
+ (void)showImageView:(NSString *)imageName;

+ (void)showProgress:(CGFloat)progress;
+ (void)dismiss;
//显示小圆圈但不让用户操作
+ (void)showSmallWithoutTouch;
//+ (void)showWithStatus:(NSString *)statu;
+ (void)pop;
// 自定义的图标
+ (void)showCustomSuccess:(NSString *)info;
+ (void)showCustomError:(NSString *)error;
// 默认图标
+ (void)showSuccess:(NSString *)info;
+ (void)showError:(NSString *)error;
+ (void)setUpCustom;
+ (void)setUpDefault;
@end
