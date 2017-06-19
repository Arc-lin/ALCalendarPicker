//
//  ALCalendarHeader.m
//  ALCalendarPickerDemo
//
//  Created by Arclin on 2017/6/16.
//  Copyright © 2017年 arclin. All rights reserved.
//

#import "ALCalendarHeader.h"

#import "ALCalendarHelper.h"

#import "UIView+Frame.h"

#import <Masonry/Masonry.h>

@interface ALCalendarHeader()

@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) UILabel  *titleLabel;

@end

@implementation ALCalendarHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self addSubview: self.leftBtn];
    [self addSubview: self.titleLabel];
    [self addSubview: self.rightBtn];
    
    __weak typeof(self) weakSelf = self;
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(@15);
        make.centerY.equalTo(strongSelf.mas_centerY);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        make.centerX.equalTo(strongSelf.mas_centerX);
        make.centerY.equalTo(strongSelf.mas_centerY);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@-15);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
    }];
}

- (void)leftBtnDidClicked:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(header:didClickLeftBtn:)]) {
        [self.delegate header:self didClickLeftBtn:button];
    }
}

- (void)rightBtnDidClicked:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(header:didClickRightBtn:)]) {
        [self.delegate header:self didClickRightBtn:button];
    }
}


- (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName
{
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"ALCalendarPicker.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *img_path = [bundle pathForResource:imgName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:img_path];
}

#pragma mark - setter & getter

- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage: [self imagesNamedFromCustomBundle:@"ic_lastday"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setImage: [self imagesNamedFromCustomBundle:@"ic_nextday"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor darkGrayColor];
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    // 格式化显示日期
    NSArray *dates = [title componentsSeparatedByString:@"-"];
    self.titleLabel.text = [NSString stringWithFormat:@"%@年 - %@月",dates.firstObject,dates.lastObject];
    
    if([title isEqualToString:self.beginYearMonth]) {
        self.leftBtn.enabled = NO;
    } else {
        self.leftBtn.enabled = YES;
    }
}

@end
