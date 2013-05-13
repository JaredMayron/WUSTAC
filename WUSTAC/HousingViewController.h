//
//  HousingViewController.h
//  WUSTAC
//
//  Created by Jared Mayron on 5/12/13.
//  Copyright (c) 2013 Jared Mayron. All rights reserved.
//

#import "dispatcherSingleton.h"
#import "DCViewController.h"
#import "parser.h"

@interface HousingViewController : DCViewController{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *SIDLabel;
    IBOutlet UILabel *mailboxPinLabel;
    IBOutlet UILabel *kioskLabel;
    IBOutlet UILabel *resCollegeLabel;
    IBOutlet UILabel *roomLabel;
    
    IBOutlet UILabel *address1Label;
    IBOutlet UILabel *address2Label;
    IBOutlet UILabel *address3Label;
}


-(void)setMailbox:(NSNotification*)notification;
-(void)setKiosk:(NSNotification*)notification;
-(void)setItem:(NSString*)regexString label:(UILabel *)label begin:(int)begin end:(int)end data:(NSMutableData*)data;



@end
