//
//  UIImage+CircleImage.h
//  Budejie
//
//  Created by opooc on 2021/4/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CircleImage)
/**
 * 返回一张圆形图片
 */
- (instancetype)circleImage;

/**
 * 返回一张圆形图片
 */
+ (instancetype)circleImageNamed:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
