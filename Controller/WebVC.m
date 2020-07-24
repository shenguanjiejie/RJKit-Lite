//
//  WebVC.m
//  kisshappy
//
//  Created by ShenRuijie on 2017/10/8.
//  Copyright © 2017年 shenguanjiejie. All rights reserved.
//

#import "WebVC.h"
#import <WebKit/WebKit.h>
#import "NSString+JKNormalRegex.h"
//#if __has_include(<SDWebImage/SDWebImageDownloader.h>)

@interface WebVC ()<WKUIDelegate,WKNavigationDelegate>
{
    WKWebView *_webView;
}
@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (![self.urlString jk_isValidUrl]) {
#ifdef kCustomNavigationBar
        [self setNavigationBarViewWithTitle:@"404" backSelector:@selector(back)];
#endif
        return;
    }
    
    _webView = [[WKWebView alloc] init];
    _webView.translatesAutoresizingMaskIntoConstraints = NO;
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    self.urlString = [self.urlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    [self.view addSubview:_webView];
//    [_webView loadHTMLString:_article.Content baseURL:nil];
    
    
    [self setNavigationBarViewWithBackMsg:kLocalString(protocol) backSelector:@selector(back)];
    NSDictionary *views = @{
                            @"navView":self.navigationBarView,
                            @"_webView":_webView
                            };
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[navView][_webView]|" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:nil views:views]];

}

- (void)back{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
}

@end
