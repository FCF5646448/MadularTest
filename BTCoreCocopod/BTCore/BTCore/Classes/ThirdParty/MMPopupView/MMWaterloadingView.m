//
//  MMWaterloadingView.m
//  Sierra
//
//  Created by 卓明 on 2017/6/1.
//  Copyright © 2017年 zhuoming. All rights reserved.
//

#import "MMWaterloadingView.h"
#import "AJWaveRefreshAnimation.h"
#import <Masonry/Masonry.h>

@interface MMWaterloadingView()

@end

@implementation MMWaterloadingView

- (instancetype)init
{
    if (self = [super init]) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_equalTo(100);
            }];
            //设置类型
            self.type = MMPopupTypeCustom;
            self.touchToDismiss = NO;
            self.attachedView.backgroundColor = [UIColor clearColor];
            self.backgroundColor = [UIColor clearColor];
            
        }];
    }
    return self;
}

- (void)show
{
    [MMPopupWindow sharedWindow].attachView.mm_dimBackgroundView.backgroundColor = [UIColor clearColor];
    [super show];
}

- (void)hide
{
    [MMPopupWindow sharedWindow].attachView.mm_dimBackgroundView.backgroundColor = MMHexColor(0x0000007F);
    [super hide];
}

@end
