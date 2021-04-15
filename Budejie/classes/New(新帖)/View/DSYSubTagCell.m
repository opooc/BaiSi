//
//  DSYSubTagCell.m
//  Budejie
//
//  Created by opooc on 2021/4/15.
//
#import <UIImageView+WebCache.h>

#import "DSYSubTagCell.h"


@interface DSYSubTagCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;


@end

@implementation DSYSubTagCell

-(void)setItem:(DSYSubTagItem *)item{
    _item = item;
    self.nameLabel.text = item.theme_name;
    
    NSString* numStr = [NSString stringWithFormat:@"%@人订阅",item.sub_number];
    if(numStr.intValue >10000){
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",item.sub_number.intValue/10000.0];
    }
    self.numLabel.text  = numStr;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"friendsRecommentIcon"]];//占位图
    
}
//从xib加载就会调用，且只会调用一次
- (void)awakeFromNib {
    //使用Product中的profile的CoreAnimation可以测动画测帧率
    [super awakeFromNib];
    //这里是使用xib图片的runtime的形式，直接在xib中进行了裁剪 
//    self.iconView.layer.cornerRadius = 30;
//    self.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
