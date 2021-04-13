//
//  DSYEssenceViewController.m
//  Budejie
//
//  Created by opooc on 2021/4/8.
//

#import "DSYEssenceViewController.h"

@interface DSYEssenceViewController ()

@end

@implementation DSYEssenceViewController

- (void)viewDidLoad {
    [self setupNavBar];
}
-(void)setupNavBar{
    /*在之前的版本中，导航条会对button做一定的处理，导致点击范围变大,现在没有这个bug了
     [btn sizeToFit];
     UIView* containView = [[UIView alloc]initWithFrame:btn.bounds];
     [containView addSubview:btn];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:containView];
     */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"nav_item_game_icon" highImageName:@"nav_item_game_click_icon" addTarget:self action:@selector(game)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationButtonRandom" highImageName:@"navigationButtonRandomClick" addTarget:nil action:nil];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
}
-(void) game{
    DSYFunc;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
