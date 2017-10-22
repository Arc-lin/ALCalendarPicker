# ALCalendarPicker

简洁简单的日历选择器

![License MIT](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)
![Pod version](https://img.shields.io/cocoapods/v/ALCalendarPicker.svg?style=flat)
[![Platform info](https://img.shields.io/cocoapods/p/ALCalendarPicker.svg?style=flat)](http://cocoadocs.org/docsets/ALCalendarPicker)
![Platform version](https://img.shields.io/badge/iOS_Version->8.0-red.svg)

<img alt="简洁的日历选择器" src="https://ooo.0o0.ooo/2017/06/19/59474fc1bad50.png" width="40%" height="75%" />

### 安装 - CocoaPods

`pod "ALCalendarPicker"`

### 特性
1. 可配置当前日期背景颜色,文字,背景圆角度数
2. 可配置特殊高亮日期(如预约日期),并且可以配置高亮日期背景颜色,文字,背景圆角度数
3. 点击日期代理回调
4. 支持设定起始日期
5. 支持点击给日期添加选择样式

### 关于时间区间

目前日历的时间区间

`开始时间(如果有的话) - 今天年月 - 结束时间(如果有的话)`

之后的版本会有 另外的区间模式

`开始时间 - 结束时间`

### 使用

```
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    // 宽度建议使用屏幕宽度 高度太低会有滚动条
    ALCalendarPicker *calP = [[ALCalendarPicker alloc] initWithFrame:CGRectMake(0, 64, screenSize.width, 400)];
    calP.delegate = self;
    // 起始日期 
//    calP.beginYearMonth = @"2017-01";
    calP.hightLightItems = @[@"2017-06-17",@"2017-05-22",@"2017-06-12"];
    calP.hightlightPriority = NO;
    
    // 高亮日期样式
    [calP setupHightLightItemStyle:^(UIColor *__autoreleasing *backgroundColor, NSNumber *__autoreleasing *backgroundCornerRadius, UIColor *__autoreleasing *titleColor) {
        *backgroundColor = [UIColor colorWithRed:234.0/255.0 green:240.0/255.0 blue:243.0/255.0 alpha:1];
        *backgroundCornerRadius = @(5.0);
        *titleColor = [UIColor colorWithRed:44.0/255.0 green:49.0/255.0 blue:53.0/255.0 alpha:1];
    }];
    
    // 今天日期样式
    [calP setupTodayItemStyle:^(UIColor *__autoreleasing *backgroundColor, NSNumber *__autoreleasing *backgroundCornerRadius, UIColor *__autoreleasing *titleColor) {
        *backgroundColor = [UIColor colorWithRed:78.0/255.0 green:133.0/255.0 blue:222.0/255.0 alpha:1];
        *backgroundCornerRadius = @(screenSize.width / 20); // 因为宽度是屏幕宽度,宽度 / 10 是cell 宽高 , cell宽高 / 2 为圆形
        *titleColor = [UIColor whiteColor];
    }];
    
    // 选择日期颜色
    [calP setupSelectedItemStyle:^(UIColor *__autoreleasing *backgroundColor, NSNumber *__autoreleasing *backgroundCornerRadius, UIColor *__autoreleasing *titleColor) {
        *backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        *backgroundCornerRadius = @(screenSize.width / 20); // 因为宽度是屏幕宽度,宽度 / 10 是cell 宽高 , cell宽高 / 2 为圆形
        *titleColor = [UIColor whiteColor];
    }];
    
    [self.view addSubview:calP];
```

使用代理以响应点击事件

```
- (void)calendarPicker:(ALCalendarPicker *)picker didSelectItem:(ALCalendarDate *)date date:(NSDate *)dateObj dateString:(NSString *)dateStr;
```

### 反馈

使用过程中如果发现问题请issue我 或者发送邮件到arclin@dankal.cn

### 证书

ALCalendarPicker 使用的是MIT证书,详情见LICENSE文件.
