//
//  HUBManager.m
//  Sierra
//
//  Created by 卓明 on 2017/2/16.
//  Copyright © 2017年 zhuoming. All rights reserved.
//

#import "HUBManager.h"
#import "AJWaveRefreshAnimation.h"
#import "prefixHeader.h"

@interface HUBManager()

@property (strong, nonatomic) AJWaveRefreshAnimation  * waterlogo;// 是否转屏

@end

@implementation HUBManager

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static HUBManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[HUBManager alloc] init];
    });
    return instance;
}

- (AJWaveRefreshAnimation *)waterlogo
{
    if (_waterlogo) {
        return _waterlogo;
    }
    _waterlogo = [[AJWaveRefreshAnimation alloc] initWithFrame:CGRectMake(100, 100, 100, 100)
                                                     grayImage:[UIImage imageNamed:@"灰色loading"]
                                                      redImage:[UIImage imageNamed:@"蓝色loading"]];
    return _waterlogo;
}

- (void)setOrientation:(UIInterfaceOrientation)orientation
{
    _orientation = orientation;
    [SVProgressHUD sharedView].transform = CGAffineTransformIdentity;
    _waterlogo.transform = CGAffineTransformIdentity;
//    self.view.transform = CGAffineTransformIdentity;
//    self.view.transform = [self getTransformRotationAngle];
    if (orientation == UIInterfaceOrientationPortrait) {
        [SVProgressHUD sharedView].transform = CGAffineTransformIdentity;
        _waterlogo.transform = CGAffineTransformIdentity;
    } else if (orientation == UIInterfaceOrientationLandscapeLeft){
        [SVProgressHUD sharedView].transform =  CGAffineTransformMakeRotation(-M_PI_2);
        _waterlogo.transform = CGAffineTransformMakeRotation(-M_PI_2);
    } else if(orientation == UIInterfaceOrientationLandscapeRight){
        [SVProgressHUD sharedView].transform =  CGAffineTransformMakeRotation(M_PI_2);
        _waterlogo.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
}

/************************** V2.0 ************************/
// loding 水波
+ (void)showWaterLoading
{
    [self showWaterLoadingWithString:@"加载中"];
}
+ (void)showWaterLoadingWithString:(NSString *)string
{
    [SVProgressHUD dismiss];
    [HUBManager sharedManager].waterlogo.notiString = string;
    [[HUBManager sharedManager].waterlogo startAnimating];
    if ([HUBManager sharedManager].waterlogo.superview) {
        [KAppDelegate.window bringSubviewToFront:[HUBManager sharedManager].waterlogo];
    }else
    {
        [HUBManager sharedManager].waterlogo.frame = CGRectMake(0, 0,100, 100);
        [HUBManager sharedManager].waterlogo.center = kKeyWindow.center;
        [KAppDelegate.window addSubview:[HUBManager sharedManager].waterlogo];
    }
    
}
+ (void)dismissWaterLoading
{
    if ([HUBManager sharedManager].waterlogo.superview != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[HUBManager sharedManager].waterlogo stopAnimating];
            [[HUBManager sharedManager].waterlogo removeFromSuperview];
        });
//        if ([HUBManager sharedManager].waterlogo.times<3) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [[HUBManager sharedManager].waterlogo stopAnimating];
//                [[HUBManager sharedManager].waterlogo removeFromSuperview];
//            });
//        }else
//        {
//            
//        }
    }
    
}


/************************** V1.0 ************************/
/**
 显示小圆圈
 */
+ (void)showSmall
{
    [self setUpCustom];
    [SVProgressHUD showWithStatus:@"加载中"];
}

+ (void)showStatu:(NSString *)statu
{
    [self setUpDefault];
    [self dismiss];
    [SVProgressHUD showImage:nil status:statu];
}

+ (void)showSmallWithStatus:(NSString *)statu
{
    [self setUpCustom];
    [SVProgressHUD showWithStatus:statu];
}

/**
 自己写的view  会主动消失
 @param imageName 图片名
 */
+ (void)showImageView:(NSString *)imageName
{
    [HUBManager dismiss];
    if ([HUBManager sharedManager].imageview == nil) {
        [HUBManager sharedManager].imageview = [UIImageView new];
    }
    UIImage * image = [UIImage imageNamed:imageName];
    [HUBManager sharedManager].imageview.image = image;
    [HUBManager sharedManager].imageview.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [HUBManager sharedManager].imageview.center = kKeyWindow.center;
    [kKeyWindow addSubview:[HUBManager sharedManager].imageview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[HUBManager sharedManager].imageview removeFromSuperview];
    });
}




//显示小圆圈但不让用户操作
+ (void)showSmallWithoutTouch
{
    [self setUpCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:@"加载中"];
}

// 自定义的图标
+ (void)showCustomSuccess:(NSString *)info
{
    [self setUpDefault];
    
    [SVProgressHUD showImage:[UIImage imageNamed:@"btu_gou"] status:info];
}
+ (void)showCustomError:(NSString *)error
{
    [self setUpDefault];
    [SVProgressHUD showErrorWithStatus:error];
}

+ (void)showProgress:(CGFloat)progress
{
    [self setUpDefault];
    [SVProgressHUD showProgress:progress];
}

// 默认图标
+ (void)showSuccess:(NSString *)info
{
    
    [self setUpDefault];
    [HUBManager showStatu:info];
}

+ (void)showError:(NSString *)error
{
    [self setUpDefault];
    [SVProgressHUD showErrorWithStatus:error];
}

+ (void)pop
{
    [SVProgressHUD popActivity];
//    ZMLog(@"SVProgressHUD popActivity");
}

+ (void)dismiss
{
    [SVProgressHUD dismiss];
    [HUBManager dismissWaterLoading];
}

/**
 设置自定义样式  loading 样式
 */
+ (void)setUpCustom
{

    if ([HUBManager sharedManager].isCustom) {
        return;
    }
    [SVProgressHUD setMinimumDismissTimeInterval:15];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:14]];
    [SVProgressHUD setForegroundColor:[UIColor zm_colorWithHexString:@"#93D5F4"]];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setRingNoTextRadius:10];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [HUBManager sharedManager].isCustom = YES;
}

/**
 恢复默认样式 字体样式
 */
+ (void)setUpDefault
{
    if (![HUBManager sharedManager].isCustom) {
        return;
    }
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:16]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor zm_colorWithWholeRed:0 green:0 blue:0 alpha:0.7]];
    [SVProgressHUD setCornerRadius:4];
    [SVProgressHUD setRingNoTextRadius:15];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [HUBManager sharedManager].isCustom = NO;
}

@end
