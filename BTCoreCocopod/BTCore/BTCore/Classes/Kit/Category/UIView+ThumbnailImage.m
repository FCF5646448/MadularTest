//
//  UIView+ThumbnailImage.m
//  Sierra
//
//  Created by 冯才凡 on 2018/5/23.
//  Copyright © 2018年 zhuoming. All rights reserved.
//

#import "UIView+ThumbnailImage.h"


@implementation UIView (ThumbnailImage)
- (UIImage *)getThumbnailImageFromAsset:(AVURLAsset *)asset time:(NSTimeInterval )videoTime{
    if (asset == nil) {
        return nil;
    }
    AVAssetImageGenerator * gen = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    
    NSError *error=nil;
    CMTime time = CMTimeMakeWithSeconds(videoTime, 10);//CMTime是表示电影时间信息的结构体，第一个参数表示是视频第几秒，第二个参数表示每秒帧数.(如果要活的某一秒的第几帧可以使用CMTimeMake方法)
    CMTime actualTime;
    NSLog(@"## copyCGImageAtTime before");
    CGImageRef cgImage= [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    NSLog(@"## copyCGImageAtTime end");
    if(error){
        
        NSLog(@"截取视频缩略图时发生错误，错误信息：%@",error.localizedDescription);
        
        return nil;
    }
    
    UIImage *image=[UIImage imageWithCGImage:cgImage];//转化为UIImage
    
    CGImageRelease(cgImage);
    
    return image;
}


- (UIImage *)getThumbnailImageFromVideoURL:(NSString *)urlStr isLocal:(BOOL)local time:(NSTimeInterval )videoTime {
    NSURL * url;
    if (local) {
        //本地
        url = [[NSURL alloc] initFileURLWithPath:urlStr];
    }else{
        //远程
        url = [NSURL URLWithString:urlStr];
    }
    AVURLAsset * asset = [AVURLAsset assetWithURL:url];
    return [self getThumbnailImageFromAsset:asset time:videoTime];
    
}



#pragma mark - 截屏
- (void)replaceDownscaledPath{
    
//    NSString * dirPath = [NSString stringWithFormat:@"%@/Snapshots/%@",[FileManage cachesDir],[NSBundle mainBundle].bundleIdentifier];
//    NSArray * fileArr = [FileManage listFilesInDirectoryAtPath:dirPath deep:NO];
//    ZMLog(@"%@",fileArr);
//    // 用第二张替换第一张
//    if (fileArr.count == 5) {
//        fileArr = [fileArr sortedArrayUsingSelector:@selector(compare:)];
//        NSString * first = fileArr[0];
//        NSString * seconde = fileArr[1];
//        NSError * error;
//        BOOL success = YES;
//        success = [FileManage copyItemAtPath:[NSString stringWithFormat:@"%@/%@",dirPath,seconde] toPath:[NSString stringWithFormat:@"%@/%@",dirPath,first] overwrite:YES error:&error];
//        if (success) {
//            ZMLog(@"替换成功");
//        }
//        
//    }
    
    
}



//传入需要截取的view
-(UIImage *)currentScreenShotView:(CGRect)rect {
    
//    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
//    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
    
    
//    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
//    [self drawViewHierarchyInRect:rect afterScreenUpdates:YES];
//    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return finalImage;
    
    UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, YES, 2.0f);
    [self.window drawViewHierarchyInRect:self.window.bounds afterScreenUpdates:YES];
    UIImage *finalImage                 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
    
//    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
//
//    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
//        [subView drawViewHierarchyInRect:subView.frame afterScreenUpdates:NO];
//    }];
//    UIImage *screenCaptureImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return screenCaptureImage;
    
//    UIImage *imageRet = [[UIImage alloc]init];
//    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
////    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
//    imageRet = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return imageRet;
}

@end
