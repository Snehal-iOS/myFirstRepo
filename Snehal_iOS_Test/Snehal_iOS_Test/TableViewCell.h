//
//  TableViewCell.h
//  Snehal_iOS_Test_DSG
//
//  Created by Snehal Lokhande on 16/07/18.
//  Copyright © 2018 Snehal Lokhande. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView * imgBG;
@property (strong, nonatomic) IBOutlet UILabel * lblTitle;
@property (strong, nonatomic) IBOutlet UILabel * lblDetails;
@property (strong, nonatomic) IBOutlet UILabel * lblDate;
@property (strong, nonatomic) IBOutlet UIButton * btnNext;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;



@end
