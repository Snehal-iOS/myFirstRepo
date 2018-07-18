//
//  ArticlesListVC.h
//  Snehal_iOS_Test_DSG
//
//  Created by Snehal Lokhande on 16/07/18.
//  Copyright © 2018 Snehal Lokhande. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticlesListVC : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tblArticles;


- (IBAction)btnMenuClicked:(id)sender;
- (IBAction)btnSearchClicked:(id)sender;
- (IBAction)btnRightMenuClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewShadow;


@end
