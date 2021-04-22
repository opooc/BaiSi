//
//  DSYFileTool.m
//  Budejie
//
//  Created by opooc on 2021/4/19.
//

#import "DSYFileTool.h"

@implementation DSYFileTool
//异步处理的时候，就不用设置返回值了，直接使用block回调就可以了;            //这里的NSInteger是block里面的返回值
+(void) getFileSize :(NSString *)driectoryPath completion:(void(^)(NSInteger))completion{
    //获取文件管理者
    NSFileManager* mgr = [NSFileManager defaultManager];
    //判断穿过来的string是否是文件夹路径
    BOOL isDirectort;
    BOOL isExsit = [mgr fileExistsAtPath:driectoryPath isDirectory: &isDirectort];
    if(!isExsit||!isDirectort){
        //当传过来的不是一个文件的时候，直接抛异常
        //name就是异常的名称 随便取 ， reason 就是报错的原因 ,
       NSException* excp = [NSException exceptionWithName:@"pathError" reason:@"需要传入文件夹的路径，并且路径要存在" userInfo:nil];
        [excp raise];
    }
    //用一个变量保存下
    static NSInteger totalSize = 0 ;
    //考虑线程的异步问题
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //拿到文件夹下所有文件的子路径
        NSArray*subPaths =  [mgr subpathsAtPath:driectoryPath];

        for (NSString* subPath in subPaths) {
            NSString* filePath = [driectoryPath stringByAppendingPathComponent:subPath];
            if ([filePath containsString:@".DS"]) {
                //是隐藏文件啥也不做
                continue;
            }
            //判断是否是文件夹,保证所有文件参与计算，文件夹不参与
            BOOL isDirectort;
            BOOL isExsit = [mgr fileExistsAtPath:filePath isDirectory: &isDirectort];//返回值是文件是否存在,但是用不到
            if(!isExsit||isDirectort)continue;;
            //获取文件属性，只能拿文件尺寸，获取文件夹拿不到
            NSDictionary* fDic = [mgr attributesOfItemAtPath:filePath error:nil];
            NSInteger fileSize = [fDic fileSize];
            totalSize += fileSize;
        }
        //回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{
            //计算完成后做的回调 ，拿到block
            if (completion) {
                completion(totalSize);
            }
        });
    });
}
+(void) removeDirctoryPath:(NSString *)driectoryPath{
    //获取文件管理者
    NSFileManager* mgr = [NSFileManager defaultManager];
    //判断穿过来的string是否是文件夹路径
    BOOL isDirectort;
    BOOL isExsit = [mgr fileExistsAtPath:driectoryPath isDirectory: &isDirectort];
    if(!isExsit||!isDirectort){
        //当传过来的不是一个文件的时候，直接抛异常
        //name就是异常的名称 随便取 ， reason 就是报错的原因 ,
       NSException* excp = [NSException exceptionWithName:@"pathError" reason:@"需要传入文件夹的路径，并且路径要存在" userInfo:nil];
        [excp raise];
    }
    //清空缓存，回去文件管理者
    //获取caches文件夹路径,不包括子路径,Sub那个方法 是包含子路径的
    NSArray* subPaths = [mgr contentsOfDirectoryAtPath:driectoryPath error:nil];
    for (NSString* subPath in subPaths) {
        //拼接路径
        NSString* filePath = [driectoryPath stringByAppendingPathComponent:subPath];
        //使用removeItem..删除
        [mgr removeItemAtPath:filePath error:nil];
    }
}

@end
