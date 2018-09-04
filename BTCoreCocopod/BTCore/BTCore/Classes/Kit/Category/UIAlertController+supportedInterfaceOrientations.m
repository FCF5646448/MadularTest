//
//  UIAlertController+supportedInterfaceOrientations.m
//  ManagementSystem
//
//  Created by 实信腾 on 15/12/23.
//  Copyright © 2015年 Ida. All rights reserved.
//

#import "UIAlertController+supportedInterfaceOrientations.h"

@implementation UIAlertController (supportedInterfaceOrientations)
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 9000
-(NSUInteger)supportedInterfaceOrientations;{
    return UIInterfaceOrientationMaskPortrait;
}
#else
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
#endif
@end
