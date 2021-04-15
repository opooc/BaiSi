//
//  DSYNewViewController.m
//  Budejie
//
//  Created by opooc on 2021/4/13.
//

#import "DSYNewViewController.h"
#import "DSYSubTagViewController.h"
@interface DSYNewViewController ()

@end

@implementation DSYNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    [self setupNavBar];
}
-(void)setupNavBar{

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" highImageName:@"MainTagSubIconClick" addTarget:self action:@selector(tagClick)];

    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
}
-(void)tagClick{
    DSYSubTagViewController* subTagVc = [[DSYSubTagViewController alloc]init];
    [self.navigationController pushViewController:subTagVc animated:YES];
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
