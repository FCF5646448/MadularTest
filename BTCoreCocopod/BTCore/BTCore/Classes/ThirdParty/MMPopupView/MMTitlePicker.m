//
//  MMTitlePicker.m
//  Sierra
//
//  Created by 卓明 on 2017/3/21.
//  Copyright © 2017年 zhuoming. All rights reserved.
//

#import "MMTitlePicker.h"
#import "MMPopupDefine.h"
#import "MMPopupCategory.h"
#import <Masonry/Masonry.h>
#import "prefixHeader.h"

@interface MMTitlePicker()<UIPickerViewDelegate,UIPickerViewDataSource>



@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnConfirm;

@end

@implementation MMTitlePicker


- (instancetype)initWithTitles:(NSArray *)titles
{
    self = [super init];
    
    if ( self )
    {
        _titles = titles;
        if (_titles.count>0) {
            _selectTitle = titles[0];
        }
        self.type = MMPopupTypeSheet;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.height.mas_equalTo(216+50);
        }];
        
        self.btnCancel = [UIButton mm_buttonWithTarget:self action:@selector(actionHide)];
        [self addSubview:self.btnCancel];
        [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 50));
            make.left.top.equalTo(self);
        }];
        [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [self.btnCancel setTitleColor:BaseColor forState:UIControlStateNormal];
        
        
        self.btnConfirm = [UIButton mm_buttonWithTarget:self action:@selector(actionSure)];
        [self addSubview:self.btnConfirm];
        [self.btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 50));
            make.right.top.equalTo(self);
        }];
        [self.btnConfirm setTitle:@"完成" forState:UIControlStateNormal];
        [self.btnConfirm setTitleColor:BaseColor forState:UIControlStateNormal];
        
        self.picker = [UIPickerView new];
        self.picker.dataSource = self;
        self.picker.delegate = self;
        
        [self addSubview:self.picker];
        [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(50, 0, 0, 0));
        }];
    }
    
    return self;
}

- (void)actionHide
{
    self.selectTitle = nil;
    [self hide];
}

- (void)actionSure
{
    [self hide];
}


#pragma mark - picker Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _titles[row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _titles.count;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectTitle =_titles[row];
}

@end
