//
//  SwipeImagesVC.m
//  Snehal_iOS_Test_DSG
//
//  Created by Snehal Lokhande on 16/07/18.
//  Copyright © 2018 Snehal Lokhande. All rights reserved.
//

#import "SwipeImagesVC.h"

@interface SwipeImagesVC ()

@end

@implementation SwipeImagesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollview.delegate = self;
    self.scrollview.dataSource = self;
    [self.scrollview reloadData];
}

#pragma mark -
#pragma mark - PHScrollView

- (NSInteger)numberOfPageInPageScrollView:(PHPageScrollView*)pageScrollView
{
    return _arrImagesUrl.count;
}

- (CGSize)sizeCellForPageScrollView:(PHPageScrollView*)pageScrollView
{
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-66);
}

- (UIView*)pageScrollView:(PHPageScrollView*)pageScrollView viewForRowAtIndex:(int)index
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 66, SCREEN_WIDTH, SCREEN_HEIGHT-66)];
    view.backgroundColor = [UIColor whiteColor];
    
         UIImageView * imgView =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-66)];
        imgView.backgroundColor=[UIColor clearColor];
        imgView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[_arrImagesUrl objectAtIndex:index] objectForKey:@"url"]]]];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imgView];
    return view;
}

- (void)pageScrollView:(PHPageScrollView*)pageScrollView didScrollToPageAtIndex:(NSInteger)index
{
    
}

- (void)pageScrollView:(PHPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index
{
    
}

#pragma mark -
#pragma mark - IBAction

-(IBAction)backbutton:(id)sender{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

@end
