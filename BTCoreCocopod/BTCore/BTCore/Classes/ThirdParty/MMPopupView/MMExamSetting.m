//
//  MMExamSetting.m
//  Sierra
//
//  Created by 卓明 on 2017/3/27.
//  Copyright © 2017年 zhuoming. All rights reserved.
//

#import "MMExamSetting.h"
#import <Masonry/Masonry.h>
#import "prefixHeader.h"

@implementation MMExamSetting

- (instancetype)init
{
    if (self = [super init]) {
        
        self.type = MMPopupTypeSheet;
        
        self.backgroundColor = [UIColor whiteColor];
//        [[UISwitch appearance] setTintColor:[UIColor zm_colorWithWholeRed:155 green:155 blue:155]];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(224);
        }];
        
        
        
        _lbleft = [UILabel new];
        _lbleft.text = @"设置";
        _lbleft.font = [UIFont systemFontOfSize:15];
        _lbleft.textColor = [UIColor zm_colorWithWholeRed:155 green:155 blue:155];
        [self addSubview:_lbleft];
        [_lbleft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self).offset(15);
        }];
        
        _btnSure = [UIButton new];
        [_btnSure setTitle:@"完成" forState:UIControlStateNormal];
        _btnSure.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnSure setTitleColor:BaseColor forState:UIControlStateNormal];
        [self addSubview:_btnSure];
        [_btnSure addTarget:self action:@selector(btnSureAction) forControlEvents:UIControlEventTouchUpInside];
        [_btnSure mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_equalTo(self);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(50);
        }];
        
        UIView * line = [UIView new];
        line.backgroundColor = [UIColor zm_colorWithWholeRed:219 green:219 blue:219];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(_btnSure.mas_bottom);
            make.right.mas_equalTo(self).offset(-15);
            make.height.mas_equalTo(0.5);
        }];
        
        _lbnext = [UILabel new];
        _lbnext.text = @"自动跳转下一题";
        _lbnext.font = [UIFont systemFontOfSize:17];
        _lbnext.textColor = Black51Color        ;
        [self addSubview:_lbnext];
        [_lbnext mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.height.mas_equalTo(50);
            make.top.mas_equalTo(_btnSure.mas_bottom).offset(0.5);
        }];
        
        _nextSwitch = [UISwitch new];
//        _nextSwitch.thumbTintColor = [UIColor whiteColor];
        _nextSwitch.tintColor = [UIColor zm_colorWithWholeRed:219 green:219 blue:219];
        _nextSwitch.onTintColor = BaseColor;
        [self addSubview:_nextSwitch];
        [_nextSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-15);
            make.centerY.mas_equalTo(_lbnext);
        }];
        UIView * line1 = [UIView new];
        line1.backgroundColor = [UIColor zm_colorWithWholeRed:219 green:219 blue:219];
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(_lbnext.mas_bottom);
            make.right.mas_equalTo(self).offset(-15);
            make.height.mas_equalTo(0.5);
        }];
        
        
        
        
        _lbauto = [UILabel new];
        _lbauto.text = @"自动展开解释";
        _lbauto.font = [UIFont systemFontOfSize:17];
        _lbauto.textColor = Black51Color;
        [self addSubview:_lbauto];
        [_lbauto mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.height.mas_equalTo(50);
            make.top.mas_equalTo(_lbnext.mas_bottom).offset(0.5);
        }];
        
        _autoSwitch = [UISwitch new];
        _autoSwitch.tintColor = [UIColor zm_colorWithWholeRed:219 green:219 blue:219];
        _autoSwitch.onTintColor = BaseColor;
        [self addSubview:_autoSwitch];
        [_autoSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-15);
            make.centerY.mas_equalTo(_lbauto);
        }];
        UIView * line2 = [UIView new];
        line2.backgroundColor = [UIColor zm_colorWithWholeRed:219 green:219 blue:219];
        [self addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(_lbauto.mas_bottom);
            make.right.mas_equalTo(self).offset(-15);
            make.height.mas_equalTo(0.5);
        }];
    
    }
    return self;
}


- (void)btnSureAction
{
    [self hide];
}

@end
