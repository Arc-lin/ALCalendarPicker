//
//  ALCalendarHeader.h
//  ALCalendarPickerDemo
//
//  Created by Arclin on 2017/6/16.
//  Copyright © 2017年 arclin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALCalendarHeader;

@protocol ALCalendarHeaderDelegate <NSObject>

/**
 点击了左边的按钮
 */
- (void)header:(ALCalendarHeader *)header didClickLeftBtn:(UIButton *)button;

/**
 点击了右边的按钮
 */
- (void)header:(ALCalendarHeader *)header didClickRightBtn:(UIButton *)button;

@end

@interface ALCalendarHeader : UIView

@property (nonatomic, copy) NSString *title;

/** 起始年月 yyyy-MM */
@property (nonatomic, copy) NSString *beginYearMonth;

/** 代理 */
@property (nonatomic, assign) id<ALCalendarHeaderDelegate> delegate;


@end
