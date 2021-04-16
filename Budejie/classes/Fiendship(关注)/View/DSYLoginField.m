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
    //监听文本框的编辑，：1.代理，2，通知，3target(常用)
    //原则：自己不要成为自己的代理
    //
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    //设置开始时候默认颜色,方式1
    [self setupPlaceholderColor:[UIColor lightGrayColor]];
    //站位文字的文字的本质是一个label,这个时候想要拿到这个label可以使用Runtime,2通过断点去查。
//    设置默认颜色，方式2,这种KVC方法使用时，一定不能
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = [UIColor redColor];
    //方式3，自己封装一下成UITextField分类的形式
//    [self textEnd];
    
    //方式4.runtime的方式
    self.placeholder = @"123123123";
}

//文本框开始编辑调用
- (void)textBegin{
    // 这个方法是用来做图文混排的
    // [NSAttributedString attributedStringWithAttachment:]
//    [self setupPlaceholderColor:[UIColor whiteColor]];
    //调找个方法
//    [self usePlacholderColor:[UIColor whiteColor]];
    
//    [self setDsy_Placeholder:@"123"];
}
-(void)textEnd{
//    [self setupPlaceholderColor:[UIColor lightGrayColor]];
//    [self usePlacholderColor:[UIColor lightGrayColor]];
    
}
@end
