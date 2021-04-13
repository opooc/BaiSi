//
//  DSYNavigationViewController.m
//  Budejie
//
//  Created by opooc on 2021/4/13.
//

#import "DSYNavigationViewController.h"

@interface DSYNavigationViewController () <UIGestureRecognizerDelegate>

@end

@implementation DSYNavigationViewController
//load方法什么时候调用啊？？
+ (void)load{
    //为什么这个地方要拿到全局的？难道是这个load方法只会调用一次？
    UINavigationBar* navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    //导航条标题，不是拿item ,只要是模型设置都是通过富文本
    NSMutableDictionary* attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [navBar setTitleTextAttributes: attrs];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}
//触发手势问题
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.childViewControllers.count > 1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //为了控制手势什么时候触发，只有非根的时候的触发;
    self.interactivePopGestureRecognizer.delegate = self;

}
//一开始就会调用4次，设置导航控制器的时候会调用这个方法initxxRootxxx;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.childViewControllers.count > 0){
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImageName:@"navigationButtonReturn" highImageName:@"navigationButtonReturnClick" addTarget:self action:@selector(back) title:@"返回"];
    }
    [super pushViewController:viewController animated:animated];
}
-(void)back{
    [self popViewControllerAnimated:YES];
    
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
