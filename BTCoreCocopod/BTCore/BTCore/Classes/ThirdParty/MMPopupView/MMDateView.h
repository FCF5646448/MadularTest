//
//  MMDateView.h
//  MMPopupView
//
//  Created by Ralph Li on 9/7/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import "MMPopupView.h"

@interface MMDateView : MMPopupView

@property (copy, nonatomic) MMPopupBlock  sureActionBlock;
@property (nonatomic, strong) UIDatePicker *datePicker;

@end
