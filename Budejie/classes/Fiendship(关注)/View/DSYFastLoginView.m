//
//  DSYFastLoginView.m
//  Budejie
//
//  Created by opooc on 2021/4/16.
//

#import "DSYFastLoginView.h"

@implementation DSYFastLoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype) fastLoginView {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}
@end
