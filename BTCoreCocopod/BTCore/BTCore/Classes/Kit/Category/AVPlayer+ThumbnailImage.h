//
//  AVPlayer+ThumbnailImage.h
//  Sierra
//
//  Created by 卓明 on 2018/5/23.
//  Copyright © 2018年 zhuoming. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AVPlayer (ThumbnailImage)
- (UIImage *)getThumbnailImageFromVideoURL:(NSURL *)URL time:(NSTimeInterval )videoTime;
- (UIImage *)getThumbnailImageFromFilePath:(NSString *)videoPath time:(NSTimeInterval )videoTime;
@end
