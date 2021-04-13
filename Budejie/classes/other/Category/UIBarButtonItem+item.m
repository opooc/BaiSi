//
//  UIBarButtonItem+item.m
//  Budejie
//
//  Created by opooc on 2021/4/13.
//

#import "UIBarButtonItem+item.h"

@implementation UIBarButtonItem (item)
+(UIBarButtonItem*)itemWithImageName:(NSString*)imageName highImageName:(NSString *)highImageName addTarget:(id)target action:(SEL)action{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+(UIBarButtonItem*)backItemWithImageName:(NSString*)imageName highImageName:(NSString *)highImageName addTarget:(id)target action:(SEL)action title:(NSString*)title{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    //设置按钮的偏移
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+(UIBarButtonItem*)itemWithImageName:(NSString*)imageName selImageName:(NSString *)selImageName addTarget:(id)target action:(SEL)action{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selImageName] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:selImageName] forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end


