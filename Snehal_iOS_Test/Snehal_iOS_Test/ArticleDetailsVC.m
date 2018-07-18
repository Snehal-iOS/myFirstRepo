//
//  ArticleDetailsVC.m
//  Snehal_iOS_Test_DSG
//
//  Created by Snehal Lokhande on 16/07/18.
//  Copyright © 2018 Snehal Lokhande. All rights reserved.
//

#import "ArticleDetailsVC.h"


@interface ArticleDetailsVC ()
{
    NSMutableArray * arrImages;
}
@end

@implementation ArticleDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arrImages = [[NSMutableArray alloc]init];
    NSLog(@"%@",_dictFromArticles);
    
    _lblTitle.text = [NSString stringWithFormat:@"%@",[_dictFromArticles objectForKey:@"title"]];
    _lblDescription.text = [NSString stringWithFormat:@"%@",[_dictFromArticles objectForKey:@"abstract"]];
    
    _lblMedia.text = [NSString stringWithFormat:@"%@",[[[_dictFromArticles objectForKey:@"media"]valueForKey:@"caption" ]objectAtIndex:0]];
    _lblPublishedOn.text = [NSString stringWithFormat:@"Published On : %@",[_dictFromArticles objectForKey:@"published_date"]];
    _lblTotalViews.text = [NSString stringWithFormat:@"Total Views : %@",[_dictFromArticles objectForKey:@"views"]];

    [_btnUrl setTitle:[NSString stringWithFormat:@"%@",[_dictFromArticles objectForKey:@"url"]] forState:UIControlStateNormal];

    
    arrImages = [[[_dictFromArticles objectForKey:@"media"]valueForKey:@"media-metadata" ]objectAtIndex:0];

    [_collectionView reloadData];
    
}

#pragma mark -
#pragma mark - COLLECTIONVIEW

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrImages.count;
//    return 5;

}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionCell *cell = (CollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void)
                   {

                       NSURL *imageUrl = [NSURL URLWithString:[[arrImages objectAtIndex:indexPath.row]objectForKey:@"url"]];

                       
                       cell.layer.borderWidth=1.0f;
                       cell.layer.borderColor=[UIColor lightGrayColor].CGColor;
                       
//                            Load and decode image --
                           NSData * imageData = [NSData dataWithContentsOfURL:imageUrl];
                           UIImage *image = [UIImage imageWithData:imageData];
                           
                           dispatch_sync(dispatch_get_main_queue(), ^(void)
                                         {
                                             if (image == nil || image==(id)[NSNull null])
                                             {
                                                 cell.imageview.image=[UIImage imageNamed:@"Placeholder.png"];
                                             }
                                             else
                                             {
                                                 cell.imageview.image=image;
                                             }
                                         });
                   });
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SwipeImagesVC * details =[self.storyboard instantiateViewControllerWithIdentifier:@"SwipeImagesVC"];
    details.arrImagesUrl = arrImages;
    [self presentViewController:details animated:NO completion:nil];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
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
- (IBAction)btnUrlClicked:(id)sender {
    
    WebViewVC * web = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewVC"];
    web.urlAddress = [NSString stringWithFormat:@"%@",[_dictFromArticles objectForKey:@"url"]];
    [self presentViewController:web animated:YES completion:nil];
    

}
@end
