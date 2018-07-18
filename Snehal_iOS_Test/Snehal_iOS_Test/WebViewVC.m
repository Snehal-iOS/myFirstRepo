//
//  WebViewVC.m
//  Snehal_iOS_Test_DSG
//
//  Created by Vilas Kumar on 18/07/18.
//  Copyright © 2018 Vilas Kumar. All rights reserved.
//

#import "WebViewVC.h"

@interface WebViewVC ()

@end

@implementation WebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    BOOL isConnected = [[MethodsManager sharedManager]isInternetConnectionAvailable];
    if (isConnected)
    {
        
        NSURL *url = [NSURL URLWithString:_urlAddress];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:urlRequest];
    }
    else{
        
        [[MethodsManager sharedManager]ShowAlertOnView:self WithMessage:@"Please check your internet connection"];
    }
}

#pragma mark - 
#pragma mark - UIWebView Delegates

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"didFinish: %@; stillLoading: %@", [[webView request]URL],
          (webView.loading?@"YES":@"NO"));
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFail: %@; stillLoading: %@", [[webView request]URL],
          (webView.loading?@"YES":@"NO"));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - IBActions

- (IBAction)btnBackClicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
