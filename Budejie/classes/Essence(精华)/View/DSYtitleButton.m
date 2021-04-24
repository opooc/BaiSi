//
//  DSYtitleButton.m
//  Budejie
//
//  Created by opooc on 2021/4/23.
//

#import "DSYtitleButton.h"

@implementation DSYtitleButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//初始化子控件
//NS_DESIGNATED_INITIALIZER是指定构造方法,特点是子类如果重写父类，那么必须用super调用父类的方法，不然会报警告;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        //按钮选设置了选中装填，normal下的高亮正常，选中状态下的点击的高粱状态就会失效，直接就是normal,
        //使用自定义按钮可以避免上面的多种状态的模式
        //让按钮无法点击的两种方法：设置enabled;设置不可交互
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted{
    //不让它干事
}

//布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
}
//在模型的初始化方法中 给控件传数据
@end
