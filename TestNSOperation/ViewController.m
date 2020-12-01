//
//  ViewController.m
//  TestNSOperation
//
//  Created by baidu on 2020/7/24.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "ParallelLoadManage.h"
#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()
@property (assign, atomic) int count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKWebView *webview = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.baidu.com"]]];
    [self.view addSubview:webview];
    NSLog(@"qy6");

    NSMutableArray<NSString *> *urlArray = [NSMutableArray arrayWithCapacity:100];
    for (int i = 0; i < 100; i++) {
//        [[ParallelLoadManage shared] addParallelLoadTaskWithUrlStr:[NSString stringWithFormat:@"%d", i]];
        NSString *urlStr = [NSString stringWithFormat:@"%d", i];
        [urlArray addObject:urlStr];
    }
    [[ParallelLoadManage shared] addParallelLoadTaskWithUrlArray:urlArray];
}

@end
