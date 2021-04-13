//
//  UIView+Frame.h
//  Budejie
//
//  Created by opooc on 2021/4/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)
//写分类的时候，一定要避免跟其他人产生冲突
@property CGFloat dsy_x;
@property CGFloat dsy_y;
@property CGFloat dsy_width;
@property CGFloat dsy_height;
@end

NS_ASSUME_NONNULL_END
