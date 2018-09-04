//
//  UIView+ThumbnailImage.h
//  Sierra
//
//  Created by 冯才凡 on 2018/5/23.
//  Copyright © 2018年 zhuoming. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface UIView (ThumbnailImage)
- (UIImage *)getThumbnailImageFromAsset:(AVURLAsset *)asset time:(NSTimeInterval )videoTime;

- (UIImage *)getThumbnailImageFromVideoURL:(NSString *)urlStr isLocal:(BOOL)local time:(NSTimeInterval )videoTime;

-(UIImage *)currentScreenShotView:(CGRect)rect;

@end
