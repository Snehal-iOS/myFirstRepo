//
//  ArticleDetailsVC.h
//  Snehal_iOS_Test_DSG
//
//  Created by Snehal Lokhande on 16/07/18.
//  Copyright © 2018 Snehal Lokhande. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleDetailsVC : UIViewController

- (IBAction)btnBackClicked:(id)sender;
@property(strong,nonatomic) NSDictionary * dictFromArticles;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblMedia;
@property (weak, nonatomic) IBOutlet UILabel *lblPublishedOn;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalViews;

@property (weak, nonatomic) IBOutlet UIButton *btnUrl;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)btnUrlClicked:(id)sender;

@end
