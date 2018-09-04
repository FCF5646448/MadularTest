//
//  MMAlertView.h
//  MMPopupView
//
//  Created by Ralph Li on 9/6/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import "MMPopupView.h"
#import "MMPopupDefine.h"

typedef void(^MMPopupInputHandler)(NSString *text);

@interface MMAlertView : MMPopupView
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *detailLabel;
@property (nonatomic, strong) UILabel     *checkLabel;
@property (nonatomic, strong) UIButton    *checkButton;
@property (nonatomic, assign) NSUInteger maxInputLength;    // default is 0. Means no length limit.
@property (assign, nonatomic) BOOL isvolatile;// 是否竖排
@property (assign, nonatomic) BOOL check;// 是否选择



- (instancetype) initWithInputTitle:(NSString*)title
                             detail:(NSString*)detail
                        placeholder:(NSString*)inputPlaceholder
                            handler:(MMPopupInputHandler)inputHandler;

- (instancetype) initWithConfirmTitle:(NSString*)title
                               detail:(NSString*)detail;

- (instancetype) initWithTitle:(NSString*)title
                        detail:(NSString*)detail
                         items:(NSArray*)items;

// 添加一个竖排的// 默认的是超过三个
- (instancetype) initWithTitle:(NSString*)title
                        detail:(NSString*)detail
                         items:(NSArray*)items
                      vertical:(BOOL)vertical;

//  添加一个check
- (instancetype)initWithTitle:(NSString *)title
                       detail:(NSString *)detail
                        items:(NSArray *)items
             inputPlaceholder:(NSString *)inputPlaceholder
                 inputHandler:(MMPopupInputHandler)inputHandler
                    needCheck:(BOOL)check
                   checkTitle:(NSString *)checkTitle;

     

@end



/**
 *  Global Configuration of MMAlertView.
 */
@interface MMAlertViewConfig : NSObject

+ (MMAlertViewConfig*) globalConfig;

@property (nonatomic, assign) CGFloat width;                // Default is 275.
@property (nonatomic, assign) CGFloat buttonHeight;         // Default is 50.
@property (nonatomic, assign) CGFloat innerMargin;          // Default is 15.
@property (nonatomic, assign) CGFloat innerMarginLeft;      // Default is 22.5.
@property (nonatomic, assign) CGFloat cornerRadius;         // Default is 5.

@property (nonatomic, assign) CGFloat titleFontSize;        // Default is 18.
@property (nonatomic, assign) CGFloat detailFontSize;       // Default is 14.
@property (nonatomic, assign) CGFloat buttonFontSize;       // Default is 17.

@property (nonatomic, strong) UIColor *backgroundColor;     // Default is #FFFFFF.
@property (nonatomic, strong) UIColor *titleColor;          // Default is #333333.
@property (nonatomic, strong) UIColor *detailColor;         // Default is #333333.
@property (nonatomic, strong) UIColor *splitColor;          // Default is #CCCCCC.
@property (nonatomic, strong) UIColor *checkColor;          // Default is #999999.
// 按钮颜色
@property (nonatomic, strong) UIColor *itemNormalColor;     // Default is 蓝#01A0EB. effect with MMItemTypeNormal
@property (nonatomic, strong) UIColor *itemDisableColor;    // Default is 灰#999999. effect with MMItemTypeDisabled
@property (nonatomic, strong) UIColor *itemHighlightColor;  // Default is 蓝#01A0EB. effect with MMItemTypeHighlight
@property (nonatomic, strong) UIColor *itemDangerColor;     // Default is 红#FB3857. effect with MMItemTypeDanger
@property (nonatomic, strong) UIColor *itemPressedColor;    // Default is #EFEDE7.
// 夜间模式按钮颜色
@property (nonatomic, strong) UIColor *itemNormalColor_N;     // Default is 蓝#01A0EB. effect with MMItemTypeNormal
@property (nonatomic, strong) UIColor *itemDisableColor_N;    // Default is 灰#999999. effect with MMItemTypeDisabled
@property (nonatomic, strong) UIColor *itemHighlightColor_N;  // Default is 蓝#01A0EB. effect with MMItemTypeHighlight
@property (nonatomic, strong) UIColor *itemDangerColor_N;     // Default is 红#FB3857. effect with MMItemTypeDanger
@property (nonatomic, strong) UIColor *itemPressedColor_N;    // Default is #EFEDE7.
// 默认button title
@property (nonatomic, strong) NSString *defaultTextOK;      // Default is "好".
@property (nonatomic, strong) NSString *defaultTextCancel;  // Default is "取消".
@property (nonatomic, strong) NSString *defaultTextConfirm; // Default is "确定".


// 加个夜间模式
@property (nonatomic, strong) UIColor *backgroundColor_Night;     // Default is #666666.
@property (nonatomic, strong) UIColor *titleColor_Night;          // Default is #f5f5f5.
@property (nonatomic, strong) UIColor *detailColor_Night;         // Default is #f5f5f5.
@property (nonatomic, strong) UIColor *splitColor_Night;          // Default is #666666.
@property (nonatomic, strong) UIColor *btnSplitColor_Night;       // Default is #666666.
@property (nonatomic, strong) UIColor *checkColor_Night;          // Default is #999999.




- (UIColor *)colorForType:(MMPopupItem *)item night:(BOOL)night;
@end
