//
//  NSDate+ZMWeek.m
//  Sierra
//
//  Created by 刘卓明 on 16/12/8.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import "NSDate+ZMWeek.h"

@implementation NSDate (ZMWeek)

- (NSUInteger)zm_day {
    return [NSDate zm_day:self];
}

- (NSUInteger)zm_month {
    return [NSDate zm_month:self];
}

- (NSUInteger)zm_year {
    return [NSDate zm_year:self];
}

- (NSUInteger)zm_hour {
    return [NSDate zm_hour:self];
}

- (NSUInteger)zm_minute {
    return [NSDate zm_minute:self];
}

- (NSUInteger)zm_second {
    return [NSDate zm_second:self];
}

+ (NSUInteger)zm_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)zm_month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)zm_year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)zm_hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)zm_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)zm_second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)zm_daysInYear {
    return [NSDate zm_daysInYear:self];
}

+ (NSUInteger)zm_daysInYear:(NSDate *)date {
    return [self zm_isLeapYear:date] ? 366 : 365;
}

- (BOOL)zm_isLeapYear {
    return [NSDate zm_isLeapYear:self];
}

+ (BOOL)zm_isLeapYear:(NSDate *)date {
    NSUInteger year = [date zm_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)zm_formatYMD {
    return [NSDate zm_formatYMD:self];
}

+ (NSString *)zm_formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%lu-%02lu-%02lu",[date zm_year],[date zm_month], [date zm_day]];
}

- (NSUInteger)zm_weeksOfMonth {
    return [NSDate zm_weeksOfMonth:self];
}

+ (NSUInteger)zm_weeksOfMonth:(NSDate *)date {
    return [[date zm_lastdayOfMonth] zm_weekOfYear] - [[date zm_begindayOfMonth] zm_weekOfYear] + 1;
}

- (NSUInteger)zm_weekOfYear {
    return [NSDate zm_weekOfYear:self];
}

+ (NSUInteger)zm_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date zm_year];
    
    NSDate *lastdate = [date zm_lastdayOfMonth];
    
    for (i = 1;[[lastdate zm_dateAfterDay:-7 * i] zm_year] == year; i++) {
        
    }
    
    return i;
}

- (NSDate *)zm_dateAfterDay:(NSUInteger)day {
    return [NSDate zm_dateAfterDate:self day:day];
}

+ (NSDate *)zm_dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)zm_dateAfterMonth:(NSUInteger)month {
    return [NSDate zm_dateAfterDate:self month:month];
}

+ (NSDate *)zm_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)zm_zeroOfDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    
    // components.nanosecond = 0 not available in iOS
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    return [NSDate dateWithTimeIntervalSince1970:ts];
}

// 设置时间戳
/*
 当天时间—— 小时：分钟
 昨天——昨天
 前天——具体星期几
 5天前——年／月／日
 */
+ (NSString *)timeStrByFormat:(NSInteger)time
{
    NSString * msgTimeFmt;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
    //ZMLog(@"time = %@ 前 %lu 天",timestr,(unsigned long)[date zm_daysAgo]);
    if ([date zm_isToday]) {
        msgTimeFmt = [date zm_stringWithFormat:@"HH:mm"];
    }else if ([date zm_daysAgo] == 0)// 昨天
    {
        msgTimeFmt = [NSString stringWithFormat:@"昨天 %@",[date zm_stringWithFormat:@"HH:mm"]];
    }else if ([date zm_daysAgo] < 5)// 昨天
    {
        msgTimeFmt = [NSString stringWithFormat:@"%@ %@",[date zm_dayFromWeekday],[date zm_stringWithFormat:@"HH:mm"]];
    }else
    {
        msgTimeFmt = [date zm_stringWithFormat:@"yy/MM/dd HH:mm"];
    }
    return msgTimeFmt;
}



- (NSDate *)zm_begindayOfMonth {
    return [NSDate zm_begindayOfMonth:self];
}

+ (NSDate *)zm_begindayOfMonth:(NSDate *)date {
    return [self zm_dateAfterDate:date day:-[date zm_day] + 1];
}

- (NSDate *)zm_lastdayOfMonth {
    return [NSDate zm_lastdayOfMonth:self];
}

+ (NSDate *)zm_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self zm_begindayOfMonth:date];
    return [[lastDate zm_dateAfterMonth:1] zm_dateAfterDay:-1];
}

- (NSUInteger)zm_daysAgo {
    return [NSDate zm_daysAgo:self];
}

+ (NSUInteger)zm_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)zm_weekday {
    return [NSDate zm_weekday:self];
}

+ (NSInteger)zm_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)zm_dayFromWeekday {
    return [NSDate zm_dayFromWeekday:self];
}

+ (NSString *)zm_dayFromWeekday:(NSDate *)date {
    switch([date zm_weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)zm_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)zm_isToday {
    return [self zm_isSameDay:[NSDate date]];
}

- (NSDate *)zm_dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)zm_monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}
+ (NSString *)zm_chinesemonthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"一月";
            break;
        case 2:
            return @"二月";
            break;
        case 3:
            return @"三月";
            break;
        case 4:
            return @"四月";
            break;
        case 5:
            return @"五月";
            break;
        case 6:
            return @"六月";
            break;
        case 7:
            return @"七月";
            break;
        case 8:
            return @"八月";
            break;
        case 9:
            return @"九月";
            break;
        case 10:
            return @"十月";
            break;
        case 11:
            return @"十一月";
            break;
        case 12:
            return @"十二月";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)zm_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date zm_stringWithFormat:format];
}

- (NSString *)zm_stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)zm_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

- (NSUInteger)zm_daysInMonth:(NSUInteger)month {
    return [NSDate zm_daysInMonth:self month:month];
}

+ (NSUInteger)zm_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date zm_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)zm_daysInMonth {
    return [NSDate zm_daysInMonth:self];
}

+ (NSUInteger)zm_daysInMonth:(NSDate *)date {
    return [self zm_daysInMonth:date month:[date zm_month]];
}

- (NSString *)zm_timeInfo {
    return [NSDate zm_timeInfoWithDate:self];
}

+ (NSString *)zm_timeInfoWithDate:(NSDate *)date {
    return [self zm_timeInfoWithDateString:[self zm_stringWithDate:date format:[self zm_ymdHmsFormat]]];
}

+ (NSString *)zm_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self zm_dateWithString:dateString format:[self zm_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate zm_month] - [date zm_month]);
    int year = (int)([curDate zm_year] - [date zm_year]);
    int day = (int)([curDate zm_day] - [date zm_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate zm_month] == 1 && [date zm_month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self zm_daysInMonth:date month:[date zm_month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate zm_day] + (totalDays - (int)[date zm_day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate zm_month];
            int preMonth = (int)[date zm_month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

- (NSString *)zm_ymdFormat {
    return [NSDate zm_ymdFormat];
}

- (NSString *)zm_hmsFormat {
    return [NSDate zm_hmsFormat];
}

- (NSString *)zm_ymdHmsFormat {
    return [NSDate zm_ymdHmsFormat];
}

+ (NSString *)zm_ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)zm_hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)zm_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self zm_ymdFormat], [self zm_hmsFormat]];
}

- (NSDate *)zm_offsetYears:(int)numYears {
    return [NSDate zm_offsetYears:numYears fromDate:self];
}

+ (NSDate *)zm_offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)zm_offsetMonths:(int)numMonths {
    return [NSDate zm_offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)zm_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)zm_offsetDays:(int)numDays {
    return [NSDate zm_offsetDays:numDays fromDate:self];
}

+ (NSDate *)zm_offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)zm_offsetHours:(int)hours {
    return [NSDate zm_offsetHours:hours fromDate:self];
}

+ (NSDate *)zm_offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}



/**
 返回 2小时前  3分钟前   刚刚 这样的
 
 @return 2小时前  3分钟前   刚刚 这样的
 */
- (NSString *)zm_timeAgoFromNow
{
   
    NSTimeInterval  timeInterval = [self timeIntervalSinceNow];
    timeInterval = -timeInterval;
    int temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = @"刚刚";
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%d小时前",temp];
    }
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%d天前",temp];
    }
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%d月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%d年前",temp];
    }
    return  result;
    
}

- (NSString *)zm_offset_D_H_M_ToSomeDay:(NSDate *)endDate{
    
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond
                                                        fromDate:self
                                                          toDate:endDate
                                                         options:0];
    NSLog(@"day : %ld H: %ld M : %ld S:%ld", [components day], (long)[components hour],(long)[components minute],(long)[components second]);
    if ( [components day]>0) {
        return [NSString stringWithFormat:@"%ld天%ld小时%ld分钟", [components day], (long)[components hour],(long)[components minute]];
    }else{
        return [NSString stringWithFormat:@"%ld小时%ld分钟", (long)[components hour],(long)[components minute]];
    }
    
}


@end
