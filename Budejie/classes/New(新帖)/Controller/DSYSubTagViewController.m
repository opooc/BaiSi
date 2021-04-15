//
//  DSYSubTagViewController.m
//  Budejie
//
//  Created by opooc on 2021/4/14.
//
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>

#import "DSYSubTagViewController.h"
#import "DSYSubTagItem.h"
#import "DSYSubTagCell.h"
@interface DSYSubTagViewController ()

@property(nonatomic,strong) NSArray* subTags;

@end

@implementation DSYSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    //使用下面的注册方法就不用进行xib绑定了，也不用判断cell是否为空了
    //self.tableView registerNib: forCellReuseIdentifier:
    self.title = @"推荐标签";//底层会对self.tableBarItem 和 self.navigationItem赋值;
}
-(void)loadData{
    AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [mgr GET:@"http://localhost:8080/baisi/SubTag" parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.subTags = [DSYSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        //刷新表格
        [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DSYLog(@"failure");
        }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.subTags.count;
}

//下面这两个一定得一起设置，才能保证tableView的高度在缓存池中能够适配
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* ID = @"cell";
    DSYSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        //创建系统的cell
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //loadNibName可以直接写名字
        //使用xib创建一定要记得在xib中绑定cell
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DSYSubTagCell class]) owner:nil options:nil][0];
    }
    DSYLog(@"%p",cell);
    cell.item = self.subTags[indexPath.row];
    return cell;
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
