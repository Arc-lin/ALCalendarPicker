//
//  ALCalendarCell.m
//  ALCalendarPickerDemo
//
//  Created by Arclin on 2017/6/16.
//  Copyright © 2017年 arclin. All rights reserved.
//

#import "ALCalendarCell.h"

#import "ALCalendarDate.h"

#import <Masonry/Masonry.h>

#define KLightGrayColor [UIColor colorWithRed:127.0/255.0 green:143.0/255.0 blue:164.0/255.0 alpha:1]

#define KDarkGrayColor  [UIColor colorWithRed:44.0/255.0 green:49.0/255.0 blue:53.0/255.0 alpha:1]

@interface ALCalendarCell()

@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation ALCalendarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self addSubview:self.dateLabel];
    
    self.layer.cornerRadius = 5.0f;
    
    __weak typeof(self) weakSelf = self;
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
}

- (void)setDate:(ALCalendarDate *)date
{
    _date = date;
    if (date.notThisMonth) {
        self.backgroundColor = [UIColor whiteColor];
        self.dateLabel.textColor = KLightGrayColor;
    } else {
        self.backgroundColor = [UIColor whiteColor];
        self.dateLabel.textColor = KDarkGrayColor;
    }
    self.dateLabel.text = date.date;
}

- (void)setWeekDay:(NSString *)weekDay
{
    _weekDay = weekDay;
    self.dateLabel.text = weekDay;
    self.dateLabel.textColor = KLightGrayColor;
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = KDarkGrayColor;
        _dateLabel.font = [UIFont systemFontOfSize:14];
    }
    return _dateLabel;
}


@end
