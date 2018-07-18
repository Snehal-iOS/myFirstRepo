//
//  AppDelegate.h
//  Snehal_iOS_Test_DSG
//
//  Created by Snehal Lokhande on 16/07/18.
//  Copyright © 2018 Snehal Lokhande. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@end

