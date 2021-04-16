//
//  DSYFriendShipViewController.m
//  Budejie
//
//  Created by opooc on 2021/4/8.
//

#import "DSYFriendShipViewController.h"
#import "DSYLoginRegisterViewController.h"
@interface DSYFriendShipViewController ()

@end

@implementation DSYFriendShipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
}
- (IBAction)clickLoginRegister:(id)sender {
    DSYLoginRegisterViewController* lgVc = [[DSYLoginRegisterViewController alloc]init];
    [self presentViewController:lgVc animated:YES completion:nil];
}
-(void)setupNavBar{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"friendsRecommentIcon" highImageName:@"friendsRecommentIcon-click" addTarget:self action:@selector(friendsRecomment)];
    self.navigationItem.title = @"我的关注";
}
-(void)friendsRecomment{
   
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
