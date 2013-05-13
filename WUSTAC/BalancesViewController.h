//
//  BalancesViewController.h
//  WUSTAC
//
//  Created by Jared Mayron on 5/12/13.
//  Copyright (c) 2013 Jared Mayron. All rights reserved.
//

#import "DCViewController.h"
#import "dispatcherSingleton.h"
#import "parser.h"

@interface BalancesViewController : DCViewController{
    
    IBOutlet UILabel *mealPlanTypeLabel;
    IBOutlet UILabel *mealPlanBalanceLabel;
    IBOutlet UILabel *campusCardLabel;
}
-(void)finishSend:(NSNotification*)notification;

-(void)setMealPoints:(NSNotification*)notification;
-(void)setBearBux:(NSNotification*)notification;

-(void)setItem:(NSString*)regexString label:(UILabel *)label begin:(int)begin end:(int)end data:(NSMutableData*)data;

@end
