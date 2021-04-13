//
//  UIImage+image.m
//  Budejie
//
//  Created by opooc on 2021/4/8.
//

#import "UIImage+image.h"

@implementation UIImage (image)
+(UIImage *)imageOriginalWithName:(NSString *)imageName{
    UIImage* image = [UIImage imageNamed:imageName];
    image          = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}
@end
