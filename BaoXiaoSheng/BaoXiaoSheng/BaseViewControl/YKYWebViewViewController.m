//
//  YKYWebViewViewController.m
//  ShengYa
//
//  Created by apple on 2019/4/25.
//  Copyright © 2019 Wkz. All rights reserved.
//

#import "YKYWebViewViewController.h"

@interface YKYWebViewViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>


@property (nonatomic, strong) WKUserContentController *userContentController;

@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, strong) UIButton * backButton;

@end

@implementation YKYWebViewViewController

- (WKUserContentController *)userContentController {
    if (!_userContentController) {
        
        _userContentController = [[WKUserContentController alloc] init];
    }
    return _userContentController;
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        
        // window.webkit.messageHandlers.showDialog.postMessage({body: '传数据'});
        // WKWebView 的配置
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.preferences.javaScriptEnabled = YES;
        configuration.allowsInlineMediaPlayback = NO;
//        configuration.mediaPlaybackRequiresUserAction = YES;
        if (@available(iOS 10.0, *)) {
            configuration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeAll;
        } else {
            // Fallback on earlier versions
        }
        configuration.userContentController = self.userContentController;
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero
                                        configuration:configuration];
        _wkWebView.scrollView.scrollEnabled = YES;
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        _wkWebView.scrollView.bounces = NO;
    }
    return _wkWebView;
}

- (UIButton *)backButton
{
    if(_backButton == nil) {
        _backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
//        _backButton.backgroundColor = [UIColor lightGrayColor];
        _backButton.layer.cornerRadius = kWidth(8);
        _backButton.layer.masksToBounds = YES;
//        [_backButton setTitle:@"<" forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"navigationbar_back"] forState:0];
        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _backButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _backButton.titleLabel.numberOfLines = 0;
        _backButton.titleLabel.font = KFont(14);
        [_backButton addTarget:self action:@selector(backButtonBUttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
    self.title = self.titleString;
    [self.view addSubview:self.wkWebView];
    
    self.navigationController.navigationBar.hidden = YES;
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.view addSubview:self.progressView];
//    [self.view addSubview:self.backButton];
//    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.equalTo(self.view).mas_offset(10.f);
//        make.height.mas_equalTo(40.f);
//        make.width.mas_equalTo(80.f);
//    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(2.f);
    }];
    [self wkWebViewRequestWithURL];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.fd_interactivePopDisabled = YES;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kColor(51, 51, 51)}];
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
//    self.navigationController.navigationItem.backBarButtonItem = self.backButton;
    
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backButton];
    
//    kAppDelegate.shouldChangeOrientation = YES;
    
    // 视图出现时候添加js回调
    [self.userContentController removeScriptMessageHandlerForName:@"NJWebViewModel"];
    [self.userContentController addScriptMessageHandler:self name:@"NJWebViewModel"];
    
    
    [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"title"]){
        if (object == self.wkWebView) {
            self.title = self.wkWebView.title;
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    self.fd_interactivePopDisabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 防止内存泄漏
    [self.userContentController removeScriptMessageHandlerForName:@"NJWebViewModel"];
}

- (void)wkWebViewRequestWithURL {
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    urlRequest.timeoutInterval = 15;
    
    [self.wkWebView loadRequest:urlRequest];
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    
    [self.progressView setProgress:0 animated:NO];
    self.progressView.alpha = 1.f;
    [self.progressView setProgress:0.2f animated:YES];
    
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {//4.
    [self.progressView setProgress:1.f animated:YES];
    [UIView animateWithDuration:1.5f animations:^{
        self.progressView.alpha = 0;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.progressView.alpha > 0) {
            [self.progressView setProgress:1.f animated:YES];
            [UIView animateWithDuration:1.0f animations:^{
                self.progressView.alpha = 0;
            }];
        }
    });
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {//5.
    
    [self.progressView setProgress:1.f animated:YES];
    [UIView animateWithDuration:1.5f animations:^{
        self.progressView.alpha = 0;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.progressView.alpha > 0) {
            [self.progressView setProgress:1.f animated:YES];
            [UIView animateWithDuration:1.0f animations:^{
                self.progressView.alpha = 0;
            }];
        }
    });
}



- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler {
    
    
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    completionHandler(YES);
    
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}



- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    if (error && error.code != -999) {
        [UIView animateWithDuration:1.0f animations:^{
            self.progressView.alpha = 0;
        }];
        [MBProgressHUD showError:@"加载失败" toView:self.view complication:^{
            
        }];
    }else {
        [self.progressView setProgress:1.f animated:YES];
        [UIView animateWithDuration:1.0f animations:^{
            self.progressView.alpha = 0;
        }];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if (error && error.code != -999) {
        [UIView animateWithDuration:1.0f animations:^{
            self.progressView.alpha = 0;
        }];
        [MBProgressHUD showError:@"加载失败" toView:self.view complication:^{
            
        }];
    } else {
        [self.progressView setProgress:1.f animated:YES];
        [UIView animateWithDuration:1.0f animations:^{
            self.progressView.alpha = 0;
        }];
    }
    
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"\n%@ %@\n", navigationResponse.response.URL.absoluteString, navigationResponse.response.URL);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
}


- (void)backButtonBUttonClick:(UIButton*)sender
{
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    kAppDelegate.shouldChangeOrientation = NO;
    if (self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

/*
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethodImp = class_getInstanceMethod(self, @selector(backBarButtonItem));
        Method destMethodImp = class_getInstanceMethod(self, @selector(myCustomBackButton));
        method_exchangeImplementations(originalMethodImp, destMethodImp);
    });
}

static char kCustomBackButtonKey;

-(UIBarButtonItem *)myCustomBackButton{
    UIBarButtonItem *item = [self myCustomBackButton];
    if (item) {
        return item;
    }
    item = objc_getAssociatedObject(self, &kCustomBackButtonKey);
    if (!item) {
        item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:NULL];
        objc_setAssociatedObject(self, &kCustomBackButtonKey, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return item;
}

- (void)dealloc
{
    objc_removeAssociatedObjects(self);
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
