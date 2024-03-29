//
//  DSYMeViewController.m
//  Budejie
//
//  Created by opooc on 2021/4/8.
//
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
//#import <SafariServices/SafariServices.h>
#import <WebKit/WebKit.h>

#import "DSYMeViewController.h"
#import "DSYSettingViewController.h"
#import "DSYSquareCell.h"
#import "DSYSquareItem.h"
#import "DSYWebViewController.h"


static NSInteger cols = 4;
static CGFloat margin = 1;
#define itemWH ((DSYScreenW - (cols - 1)*margin) / cols)

static NSString* const ID =@"cell";
//SFSafariViewControllerDelegate
@interface DSYMeViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong) NSMutableArray* squareItems;
@property(nonatomic,weak) UICollectionView *collectionView;
@end

@implementation DSYMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航
    [self setupNavBar];
    //设置底部视图
    [self setupFootView];
    //展示方块内容
    [self loadData];
    //tableView分组样式，有额外的头部和尾部间距
    [self changeSpacing];
}
-(void)changeSpacing{
    //这样设置后，最顶部是不算的
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;

    //最顶部的间距处理;整体上偏移 ，默认-25 = cell的35 -10
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",NSStringFromCGRect(cell.frame));
}
- (void)viewWillAppear:(BOOL)animated{
    //查看tabview的内边距
    DSYLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.contentInset));
}
*/
-(void)loadData{
    AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];

    [mgr GET:@"http://localhost:8080/baisi/mine" parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //设置cell的数据,并重新加载
        self.squareItems = [DSYSquareItem mj_objectArrayWithKeyValuesArray:responseObject];
        //判断数据是否满行。不够就补一下,让UI好看一些
        [self resloveData];
        //加载数据,刷新表格
        [self.collectionView reloadData];

        //计算collectionView的高度 = rows*itemWH;
        //万能公式rows = (count -1)/cols +1;
        NSInteger count = self.squareItems.count;
        NSInteger rows  = (count -1)/cols +1;
        //设置 collectionView的高度,让其自适应
        /*设置self.tableView.contentSize是没有效果的，因为这个的范围是系统自动管理，所以这里只需重新对
          footerView重新赋值就好了，tableView会重新计算自己的高度，开始是没有数据的时候collectionView的高度，即300
         */
        self.collectionView.dsy_height = rows * itemWH;
        //同时要设置footview的高度
        self.tableView.tableFooterView = self.collectionView;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
}
#pragma mark - 处理请求完成数据
-(void)resloveData{
    NSInteger count = self.squareItems.count;
    NSInteger exter = cols - count%cols;
    for(int i = 0 ;i<exter ;i++){
        DSYSquareItem *item = [[DSYSquareItem alloc]init];
        [self.squareItems addObject:item];
    }
}
-(void)setupFootView{
    //初始化要设置流水 ->要注册cell -》自定义cell
    //宽度自己管不了
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    //设置行间距，和列间距
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = collectionView;
    //设置collectionView不能滚动
    collectionView.scrollEnabled = NO;
    collectionView.dataSource    = self;
    collectionView.delegate      = self;
    
    [collectionView registerNib:[UINib nibWithNibName:@"DSYSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier: ID];
    
}
#pragma mark - 处理小格子
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //跳转网页:1.Safari 2.UIWebView（不能上架了） 3.SFSafariViewController(不怎么用)
    //4.WKWebView可以1监听进度 2.缓存
    DSYSquareItem* item =  self.squareItems[indexPath.item];
    if(![item.url containsString:@"http"])return;
    //使用方式3
//    SFSafariViewController* safariVc = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:item.url]];
//    safariVc.delegate = self;
    //如果用导航栏 push的方式，就需要隐藏一下顶部导航，隐藏后在 返回的时候，还要记得显示导航栏
//    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController pushViewController:safariVc animated:YES];
    //苹果推荐 Modal，但是底层对自动做push，导航栏也不用自己用;
//    [self presentViewController:safariVc animated:YES completion:nil];
    
    //使用方式4
    DSYWebViewController* webVc = [[DSYWebViewController alloc]init];
    webVc.urlstring = item.url;
    [self.navigationController pushViewController:webVc animated:YES];
                      
}
#pragma mark - SFSafariViewControllerDelegate
//- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
//    [self.navigationController popViewControllerAnimated: YES];
//}

#pragma mark - 返回小格子的数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.squareItems.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DSYSquareCell* cell =  [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.squareItem = self.squareItems[indexPath.item];
    return cell;
}

-(void)setupNavBar{
    UIBarButtonItem* settingItem = [UIBarButtonItem itemWithImageName:@"mine-setting-icon" highImageName:@"mine-setting-icon-click" addTarget:self action:@selector(setting)];
    //为了做选中状态,这里最好单独抽一个方法来处理
    UIBarButtonItem* nightItem = [UIBarButtonItem itemWithImageName:@"mine-moon-icon" selImageName:@"mine-moon-icon-click" addTarget:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
    self.navigationItem.title = @"我的";
}

-(void)night:(UIButton *)button{
    //按钮一点击，把按钮自身传进来了
    button.selected = !button.selected;
}
-(void)setting{
    DSYSettingViewController* settingVc = [[DSYSettingViewController alloc]init];
    //隐藏底部tabbar ,必须在显示之前设置,不能放到settingVc这个控制器里面
    //settingVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVc animated:YES];
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
