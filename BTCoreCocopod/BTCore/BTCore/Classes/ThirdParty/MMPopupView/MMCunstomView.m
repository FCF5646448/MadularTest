//
//  MMCunstomView.m
//  Sierra
//
//  Created by 卓明 on 2018/8/13.
//  Copyright © 2018年 zhuoming. All rights reserved.
//

#import "MMCunstomView.h"
#import <Masonry/Masonry.h>
#import "prefixHeader.h"


@interface MMCunstomView()
@property (nonatomic, strong) NSArray     *actionItems;
@end



@implementation MMCunstomView

- (instancetype)initWithMiddleView:(UIView *)middeleView title:(NSString *)title height:(CGFloat)height andItems:(NSArray*)items{
    self = [super init];
    
    if ( self )
    {
        self.actionItems = items;
        MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
        self.backgroundColor = [UIColor whiteColor];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(280);
//            make.height.mas_greaterThanOrEqualTo(100);
        }];
        MASViewAttribute *lastAttribute = self.mas_top;
        if (title != nil) {
            _lbtitle = [UILabel new];
            _lbtitle.text = title;
            _lbtitle.textAlignment = NSTextAlignmentCenter;
            _lbtitle.textColor = Black51Color;
            [self addSubview:_lbtitle];
            
            [_lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self).offset(10);
                make.left.right.mas_equalTo(self);
            }];
            // 垂直抗拉伸
            
            [_lbtitle setContentHuggingPriority:UILayoutPriorityRequired
                                           forAxis:UILayoutConstraintAxisVertical];
            UIView * line = [UIView new];
            line.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1/1.0];
            [self addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_lbtitle.mas_bottom).mas_offset(10);
                make.left.right.mas_equalTo(self);
                make.height.mas_equalTo(1);
            }];
            lastAttribute = line.mas_bottom;
           
        }
        if (middeleView != nil) {
            _middleView = middeleView;
            [self addSubview:middeleView];
            [middeleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lastAttribute);
                make.left.right.mas_equalTo(self);
                if (height>0) {
                    make.height.mas_equalTo(height);
                }
            }];
            lastAttribute = middeleView.mas_bottom;
        }
        



        self.buttonView = [UIView new];
        [self addSubview:self.buttonView];
        [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute);
            make.left.right.equalTo(self);
        }];

        __block UIButton *firstButton = nil;
        __block UIButton *lastButton = nil;
        for ( NSInteger i = 0 ; i < items.count; ++i )
        {
            MMPopupItem *item = items[i];

            UIButton *btn = [UIButton mm_buttonWithTarget:self action:@selector(actionButton:)];
            [self.buttonView addSubview:btn];
            btn.tag = i;

            [btn mas_makeConstraints:^(MASConstraintMaker *make) {

                if ( items.count <= 2 && _isvolatile == NO)
                {
                    make.top.bottom.equalTo(self.buttonView);
                    make.height.mas_equalTo(config.buttonHeight);

                    if ( !firstButton )
                    {
                        firstButton = btn;
                        make.left.equalTo(self.buttonView.mas_left).offset(-MM_SPLIT_WIDTH);
                    }
                    else
                    {
                        make.left.equalTo(lastButton.mas_right).offset(-MM_SPLIT_WIDTH);
                        make.width.equalTo(firstButton);
                    }
                }
                else
                {
                    make.left.right.equalTo(self.buttonView);
                    make.height.mas_equalTo(config.buttonHeight);

                    if ( !firstButton )
                    {
                        firstButton = btn;
                        make.top.equalTo(self.buttonView.mas_top).offset(-MM_SPLIT_WIDTH);
                    }
                    else
                    {
                        make.top.equalTo(lastButton.mas_bottom).offset(-MM_SPLIT_WIDTH);
                        make.width.equalTo(firstButton);
                    }
                }

                lastButton = btn;
            }];
            [btn setBackgroundImage:[UIImage mm_imageWithColor:self.backgroundColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage mm_imageWithColor:dk_night?config.itemPressedColor_N:config.itemPressedColor] forState:UIControlStateHighlighted];
            [btn setTitle:item.title forState:UIControlStateNormal];
            if (item.color) {
                [btn setTitleColor:item.color forState:UIControlStateNormal];
                //                [btn dk_setTitleColorPicker:DKColorPickerWithColors(item.color,item.color_Night) forState:UIControlStateNormal];
            }else
            {
                [btn setTitleColor:[config colorForType:item night:NO] forState:UIControlStateNormal];
            }
            btn.layer.borderWidth = MM_SPLIT_WIDTH;
            btn.layer.borderColor = dk_night?config.btnSplitColor_Night.CGColor:config.splitColor.CGColor;

            btn.titleLabel.font = [UIFont systemFontOfSize:config.buttonFontSize];
        }
        [lastButton mas_updateConstraints:^(MASConstraintMaker *make) {

            if ( items.count <= 2 && _isvolatile == NO)
            {
                make.right.equalTo(self.buttonView.mas_right).offset(MM_SPLIT_WIDTH);
            }
            else
            {
                make.bottom.equalTo(self.buttonView.mas_bottom).offset(MM_SPLIT_WIDTH);
            }

        }];
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.buttonView.mas_bottom);
        }];
        
        
        
       
    }
    return self;
}


- (void)actionButton:(UIButton*)btn
{
    MMPopupItem *item = self.actionItems[btn.tag];
    [self hide];
    if ( item.handler )
    {
        item.handler(btn.tag);
    }
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
