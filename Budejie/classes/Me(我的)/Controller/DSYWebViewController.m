//
//  DSYWebViewController.m
//  Budejie
//
//  Created by opooc on 2021/4/17.
//
#import <WebKit/WebKit.h>
#import "DSYWebViewController.h"

@interface DSYWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;


@property (nonatomic,weak) WKWebView* webView;
@end

@implementation DSYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView* webView = [[WKWebView alloc]init];
    self.webView       = webView;
    [self.contentView addSubview:webView];
    
    //开始请求网页
    NSURLRequest* reqs = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlstring]];
    [webView loadRequest:reqs];
    //KVO监听,这里给canGoBack是webView的属性，不能加了item上
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}
//只要对象属性发生改变就调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    self.backItem.enabled = self.webView.canGoBack;
    self.forwardItem.enabled = self.webView.canGoForward;
    self.progressView.progress = self.webView.estimatedProgress;
    //等于1的时候隐藏 
    self.progressView.hidden = self.webView.estimatedProgress>=1;
    self.title = self.webView.title;
}

//页面销毁的时候，移除KVO
-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (IBAction)geBackClick:(id)sender {
    [self.webView goBack];
}
- (IBAction)geForwardClick:(id)sender {
    [self.webView goForward];
}
- (IBAction)goReloadClick:(id)sender {
    [self.webView reload];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.webView.frame = self.contentView.frame;

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
