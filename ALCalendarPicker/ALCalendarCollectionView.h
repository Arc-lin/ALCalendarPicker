//
//  ALCalendarCollectionView.h
//  ALCalendarPickerDemo
//
//  Created by Arclin on 2017/6/16.
//  Copyright © 2017年 arclin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALCalendarDate,ALCalendarCollectionView,ALCalendarConfig;

@protocol ALCalendarCollectionViewDelegate <NSObject>

/** 
 * 点击了某个日期
 */
- (void)calendarView:(ALCalendarCollectionView *)calendarCollectionView didSelectItem:(ALCalendarDate *)date dateString:(NSString *)dateString;

@end

@interface ALCalendarCollectionView : UICollectionView

/** 当前的年份和月份 yyyy-MM */
@property (nonatomic, copy) NSString *yearAndMonth;

/** 代理 */
@property (nonatomic, assign) id<ALCalendarCollectionViewDelegate> collectionViewDelegate;

/** 配置 */
@property (nonatomic, strong) ALCalendarConfig *config;

@end
