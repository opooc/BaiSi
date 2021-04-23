//
//  DSYEssenceViewController.m
//  Budejie
//
//  Created by opooc on 2021/4/8.
//

#import "DSYEssenceViewController.h"
#import "DSYtitleButton.h"

@interface DSYEssenceViewController ()
@property(nonatomic,weak)UIView* titleview;
@property(nonatomic,weak)UIButton* priClickBtn;
@end

@implementation DSYEssenceViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    
    //设置当行条
    [self setupNavBar];
    //scrollView
    [self setupScrollView];
    //标题栏
    [self setupTitlesView];
}
-(void)setupNavBar{
    /*在之前的版本中，导航条会对button做一定的处理，导致点击范围变大,现在没有这个bug了
     [btn sizeToFit];
     UIView* containView = [[UIView alloc]initWithFrame:btn.bounds];
     [containView addSubview:btn];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:containView];
     */
    self.navigationItem.leftBarButtonItem  = [UIBarButtonItem itemWithImageName:@"nav_item_game_icon" highImageName:@"nav_item_game_click_icon" addTarget:self action:@selector(game)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationButtonRandom" highImageName:@"navigationButtonRandomClick" addTarget:self action:nil];
    self.navigationItem.titleView          = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
}
-(void)setupScrollView{
    UIScrollView* scrollView   = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.frame           = self.view.bounds;
    [self.view addSubview:scrollView];
//    如果向scrollView添加子控件,会自动偏移64+30，往下移动是因为scrollView碰到导航栏自带内边距
//    UISwitch* s = [[UISwitch alloc]init];
//    s.dsy_x = 0;s.dsy_y = 0;
//    [scrollView addSubview:s];
//    按钮中的控件是懒加载的，用到的时候才会创建,背景，图片，文字都是懒加载 UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [UIImage imagenamed];只能加载assets中的文件 ，加载外面的bundle要添加路径.「bundle文件」/文件名
    
}
-(void)setupTitlesView{
    UIView *titleView         = [[UIView alloc]init];
    //半透明，如果设置控件的alpha会导致文字也会变得透明,应该使用颜色的alpha,
    //[UIColor colorWithWhite:1.0 alpha:0.5];可以达到相同的效果
    //[[UIColor whiteColor]colorWithAlphaComponent:0.5];
    titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    titleView.frame           = CGRectMake(0, 88, self.view.dsy_width, 35);    //iphone的高度是88;
    self.titleview            = titleView;
    [self.view addSubview:titleView];
    
    //标题栏按钮
    [self setupTitleButton];
    //标题下划线
    [self setupTitleUnderline];
}
-(void)setupTitleButton{
    //文字
    NSArray *titleArr = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSUInteger count  =  titleArr.count;
    CGFloat titleBtnW = self.titleview.dsy_width/count;
    CGFloat titleBtnH = self.titleview.dsy_height;
    for (NSInteger i = 0; i<count; i++) {
        DSYtitleButton* titleBtn = [[DSYtitleButton alloc]init];
        [titleBtn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        titleBtn.frame           = CGRectMake(i*titleBtnW, 0, titleBtnW, titleBtnH);
//        titleBtn.backgroundColor = DSYRandomColor;
        [titleBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        //按钮选设置了选中装填，normal下的高亮正常，选中状态下的点击的高粱状态就会失效，直接就是normal,
        //使用自定义按钮可以避免上面的多种状态的模式
        //让按钮无法点击的两种方法：设置enabled;设置不可交互
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [titleBtn setTitleColor:DSYRandomColor forState:UIControlStateHighlighted];
        if (i == 0) {
            titleBtn.selected = YES;
            self.priClickBtn = titleBtn;
        }
        [self.titleview addSubview:titleBtn];
    }
}
-(void)setupTitleUnderline{
    
}
#pragma mark -监听
-(void)titleButtonClick:(UIButton *)titleBtn{
    self.priClickBtn.selected = NO;
    titleBtn.selected = YES;
    self.priClickBtn = titleBtn;
}

-(void) game{
    DSYFunc;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
