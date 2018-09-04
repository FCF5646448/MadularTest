//
//  UIView+ZMMasonry.h
//  Sierra
//
//  Created by 刘卓明 on 16/12/7.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZMMasonry)
- (void) distributeSpacingHorizontallyWith:(NSArray*)views;
- (void) distributeSpacingVerticallyWith:(NSArray*)views;
@end
