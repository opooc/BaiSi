//
//  DSYLoginRegister.m
//  Budejie
//
//  Created by opooc on 2021/4/16.
//

#import "DSYLoginRegisterView.h"

@interface DSYLoginRegisterView()

@property (weak, nonatomic) IBOutlet UIButton *loginRegisterButton;


@end
//越复杂的界面，封装，有特殊效果的界面，也需要封装
@implementation DSYLoginRegisterView

+(instancetype) loginView{
    return  [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}
+(instancetype) registerView{
    return  [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
- (void)awakeFromNib{
    [super awakeFromNib];
    //拿到当前的按钮的背景图片，对其的高度和宽度进行调整。让其不压缩。
    UIImage* image = _loginRegisterButton.currentBackgroundImage ;
    image =[image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height*0.5];
    [_loginRegisterButton setBackgroundImage:image forState:UIControlStateNormal];
}

@end
