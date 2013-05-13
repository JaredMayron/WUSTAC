//
//  DCViewController.h
//  WUSTAC
//
//  Created by Jared Mayron on 5/12/13.
//  Copyright (c) 2013 Jared Mayron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCViewController : UIViewController

#define main @"main"
#define mailbox @"mailbox"
#define kiosk @"kiosk"
#define loads @"loads"
#define mealPoints @"mealPoints"
#define bearBux @"bearBux"

-(void) initNotifications;
-(void) startSend;

@end
