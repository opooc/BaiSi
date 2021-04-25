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

//[[UIApplication sharedApplication] delegate];其他类通过这个方法拿到AppDelegate,
//但是要在这个类中遵守协议，在其他类中，对上面的方法使用(id<UIxxxxDelegate>)就可以完美实现


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupRootWindow];
//    [self setupAllSDK];

    return YES;
}

@end
