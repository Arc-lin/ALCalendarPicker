//
//  ALCalendarPicker.h
//  ALCalendarPickerDemo
//
//  Created by Arclin on 2017/6/16.
//  Copyright © 2017年 arclin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALCalendarPicker,ALCalendarDate;

@protocol ALCalendarPickerDelegate <NSObject>

/**
 选择某个日期
 */
- (void)calendarPicker:(ALCalendarPicker *)picker didSelectItem:(ALCalendarDate *)date dateString:(NSString *)dateStr;

@end

@interface ALCalendarPicker : UIView

/** 起始年月 yyyy-MM */
@property (nonatomic, copy) NSString *beginYearMonth;

@property (nonatomic, assign) id<ALCalendarPickerDelegate> delegate;

/** 高亮日期 yyyy-MM-dd 格式 */
@property (nonatomic, assign) NSArray<NSString *> *hightLightItems;

/** 高亮日期优先 当高亮日期与当日日期的重叠的时候优先使用高亮日期的样式 */
@property (nonatomic, assign) BOOL hightlightPriority;

/** 高亮的日期的样式 */
- (void)setupHightLightItemStyle:(void(^)(UIColor **backgroundColor,NSNumber **backgroundCornerRadius,UIColor **titleColor))style;

/** 当日日期的样式 */
- (void)setupTodayItemStyle:(void(^)(UIColor **backgroundColor,NSNumber **backgroundCornerRadius,UIColor **titleColor))style;

@end
