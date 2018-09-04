//
//  UINavigationBar+ZMClearBar.h
//  Sierra
//
//  Created by 刘卓明 on 16/12/6.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (ZMClearBar)
- (void)zm_setBackgroundColor:(UIColor *)backgroundColor;
- (void)zm_setElementsAlpha:(CGFloat)alpha;
- (void)zm_setTranslationY:(CGFloat)translationY;
- (void)zm_reset;
@end
