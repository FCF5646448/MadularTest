//
//  UIImage+Zip.h
//  Sierra
//
//  Created by 卓明 on 2018/1/31.
//  Copyright © 2018年 zhuoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Zip)
- (NSData *)zm_zip;
- (NSData *)zm_zipWith:(NSInteger)maxFileSize;
@end
