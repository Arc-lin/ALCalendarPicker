//
//  ALCalendarCollectionView.m
//  ALCalendarPickerDemo
//
//  Created by Arclin on 2017/6/16.
//  Copyright © 2017年 arclin. All rights reserved.
//

#import "ALCalendarCollectionView.h"

#import "ALCalendarCell.h"

#import "ALCalendarDate.h"
#import "ALCalendarHelper.h"
#import "ALCalendarConfig.h"

#import "UIView+Frame.h"

@interface ALCalendarCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *dates;

@end

@implementation ALCalendarCollectionView

static NSString *identifier = @"dateCell";

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.dataSource      = self;
        self.delegate        = self;
        self.contentInset    = UIEdgeInsetsMake(5, 20, 0, 20);
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[ALCalendarCell class] forCellWithReuseIdentifier:identifier];
    }
    return self;
}

#pragma mark - UICollectionDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) return 7;
    return self.dates.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    if(indexPath.section == 0) {
        cell.weekDay = self.titles[indexPath.row];
    } else {
        ALCalendarDate *date = self.dates[indexPath.row];
        cell.date = date;
        
        /** 当前显示的日期 */
        NSString *currentDate = [self.yearAndMonth stringByAppendingFormat:@"-%02zd",date.date.integerValue];
        
        if ([self.config.heightlightDates containsObject:currentDate]) {
            cell.backgroundColor = self.config.hl_backgroundColor;
            cell.layer.cornerRadius = self.config.hl_backgroundCornerRadius.floatValue;
            cell.dateLabel.textColor = self.config.hl_textColor;
        }
        
        if (date.isToday) {
            if (![self.config.heightlightDates containsObject:currentDate] ||
                ([self.config.heightlightDates containsObject:currentDate] && !self.config.hightlightPriority)) {
                cell.backgroundColor     = self.config.tod_backgroundColor;
                cell.layer.cornerRadius  = self.config.tod_backgroundCornerRadius.floatValue;
                cell.dateLabel.textColor = self.config.tod_textColor;
            }
        }
    }
    return cell;
}

#pragma mark - UICollectionDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.collectionViewDelegate respondsToSelector:@selector(calendarView:didSelectItem:date:dateString:)]) {
        ALCalendarDate *date = self.dates[indexPath.row];
        NSString *dateString = [self.yearAndMonth stringByAppendingFormat:@"-%02zd",date.date.integerValue];
        NSDate *dateObj = [ALCalendarHelper dateStringToDate:dateString format:@"yyyy-MM-dd"];
        [self.collectionViewDelegate calendarView:self didSelectItem:date date:dateObj dateString:dateString];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.width / 10, self.width / 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 0, 5, 0);
}

#pragma mark - setter & getter

- (NSArray *)titles
{
    return @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
}

- (void)setYearAndMonth:(NSString *)yearAndMonth
{
    _yearAndMonth = yearAndMonth;
    if (yearAndMonth) {
        _dates = [ALCalendarHelper datesWithYearAndMonth:yearAndMonth];
        [self reloadData];
    }
}

@end
