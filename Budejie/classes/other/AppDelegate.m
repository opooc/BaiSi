//
//  AppDelegate.m
//  Budejie
//
//  Created by opooc on 2021/4/8.
//

#import "AppDelegate.h"
#import "AppDelegate+RootWindow.h"
//#import "AppDelegate+SDK.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupRootWindow];
//    [self setupAllSDK];
    return YES;
}
  
@end
