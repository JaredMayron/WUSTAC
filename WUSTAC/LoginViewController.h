//
//  ViewController.h
//  WU_LockedOut
//
//  Created by Jared Mayron on 4/16/13.
//  Copyright (c) 2013 Jared Mayron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UIWebViewDelegate>
{
    NSURL *connectURL;
    NSString *transitionString;
    NSString *loginString;
}
@property (strong, nonatomic) IBOutlet UIWebView *loginView;

-(void) initilize;

@end
