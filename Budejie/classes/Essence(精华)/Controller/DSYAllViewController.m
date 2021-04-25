//
//  DSYAllViewController.m
//  Budejie
//
//  Created by opooc on 2021/4/24.
//

#import "DSYAllViewController.h"

@interface DSYAllViewController ()
@property(nonatomic,weak)UIView* footerView;
@property(nonatomic,weak)UILabel* footerLabel;
@property(nonatomic,assign,getter=isFooterRefreshing)BOOL footerRefreshing;
@property(nonatomic,assign)NSInteger dataCount;
@end

@implementation DSYAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化模拟数据
    self.dataCount = 20;
    //这里的穿透如果设置给scrollView，就会导致tableView达不到最上面的位置 。
    self.tableView.contentInset = UIEdgeInsetsMake(DSYTitlesViewH + DSYNavMaxY, 0, DSYTabBarH, 0);
    self.tableView.contentOffset = CGPointMake(0, -(DSYTitlesViewH + DSYNavMaxY));//当加入foot的时候，会导致tableView自动往上跑一块，所以要主动让他下来
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(DSYTitlesViewH , 0, 0, 0);//设置滚动条
    //接收通知.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarDidRepeatClick) name:DSYTabBarItemDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleBtnDidRepeatClick) name:DSYTitleBtnDidRepeatClickNotification object:nil];
    [self setupRefrash];
}

#pragma mark -上拉刷新控件
-(void)setupRefrash{
    UIView* footerView = [[UIView alloc]init];
    footerView.frame   = CGRectMake(0, 0, DSYScreenW, 35);//这里拿不到tableView的宽度
    UILabel* textLabel = [[UILabel alloc]init];
    textLabel.frame    = footerView.bounds;
    textLabel.text     = @"上拉可以加载更多";
    textLabel.backgroundColor = [UIColor redColor];
    textLabel.textColor       = [UIColor whiteColor];
    textLabel.textAlignment   = NSTextAlignmentCenter;
    [footerView addSubview:textLabel];
    self.tableView.tableFooterView = footerView;
    self.footerView  = footerView;
    self.footerLabel = textLabel;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //减少一半的footer- self.tableView.tableFooterView.dsy_height * 0.5
    CGFloat offY = scrollView.contentSize.height - scrollView.dsy_height + scrollView.contentInset.bottom ;
    //底部完全展示的时候tableView偏移的Y = 内容高 -(本身高+偏移)
    NSLog(@"%f",offY);
    //本来就啥也没有 或者 正在刷新 不用判断
    if(self.tableView.contentSize.height == self.tableView.tableFooterView.dsy_height ||[self isFooterRefreshing])return;
    if(scrollView.contentOffset.y >= offY){
        self.footerRefreshing = YES;
        self.dataCount += 6;
        [self.tableView reloadData];
        self.footerLabel.text = @"正在加载更多数据...";
        self.footerLabel.backgroundColor = [UIColor blueColor];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.footerRefreshing = NO;

            self.footerLabel.text     = @"上拉可以加载更多";
            self.footerLabel.backgroundColor = [UIColor redColor];
        });
        
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)tabBarDidRepeatClick{
    //自己的窗口没有，说明当前情况本控制器的view不用刷新
    if (self.view.window == nil) return;
    //是当前控制器，但不是本view,因为当时怕有点击最上方没有刷新的问题，设置过只能有一个刷新，故此时可以复用
    if (self.tableView.scrollsToTop == NO) return;
    
}
-(void)titleBtnDidRepeatClick{
    //因为标题和tab的操作一样，直接调就可以
    [self tabBarDidRepeatClick];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections/var/folders/19/bld3vk392771j16qwtn5q2lh0000gn/T/simulator_screenshot_69DE9E18-A351-4171-8DF2-EBBEFF7ADB1F.png
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    self.footerView.hidden = (self.dataCount == 0);
    return self.dataCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* ID = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%d",self.class,indexPath.row];
   
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
