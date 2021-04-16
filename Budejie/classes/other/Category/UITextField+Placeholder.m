//
//  UITextField+Placeholder.m
//  Budejie
//
//  Created by opooc on 2021/4/16.
//

#import "UITextField+Placeholder.h"
#import <objc/message.h>
#import <objc/runtime.h>

@implementation UITextField (Placeholder)


/*
-(void)usePlacholderColor:(UIColor*)color{
//常规设置
    NSMutableDictionary* attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = color;
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attrs];
//使用runtime设置
}
*/
//分类不能添加属性，所以这个方法也就不使用了
//-(UIColor *) placholderColor{
//    return nil;
//}
//+(void)load{
//    Method setPlaceholder = class_getInstanceMethod(self, @selector(setPlaceholder:));
//    Method  setDsy_Placeholder = class_getInstanceMethod(self, @selector(setDsy_Placeholder:));
//
//
//    method_exchangeImplementations(setPlaceholder, setDsy_Placeholder);
//}



- (void)setPlacholderColor:(UIColor*)color{
    //策略一般使用strong,使用下面方法添加成员属性
    UILabel* pLabel = [self valueForKey:@""];
//    objc_setAssociatedObject(self, @"placeholdColor", color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
-(UIColor *)placholderColor{
    return objc_getAssociatedObject(self, @"placeholdColor");
}

//设置占位文字,设置颜色
-(void) setDsy_Placeholder:(NSString *)placeholder{
    self.placeholder = placeholder;
    self.placholderColor = self.placholderColor;
}
@end
