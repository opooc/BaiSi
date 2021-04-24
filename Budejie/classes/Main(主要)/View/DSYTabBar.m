//
//  DSYTabBar.m
//  Budejie
//
//  Created by opooc on 2021/4/11.
//

#import "DSYTabBar.h"
#import "UIView+Frame.h"
@interface DSYTabBar()

@property(nonatomic,weak) UIButton *publishButton;

@end

@implementation DSYTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        //这句话是来调整控件大小的，只设置了内部图片不行，还要调用这个方法，让btn的大小和内部的image大小一样，自动调整
        //一般自定义控件的时候调用这个方法。
        [btn sizeToFit];
        [self addSubview:btn];
        self.publishButton = btn;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSInteger count = self.items.count;
    CGFloat btnW    = self.dsy_width /(count +1);
    CGFloat btnH    = self.dsy_height;
    int i           = 0;
    //这里不能使用item直接拿，因为item代表的是内容，当然数量是相同的，但是
    for (UIView* tabBarButton in self.subviews) {
        if([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            if(i == 2){
                i++;
            }
            tabBarButton.frame = CGRectMake(i++*btnW, 0, btnW, btnH);
        }
    }
    //调整发布按钮位置
    self.publishButton.center = CGPointMake(self.dsy_width*0.5, self.dsy_height*0.5);
}
@end
