//
//  MMImageAlert.h
//  Sierra
//
//  Created by 卓明 on 2017/3/23.
//  Copyright © 2017年 zhuoming. All rights reserved.
//

#import "MMPopupView.h"

@interface MMImageAlert : MMPopupView

@property (strong, nonatomic) UIImageView * imageView;
@property (strong, nonatomic) UILabel * lbtitle;
- (instancetype)initWithTitle:(NSString *)title andImageName:(NSString *)imageName;
@end
