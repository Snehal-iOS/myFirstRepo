//
//  SwipeImagesVC.h
//  Snehal_iOS_Test_DSG
//
//  Created by Snehal Lokhande on 16/07/18.
//  Copyright © 2018 Snehal Lokhande. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PHPageScrollView.h"


@interface SwipeImagesVC : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate,PHPageScrollViewDataSource, PHPageScrollViewDelegate>

@property(strong,nonatomic)IBOutlet PHPageScrollView * scrollview;
@property(strong,nonatomic) UIImageView*ivImage;
@property(strong,nonatomic) NSMutableArray * arrImagesUrl;
@property(strong,nonatomic) NSString*index;
-(IBAction)backbutton:(id)sender;
@end
