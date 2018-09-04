//
//  UINavigationBar+ZMClearBar.m
//  Sierra
//
//  Created by 刘卓明 on 16/12/6.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import "UINavigationBar+ZMClearBar.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@implementation UINavigationBar (ZMClearBar)
static char overlayKey;
// navigationBar 底部的线
static char lineKey;


- (UIView *)line
{
    return objc_getAssociatedObject(self, &lineKey);
}

- (void)setLine:(UIView *)line
{
    objc_setAssociatedObject(self, &lineKey, line, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)zm_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        
        if (self.subviews.count>0) {
            [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
            
            self.overlay.userInteractionEnabled = NO;
            self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight`
            [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
            [self.overlay mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.mas_equalTo(self.overlay.superview);
                //            make.height.mas_equalTo(self.overlay.superview).offset(20);
            }];
        }
        
    }
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")] || [obj isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            self.line = obj.subviews[1];
            self.line.hidden = YES;
        }
    }];
    
    
    
    self.overlay.backgroundColor = backgroundColor;
}

- (void)zm_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)zm_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
       
    }];
    
    
    
    
}

- (void)zm_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

@end
