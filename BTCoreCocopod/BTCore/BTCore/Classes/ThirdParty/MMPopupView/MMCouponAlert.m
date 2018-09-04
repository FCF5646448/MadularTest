//
//  MMCouponAlert.m
//  Sierra
//
//  Created by 卓明 on 2017/3/23.
//  Copyright © 2017年 zhuoming. All rights reserved.
//

#import "MMCouponAlert.h"
#import "UIView+ZMCustromBorder.h"
#import "MMImageAlert.h"
#import <Masonry/Masonry.h>
#import "prefixHeader.h"

@interface MMCouponAlert()<UITextFieldDelegate>

@end

@implementation MMCouponAlert

- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        self.backgroundColor = [UIColor whiteColor];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(280);
            make.height.mas_greaterThanOrEqualTo(193);
        }];
        
        
        _middleView = [UIView new];
        [self addSubview:_middleView];

        
        _lbtitle = [UILabel new];
        _lbtitle.text = @"使用优惠码快速解锁";
        _lbtitle.textColor = Black51Color;
        [self addSubview:_lbtitle];
        
        _lbLeft = [UILabel new];
        _lbLeft.text = @"优惠码";
        _lbLeft.textColor = Black51Color;
        _lbLeft.backgroundColor = [UIColor zm_colorWithWholeRed:219 green:219 blue:219];
        _lbLeft.font = [UIFont systemFontOfSize:14];
        _lbLeft.textAlignment = NSTextAlignmentCenter;
        [_middleView addSubview:_lbLeft];
        
        _lbnoti = [UILabel new];
        _lbnoti.text = @"优惠码填写错误，请重新输入";
        _lbnoti.textColor = [UIColor zm_colorWithWholeRed:255 green:90 blue:90];
        _lbnoti.hidden = YES;
        _lbnoti.font = [UIFont systemFontOfSize:12];
        _lbnoti.numberOfLines = 3;
        _lbnoti.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbnoti];
        
        _tfContent = [UITextField new];
        [_middleView addSubview:_tfContent];
        
        _btnUnlock = [UIButton new];
        [_btnUnlock setTitle:@"解锁" forState:UIControlStateNormal];
        _btnUnlock.titleLabel.font = [UIFont systemFontOfSize:17];
        _btnUnlock.backgroundColor = _lbLeft.backgroundColor;
        [_btnUnlock addTarget:self action:@selector(lockAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnUnlock];
        
        _btnGetCode = [UIButton new];
        [_btnGetCode setTitle:@"获取优惠码 >" forState:UIControlStateNormal];
        [_btnGetCode setTitleColor:BaseColor forState:UIControlStateNormal];
        _btnGetCode.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnGetCode addTarget:self action:@selector(getcodeAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnGetCode];
        
        [_lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(20);
            make.centerX.mas_equalTo(self);
        }];
        [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_lbtitle.mas_bottom).offset(20);
            make.left.mas_equalTo(self).offset(15);
            make.centerX.mas_equalTo(self);
            make.height.mas_equalTo(35);
        }];
        
        [_lbLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_lbtitle.mas_bottom).offset(20);
            make.left.mas_equalTo(self).offset(15);
            make.width.mas_equalTo(72);
            make.height.mas_equalTo(35);
        }];
        
        [_lbnoti mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_middleView.mas_bottom).offset(2);
            make.centerX.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(15);
        }];
        
        [_tfContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(_lbLeft);
            make.left.mas_equalTo(_lbLeft.mas_right).offset(15);
            make.right.mas_equalTo(self).offset(-15);
        }];
        
        [_btnUnlock mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_lbnoti.mas_bottom).offset(15);
            make.left.mas_equalTo(self).offset(15);
            make.centerX.mas_equalTo(self);
            make.bottom.mas_equalTo(self).offset(-35);
        }];
        [_btnGetCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-15);
            make.bottom.mas_equalTo(self).offset(-3);
        }];
        
        
        [_tfContent addTarget:self action:@selector(textChnage:) forControlEvents:UIControlEventEditingChanged];
        
        
        //如果夜间模式
        if (dk_night) {
            self.dk_backgroundColorPicker = DKColorPickerWithKey(bgwhite);
            _lbtitle.dk_textColorPicker = DKColorPickerWithKey(text);
            _lbLeft.backgroundColor = [UIColor zm_colorWithHex:bt_4a4a4a];
            _lbLeft.textColor = [UIColor zm_colorWithHex:bt_f5f5f5];
            _btnUnlock.backgroundColor = [UIColor zm_colorWithHex:bt_4a4a4a];
            _tfContent.dk_textColorPicker = DKColorPickerWithKey(text);
            [_btnGetCode dk_setTitleColorPicker:DKColorPickerWithKey(basecolor) forState:UIControlStateNormal];
        }
        
    }
    
    return self;
}

- (void)textChnage:(UITextField *)tf
{
    self.useable = tf.text.length>0;
}


- (void)setUseable:(BOOL)useable
{
    if (useable) {
        if (dk_night) {
            _lbLeft.backgroundColor = [UIColor zm_colorWithHex:bt_base_n];
            _lbLeft.textColor = [UIColor whiteColor];
            _btnUnlock.backgroundColor = [UIColor zm_colorWithHex:bt_base_n];
        }else{
            _lbLeft.backgroundColor = BaseColor;
            _lbLeft.textColor = [UIColor whiteColor];
            _btnUnlock.backgroundColor = BaseColor;
        }
        self.touchToDismiss = NO;
        self.lbnoti.text = @"";
        self.btnUnlock.userInteractionEnabled = YES;
    }else
    {
        if (dk_night) {
            _lbLeft.backgroundColor = [UIColor zm_colorWithHex:bt_4a4a4a];
            _lbLeft.textColor = [UIColor zm_colorWithHex:bt_f5f5f5];
            _btnUnlock.backgroundColor = [UIColor zm_colorWithHex:bt_4a4a4a];
        }else{
            _lbLeft.backgroundColor = [UIColor zm_colorWithWholeRed:219 green:219 blue:219];
            _lbLeft.textColor = Black51Color;
            _btnUnlock.backgroundColor = [UIColor zm_colorWithWholeRed:219 green:219 blue:219];
        }
        self.touchToDismiss = YES;
        self.btnUnlock.userInteractionEnabled = NO;
    }
    
}

/**
 设置
 */
- (void)showErrorWith:(NSString *)str
{
    
    if (str.length>0) {
        self.useable = NO;
        self.lbnoti.hidden = NO;
        self.lbnoti.text = str;
    }
}

- (void)lockAction
{
    if (_tfContent.text.length<1) {
        _lbnoti.hidden = NO;
    }else
    {
        self.useable = NO;
        _lbnoti.hidden = YES;
        if (_unlockCallback) {
            ZMWeakSelf(self);
            self.unlockCallback(weakself.tfContent.text);
        }

    }
}

- (void)actionHide
{
    [self hide];
}

- (void)getcodeAction
{
    [self hide];
    if (_getCodeCallback) {
        self.getCodeCallback(nil);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self zm_setRoundedCorners:UIRectCornerAllCorners radius:10];
//    [_lbLeft zm_setRoundedCorners:UIRectCornerTopLeft radius:4];
//    [_lbLeft zm_setRoundedCorners:UIRectCornerBottomLeft radius:4];
//    [_lbLeft zm_addLeftBorderWithColor:_lbLeft.backgroundColor width:1];
    
    [_middleView zm_addAllBorderWithColor:dk_night?[UIColor zm_colorWithHex:0x535353]:[UIColor zm_colorWithHex:bt_dbdbdb] width:0.5 cornerRadius:4 lineType:nil];
    
    [_middleView zm_setRoundedCorners:UIRectCornerAllCorners radius:4];
    
    [_btnUnlock zm_setRoundedCorners:UIRectCornerAllCorners radius:4];
}




@end
