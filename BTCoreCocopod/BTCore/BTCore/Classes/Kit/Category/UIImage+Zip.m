//
//  UIImage+Zip.m
//  Sierra
//
//  Created by 卓明 on 2018/1/31.
//  Copyright © 2018年 zhuoming. All rights reserved.
//

#import "UIImage+Zip.h"

@implementation UIImage (Zip)
//==========================
// 图像压缩
//==========================


- (NSData *)zm_zipWith:(NSInteger)maxFileSize{
    CGFloat compression = 0.7f;
    NSData *compressedData = UIImageJPEGRepresentation(self, compression);
    NSLog(@"初步压缩 %lu",(unsigned long)compressedData.length);
    while ([compressedData length] > maxFileSize) {
        compression *= 0.7;
        compressedData = UIImageJPEGRepresentation([self zm_compressImage:self newWidth:self.size.width*compression], compression);
    }
    NSLog(@"最后压缩 %lu",(unsigned long)compressedData.length);
    return compressedData;
}


/**
 压图片质量
 
 @param image image
 @return Data
 */
- (NSData *)zm_zip
{

    CGFloat maxFileSize = 200*1024;
    return [self  zm_zipWith:maxFileSize];
}

/**
 *  等比缩放本图片大小
 *
 *  @param newImageWidth 缩放后图片宽度，像素为单位
 *
 *  @return self-->(image)
 */
- (UIImage *)zm_compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth
{
    if (!image) return nil;
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = newImageWidth;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}





@end
