//
//  NSDictionary+JsonString.h
//  Sierra
//
//  Created by 刘卓明 on 16/12/15.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JsonString)
/**
 *  @brief NSDictionary转换成JSON字符串
 *
 *  @return  JSON字符串
 */
-(NSString *)zm_JsonString;
@end
