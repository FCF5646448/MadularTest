//
//  UITextView+ZMPlaceHolder.m
//  Sierra
//
//  Created by 刘卓明 on 16/12/27.
//  Copyright © 2016年 zhuoming. All rights reserved.
//
#import <objc/runtime.h>
#import "UITextView+ZMPlaceHolder.h"

static const char *zm_placeHolderTextView = "zm_placeHolderTextView";
@implementation UITextView (ZMPlaceHolder)

- (UITextView *)zm_placeHolderTextView {
    return objc_getAssociatedObject(self, zm_placeHolderTextView);
}
- (void)setzm_placeHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, zm_placeHolderTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)zm_addPlaceHolder:(NSString *)placeHolder {
    if (![self zm_placeHolderTextView]) {
        self.delegate = self;
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setzm_placeHolderTextView:textView];
    }
}
# pragma mark -
# pragma mark - UITextViewDelegate
//- (void)textViewDidBeginEditing:(UITextView *)textView {
//    self.zm_placeHolderTextView.hidden = YES;
//    // if (self.textViewDelegate) {
//    //
//    // }
//}
//- (void)textViewDidEndEditing:(UITextView *)textView {
//    if (textView.text && [textView.text isEqualToString:@""]) {
//        self.zm_placeHolderTextView.hidden = NO;
//    }
//}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self.zm_placeHolderTextView.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [self.zm_placeHolderTextView.delegate textView:self shouldChangeTextInRange:range replacementText:text];
    }
    
    return YES;
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.zm_placeHolderTextView.delegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        return [self.zm_placeHolderTextView.delegate textViewDidEndEditing:self.zm_placeHolderTextView];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
   self.zm_placeHolderTextView.hidden = textView.text.length;
}


@end
