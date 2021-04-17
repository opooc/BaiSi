//
//  DSYLoginField.m
//  Budejie
//
//  Created by opooc on 2021/4/16.
//

#import "DSYLoginField.h"
#import "UITextField+Placeholder.h"
@implementation DSYLoginField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    //当不知道颜色的时候，使用tintColor
    self.tintColor = [UIColor whiteColor];
    //监听文本框的编辑：1.代理 2，通知，3target(常用)原则：自己不要成为自己的代理

    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    //提前设置一下颜色，避免到时候拿不到
    //设置placeholdColor的方式1：使用标准提供
//    NSMutableDictionary* attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attrs];
    
    //现在的问题是，如何向系统一样可以快速设置xx.placeholdColor;
    //查看label属性名的方法：runtime /断点
    //设置placeholdColor的方式2：使用KVC
    //UILabel* lb = [self valueForKey:@"placeholderLabel"];//这里一定不能加下划线，会直接崩掉
    //lb.textColor = [UIColor redColor];
    
    //设置placeholdColor的方式3：把方式2封装,并设置专门的颜色属性
    self.placeholderColor = [UIColor lightGrayColor];
    
    
}

//文本框开始编辑调用
- (void)textBegin{
    // 这个方法是用来做图文混排的[NSAttributedString attributedStringWithAttachment:]
//    NSMutableDictionary* attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//       self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attrs];
    self.placeholderColor = [UIColor whiteColor];
}
//文本框结束编辑调用
-(void)textEnd{
//    NSMutableDictionary* attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//       self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attrs];
    self.placeholderColor = [UIColor lightGrayColor];
}
@end
