//
//  MMSheetView.h
//  MMPopupView
//
//  Created by Ralph Li on 9/6/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import "MMPopupView.h"
#import "MMPopupDefine.h"

@interface MMSheetView : MMPopupView
@property (nonatomic, strong) UIView      *titleView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UIView      *buttonView;
@property (nonatomic, strong) UIButton    *cancelButton;

@property (nonatomic, strong) NSArray     *actionItems;

- (instancetype) initWithTitle:(NSString*)title
                         items:(NSArray*)items;

@end


/**
 *  Global Configuration of MMSheetView.
 */
@interface MMSheetViewConfig : NSObject

+ (MMSheetViewConfig*) globalConfig;

@property (nonatomic, assign) CGFloat buttonHeight;         // Default is 50.
@property (nonatomic, assign) CGFloat innerMargin;          // Default is 19.

@property (nonatomic, assign) CGFloat titleFontSize;        // Default is 14.
@property (nonatomic, assign) CGFloat buttonFontSize;       // Default is 17.

@property (nonatomic, strong) UIColor *backgroundColor;     // Default is #FFFFFF.
@property (nonatomic, strong) UIColor *titleColor;          // Default is #666666.
@property (nonatomic, strong) UIColor *splitColor;          // Default is #CCCCCC.

@property (nonatomic, strong) UIColor *itemNormalColor;     // Default is 蓝#01A0EB. effect with MMItemTypeNormal
@property (nonatomic, strong) UIColor *itemDisableColor;    // Default is 灰#999999. effect with MMItemTypeDisabled
@property (nonatomic, strong) UIColor *itemHighlightColor;  // Default is 蓝#01A0EB. effect with MMItemTypeHighlight
@property (nonatomic, strong) UIColor *itemDangerColor;     // Default is 红#FB3857. effect with MMItemTypeDanger
@property (nonatomic, strong) UIColor *itemPressedColor;    // Default is #EFEDE7.

@property (nonatomic, strong) NSString *defaultTextCancel;  // Default is "取消"
- (UIColor *)colorForType:(MMPopupItem *)item;
@end
