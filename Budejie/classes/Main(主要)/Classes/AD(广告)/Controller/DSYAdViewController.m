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
    NSURL* url = [NSURL URLWithString:@"http://www.opooc.com"];
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
    self.adView.frame = self.adContainView.frame;
    //这里直接加广告图，没有采用请求数据
    [self.adView sd_setImageWithURL:[NSURL URLWithString:@"https://b-ssl.duitang.com/uploads/item/201411/21/20141121195843_SuTBH.thumb.700_0.jpeg"]];
    
    
    
//    [mgr GET:@"http://t.weather.itboy.net/api/weather/city/101030100" parameters:para headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        //创建字典
////        NSDictionary* adDict = [responseObject[@"ad"] lastObject];
//    //字典转模型,同时要把模型设置为全局的，保证在点击的跳转逻辑中可以拿到跳转的目标地址
////        DSYAdItem* item = [DSYAdItem mj_objectWithKeyValues:adDict];
//        //这个地方可以使用服务器返回的图片的大小来处理;
////        CGFloat h = DSYScreenW / item.w * item.h;//按比例去拉伸
////        self.adView.frame = CGRectMake(0, 0, DSYScreenW, xx);
//        //加载广告图
//         [self.adView sd_setImageWithURL:];
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            DSYLog(@"123123");
//        }];
//
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
