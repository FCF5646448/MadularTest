//
//  UIImage+ZMColor.h
//  Sierra
//
//  Created by 刘卓明 on 16/12/7.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZMColor)
/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *  @param size  大小 留空则为 1x1
 *
 *  @return 纯色图片
 */
+ (UIImage *)zm_imageWithColor:(UIColor *)color withSize:(CGSize)size;
/**
 *  @brief  取图片某一点的颜色
 *
 *  @param point 某一点
 *
 *  @return 颜色
 */
- (UIColor *)zm_colorAtPoint:(CGPoint )point;
//more accurate method ,colorAtPixel 1x1 pixel
/**
 *  @brief  取某一像素的颜色
 *
 *  @param point 一像素
 *
 *  @return 颜色
 */
- (UIColor *)zm_colorAtPixel:(CGPoint)point;
/**
 *  @brief  返回该图片是否有透明度通道
 *
 *  @return 是否有透明度通道
 */
- (BOOL)zm_hasAlphaChannel;

/**
 *  @brief  获得灰度图
 *
 *  @param sourceImage 图片
 *
 *  @return 获得灰度图片
 */
+ (UIImage*)zm_covertToGrayImageFromImage:(UIImage*)sourceImage;


/**
 根据颜色创作渐变色图片

 @param colors 颜色数组
 @param imgSize 图片尺寸
 @return 渐变色图片
 */
+ (UIImage *)getGradientImageWithColors:(NSArray*)colors imgSize:(CGSize)imgSize;

/**
 获取平均色

 @param image 图片
 @return 平均色
 */
+ (UIColor *)averageColorOfImage:(UIImage*)image;


@end
