//
//  ALCalendarPicker.m
//  ALCalendarPickerDemo
//
//  Created by Arclin on 2017/6/16.
//  Copyright © 2017年 arclin. All rights reserved.
//

#import "ALCalendarPicker.h"

#import "ALCalendarHeader.h"
#import "ALCalendarCollectionView.h"

#import "ALCalendarHelper.h"
#import "ALCalendarConfig.h"

#import "UIView+Frame.h"

#import <Masonry/Masonry.h>

@interface ALCalendarPicker()<UIScrollViewDelegate,ALCalendarHeaderDelegate,ALCalendarCollectionViewDelegate>
{
    NSInteger _currentPage;
}
@property (nonatomic, strong) ALCalendarHeader         * header;

@property (nonatomic, strong) UIScrollView             * scrollView;

@property (nonatomic, strong) NSMutableArray<ALCalendarCollectionView *> *collectionViews;

/** 配置 */
@property (nonatomic, strong) ALCalendarConfig *config;

@end

@implementation ALCalendarPicker

static CGFloat headerHeight = 45;

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self addSubview: self.header];
    [self addSubview: self.scrollView];
    
    __weak typeof(self) weakSelf = self;
    
    // 头部信息栏
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.width.equalTo(weakSelf.mas_width);
        make.height.equalTo(@(headerHeight));
    }];
    
    // 内容
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(@0);
        make.top.equalTo(strongSelf.header.mas_bottom);
        make.bottom.equalTo(@0);
        make.right.equalTo(@0);
    }];

}

- (void)reloadPicker
{
    for (ALCalendarCollectionView *collectionView in self.collectionViews) {
        [collectionView reloadData];
    }
}

- (void)setupTodayItemStyle:(void(^)(UIColor **backgroundColor,NSNumber **backgroundCornerRadius,UIColor **titleColor))style
{
    UIColor *backgroundColor;
    UIColor *titleColor;
    NSNumber *backgroundCornerRadius;
    if (style) {
        style(&backgroundColor,&backgroundCornerRadius,&titleColor);
    }
    // 配置今日日期样式
    self.config.tod_backgroundColor = backgroundColor;
    self.config.tod_textColor = titleColor;
    self.config.tod_backgroundCornerRadius = backgroundCornerRadius;
    
    for (ALCalendarCollectionView *collectionView in self.collectionViews) {
        collectionView.config = self.config;
        [collectionView reloadData];
    }
}

- (void)setupHightLightItemStyle:(void(^)(UIColor **backgroundColor,NSNumber **backgroundCornerRadius,UIColor **titleColor))style
{
    UIColor *backgroundColor;
    UIColor *titleColor;
    NSNumber *backgroundCornerRadius;
    if (style) {
        style(&backgroundColor,&backgroundCornerRadius,&titleColor);
    }
    // 配置高亮样式
    self.config.hl_backgroundColor = backgroundColor;
    self.config.hl_textColor = titleColor;
    self.config.hl_backgroundCornerRadius = backgroundCornerRadius;
    
    for (ALCalendarCollectionView *collectionView in self.collectionViews) {
        collectionView.config = self.config;
        [collectionView reloadData];
    }
}

#pragma mark - Private Method

- (void)showLeftCalendar
{
    self.header.title = [ALCalendarHelper lastYearAndMonth:self.header.title];
    [self refreshCollectionView:NO];
}

- (void)showRightCalendar
{
    self.header.title = [ALCalendarHelper nextYearAndMonth:self.header.title];
    [self refreshCollectionView:YES];
}

- (void)setupLeftAndRightCalendar
{
    // 配置上个月和下个月的数据源
    self.collectionViews.firstObject.yearAndMonth = [ALCalendarHelper lastYearAndMonth:self.header.title];
    self.collectionViews.lastObject.yearAndMonth = [ALCalendarHelper nextYearAndMonth:self.header.title];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 到达起始时间不能滚动
    if ([self.header.title isEqualToString:self.beginYearMonth] && scrollView.contentOffset.x < self.width) {
        [scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
    }
    
    // 到达结束时间不能滚动
    if ([self.header.title isEqualToString:self.endYearMonth]  && scrollView.contentOffset.x > self.width) {
        [scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self.scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
    
    [self setupLeftAndRightCalendar];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat page    = offsetX / self.width;
    if (page == 2) {
        [self showRightCalendar];
    } else if (page == 0) {
        [self showLeftCalendar];
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
    
    // 配置上个月和下个月的数据源
    [self setupLeftAndRightCalendar];
}

#pragma mark - ALCalendarHeaderDelegate

- (void)header:(ALCalendarHeader *)header didClickLeftBtn:(UIButton *)button
{
    [self showLeftCalendar];
}

- (void)header:(ALCalendarHeader *)header didClickRightBtn:(UIButton *)button
{
    [self showRightCalendar];
}

#pragma mark - ALCalendarCollectionViewDelegate

- (void)calendarView:(ALCalendarCollectionView *)calendarCollectionView didSelectItem:(ALCalendarDate *)date date:(NSDate *)dateObj dateString:(NSString *)dateString
{
    if ([self.delegate respondsToSelector:@selector(calendarPicker:didSelectItem:date:dateString:)]) {
        [self.delegate calendarPicker:self didSelectItem:date date:dateObj dateString:dateString];
    }
}

#pragma mark - private method

- (void)refreshCollectionView:(BOOL)next
{
    if (next) { // 滚到下一页
        [self.scrollView setContentOffset:CGPointMake(2 * self.width , 0) animated:YES];
    } else { // 滚到上一页
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    self.collectionViews[1].yearAndMonth = self.header.title;
}

// 比较时间先后
- (BOOL)compareOneDay:(NSString *)day1 withAnotherDay:(NSString *)day2
{
    NSDate *dateA = [ALCalendarHelper dateStringToDate:day1 format:@"yyyy-MM"];
    NSDate *dateB = [ALCalendarHelper dateStringToDate:day2 format:@"yyyy-MM"];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        return NO; // Day1 在 Day2 之后
    }
    else if (result == NSOrderedAscending) {
        return YES; // Day1 在 Day2 之前
    }
    return YES;
}

#pragma mark - setter & getter

- (ALCalendarHeader *)header
{
    if (!_header) {
        _header                 = [[ALCalendarHeader alloc] init];
        // 初始化为当前月份和年份
        _header.title           = [ALCalendarHelper currentYearAndMonth];
        _header.backgroundColor = [UIColor whiteColor];
        _header.delegate        = self;
    }
    return _header;
}

- (void)setBeginYearMonth:(NSString *)beginYearMonth
{
    _beginYearMonth            = beginYearMonth;
    self.header.beginYearMonth = beginYearMonth;
    NSAssert([self compareOneDay:beginYearMonth withAnotherDay:[ALCalendarHelper currentYearAndMonth]], @"开始时间不能比当前月晚");
    if (_endYearMonth) {
        NSAssert([self compareOneDay:beginYearMonth withAnotherDay:self.endYearMonth],@"结束时间不能比开始时间早");
    }
}

- (void)setEndYearMonth:(NSString *)endYearMonth
{
    _endYearMonth            = endYearMonth;
    self.header.endYearMonth = endYearMonth;
    NSAssert([self compareOneDay:[ALCalendarHelper currentYearAndMonth] withAnotherDay:endYearMonth], @"结束时间不能比当前月早");
    if (_beginYearMonth) {
        NSAssert([self compareOneDay:self.beginYearMonth withAnotherDay:endYearMonth],@"结束时间不能比开始时间早");
    }
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        CGFloat height = self.height - headerHeight;
        _scrollView.contentSize = (CGSize){self.width * 3,height};
        _scrollView.delegate = self;
        for (NSInteger i = 0; i < 3 ; i++) {
            ALCalendarCollectionView *collectionView = [[ALCalendarCollectionView alloc] initWithFrame:CGRectMake(self.width * i, 0, self.width,height) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
            collectionView.collectionViewDelegate = self;
            collectionView.yearAndMonth = nil;
            if (i == 0) {
                collectionView.yearAndMonth = [ALCalendarHelper lastYearAndMonth:self.header.title];
            }else if (i == 1) {
                collectionView.yearAndMonth = [ALCalendarHelper currentYearAndMonth];
            } else if (i == 2) {
                collectionView.yearAndMonth = [ALCalendarHelper nextYearAndMonth:self.header.title];
            }
            [self.collectionViews addObject:collectionView];
            [self.scrollView addSubview:collectionView];
        }
        _scrollView.showsHorizontalScrollIndicator = NO;
//        _scrollView.scrollEnabled = NO;
        [_scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
    }
    return _scrollView;
}

- (NSMutableArray<ALCalendarCollectionView *> *)collectionViews
{
    if (!_collectionViews) {
        _collectionViews = [NSMutableArray array];
    }
    return _collectionViews;
}

- (void)setHightLightItems:(NSArray<NSString *> *)hightLightItems
{
    _hightLightItems = hightLightItems;
    self.config.heightlightDates = hightLightItems;
    [self reloadPicker];
}

- (void)setHightlightPriority:(BOOL)hightlightPriority
{
    _hightlightPriority = hightlightPriority;
    self.config.hightlightPriority = hightlightPriority;
}

- (ALCalendarConfig *)config
{
    if (!_config) {
        _config = [[ALCalendarConfig alloc] init];
    }
    return _config;
}

@end
