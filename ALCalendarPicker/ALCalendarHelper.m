//
//  ALCalendarHelper.m
//  ALCalendarPickerDemo
//
//  Created by Arclin on 2017/6/16.
//  Copyright © 2017年 arclin. All rights reserved.
//

#import "ALCalendarHelper.h"
#import "ALCalendarDate.h"

@implementation ALCalendarHelper

+ (NSArray *)datesWithYearAndMonth:(NSString *)ym
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    // 设定一号
    NSString *dateStr = [ym stringByAppendingString:@"-01"];
    
    // 转成NSDate
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *date = [self dateStringToDate:dateStr format:@"yyyy-MM-dd"];
    
    // 转成日历组件
    NSDateComponents *comps;
    comps = [calendar components:unitFlags fromDate:date];
    
    // 当前月一号是星期几（注意，周日是“1”，周一是“2”。。。。）
    NSInteger weekday = comps.weekday;
    // 当前月的天数
    NSInteger days = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    // 当前月最后一天
    NSString *thisMonthLastDateStr = [NSString stringWithFormat:@"%@-%zd",ym,days];
    NSDate   *thisMonthLastDate    = [formatter dateFromString:thisMonthLastDateStr];
    // 当前月最后一天是星期几
    comps = [calendar components:unitFlags fromDate:thisMonthLastDate];
    NSInteger lastDaysWeekDay = comps.weekday;
    
    // 上个月的天数
    [comps setDay:1];
    [comps setMonth:comps.month - 1];
    NSDate *lastMonth = [calendar dateFromComponents:comps];
    NSInteger lastMonthDays = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:lastMonth].length;
    
    // 上个月
    NSMutableArray *lastMonthDates = [NSMutableArray array];
    for (NSInteger i = 0; i < weekday - 1; i++) {
        NSString *d = [NSString stringWithFormat:@"%zd",lastMonthDays - i];
        ALCalendarDate *dat = [ALCalendarDate lastMonthDateWith:d];
        [lastMonthDates addObject:dat];
    }
    lastMonthDates = [lastMonthDates reverseObjectEnumerator].allObjects.mutableCopy;
    
    // 这个月
    NSMutableArray *thisMonthDates = [NSMutableArray array];
    for (NSInteger i = 1 ; i <= days ; i++) {
        NSString *d = [NSString stringWithFormat:@"%zd",i];
        ALCalendarDate *dat = [[ALCalendarDate alloc] init];
        dat.date = d;
        if ([[ym stringByAppendingFormat:@"-%@",d] isEqualToString:[self today]]) { // 判断今天
            dat.isToday = YES;
        }
        [thisMonthDates addObject:dat];
    }
   
    // 下个月
    NSMutableArray<ALCalendarDate *> *nextMonthDates = [NSMutableArray array];
    for (NSInteger i = 1 ; i <= 7 - lastDaysWeekDay; i++) {
        NSString *d = [NSString stringWithFormat:@"%zd",i];
        ALCalendarDate *dat = [ALCalendarDate nextMonthDateWith:d];
        [nextMonthDates addObject:dat];
    }
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:lastMonthDates];
    [arr addObjectsFromArray:thisMonthDates];
    [arr addObjectsFromArray:nextMonthDates];
    
    
    // 强行补齐成六行
//    if (arr.count <= 35) {
//        NSMutableArray *tempArr = [NSMutableArray array];
//        for (NSInteger i = [nextMonthDates.lastObject.date integerValue] + 1; i <= [nextMonthDates.lastObject.date integerValue] + 7; i++) {
//            ALCalendarDate *dat =[ALCalendarDate nextMonthDateWith:[NSString stringWithFormat:@"%zd",i]];
//            [tempArr addObject:dat];
//        }
//        [arr addObjectsFromArray:tempArr];
//    }
    
    return arr;
}

+ (NSString *)currentYearAndMonth
{
    NSDate *now = [NSDate date];
    
    // 转成NSDate
    NSString *dateStr = [self dateToDateString:now format:@"yyyy-MM"];
    
    return dateStr;
}

+ (NSString *)today
{
    NSString *todayDate = [self dateToDateString:[NSDate date] format:@"yyyy-MM-dd"];
    return todayDate;
}

+ (NSString *)nextYearAndMonth:(NSString *)thisYearAndMonth
{
    NSDate *date = [self dateStringToDate:thisYearAndMonth format:@"yyyy-MM"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    comps.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [comps setMonth: comps.month + 1];
    NSDate *nextMonth = [calendar dateFromComponents:comps];
    return [self dateToDateString:nextMonth format:@"yyyy-MM"];
}

+ (NSString *)lastYearAndMonth:(NSString *)thisYearAndMonth
{
    NSDate *date = [self dateStringToDate:thisYearAndMonth format:@"yyyy-MM"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    comps.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [comps setMonth: comps.month - 1];
    NSDate *lastMonth = [calendar dateFromComponents:comps];
    return [self dateToDateString:lastMonth format:@"yyyy-MM"];
}

+ (NSString *)dateToDateString:(NSDate *)date format:(NSString *)format
{
    // 转成NSDate
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter.dateFormat = format;
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+ (NSDate *)dateStringToDate:(NSString *)dateString format:(NSString *)format
{
    // 转成NSDate
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter.dateFormat = format;
    NSDate *date = [formatter dateFromString:dateString];
    return date;
}

@end
