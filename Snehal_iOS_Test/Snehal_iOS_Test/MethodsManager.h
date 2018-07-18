//
//  MethodsManager.m
//  Snehal_iOS_Test_DSG
//
//  Created by Snehal Lokhande on 16/07/18.
//  Copyright © 2018 Snehal Lokhande. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MethodsManager : NSObject <NSURLSessionDelegate,NSURLSessionDataDelegate>
{
    // whatever instance vars you want
    UIImageView *imgViewLoading;
    UIView *transperentView;
}

+ (MethodsManager *)sharedManager;   // class method to return the singleton object
- (void)loadingView_GIF :(UIView*)view;  // for Animated loader using GIF
- (void)loadingView_PNG :(UIView*)view;  // for adding loader with arrays of PNG's
- (void)StopAnimating;    // for disappering loader (PNG's as well as GIF)
- (void)ShowAlertOnView:(UIViewController *)view WithMessage:(NSString *)msg;

-(BOOL) isInternetConnectionAvailable;
-(void)roundView:(UIView *)view onCorner:(UIRectCorner)rectCorner radius:(float)radius;
-(void)roundView:(UIView *)view withImageView : (UIImageView *)imgView withLabel : (UILabel *)lbl radius:(float)radius;


- (NSDictionary *)apiParsingWithParameters:(NSString *)parameters WithAdditiopnalHeaders:(NSString *)s1 strForUname:(NSString *)s Header:(NSString *)strPass ForPassword:(NSString *)st WithURLstring:(NSString *)strURL;

@end

