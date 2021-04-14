//
//  AppDelegate+RootWindow.m
//  Budejie
//
//  Created by opooc on 2021/4/14.
//

#import "AppDelegate+RootWindow.h"
#import "DSYAdViewController.h"

@implementation AppDelegate (RootWindow)

-(void)setupRootWindow{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    DSYAdViewController* adVc = [[DSYAdViewController alloc]init];
    self.window.rootViewController = adVc;
    [self.window makeKeyAndVisible];
}
@end
