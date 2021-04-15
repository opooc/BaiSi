//
//  DSYAdItem.h
//  Budejie
//
//  Created by opooc on 2021/4/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSYAdItem : NSObject

//广告地址
@property(nonatomic,strong) NSString *wpi_curl;
//点击广告的调转页面
@property(nonatomic,strong) NSString *pri_curl;

@end

NS_ASSUME_NONNULL_END
