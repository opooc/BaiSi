//
//  DSYFileTool.h
//  Budejie
//
//  Created by opooc on 2021/4/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSYFileTool : NSObject
/**
 获取文件夹尺寸
 */
+(void) getFileSize :(NSString *)driectoryPath completion:(void(^)(NSInteger))completion;
/**
 移除文件夹下所有的文件
 */
+(void) removeDirctoryPath:(NSString *)driectoryPath;

@end

NS_ASSUME_NONNULL_END
