//
//  WebViewVC.h
//  Snehal_iOS_Test_DSG
//
//  Created by Vilas Kumar on 18/07/18.
//  Copyright © 2018 Vilas Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewVC : UIViewController


@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic)NSString *urlAddress;

- (IBAction)btnBackClicked:(id)sender;

@end
