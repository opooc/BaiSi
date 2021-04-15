//
//  DSYAdViewController.m
//  Budejie
//
//  Created by opooc on 2021/4/14.
//
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import <AFNetworking/AFNetworking.h>

#import "DSYAdViewController.h"
#import "DSYAdItem.h"
#import "DSYTabBarController.h"


@interface DSYAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *LaunchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
@property (weak, nonatomic) UIImageView *adView;
@property (weak, nonatomic) NSTimer *timer;
@property (strong,nonatomic) DSYAdItem* adItem;
@end

@implementation DSYAdViewController

-(UIImageView*)adView{
    if(_adView == nil){
        UIImageView* imageView = [[UIImageView alloc]init];
        [self.adContainView addSubview:imageView];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        _adView = imageView;
    }
    return _adView;
}
//点击广告界面就会调用
-(void)tap{
    //这个地址一般是从模型中取。
    NSURL* url = [NSURL URLWithString:self.adItem.wpi_curl];
    UIApplication* app =[UIApplication sharedApplication];
    if( [app canOpenURL:url]){
        [app openURL:url];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLaunchImage];
    [self loadAdData];
    //创建定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}
-(void)timeChange{
    static int count  = 3;
    if(count == 0){
        //时间结束直接跳转
        [self clickJump:nil];
    }
    count--;
    //设置跳转按钮的文字
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳过(%d秒)",count] forState:UIControlStateNormal];
}
//点击跳过按钮
- (IBAction)clickJump:(UIButton *)sender {
    DSYTabBarController* tabBarVc = [[DSYTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
    [_timer invalidate];
}

-(void)loadAdData{
    AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
    NSMutableArray* para = [NSMutableArray array];
    [mgr GET:@"http://localhost:8080/baisi/Ad" parameters:para headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DSYLog(@"success");
//        创建字典
        NSDictionary* adDict = [responseObject lastObject];
    //字典转模型,同时要把模型设置为全局的，保证在点击的跳转逻辑中可以拿到跳转的目标地址
        self.adItem = [DSYAdItem mj_objectWithKeyValues:adDict];
        //这个地方可以使用服务器返回的图片的大小来处理;
//        CGFloat h = DSYScreenW / item.w * item.h;//按比例去拉伸
        self.adView.frame = self.adContainView.frame;
        //加载广告图
        [self.adView sd_setImageWithURL:[NSURL URLWithString:self.adItem.pri_curl]];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DSYLog(@"failure");
        }];
}
-(void)setupLaunchImage{
    switch ((int)DSYScreenH) {
        case iphone6P://8
            self.LaunchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
            break;
        case iphone6://6
            self.LaunchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];
            break;
        case iphone5://5
            self.LaunchImageView.image = [UIImage imageNamed:@"LaunchImage-568h@2x"];
            break;
        case iphone4:
            self.LaunchImageView.image = [UIImage imageNamed:@"LaunchImage"];
            break;
        default:
            self.LaunchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
            break;
    }
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
