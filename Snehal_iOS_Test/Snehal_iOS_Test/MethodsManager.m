//
//  MethodsManager.m
//  Snehal_iOS_Test_DSG
//
//  Created by Snehal Lokhande on 16/07/18.
//  Copyright © 2018 Snehal Lokhande. All rights reserved.
//

#import "MethodsManager.h"
#import "UIImage+animatedGIF.h"   // for GIF loader
#import "Reachability.h"          // for internet connection

@implementation MethodsManager 

static MethodsManager *SharedMethodsManager = nil;    // static instance variable

+ (MethodsManager *)sharedManager
{
    if (SharedMethodsManager == nil)
    {
        SharedMethodsManager = [[super allocWithZone:NULL] init];
    }
    return SharedMethodsManager;
}

- (id)init {
    if ( (self = [super init]) ) {
        // your custom initialization
    }
    return self;
}


#pragma mark -
#pragma mark - Loader using GIF & PNGs

-(void)loadingView_PNG:(UIView*)view          // for Animated Loader using PNG's
{
    transperentView = [[UIView alloc]init];
    transperentView.frame = view.frame;
    transperentView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    [view addSubview:transperentView];
    transperentView.hidden = NO;
    
    imgViewLoading = [[UIImageView alloc]init];
    imgViewLoading.frame = CGRectMake(CGRectGetMidX(view.frame)-30, CGRectGetMidY(view.frame), 100, 100);
    NSMutableArray * arrPNGimgs = [[NSMutableArray alloc] init];
    
    for(int i = 1; i<=2; i++)  // images count
    {
        [arrPNGimgs addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_%d.png",i]]];
    }

    imgViewLoading.animationImages = arrPNGimgs;
    imgViewLoading.animationDuration = 1.0f;
    [view addSubview:imgViewLoading];
    [imgViewLoading startAnimating];
    
//    block ui
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}

-(void)loadingView_GIF:(UIView*)view      // for Animated Loader using GIF 
{
    transperentView = [[UIView alloc]init];
    transperentView.frame = CGRectMake(CGRectGetMidX(view.frame)/2,CGRectGetMidY(view.frame)/2,200, 200);

//    transperentView.center = view.center;
    transperentView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    [view addSubview:transperentView];
    transperentView.hidden = NO;
    
    imgViewLoading = [[UIImageView alloc]init];
    imgViewLoading.frame = CGRectMake(CGRectGetMidX(view.frame)/2,CGRectGetMidY(view.frame)/2,60, 60);
    imgViewLoading.contentMode = UIViewContentModeScaleAspectFit;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"loader" withExtension:@"gif"];
    imgViewLoading.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    [transperentView addSubview:imgViewLoading];
    [imgViewLoading startAnimating];
}

-(void)StopAnimating                     // for Animated Loader using GIF
{
    transperentView.hidden = YES;
    //unblock ui
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
     [imgViewLoading stopAnimating];
}

#pragma mark -
#pragma mark - Corner Radius for  Single UIView

-(void)roundView:(UIView *)view onCorner:(UIRectCorner)rectCorner radius:(float)radius
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                   byRoundingCorners:rectCorner
                                                         cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.clipsToBounds = true;          // for marking view inside the base view
    [view.layer setMask:maskLayer];
}

#pragma mark -
#pragma mark - Corner Radius for UIView, UIImageView, UILabel

-(void)roundView:(UIView *)view withImageView : (UIImageView *)imgView withLabel : (UILabel *)lbl radius:(float)radius
{
    view.layer.cornerRadius = radius;
    imgView.layer.cornerRadius = radius;
    lbl.layer.cornerRadius = radius;

}


#pragma mark -
#pragma mark - Checking Internet Connection

-(BOOL) isInternetConnectionAvailable
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        return NO;
    }
    
    return YES;
}


#pragma mark -
#pragma mark - UIAlertController

-(void)ShowAlertOnView:(UIViewController *)viewController WithMessage:(NSString *)strMsg
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    [viewController presentViewController:alertController animated:YES completion:nil];
}


- (NSDictionary *)apiParsingWithParameters:(NSString *)parameters WithAdditiopnalHeaders:(NSString *)s1 strForUname:(NSString *)s Header:(NSString *)strPass ForPassword:(NSString *)st WithURLstring:(NSString *)strURL
{
    id responseObject;

    @try
     {
     NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
     NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
     
     
//     NSString *post = [NSString stringWithFormat:@"tokenId=%@&os=%@",@"",@""];
         NSString *post = [NSString stringWithFormat:@"%@",parameters];

     NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
     NSString *postLength = [NSString stringWithFormat:@"%ld", (unsigned long)[postData length]];
     
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
     [request setURL:[NSURL URLWithString:strURL]];
     [request setHTTPMethod:@"POST"];
     [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
     [request setHTTPBody:postData];
     [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
     [request addValue:s forHTTPHeaderField:s1];
     [request addValue:st forHTTPHeaderField:strPass];
     [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
         
     NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
     
     {
     NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
     if ([httpResponse statusCode] == 200)
     {
     id responseObject =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
     NSLog(@"%@",responseObject);
     }
     else if ([httpResponse statusCode] == 500)
     {
     
     }
     else if ([httpResponse statusCode] == 400)
     {
     
     }
     else if ([httpResponse statusCode] == 401)
     {
     
     }
     else if ([httpResponse statusCode] == 404)
     {
     
     }
     else
     {
     NSLog(@"%@",error);
     }
     
     }];
     
     [postDataTask resume];
     }
     @catch (NSException *exception)
     {
     
     }
    
    return responseObject;
}

@end


