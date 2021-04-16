//
//  DSYLoginRegisterViewController.m
//  Budejie
//
//  Created by opooc on 2021/4/15.
//

#import "DSYLoginRegisterViewController.h"
#import "DSYLoginRegisterView.h"
#import "DSYFastLoginView.h"
@interface DSYLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
//在使用auto后，一定不要直接调整控件的x,要通过 左边距等修改
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation DSYLoginRegisterViewController


//1.搭建新界面，不要慌
//2.划分结构(顶部，中间，底部)
//3.越复杂的界面，越要进行封装 
- (void)viewDidLoad {
    [super viewDidLoad];
    //登录注册
    [self setupRegisterAndLogin];
    //快速登录
    [self setupFastView];
}
-(void)setupRegisterAndLogin{
    /*一个view从xib加载，需要重新固定尺寸，确定位置，做好屏幕适配
     */
    DSYLoginRegisterView* loginView = [DSYLoginRegisterView loginView];
    [self.middleView addSubview: loginView];
    
    DSYLoginRegisterView* registerView = [DSYLoginRegisterView registerView];
    [self.middleView addSubview: registerView];
}
-(void)setupFastView{
    //添加快速登录的view
    DSYFastLoginView* btView = [DSYFastLoginView fastLoginView];
    [self.bottomView addSubview:btView];
}
- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickRegister:(UIButton *)sender {
    //设置按钮的选择状态
    sender.selected = !sender.selected;
    _leadCons.constant = _leadCons.constant==0?-self.middleView.dsy_width*0.5:0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLayoutSubviews{
    //开发中设置frame一般不放了viewDidLoad中调用，应放了这个里面布局子控件,这个里面才会真正调整view的尺寸
    [super viewDidLayoutSubviews];
    DSYLoginRegisterView* loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.dsy_width*0.5, self.middleView.dsy_height);

    
    DSYLoginRegisterView* registerView =self.middleView.subviews[1];
    registerView.frame = CGRectMake(self.middleView.dsy_width*0.5, 0, self.middleView.dsy_width*0.5, self.middleView.dsy_height);
    
    DSYFastLoginView* btView = self.bottomView.subviews.firstObject;
    btView.frame = self.bottomView.bounds;
    
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
