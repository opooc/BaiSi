//
//  UITextField+Placeholder.h
//  Budejie
//
//  Created by opooc on 2021/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Placeholder)
@property UIColor *placeholderColor;

-(void) setDsyPlaceholder:(NSString *)placeholder;
@end

NS_ASSUME_NONNULL_END
