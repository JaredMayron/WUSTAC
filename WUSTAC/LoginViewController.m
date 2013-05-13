//
//  ViewController.m
//  WU_LockedOut
//
//  Created by Jared Mayron on 4/16/13.
//  Copyright (c) 2013 Jared Mayron. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"

@implementation LoginViewController
@synthesize loginView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initilize];
    NSURLRequest *connectRequest = [NSURLRequest requestWithURL:connectURL];
    loginView.delegate = self;
    [loginView loadRequest:connectRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) initilize
{
    connectURL = [NSURL URLWithString:@"https://acadinfo.wustl.edu/housing/currentAssignment/Housing_Info.aspx"];
    transitionString = @"Housing Info";
    loginString = @"Secure Login";
}

-(void) webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *theTitle=[loginView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if([theTitle isEqualToString:transitionString]){
        UIStoryboard* secondStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController* secondViewController = [secondStoryboard instantiateViewControllerWithIdentifier:@"Main"];
        [self presentViewController: secondViewController animated:YES completion: NULL];
    } else if(!([theTitle isEqualToString:@""]||[theTitle isEqualToString:loginString])){
        NSURLRequest *connectRequest = [NSURLRequest requestWithURL:connectURL];
        [loginView loadRequest:connectRequest];
    }
    
}

@end
