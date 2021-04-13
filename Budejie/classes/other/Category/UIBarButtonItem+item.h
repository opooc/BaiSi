//
//  UIBarButtonItem+item.h
//  Budejie
//
//  Created by opooc on 2021/4/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (item)
+(UIBarButtonItem*)itemWithImageName:(NSString*)imageName highImageName:(NSString *)selectImageName addTarget:(id)target action:(SEL)action;

+(UIBarButtonItem*)backItemWithImageName:(NSString*)imageName highImageName:(NSString *)selectImageName addTarget:(id)target action:(SEL)action title:(NSString*)title;

+(UIBarButtonItem*)itemWithImageName:(NSString*)imageName selImageName:(NSString *)selectImageName addTarget:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
