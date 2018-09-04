//
//  MMWebViewAlert.m
//  Sierra
//
//  Created by 卓明 on 2017/10/12.
//  Copyright © 2017年 zhuoming. All rights reserved.
//

#import "MMWebViewAlert.h"
#import <Masonry/Masonry.h>
#import "prefixHeader.h"

@implementation MMWebViewAlert


- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        self.type = MMPopupTypeAlert;
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_WIDTH-30);
            make.height.mas_equalTo(SCREENH_HEIGHT * 0.8);
        }];
        _lbTitle = [UILabel new];
        _lbTitle.text = @"购买协议";
        _lbTitle.textColor = Black51Color;
        [self addSubview:_lbTitle];
        
        _webView = [[UIWebView alloc]init];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
        [self addSubview:_webView];
        
        
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(20);
            make.centerX.mas_equalTo(self);
        }];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self.lbTitle.mas_bottom).offset(5);
            make.bottom.mas_equalTo(self).offset(-44);
        }];
        
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage mm_imageWithColor:self.backgroundColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage mm_imageWithColor:[UIColor zm_colorWithHexString:@"#EFEDE7"]] forState:UIControlStateHighlighted];
        [btn setTitle:@"不同意" forState:UIControlStateNormal];
        // #E76153  #333333
        [btn setTitleColor:[UIColor zm_colorWithHexString:@"#E76153"] forState:UIControlStateNormal];
        btn.layer.borderWidth = MM_SPLIT_WIDTH;
        btn.layer.borderColor = [UIColor zm_colorWithHexString:@"#CCCCCC"].CGColor;
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        
        UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn1 setBackgroundImage:[UIImage mm_imageWithColor:self.backgroundColor] forState:UIControlStateNormal];
        [btn1 setBackgroundImage:[UIImage mm_imageWithColor:[UIColor zm_colorWithHexString:@"#EFEDE7"]] forState:UIControlStateHighlighted];
        [btn1 setTitle:@"同意" forState:UIControlStateNormal];
        // #E76153  #333333
        [btn1 setTitleColor:BaseColor forState:UIControlStateNormal];
        btn1.layer.borderWidth = MM_SPLIT_WIDTH;
        btn1.layer.borderColor = [UIColor zm_colorWithHexString:@"#CCCCCC"].CGColor;
        btn1.titleLabel.font = [UIFont systemFontOfSize:17];
        
        [btn addTarget:self action:@selector(hideAction) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        [self addSubview:btn1];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(self);
            make.width.mas_equalTo(self).multipliedBy(0.5);
            make.height.mas_equalTo(44);
        }];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(self);
            make.width.height.mas_equalTo(btn);
        }];
    }
    return self;
}

- (void)hideAction
{
    [self hide];
    if (_callback) {
        _callback(NO);
    }
}

- (void)sureAction
{
    [self hide];
    if (_callback) {
        _callback(YES);
    }
}

@end
