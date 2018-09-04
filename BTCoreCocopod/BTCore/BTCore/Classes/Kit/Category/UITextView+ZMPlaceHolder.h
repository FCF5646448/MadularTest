//
//  UITextView+ZMPlaceHolder.h
//  Sierra
//
//  Created by 刘卓明 on 16/12/27.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (ZMPlaceHolder)<UITextViewDelegate>
@property (nonatomic, strong) UITextView *zm_placeHolderTextView;
//@property (nonatomic, assign) id <UITextViewDelegate> textViewDelegate;
- (void)zm_addPlaceHolder:(NSString *)placeHolder;

@end
