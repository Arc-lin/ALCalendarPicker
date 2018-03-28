//
//  UIView+Frame.m
//  ArcBlog
//
//  Created by Arclin on 15/11/18.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "UIView+ALFrame.h"

@implementation UIView (ALFrame)

- (void)setAl_centerX:(CGFloat)al_centerX {
    CGPoint center = self.center;
    center.x = al_centerX;
    self.center = center;
}

- (CGFloat)al_centerX {
    return self.center.x;
}

- (void)setAl_centerY:(CGFloat)al_centerY {
    CGPoint center = self.center;
    center.y = al_centerY;
    self.center = center;
}

- (CGFloat)al_centerY {
    return self.center.y;
}

- (void)setAl_size:(CGSize)al_size {
    CGRect frame = self.frame;
    frame.size = al_size;
    self.frame = frame;
}

- (CGSize)al_size {
    return self.frame.size;
}

- (void)setAl_x:(CGFloat)al_x {
    CGRect frame = self.frame;
    frame.origin.x = al_x;
    self.frame = frame;
}

- (CGFloat)al_x {
    return self.frame.origin.x;
}

- (void)setAl_y:(CGFloat)al_y {
    CGRect frame = self.frame;
    frame.origin.y = al_y;
    self.frame = frame;
}

- (CGFloat)al_y {
    return self.frame.origin.y;
    
}

- (void)setAl_width:(CGFloat)al_width {
    CGRect frame = self.frame;
    frame.size.width = al_width;
    self.frame = frame;
}

- (CGFloat)al_width {
    return self.frame.size.width;
}

- (void)setAl_height:(CGFloat)al_height {
    CGRect frame = self.frame;
    frame.size.height = al_height;
    self.frame = frame;
}

- (CGFloat)al_height {
    return self.frame.size.height;
}

@end
