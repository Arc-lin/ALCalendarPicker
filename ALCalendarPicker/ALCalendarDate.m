//
//  ALCalendarDate.m
//  ALCalendarPickerDemo
//
//  Created by Arclin on 2017/6/17.
//  Copyright © 2017年 arclin. All rights reserved.
//

#import "ALCalendarDate.h"

@implementation ALCalendarDate

+ (instancetype)dateWith:(NSString *)dateStr isNotThisMonth:(BOOL)notThisMonth
{
    ALCalendarDate *date = [[ALCalendarDate alloc] init];
    date.date            = dateStr;
    date.notThisMonth    = notThisMonth;
    return date;
}

@end
