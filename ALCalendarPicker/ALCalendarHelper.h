//
//  ALCalendarHelper.h
//  ALCalendarPickerDemo
//
//  Created by Arclin on 2017/6/16.
//  Copyright © 2017年 arclin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALCalendarHelper : NSObject

/** 根据当前年月得出日历数组 */
+ (NSArray *)datesWithYearAndMonth:(NSString *)ym;

/** 今天的年份和月份 yyyy-MM */
+ (NSString *)currentYearAndMonth;

/** 今天 yyyy-MM-dd */
+ (NSString *)today;

/** 指定某个年月yyyy-MM 得到下个年月yyyy-MM */
+ (NSString *)nextYearAndMonth:(NSString *)thisYearAndMonth;

/** 指定某个年月yyyy-MM 得到上个年月yyyy-MM */
+ (NSString *)lastYearAndMonth:(NSString *)thisYearAndMonth;

/** 字符串转NSDate */
+ (NSDate *)dateStringToDate:(NSString *)dateString format:(NSString *)format;

@end
