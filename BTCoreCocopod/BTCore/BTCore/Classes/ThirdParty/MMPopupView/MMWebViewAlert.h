//
//  MMWebViewAlert.h
//  Sierra
//
//  Created by 卓明 on 2017/10/12.
//  Copyright © 2017年 zhuoming. All rights reserved.
//

#import "MMPopupView.h"

typedef void(^WebViewAlertCallback)(BOOL result);

@interface MMWebViewAlert : MMPopupView<UIWebViewDelegate>
@property (nonatomic , strong) UILabel * lbTitle;// 标题 购买协议
@property (nonatomic , strong) UIWebView * webView;//
@property (nonatomic , copy) WebViewAlertCallback callback;//回调
@end
