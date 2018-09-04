//
//  BTCoreTestFramework.h
//  BTCoreTestFramework
//
//  Created by 冯才凡 on 2018/8/31.
//  Copyright © 2018年 冯才凡. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for BTCoreTestFramework.
FOUNDATION_EXPORT double BTCoreTestFrameworkVersionNumber;

//! Project version string for BTCoreTestFramework.
FOUNDATION_EXPORT const unsigned char BTCoreTestFrameworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <BTCoreTestFramework/PublicHeader.h>

//所有需要在swift上使用或者要对外暴露的头文件都放在这里
#import <BTCoreTestFramework/BaseViewController.h>



#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上
#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define SCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#endif
