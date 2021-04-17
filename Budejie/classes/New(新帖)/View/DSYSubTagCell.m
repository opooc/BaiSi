//
//  DSYSubTagCell.m
//  Budejie
//
//  Created by opooc on 2021/4/15.
//
#import <UIImageView+WebCache.h>

#import "DSYSubTagCell.h"
#import "UIImage+CircleImage.h"


@interface DSYSubTagCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;


@end

@implementation DSYSubTagCell

- (void)setFrame:(CGRect)frame{
    //CGRect是可以直接改值得，是一种c语法,但是如果是self.xxx.frame 这样就相当于发送消息，进行消息传递了
    frame.size.height -=1;
    [super setFrame:frame];
}

-(void)setItem:(DSYSubTagItem *)item{
    _item = item;
    self.nameLabel.text = item.theme_name;
    [self resolveNum];
//    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"friendsRecommentIcon"]options: SDWebImageProgressiveLoad completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        self.iconView.image = [image circleImage];
//    }];//占位图
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"friendsRecommentIcon"]];
}
//处理订阅的数字
-(void)resolveNum{
    NSString* numStr = [NSString stringWithFormat:@"%@人订阅",_item.sub_number];
    if(numStr.intValue >10000){
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",_item.sub_number.intValue/10000.0];
        [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    self.numLabel.text  = numStr;
}
//从xib加载就会调用，且只会调用一次
- (void)awakeFromNib {
    //使用Product中的profile的CoreAnimation可以测动画测帧率
    [super awakeFromNib];
    //这里也可以使用xib图片的runtime的形式，直接在xib中进行了裁剪
    //也可以使用画图的形式
    self.layoutMargins = UIEdgeInsetsZero;
    
    self.iconView.layer.cornerRadius = 30;
    self.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
