//
//  DSYMeViewController.m
//  Budejie
//
//  Created by opooc on 2021/4/8.
//
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>

#import "DSYMeViewController.h"
#import "DSYSettingViewController.h"
#import "DSYSquareCell.h"
#import "DSYSquareItem.h"


static NSString* const ID =@"cell";
@interface DSYMeViewController () <UICollectionViewDataSource>
@property(nonatomic,strong) NSArray* squareItems;
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
}
-(void)loadData{
    AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];

    [mgr GET:@"http://localhost:8080/baisi/mine" parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DSYLog(@"%@",responseObject);

        self.squareItems = [DSYSquareItem mj_objectArrayWithKeyValuesArray:responseObject];
        [self.collectionView reloadData];
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
}

-(void)setupFootView{
    //初始化要设置流水 ->要注册cell -》自定义cell
    //宽度自己管不了
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    
    NSInteger cols = 4;
    CGFloat margin = 1;
    CGFloat itemWH = (DSYScreenW - (cols - 1)*margin) / cols;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    //设置行间距，和列间距
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = collectionView;
    collectionView.dataSource = self;
    
    [collectionView registerNib:[UINib nibWithNibName:@"DSYSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier: ID];
    
}
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
