//
//  TaoBaoCustomerHTMLVC.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/23.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "TaoBaoCustomerHTMLVC.h"
#import <WebKit/WebKit.h>



@interface TaoBaoCustomerHTMLVC ()<WKNavigationDelegate>

@end

@implementation TaoBaoCustomerHTMLVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建 WKWebView 对象
    CGRect rect = CGRectMake(0, 0, self.view.width, self.view.height);
    WKWebView *webView = [[WKWebView alloc] initWithFrame:rect];
    // 设置导航代理，监听网页加载进程
    webView.navigationDelegate = self;
    // 将 webView 对象添加到视图
    
    
    [self.view addSubview:webView];
    // 根据URL发起网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.taoBaoVM.buyURL]];
    [webView loadRequest:request];
    [self.view showBusyHUD];
}

//设置允许跳转，不设置则报错。
//该方法执行在加载界面之前
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    
    //不允许跳转
    //    decisionHandler(WKNavigationActionPolicyCancel);
    NSLog(@"在请求发送之前，决定是否跳转。  1");
    
}

//在收到响应后，决定是否跳转（同上）
//该方法执行在内容返回之前
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //    decisionHandler(WKNavigationResponsePolicyCancel);
    NSLog(@"在收到响应后，决定是否跳转。 3");

}

//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"页面开始加载时调用");
}

//接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"接收到服务器跳转请求之后调用");
}

//请求失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"didFailProvisional:%@",error.localizedDescription);
}

//内容返回时调用，得到请求内容时调用(内容开始加载) -> view的过渡动画可在此方法中加载
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"内容返回时调用，得到请求内容时调用(内容开始加载");
}

//页面加载完成时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
     NSLog(@"页面加载完成时调用");
    [self.view hideBusyHUD];
}


- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"didFailNavigation:%@",error.localizedDescription);
}


- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}


- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    NSLog(@"webViewWebContentProcessDidTerminate");
}


- (IBAction)HTMLBackBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(GetModel:)]) {
        [_delegate GetModel:self.taoBaoVM];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
