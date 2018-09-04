//
//  MMImageAlert.m
//  Sierra
//
//  Created by 卓明 on 2017/3/23.
//  Copyright © 2017年 zhuoming. All rights reserved.
//

#import "MMImageAlert.h"
#import "UIView+ZMCustromBorder.h"
#import <Masonry/Masonry.h>
#import "prefixHeader.h"

@interface MMImageAlert()<UITextFieldDelegate>

@end

@implementation MMImageAlert

- (instancetype)initWithTitle:(NSString *)title andImageName:(NSString *)imageName
{
    self = [super init];
    
    if ( self )
    {
        self.backgroundColor = [UIColor whiteColor];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(280);
            make.height.mas_equalTo(146);
        }];
        
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:_imageView];
        
        _lbtitle = [UILabel new];
        _lbtitle.text = title;
        _lbtitle.textColor = Black51Color;
        [self addSubview:_lbtitle];
        
        [_lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self).offset(-25);
            make.centerX.mas_equalTo(self);
        }];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(24);
            make.width.height.mas_equalTo(64);
            make.centerX.mas_equalTo(self);
        }];
    }
    
    return self;
}

- (void)actionHide
{
    [self hide];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self zm_setRoundedCorners:UIRectCornerAllCorners radius:10];
   
}

@end
