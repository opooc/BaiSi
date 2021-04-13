//
//  AppDelegate.m
//  Budejie
//
//  Created by opooc on 2021/4/8.
//

#import "AppDelegate.h"
#import "DSYTabBarController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1.创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //2.设置控制器
    DSYTabBarController* tabBarVc = [[DSYTabBarController alloc]init];
    self.window.rootViewController = tabBarVc;
    
    //3.显示窗口  
    [self.window makeKeyAndVisible];
    return YES;
}
  
@end
