//
//  UITextField+Placeholder.m
//  Budejie
//
//  Created by opooc on 2021/4/17.
//

#import "UITextField+Placeholder.h"
#import <objc/runtime.h>
@implementation UITextField (Placeholder)

+(void)load{
    Method setPlaceholder= class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method setDsyPlaceholder= class_getInstanceMethod(self, @selector(setDsyPlaceholder:));
    method_exchangeImplementations(setPlaceholder, setDsyPlaceholder);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
//这样还不是最完美的，当先设置颜色，再设置文字的时候，会失效;因为系统的Label用了懒加载，先设置颜色根本拿不到，没用
//    UILabel* lb = [self valueForKey:@"placeholderLabel"];
//    lb.textColor = placeholderColor;
    
    //给成员属性赋值，runtime给系统的类添加成员变量
    UILabel* lb = [self valueForKey:@"placeholderLabel"];
    lb.textColor = placeholderColor;
    //这样做第一次的未初始化的颜色就可以保存下来了
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//这里不能直接进行重写，重写的话在设置文字的时候，就进入了循环引用
//- (void)setPlaceholder:(NSString *)placeholder;

//改个名写逻辑，然后runtime换掉get重写;
//-(void) setDsyPlaceholder:(NSString *)placeholder{
//    self.placeholder = placeholder;
//    //这样的话，每次设置文字都是先取一下上次保存的颜色;空就是没色
//    self.placeholderColor = self.placeholderColor;
//}
//交换之后，里面就不能用self拿了，否则又会循环引用;
-(void) setDsyPlaceholder:(NSString *)placeholder{

    [self setDsyPlaceholder:placeholder];//这个地方就是得靠逻辑流了
    self.placeholderColor = self.placeholderColor;
}

- (UIColor *)placeholderColor{
    //使用常规方法的时候，这里用不到
    return objc_getAssociatedObject(self, @"placeholderColor");
}


@end
