//
//  MMCunstomView.h
//  Sierra
//
//  Created by 卓明 on 2018/8/13.
//  Copyright © 2018年 zhuoming. All rights reserved.
//

#import "MMAlertView.h"
/**
 灵活塞入view 弹框只负责显示和关闭 ，
 */
@interface MMCunstomView : MMPopupView
@property (strong, nonatomic) UILabel * lbtitle;
@property (strong, nonatomic, readonly) UIView * middleView;
@property (nonatomic, strong) UIView      *buttonView;
@property (assign, nonatomic) BOOL isvolatile;// 是否竖排
/**
 必须通过初始化来设置middleView

 @param middeleView 中间视图，宽度会被现实成弹框宽度
 @param height -1 代表自动适配
 @return 自定义弹框
 */
- (instancetype)initWithMiddleView:(UIView *)middeleView title:(NSString *)title height:(CGFloat)height andItems:(NSArray*)items;
@end
