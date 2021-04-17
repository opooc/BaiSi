//
//  DSYFriendShipViewController.m
//  Budejie
//
//  Created by opooc on 2021/4/8.
//

#import "DSYFriendShipViewController.h"
#import "DSYLoginRegisterViewController.h"
#import "UITextField+Placeholder.h"
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


 /*测试了textFiled的runtime 的修改
 //    self.testField.placeholderColor = [UIColor redColor];
     //此时不适用runtime替换方法，就只能通过这个方法设置占位的文字了;
 //    [self.testField setDsyPlaceholder:@"123"];
 //    self.testField.placeholder =@"123123";
 **/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
