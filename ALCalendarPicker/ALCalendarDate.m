//
//  ALCalendarDate.m
//  ALCalendarPickerDemo
//
//  Created by Arclin on 2017/6/17.
//  Copyright © 2017年 arclin. All rights reserved.
//

#import "ALCalendarDate.h"

@implementation ALCalendarDate

+ (instancetype)lastMonthDateWith:(NSString *)dateStr
{
    ALCalendarDate *date = [[ALCalendarDate alloc] init];
    date.date            = dateStr;
    date.isLastMonth     = YES;
    date.notThisMonth    = YES;
    return date;
}

+ (instancetype)nextMonthDateWith:(NSString *)dateStr
{
    ALCalendarDate *date = [[ALCalendarDate alloc] init];
    date.date            = dateStr;
    date.isNextMonth     = YES;
    date.notThisMonth    = YES;
    return date;
}

@end
