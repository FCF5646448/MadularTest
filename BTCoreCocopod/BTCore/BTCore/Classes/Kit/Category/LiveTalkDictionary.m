//
//  LiveTalkDictionary.m
//  Sierra
//
//  Created by 卓明 on 2017/3/6.
//  Copyright © 2017年 zhuoming. All rights reserved.
//

#import "LiveTalkDictionary.h"

@interface LiveTalkDictionary()
{
       NSDictionary *_dict;
}
@end

@implementation LiveTalkDictionary
- (BOOL)isEqual:(id)object
{
    if ([self[@"time"] isEqual:[object objectForKey:@"time"]]) {
        return YES;
    }
    return NO;
}

- (BOOL)isEqualToDictionary:(NSDictionary *)otherDictionary
{
    if ([self[@"time"] isEqual:[otherDictionary objectForKey:@"time"]]) {
        return YES;
    }
    return NO;
}


- (NSUInteger)count {
    return [_dict count];
}
- (id)objectForKey:(id)aKey {
    return [_dict objectForKey:aKey];
}
- (NSEnumerator *)keyEnumerator {
    return [_dict keyEnumerator];
}

- (instancetype)initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt
{
    _dict = [NSDictionary dictionaryWithObjects:objects forKeys:keys count:cnt];
    return self;
}

@end
