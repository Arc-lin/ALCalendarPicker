//
//  ALCalendarPicker.h
//  ALCalendarPickerDemo
//
//  Created by Arclin on 2017/6/16.
//  Copyright © 2017年 arclin. All rights reserved.
//

#import <UIKit/UIKit.h>

// 当宽度为屏幕宽度时,自动计算高度
#define ALPickerHeight 45 + (([UIScreen mainScreen].bounds.size.width / 10) * 7) + ((([UIScreen mainScreen].bounds.size.width - 40) - (7 * [UIScreen mainScreen].bounds.size.width / 10)) / 7) * 8

@class ALCalendarPicker,ALCalendarDate;

@protocol ALCalendarPickerDelegate <NSObject>

@optional

/**
 选择某个日期
 */
- (void)calendarPicker:(ALCalendarPicker *)picker didSelectItem:(ALCalendarDate *)date date:(NSDate *)dateObj dateString:(NSString *)dateStr;

/**
 点击按钮即将进入某个月历
 
 @param yearMonth yyyy-MM格式
 */
- (void)calendarPicker:(ALCalendarPicker *)picker willClickToYearMonth:(NSString *)yearMonth;

/**
 进入某个月历
 
 @param yearMonth yyyy-MM格式
 @param isScroll 判断是点击按钮进入日历或者滑动进入日历
 */
- (void)calendarPicker:(ALCalendarPicker *)picker didScrollToYearMonth:(NSString *)yearMonth isScroll:(BOOL)isScroll;

@end

@interface ALCalendarPicker : UIView

/** 起始年月 yyyy-MM */
@property (nonatomic, copy) NSString *beginYearMonth;

/** 结束年月 yyyy-MM */
@property (nonatomic, copy) NSString *endYearMonth;

/** 代理 */
@property (nonatomic, assign) id<ALCalendarPickerDelegate> delegate;

/** 高亮日期 yyyy-MM-dd 格式 */
@property (nonatomic, assign) NSArray<NSString *> *hightLightItems;

/** 选择日期 yyyy-MM-dd 格式 */
@property (nonatomic, assign) NSArray<NSString *> *selectedItems;

/** 高亮日期优先 当高亮日期与当日日期的重叠的时候优先使用高亮日期的样式 */
@property (nonatomic, assign) BOOL hightlightPriority;

/** 重新加载选择器 */
- (void)reloadPicker;

/** 高亮的日期的样式 */
- (void)setupHightLightItemStyle:(void(^)(UIColor **backgroundColor,NSNumber **backgroundCornerRadius,UIColor **titleColor))style;

/** 当日日期的样式 */
- (void)setupTodayItemStyle:(void(^)(UIColor **backgroundColor,NSNumber **backgroundCornerRadius,UIColor **titleColor))style;

/** 选择日期的样式 */
- (void)setupSelectedItemStyle:(void(^)(UIColor **backgroundColor,NSNumber **backgroundCornerRadius,UIColor **titleColor))style;

/** 跳转到某个月历 只需提供日月 */
- (void)jumpToYearMonth:(NSDate *)date;

/** 字符串yyyy-MM 方式跳转 */
- (void)jumpToYearMonthByStr:(NSString *)dateStr;

@end
