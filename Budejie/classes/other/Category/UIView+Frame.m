//
//  UIView+Frame.m
//  Budejie
//
//  Created by opooc on 2021/4/13.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setDsy_height:(CGFloat)dsy_height{
    CGRect rect      = self.frame;
    rect.size.height = dsy_height;
    self.frame       = rect;
}
- (CGFloat)dsy_height{
    return self.frame.size.height;
}

- (void)setDsy_width:(CGFloat)dsy_width{
    CGRect rect     = self.frame;
    rect.size.width = dsy_width;
    self.frame      = rect;
}
- (CGFloat)dsy_width{
    return self.frame.size.width;
}

- (void)setDsy_x:(CGFloat)dsy_x{
    CGRect rect   = self.frame;
    rect.origin.x = dsy_x;
    self.frame    = rect;
}
- (CGFloat)dsy_x{
    return self.frame.origin.x;
}

- (void)setDsy_y:(CGFloat)dsy_y{
    CGRect rect   = self.frame;
    rect.origin.y = dsy_y;
    self.frame    = rect;
}
- (CGFloat)dsy_y{
    return self.frame.origin.y;
}
@end
