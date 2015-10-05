//
//  ViewController.m
//  UIWebViewWithLocalImage
//
//  Created by Milan Panchal on 10/5/15.
//  Copyright (c) 2015 Pantech. All rights reserved.
//

#import "ViewController.h"
#import "NSURLProtocolCustom.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

#pragma mark - View life cycle

- (void)viewDidLoad {

    [NSURLProtocol registerClass:[NSURLProtocolCustom class]];
    
    NSString *localHtmlFilePath = [[NSBundle mainBundle] pathForResource:@"Index" ofType:@"html"];
    
    NSString *localHtmlFileURL = [NSString stringWithFormat:@"file://%@", localHtmlFilePath];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:localHtmlFileURL]]];
    
    NSString *html = [NSString stringWithContentsOfFile:localHtmlFilePath encoding:NSUTF8StringEncoding error:nil];
    
    [_webView loadHTMLString:html baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
