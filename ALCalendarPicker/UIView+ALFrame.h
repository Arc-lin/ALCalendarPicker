//
//  UIView+Frame.h
//  ArcBlog
//
//  Created by Arclin on 15/11/18.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ALFrame)

// 分类不能添加成员属性
// @property如果在分类里面，只会自动生成get,set方法的声明，不会生成带有下划线的成员属性，和方法的实现

@property (nonatomic,assign) CGFloat al_centerX;
@property (nonatomic,assign) CGFloat al_centerY;
@property (nonatomic,assign) CGSize  al_size;
@property (nonatomic,assign) CGFloat al_x;
@property (nonatomic,assign) CGFloat al_y;
@property (nonatomic,assign) CGFloat al_width;
@property (nonatomic,assign) CGFloat al_height;

@end
