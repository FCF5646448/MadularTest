//
//  SVProgressHUD+MoreImage.m
//  SVProgressHUD
//
//  Created by 卓明 on 2017/2/9.
//
//
#import <objc/runtime.h>
#import "SVProgressHUD+MoreImage.h"

@implementation SVProgressHUD (MoreImage)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        SEL originalSelector = @selector(showImage:status:duration:);
        SEL swizzledSelector = @selector(zmshowImage:status:duration:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL didAddMethod = class_addMethod(class,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling
- (void)zmshowImage:(UIImage*)image status:(NSString*)status duration:(NSTimeInterval)duration {
    [self zmshowImage:image status:status duration:duration];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        UIImageView * imageView = [self valueForKey:@"imageView"];
        imageView.image = image;
    }];
   
}




#pragma mark - Setters
//+ (void)setLoaingAnimationImages:(NSArray <UIImage *> *)images
//{
//    [SVProgressHUD setLoaingAnimationImages:images imageSize:CGSizeZero];
//}
//
//+ (void)setLoaingAnimationImages:(NSArray <UIImage *> *)images imageSize:(CGSize)size
//{
//    [SVProgressHUD sharedView].animateImages = images;
//    [self sharedView].animateImageSize = size;
//    [self sharedView].animateImageView.animationImages = images;
//    [self sharedView].animateImageView.animationDuration = images.count * 0.04;
//}


//- (void)showImage:(UIImage*)image status:(NSString*)status duration:(NSTimeInterval)duration {
//    __weak SVProgressHUD *weakSelf = self;
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//        __strong SVProgressHUD *strongSelf = weakSelf;
//        if(strongSelf){
//            // Update / Check view hierarchy to ensure the HUD is visible
//            [strongSelf updateViewHierarchy];
//            
//            // Reset progress and cancel any running animation
//            strongSelf.progress = SVProgressHUDUndefinedProgress;
//            [strongSelf cancelRingLayerAnimation];
//            [strongSelf cancelIndefiniteAnimatedViewAnimation];
//            
//            // Update imageView
//            UIColor *tintColor = strongSelf.foregroundColorForStyle;
//            UIImage *tintedImage = image;
//            if (image.renderingMode != UIImageRenderingModeAlwaysTemplate) {
//                tintedImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//            }
//            strongSelf.imageView.tintColor = tintColor;
//            strongSelf.imageView.image = tintedImage;
//            strongSelf.imageView.hidden = NO;
//            
//            // Update text
//            strongSelf.statusLabel.text = status;
//            
//            // Show
//            [strongSelf showStatus:status];
//            
//            // An image will dismissed automatically. Therefore we start a timer
//            // which then will call dismiss after the predefined duration
//            strongSelf.fadeOutTimer = [NSTimer timerWithTimeInterval:duration target:strongSelf selector:@selector(dismiss) userInfo:nil repeats:NO];
//            [[NSRunLoop mainRunLoop] addTimer:strongSelf.fadeOutTimer forMode:NSRunLoopCommonModes];
//        }
//    }];
//}

@end
