//
//  ALCalendarCell.h
//  ALCalendarPickerDemo
//
//  Created by Arclin on 2017/6/16.
//  Copyright © 2017年 arclin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALCalendarDate;

@interface ALCalendarCell : UICollectionViewCell

@property (nonatomic, strong) ALCalendarDate *date;

/** 星期 */
@property (nonatomic, copy) NSString *weekDay;

@property (nonatomic, strong, readonly) UILabel *dateLabel;

@end
