//
//  DSYViewController.m
//  Budejie
//
//  Created by opooc on 2021/4/8.
//

#import "DSYTabBarController.h"
#import "DSYEssenceViewController.h"
#import "DSYNewViewController.h"
#import "DSYPublishViewController.h"
#import "DSYFriendShipViewController.h"
#import "DSYMeViewController.h"
#import "UIImage+image.h"
#import "DSYTabBar.h"
@interface DSYTabBarController ()

@end

@implementation DSYTabBarController
+(void)load{
    UITabBarItem* item =  [UITabBarItem appearanceWhenContainedIn:self,nil];
    NSMutableDictionary* dicC = [NSMutableDictionary dictionary];
    dicC[NSForegroundColorAttributeName] = [UIColor blackColor ];
    [item setTitleTextAttributes:dicC forState:UIControlStateSelected];
    
    NSMutableDictionary* dicA = [NSMutableDictionary dictionary];
    dicA[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:dicA forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllChildViewController];
    [self setupAllTitleButton];
    [self setupTabBar];
}
-(void)setupTabBar{
    
    DSYTabBar* tabBar = [[DSYTabBar alloc]init];
    
    [self setValue:tabBar forKey:@"tabBar"];
}
-(void)setupAllChildViewController{
    DSYEssenceViewController* essenceVc = [[DSYEssenceViewController alloc]init];
    UINavigationController* nav1        = [[UINavigationController alloc]initWithRootViewController:essenceVc];
    [self addChildViewController:nav1];
    
    DSYNewViewController* newVc  = [[DSYNewViewController alloc]init];
    UINavigationController* nav2 = [[UINavigationController alloc]initWithRootViewController:newVc];
    [self addChildViewController:nav2];
    
    DSYFriendShipViewController* friendshipVc = [[DSYFriendShipViewController alloc]init];
    UINavigationController* nav3              = [[UINavigationController alloc]initWithRootViewController:friendshipVc];
    [self addChildViewController:nav3];
    
    DSYMeViewController* meVc    = [[DSYMeViewController alloc]init];
    UINavigationController* nav4 = [[UINavigationController alloc]initWithRootViewController:meVc];
    [self addChildViewController:nav4];
}
-(void)setupAllTitleButton{
    UINavigationController* nav1  = self.childViewControllers[0];
    nav1.tabBarItem.title         = @"精华";
    nav1.tabBarItem.image         = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];
    
    UINavigationController* nav2  = self.childViewControllers[1];
    nav2.tabBarItem.title         = @"新帖";
    nav2.tabBarItem.image         = [UIImage imageNamed:@"tabBar_new_icon"];  
    nav2.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];
    
//    DSYPublishViewController* publishVc = self.childViewControllers[2];
//    publishVc.tabBarItem.image          = [UIImage imageOriginalWithName:@"tabBar_publish_icon"];
//    publishVc.tabBarItem.selectedImage  = [UIImage imageOriginalWithName:@"tabBar_publish_click_icon"];
    
    UINavigationController* nav3  = self.childViewControllers[2];
    nav3.tabBarItem.title         = @"关注";
    nav3.tabBarItem.image         = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"];
    
    UINavigationController* nav4  = self.childViewControllers[3];
    nav4.tabBarItem.title         = @"我的";
    nav4.tabBarItem.image         = [UIImage imageNamed:@"tabBar_me_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];
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
