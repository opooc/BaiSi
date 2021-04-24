//
//  DSYEssenceViewController.m
//  Budejie
//
//  Created by opooc on 2021/4/8.
//

#import "DSYEssenceViewController.h"
#import "DSYtitleButton.h"
#import "DSYAllViewController.h"
#import "DSYPictureViewController.h"
#import "DSYVideoViewController.h"
#import "DSYVoiceViewController.h"
#import "DSYWorldViewController.h"

@interface DSYEssenceViewController ()
@property(nonatomic,weak)UIView* titleview;
//文字下划线
@property(nonatomic,weak)UIView *titleUnderline;
@property(nonatomic,weak)UIButton* priClickBtn;
@end

@implementation DSYEssenceViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    //初始化自控制器
    [self setupAllChildVcs];
    //设置当行条
    [self setupNavBar];
    //scrollView
    [self setupScrollView];
    //标题栏
    [self setupTitlesView];
}

-(void)setupAllChildVcs{
    [self addChildViewController:[[DSYAllViewController alloc]init]];
    [self addChildViewController:[[DSYPictureViewController alloc]init]];
    [self addChildViewController:[[DSYVideoViewController alloc]init]];
    [self addChildViewController:[[DSYVoiceViewController alloc]init]];
    [self addChildViewController:[[DSYWorldViewController alloc]init]];
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
//UIScrollView在viewDidLoad中加载的时候，会默认加上一个导航栏的高度，在其他地方不会加
//加载xib的时候，[[NSBundle main]loadNibNamed:@""xxx].firstObj,  bundle是文件夹

//从非主资源包加载xib是不行的，因为xib在mainBundle中会编译成nib，而Load这个方法找的就是nib,不在mainB中的不会编译
//    NSURL*url = [NSBundle mainBundle]URLForResource:123 withExtension:123
//    NSBundle xx = [[NSBundle bundleWithURL:url]loadnilName:xxx]//拿bundle
//    [xx URLForResource :@"" withExtension:@""];
//可以用上面的方法，拿图片，Mp3，MP4,也可以使用下面的
//    str = [NSBundle mainBundle]pathForResource:123 ofType:123//直接拿文件,从资源包中拿
//    [UIImage imageWithContentsOfFile:str]直接拿图片,相比imageNamed从资源包中拿没有缓存
-(void)setupScrollView{
    UIScrollView* scrollView   = [[UIScrollView alloc]init];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    scrollView.pagingEnabled = YES;//开启分页功能
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.frame           = self.view.bounds;
    [self.view addSubview:scrollView];
    //tableView 的contentSize是无法控制的
    //直接使用5个tableView不太合理
//    for (NSUInteger i = 0 ; i < 5 ; i++) {
//        UITableView* tableView = [[UITableView alloc]init];
//        tableView.dsy_width = scrollView.dsy_width;
//        tableView.dsy_height = scrollView.dsy_height;
//        tableView.dsy_y = 0;
//        tableView.dsy_x = i * scrollView.dsy_width;
//        //这里可以设置tag，然后在cell等数据源，或者代理源中处理是哪个tableView。
//        tableView.backgroundColor = DSYRandomColor;
//        [scrollView addSubview: tableView];
//    }
    if (@available(*, iOS 10.3)){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    CGFloat scrollViewW = scrollView.dsy_width;
    CGFloat scrollViewH = scrollView.dsy_height;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        //取出i位置子控器的view
        UITableView *childVcView = (UITableView*)self.childViewControllers[i].view;
        if (@available(iOS 11.0, *)){
            //tableView 设置全屏穿透效果,开启
            childVcView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        childVcView.backgroundColor = DSYRandomColor;
        //设置一下大小和位置
        childVcView.frame = CGRectMake(i *scrollViewW,0, scrollViewW, scrollViewH);
        //设置顶和底的内边距，这样cell可以一直停留在中间
        
        [scrollView addSubview:childVcView];
    }
    
    //scrollView的contentSize当小于等于内容的时候，就不能滑动了，当大一点点的时候就会有弹簧功能
    scrollView.contentSize = CGSizeMake(5*scrollView.dsy_width, 0);
    
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
    titleView.frame           = CGRectMake(0,  DSYNavMaxY, self.view.dsy_width, DSYTitlesViewH);    //iphone的高度是88;
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
        titleBtn.frame = CGRectMake(i*titleBtnW, 0, titleBtnW, titleBtnH);
        [titleBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [self.titleview addSubview:titleBtn];
    }
}
-(void)setupTitleUnderline{
    //主要是为了拿到第一个按钮某种状态下的颜色
    DSYtitleButton *firstTitleButton = [self.titleview.subviews firstObject];
    firstTitleButton.selected = YES;
    self.priClickBtn = firstTitleButton;
    [firstTitleButton.titleLabel sizeToFit]; //提前设置尺寸
    UIView *titleUnderline = [[UIView alloc]init];
    titleUnderline.dsy_height = 2;
    titleUnderline.dsy_width  = firstTitleButton.titleLabel.dsy_width+10;
    //位置如果不设置，默认为0
    titleUnderline.dsy_y = self.titleview.dsy_height - titleUnderline.dsy_height;
    titleUnderline.dsy_centerX = firstTitleButton.dsy_centerX;
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    self.titleUnderline = titleUnderline;
    [self.titleview addSubview:titleUnderline];
}
#pragma mark -监听
-(void)titleButtonClick:(UIButton *)titleBtn{
    //设置按钮的状态切换
    self.priClickBtn.selected = NO;
    titleBtn.selected = YES;
    self.priClickBtn = titleBtn;
    //设置标题按钮的状态
    [UIView animateWithDuration:0.25 animations:^{
        //取按钮当前文字下的颜色；也可以自己使用状态取[titleBtn currentTitle];
        //sizeWithFont已经过期,[[titleBtn currentTitle] sizeWithFont:titleBtn.titleLabel.font].width;
        NSMutableDictionary* fontDic = [NSMutableDictionary dictionary];
        fontDic[NSFontAttributeName] = titleBtn.titleLabel.font;
        //Attributes的属性都来源于这个文件 <Foundation/NSAttributedString.h>
        //格式：NSxxxxxAttributeName ,iOS7之前叫UITextAttributexxxx，来自UIStringDrawing.h
//        self.titleUnderline.dsy_width = [[titleBtn currentTitle] sizeWithAttributes: fontDic].width;
        self.titleUnderline.dsy_width = titleBtn.titleLabel.dsy_width+10;
        self.titleUnderline.dsy_centerX = titleBtn.dsy_centerX;
    }];
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
