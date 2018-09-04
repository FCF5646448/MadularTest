//
//  NSDate+ZMWeek.h
//  Sierra
//
//  Created by 刘卓明 on 16/12/8.
//  Copyright © 2016年 zhuoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZMWeek)

/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)zm_day;
- (NSUInteger)zm_month;
- (NSUInteger)zm_year;
- (NSUInteger)zm_hour;
- (NSUInteger)zm_minute;
- (NSUInteger)zm_second;
+ (NSUInteger)zm_day:(NSDate *)date;
+ (NSUInteger)zm_month:(NSDate *)date;
+ (NSUInteger)zm_year:(NSDate *)date;
+ (NSUInteger)zm_hour:(NSDate *)date;
+ (NSUInteger)zm_minute:(NSDate *)date;
+ (NSUInteger)zm_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)zm_daysInYear;
+ (NSUInteger)zm_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)zm_isLeapYear;
+ (BOOL)zm_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)zm_weekOfYear;
+ (NSUInteger)zm_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)zm_formatYMD;
+ (NSString *)zm_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)zm_weeksOfMonth;
+ (NSUInteger)zm_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)zm_begindayOfMonth;
+ (NSDate *)zm_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)zm_lastdayOfMonth;
+ (NSDate *)zm_lastdayOfMonth:(NSDate *)date;

- (NSDate *)zm_zeroOfDate;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)zm_dateAfterDay:(NSUInteger)day;
+ (NSDate *)zm_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)zm_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)zm_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)zm_offsetYears:(int)numYears;
+ (NSDate *)zm_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)zm_offsetMonths:(int)numMonths;
+ (NSDate *)zm_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)zm_offsetDays:(int)numDays;
+ (NSDate *)zm_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)zm_offsetHours:(int)hours;
+ (NSDate *)zm_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)zm_daysAgo;
+ (NSUInteger)zm_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)zm_weekday;
+ (NSInteger)zm_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)zm_dayFromWeekday;
+ (NSString *)zm_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)zm_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)zm_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)zm_dateByAddingDays:(NSUInteger)days;

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
+ (NSString *)zm_monthWithMonthNumber:(NSInteger)month;
+ (NSString *)zm_chinesemonthWithMonthNumber:(NSInteger)month;
/**
 * 根据日期返回字符串
 */
+ (NSString *)zm_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)zm_stringWithFormat:(NSString *)format;
+ (NSDate *)zm_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)zm_daysInMonth:(NSUInteger)month;
+ (NSUInteger)zm_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)zm_daysInMonth;
+ (NSUInteger)zm_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)zm_timeInfo;
+ (NSString *)zm_timeInfoWithDate:(NSDate *)date;
+ (NSString *)zm_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)zm_ymdFormat;
- (NSString *)zm_hmsFormat;
- (NSString *)zm_ymdHmsFormat;
+ (NSString *)zm_ymdFormat;
+ (NSString *)zm_hmsFormat;
+ (NSString *)zm_ymdHmsFormat;

// 设置时间戳
/*
 当天时间—— 小时：分钟
 昨天——昨天
 前天——具体星期几
 5天前——年／月／日
 */
+ (NSString *)timeStrByFormat:(NSInteger)time;

/**
 返回 2小时前  3分钟前   刚刚 这样的

 @return 2小时前  3分钟前   刚刚 这样的
 */
- (NSString *)zm_timeAgoFromNow;


/**
 到未来某一个时刻的距离

 @param endDate 未来某一个天
 @return XX天XX小时XX分钟
 */
- (NSString *)zm_offset_D_H_M_ToSomeDay:(NSDate *)endDate;
@end
