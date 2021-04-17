//
//  DSYSquareCell.m
//  Budejie
//
//  Created by opooc on 2021/4/17.
//
#import <UIImageView+WebCache.h>

#import "DSYSquareCell.h"
#import "DSYSquareItem.h"

@interface DSYSquareCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation DSYSquareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSquareItem:(DSYSquareItem *)squareItem{
    _squareItem = squareItem;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:squareItem.icon]];
    self.nameLabel.text = squareItem.name;
    
}
@end
