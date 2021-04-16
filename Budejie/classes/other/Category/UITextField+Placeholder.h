//
//  UITextField+Placeholder.h
//  Budejie
//
//  Created by opooc on 2021/4/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Placeholder)
//分类中不能设置属性?
@property UIColor *placholderColor;


-(void)usePlacholderColor:(UIColor*)color;

-(void) setDsy_Placeholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
