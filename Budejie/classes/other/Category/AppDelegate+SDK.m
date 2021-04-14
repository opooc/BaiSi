//
//  AppDelegate+SDK.m
//  Budejie
//
//  Created by opooc on 2021/4/14.
//

#import "AppDelegate+SDK.h"
#import <BmobSDK/Bmob.h>
@implementation AppDelegate (SDK)
-(void)setupAllSDK{
    [Bmob registerWithAppKey:@"c5e637fb8c35a31dc67b501ad8872ff9"];
}
@end
