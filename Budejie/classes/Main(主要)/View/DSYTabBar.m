//
//  DSYTabBar.m
//  Budejie
//
//  Created by opooc on 2021/4/11.
//

#import "DSYTabBar.h"

@interface DSYTabBar()

@property(nonatomic,weak) UIButton *publishButton;

@end

@implementation DSYTabBar

- (void)layoutSubviews{
    [super layoutSubviews];
    NSInteger count = self.items.count;
    CGFloat btnW = self.bounds.size.width /(self.items.count +1);
    //

    NSLog(@"-----");
    //这里不能使用item直接拿，因为item代表的是内容，当然数量是相同的，但是
    for (UIView* tabBarButton in self.subviews) {
        if([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            NSLog(@"%@",tabBarButton);
        }
    }
}


@end
