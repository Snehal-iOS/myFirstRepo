//
//  ArticlesListVC.m
//  Snehal_iOS_Test_DSG
//
//  Created by Snehal Lokhande on 16/07/18.
//  Copyright © 2018 Snehal Lokhande. All rights reserved.
//

#import "ArticlesListVC.h"
#import "AFNetworking.h"

@interface ArticlesListVC ()
{
    NSMutableArray * arrArticles;
}
@end

@implementation ArticlesListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tblArticles.estimatedRowHeight = 160;//the estimatedRowHeight but if is more this autoincremented with autolayout
    _tblArticles.rowHeight = UITableViewAutomaticDimension;
    
    _viewShadow.layer.masksToBounds = NO;
    _viewShadow.layer.shadowOffset = CGSizeMake(.0f,4.5f);
    _viewShadow.layer.shadowRadius = 1.5f;
    _viewShadow.layer.shadowOpacity = .6f;
    _viewShadow.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    
    
    arrArticles = [[NSMutableArray alloc]init];
    [self apiData];
}

#pragma mark -
#pragma mark - Downloaded Data From API

-(void)apiData
{
    BOOL isConnected = [[MethodsManager sharedManager]isInternetConnectionAvailable];
    if (isConnected)
    {
        static NSString * const BaseURLString = @"http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=";
        NSString *string = [NSString stringWithFormat:@"%@5d7611aae2b340c0bd0e0ead3eeb8ba5", BaseURLString];
        NSURL *url = [NSURL URLWithString:string];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"%@", responseObject);
            
            arrArticles = [responseObject objectForKey:@"results"];
            [_tblArticles reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [[MethodsManager sharedManager]ShowAlertOnView:self WithMessage:@"Something went wrong..Please try again!"];
        }];
        
        [operation start];
    }
    else
    {
        [[MethodsManager sharedManager]StopAnimating];
        [[MethodsManager sharedManager]ShowAlertOnView:self WithMessage:@"Please check your internet connection"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - UITableView DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrArticles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TableViewCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    [[MethodsManager sharedManager]roundView:cell.imgBG withImageView:cell.imgView withLabel:nil radius:25.0f];
    
    cell.lblTitle.text = [NSString stringWithFormat:@"%@",[[arrArticles valueForKey:@"title"]objectAtIndex:indexPath.row]];
    cell.lblDetails.text = [NSString stringWithFormat:@"%@",[[arrArticles valueForKey:@"byline"]objectAtIndex:indexPath.row]];
    cell.lblDate.text = [NSString stringWithFormat:@"%@",[[arrArticles valueForKey:@"published_date"]objectAtIndex:indexPath.row]];
    
    cell.btnNext.tag = indexPath.row;
    [cell.btnNext addTarget:self action:@selector(nextButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

-(void)nextButtonClicked:(UIButton*)sender
{
    NSDictionary * dict = [arrArticles objectAtIndex:sender.tag];
    NSLog(@"%@",dict);
    
    ArticleDetailsVC * articles = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailsVC"];
    articles.dictFromArticles = dict;
    [self presentViewController:articles animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * dict = [arrArticles objectAtIndex:indexPath.row];
    NSLog(@"%@",dict);
    
    ArticleDetailsVC * articles = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailsVC"];
    articles.dictFromArticles = dict;
    [self presentViewController:articles animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark -
#pragma mark - IBActions

- (IBAction)btnMenuClicked:(id)sender {
    
    [[MethodsManager sharedManager]ShowAlertOnView:self WithMessage:@"Work in Progress"];
}

- (IBAction)btnSearchClicked:(id)sender {
    
    [[MethodsManager sharedManager]ShowAlertOnView:self WithMessage:@"Work in Progress"];
}
- (IBAction)btnRightMenuClicked:(id)sender {
    
    [[MethodsManager sharedManager]ShowAlertOnView:self WithMessage:@"Work in Progress"];
}
@end
