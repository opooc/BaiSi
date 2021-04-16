//
//  DSYFastButton.m
//  Budejie
//
//  Created by opooc on 2021/4/16.
//

#import "DSYFastButton.h"

@implementation DSYFastButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews{
    [super layoutSubviews];
    //设置图片位置
    self.imageView.dsy_y = 0;
    self.imageView.dsy_centerX = self.dsy_width * 0.5;
    
    //设置标题位置
    self.titleLabel.dsy_y = self.dsy_height - self.titleLabel.dsy_height;
    [self.titleLabel sizeToFit];//想让文字和label一样大，就用这个方法就可以
    self.titleLabel.dsy_centerX = self.dsy_width * 0.5;
    //设置文字宽度，设置label宽度
//    self.titleLabel.text boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:<#(nullable NSDictionary<NSAttributedStringKey,id> *)#> context:<#(nullable NSStringDrawingContext *)#>
//    [self.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:10]];
    
}

@end
