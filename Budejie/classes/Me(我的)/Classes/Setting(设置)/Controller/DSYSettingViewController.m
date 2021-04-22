//
//  DSYSettingViewController.m
//  Budejie
//
//  Created by opooc on 2021/4/13.
//
#import <SDWebImage.h>
#import <SVProgressHUD/SVProgressHUD.h>

#import "DSYSettingViewController.h"
#import "UIBarButtonItem+item.h"
#import "DSYFileTool.h"
static NSString *ID = @"cell";
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject]
@interface DSYSettingViewController ()
@property(nonatomic,assign) NSInteger totalSize;
@end

@implementation DSYSettingViewController
/*UITableViewController 的方法调用顺序
 viewWillLayoutSubviews
 numberOfSectionsInTableView
 numberOfRowsInSection
 cellForRowAtIndexPath
 heightForRowAtIndexPath
 viewDidLoad
 viewWillAppear
 viewDidAppear
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [SVProgressHUD showWithStatus:@"正在计算缓存大小..."];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"jump" style:UIBarButtonItemStylePlain target:self action:@selector(jump)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    //计算缓存文件的大小，先存起来；
    //这里一定得考虑清楚线程的问题
    [DSYFileTool getFileSize:CachePath completion:^(NSInteger totalSize) {
        //这个totalSize是Block 的参数,是从里面拿到的数据，相当于调这个方法的一个返回值
        self.totalSize = totalSize;
        //这里要在主线程刷进一下
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
 
    
}

//-(void) back{
//    [self.navigationController popViewControllerAnimated:YES];
//}

-(void)jump{
    //查看缓存文件夹的位置
//    NSLog(@"%@",NSHomeDirectory());cache中缓存名字做了加密,防止文件重名
    //通过下面的方法，可以拿到Cache的缓存量

/*SDWebImage的获取文件大小的方法的本质
 NSUInteger size = 0;
 NSDirectoryEnumerator *fileEnumerator = [self.fileManager enumeratorAtPath:self.diskCachePath];
 for (NSString *fileName in fileEnumerator) {
     NSString *filePath = [self.diskCachePath stringByAppendingPathComponent:fileName];
     NSDictionary<NSString *, id> *attrs = [self.fileManager attributesOfItemAtPath:filePath error:nil];
     size += [attrs fileSize];
 }
 return size;
 */
//使用sd的方法拿
//    NSUInteger size =  [[SDImageCache sharedImageCache]totalDiskSize];
//    DSYLog(@"%ld",size);

}
/*已经抽成了DSYFileTool
//自己设计拿到文件尺寸
-(NSInteger ) getFileSize :(NSString *)driectoryPath{

    //获取文件管理者
    NSFileManager* mgr = [NSFileManager defaultManager];
    //拿到文件夹下所有文件的子路径
    NSArray*subPaths =  [mgr subpathsAtPath:driectoryPath];
    //用一个变量保存下
    NSInteger totalSize = 0 ;
    for (NSString* subPath in subPaths) {
        NSString* filePath = [driectoryPath stringByAppendingPathComponent:subPath];
        if ([filePath containsString:@".DS"]) {
            //是隐藏文件啥也不做
            continue;
        }
        //判断是否是文件夹
        BOOL isDirectort;
        BOOL isExsit = [mgr fileExistsAtPath:filePath isDirectory: &isDirectort];//返回值是文件是否存在,但是用不到
        if(!isExsit||isDirectort)continue;;
        //获取文件属性，只能拿文件尺寸，获取文件夹拿不到
        NSDictionary* fDic = [mgr attributesOfItemAtPath:filePath error:nil];
        NSInteger fileSize = [fDic fileSize];
        totalSize +=fileSize;
    }
    
    return totalSize;
}

*/
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.textLabel.text = [self sizeStr];
    return cell;
}
//文件夹小的时候可以用，文件夹非常大的时候，
-(NSString *)sizeStr{
    //计算缓存数据,沙盒文件夹？3个文件夹?=>Cache的大小,尺寸
    //自己写方法拿
        //获取沙盒中Cache文件的路径 、这个方法也能Documents的路径,拿不了SystemData和tmp的
        //第二个参数是获取范围,第三个参数是 是否展开 ,
    //已经声明称宏了
//    NSString* cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    //获取default文件路径,下面的path的拼接方法 会自动把字符串拼接成路径
//    NSString* defaultPath = [cachePath stringByAppendingPathComponent  :@"com.hackemist.SDImageCache/default"];

    NSString* sizeStr = @"清除缓存";
    NSInteger totalSize = self.totalSize;
    if(totalSize > 1000*1000){
        CGFloat sizeF = totalSize / 1000.0/1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeF];
    }else if(totalSize >1000){
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
    }else if(totalSize>0){
        CGFloat sizeF = totalSize ;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fB)",sizeStr,sizeF];
    }
    return sizeStr;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [DSYFileTool removeDirctoryPath:CachePath];//testException
    self.totalSize = 0;
    //重新加载tableView
    [self.tableView reloadData];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
