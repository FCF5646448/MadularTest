//
//  MMAlertView.m
//  MMPopupView
//
//  Created by Ralph Li on 9/6/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import "MMAlertView.h"
#import "MMPopupItem.h"
#import "MMPopupCategory.h"
#import "MMPopupDefine.h"
#import <Masonry/Masonry.h>
#import "prefixHeader.h"

@interface MMAlertView()


@property (nonatomic, strong) UITextField *inputView;
@property (nonatomic, strong) UIView      *buttonView;

@property (nonatomic, strong) NSArray     *actionItems;

@property (nonatomic, copy) MMPopupInputHandler inputHandler;

@end

@implementation MMAlertView




- (instancetype) initWithInputTitle:(NSString *)title
                             detail:(NSString *)detail
                        placeholder:(NSString *)inputPlaceholder
                            handler:(MMPopupInputHandler)inputHandler
{
    MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
    
    NSArray *items =@[
                      MMItemMake(config.defaultTextCancel, MMItemTypeNormal, nil),
                      MMItemMake(config.defaultTextConfirm, MMItemTypeNormal, nil)
                      ];
    return [self initWithTitle:title detail:detail items:items inputPlaceholder:inputPlaceholder inputHandler:inputHandler];
}

- (instancetype) initWithConfirmTitle:(NSString*)title
                               detail:(NSString*)detail
{
    MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
    
    NSArray *items =@[
                      MMItemMake(config.defaultTextOK, MMItemTypeHighlight, nil)
                      ];
    
    return [self initWithTitle:title detail:detail items:items];
}





- (instancetype) initWithTitle:(NSString*)title
                        detail:(NSString*)detail
                         items:(NSArray*)items
{
    return [self initWithTitle:title detail:detail items:items inputPlaceholder:nil inputHandler:nil];
}

- (instancetype) initWithTitle:(NSString*)title
                        detail:(NSString*)detail
                         items:(NSArray*)items
                      vertical:(BOOL)vertical
{
    _isvolatile = vertical;
    return [self initWithTitle:title detail:detail items:items inputPlaceholder:nil inputHandler:nil];
}

- (instancetype)initWithTitle:(NSString *)title
                       detail:(NSString *)detail
                        items:(NSArray *)items
             inputPlaceholder:(NSString *)inputPlaceholder
                 inputHandler:(MMPopupInputHandler)inputHandler{
    return [self initWithTitle:title detail:detail items:items inputPlaceholder:inputPlaceholder inputHandler:inputHandler needCheck:NO checkTitle:nil];
}

//  添加一个check
- (instancetype)initWithTitle:(NSString *)title
                       detail:(NSString *)detail
                        items:(NSArray *)items
             inputPlaceholder:(NSString *)inputPlaceholder
                 inputHandler:(MMPopupInputHandler)inputHandler
                    needCheck:(BOOL)check
                   checkTitle:(NSString *)checkTitle
{
    self = [super init];
    
    if ( self )
    {
        NSAssert(items.count>0, @"Could not find any items.");
        
        MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
        
        self.type = MMPopupTypeAlert;
        self.withKeyboard = (inputHandler!=nil);
        
        self.inputHandler = inputHandler;
        self.actionItems = items;
        self.layer.cornerRadius = config.cornerRadius;
        self.clipsToBounds = YES;
        self.layer.borderWidth = MM_SPLIT_WIDTH;
        if (dk_night) {
            self.backgroundColor = config.backgroundColor_Night;
            self.layer.borderColor = config.splitColor_Night.CGColor;
        }else{
            self.backgroundColor = config.backgroundColor;
            self.layer.borderColor = config.splitColor.CGColor;
        }
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(config.width);
        }];
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
        
        MASViewAttribute *lastAttribute = self.mas_top;
        if ( title.length > 0 )
        {
            self.titleLabel = [UILabel new];
    
            [self addSubview:self.titleLabel];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(config.innerMargin);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMarginLeft, 0, config.innerMarginLeft));
            }];
//            self.titleLabel.textColor = config.titleColor;
            self.titleLabel.dk_textColorPicker = DKColorPickerWithColors(config.titleColor,config.titleColor_Night);
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.font = [UIFont systemFontOfSize:config.titleFontSize];
            self.titleLabel.numberOfLines = 0;
            self.titleLabel.backgroundColor = self.backgroundColor;
            
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = 8;// 字体的行间距
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:config.titleFontSize], NSParagraphStyleAttributeName:paragraphStyle};
            self.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:title attributes:attributes];
   
            
            lastAttribute = self.titleLabel.mas_bottom;
        }
        
        if ( detail.length > 0 )
        {
            self.detailLabel = [UILabel new];
            [self addSubview:self.detailLabel];
            [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(10);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMarginLeft, 0, config.innerMarginLeft));
            }];
//            self.detailLabel.textColor = config.detailColor;
            self.detailLabel.dk_textColorPicker = DKColorPickerWithColors(config.detailColor,config.detailColor_Night);
            self.detailLabel.textAlignment = NSTextAlignmentCenter;
            self.detailLabel.font = [UIFont systemFontOfSize:config.detailFontSize];
            self.detailLabel.numberOfLines = 0;
            self.detailLabel.backgroundColor = self.backgroundColor;
//            self.detailLabel.text = detail;
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = 4;// 字体的行间距
            
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle};
            self.detailLabel.attributedText = [[NSAttributedString alloc] initWithString:detail attributes:attributes];
            
            lastAttribute = self.detailLabel.mas_bottom;
        }else
        {
//            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.mas_top).offset(config.innerMargin+20);
//                
//            }];
            lastAttribute = self.titleLabel.mas_bottom;
        }
        
        if ( self.inputHandler )
        {
            self.inputView = [UITextField new];
            [self addSubview:self.inputView];
            [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(10);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMarginLeft, 0, config.innerMarginLeft));
                make.height.mas_equalTo(40);
            }];
            self.inputView.backgroundColor = self.backgroundColor;
            self.inputView.layer.borderWidth = MM_SPLIT_WIDTH;
            self.inputView.layer.borderColor = config.splitColor.CGColor;
            self.inputView.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
            self.inputView.leftViewMode = UITextFieldViewModeAlways;
            self.inputView.clearButtonMode = UITextFieldViewModeWhileEditing;
            self.inputView.placeholder = inputPlaceholder;
            
            lastAttribute = self.inputView.mas_bottom;
        }
        
        if (check && checkTitle.length>0) {
            self.checkButton = [UIButton new];
            [self addSubview:self.checkButton];
            [self.checkButton addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.checkButton setImage:[UIImage imageNamed:@"任务_未选中"] forState:UIControlStateNormal];
            [self.checkButton setImage:[UIImage imageNamed:@"任务_选择"] forState:UIControlStateSelected];
            [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(10);
                make.left.equalTo(self).offset(config.innerMarginLeft);
                make.width.height.mas_equalTo(15);
            }];
            
            self.checkLabel = [UILabel new];
            [self addSubview:self.checkLabel];
            self.checkLabel.font = [UIFont systemFontOfSize:12];
            self.checkLabel.textColor = config.checkColor;
            self.checkLabel.text = checkTitle;
            [self.checkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.checkButton.mas_right).mas_offset(11);
                make.right.mas_equalTo(self).offset(-1*config.innerMarginLeft);
                make.top.mas_equalTo(lastAttribute).offset(10);
                make.height.mas_lessThanOrEqualTo(90);
                make.height.mas_greaterThanOrEqualTo(15);
            }];
            lastAttribute = self.checkLabel.mas_bottom;
            
        }
        
        self.buttonView = [UIView new];
        [self addSubview:self.buttonView];
        [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute).offset(config.innerMargin);
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
                [btn setTitleColor:[config colorForType:item night:dk_night] forState:UIControlStateNormal];
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
        
        
//        if (dk_night) {
//            self.backgroundColor = [UIColor zm_colorWithHex:bt_666666];
//            self.titleLabel.backgroundColor = self.backgroundColor;
//            self.detailLabel.backgroundColor = self.backgroundColor;
//            self.titleLabel.textColor = [UIColor zm_colorWithHex:bt_f5f5f5];
//            self.detailLabel.textColor = [UIColor zm_colorWithHex:bt_f5f5f5];
//
//
//        }
        
    }
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)actionButton:(UIButton*)btn
{
    MMPopupItem *item = self.actionItems[btn.tag];
    
    
    if ( self.withKeyboard && (btn.tag==1) )
    {
        if ( self.inputView.text.length > 0 )
        {
            [self hide];
        }
    }
    else
    {
        [self hide];
    }
    
    if ( self.inputHandler && (btn.tag>0) )
    {
        self.inputHandler(self.inputView.text);
    }
    else
    {
        if ( item.handler )
        {
            item.handler(btn.tag);
        }
    }
}

- (void)notifyTextChange:(NSNotification *)n
{
    if ( self.maxInputLength == 0 )
    {
        return;
    }
    
    if ( n.object != self.inputView )
    {
        return;
    }
    
    UITextField *textField = self.inputView;
    
    NSString *toBeString = textField.text;

    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (toBeString.length > self.maxInputLength) {
            textField.text = [toBeString mm_truncateByCharLength:self.maxInputLength];
        }
    }
}

- (void)checkAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.check = btn.selected;
}

- (void)showKeyboard
{
    [self.inputView becomeFirstResponder];
}

- (void)hideKeyboard
{
    [self.inputView resignFirstResponder];
}

@end


@interface MMAlertViewConfig()

@end

@implementation MMAlertViewConfig

+ (MMAlertViewConfig *)globalConfig
{
    static MMAlertViewConfig *config;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        config = [MMAlertViewConfig new];
        
    });
    
    return config;
}

- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        self.defaultTextOK         = @"好";
        self.defaultTextCancel     = @"取消";
        self.defaultTextConfirm    = @"确定";
        self.width                 = 275.0f;
        self.buttonHeight          = 50.0f;
        self.innerMargin           = 15.0f;
        self.innerMarginLeft       = 22.5f;
        self.cornerRadius          = 10.0f;

        self.titleFontSize         = 17.0f;
        self.detailFontSize        = 14.0f;
        self.buttonFontSize        = 16.0f;
        // 正常模式
        self.backgroundColor       = MMHexColor(0xFFFFFFFF);
        self.titleColor            = MMHexColor(0x333333FF);
        self.detailColor           = MMHexColor(0x333333FF);
        self.splitColor            = MMHexColor(0xE6E6E6FF);
        self.checkColor            = MMHexColor(0x999999ff);

        // 夜间模式
        self.backgroundColor_Night = MMHexColor(0x666666ff);
        self.titleColor_Night      = MMHexColor(0xf5f5f5ff);
        self.detailColor_Night     = MMHexColor(0xf5f5f5ff);
        self.splitColor_Night      = MMHexColor(0x666666ff);
        self.btnSplitColor_Night   = MMHexColor(0x535353ff);
        self.checkColor_Night      = MMHexColor(0x999999ff);

        // 按钮颜色
        self.itemNormalColor       = MMHexColor(0x01A0EBFF);
        self.itemDisableColor      = MMHexColor(0x999999FF);
        self.itemHighlightColor    = MMHexColor(0x01A0EBFF);
        self.itemDangerColor       = MMHexColor(0xFB3857FF);
        self.itemPressedColor      = MMHexColor(0xEFEDE7FF);
        
        self.itemNormalColor_N     = MMHexColor(0x01A0EBFF);
        self.itemDisableColor_N    = MMHexColor(0x999999FF);
        self.itemHighlightColor_N  = MMHexColor(0x01A0EBFF);
        self.itemDangerColor_N     = MMHexColor(0xFB3857FF);
        self.itemPressedColor_N    = MMHexColor(0xEFEDE7FF);
        
        
        
    }
    
    return self;
}


- (UIColor *)colorForType:(MMPopupItem *)item night:(BOOL)night{
    switch (item.type) {
        case MMItemTypeNormal:
            return night?self.itemNormalColor_N:self.itemNormalColor;
        case MMItemTypeHighlight:
            return night?self.itemHighlightColor_N:self.itemHighlightColor;
        case MMItemTypeDanger:
            return night?self.itemDangerColor_N:self.itemDangerColor;
        case MMItemTypeDisabled:
            return night?self.itemDisableColor_N:self.itemDisableColor;
        default:
            return night?self.itemNormalColor_N:self.itemNormalColor;
            break;
    }
    
}




@end
