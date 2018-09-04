//
//  MMTitlePicker.h
//  Sierra
//
//  Created by 卓明 on 2017/3/21.
//  Copyright © 2017年 zhuoming. All rights reserved.
//

#import "MMPopupView.h"

@interface MMTitlePicker : MMPopupView
@property (strong, nonatomic) UIPickerView * picker;
@property (strong, nonatomic) NSArray * titles;
@property (copy, nonatomic) NSString * selectTitle;
- (instancetype)initWithTitles:(NSArray *)titles;
@end
