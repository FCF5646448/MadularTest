//
//  MMActionItem.h
//  MMPopupView
//
//  Created by Ralph Li on 9/6/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, MMItemType) {
    MMItemTypeNormal,
    MMItemTypeHighlight,
    MMItemTypeDisabled,
    MMItemTypeDanger
};

typedef void(^MMPopupItemHandler)(NSInteger index);

@interface MMPopupItem : NSObject

@property (nonatomic, assign) MMItemType    type;
@property (nonatomic, strong) NSString      *title;
@property (nonatomic, strong) UIColor       *color;
@property (nonatomic, strong) UIColor       *color_Night;// 夜间颜色
@property (nonatomic, copy)   MMPopupItemHandler handler;

@end



NS_INLINE MMPopupItem* MMItemMake(NSString* title, MMItemType type, MMPopupItemHandler handler)
{
    MMPopupItem *item = [MMPopupItem new];
    item.type = type;
    item.title = title;
    item.handler = handler;
    
    return item;
}
