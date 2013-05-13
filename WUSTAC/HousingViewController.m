//
//  HousingViewController.m
//  WUSTAC
//
//  Created by Jared Mayron on 5/12/13.
//  Copyright (c) 2013 Jared Mayron. All rights reserved.
//

#import "HousingViewController.h"


@implementation HousingViewController

static NSString *resCollegeRegex = @"Hall_..>[^<]*";
static NSString *roomRegex = @"LabelRoom_..>[a-zA-Z0-9]*";
static NSString *mailboxRegex = @"[0-9]{1,2}-[0-9]{1,2}-[0-9]{1,2}";
static NSString *kioskRegex = @">[0-9]{4}<";
static NSString *nameRegex = @"lblStudent[^\(]*";
static NSString *SIDRegex = @": [0-9]{6}";

static NSString *address1Regex = @"CAddr1_..>[^<]*";
static NSString *address2Regex = @"CAddr2_..>[^<]*";
static NSString *address3Regex = @"CAddr3_..>[^<]*";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initNotifications];
    [self startSend];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setMailbox:) name:mailbox object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setKiosk:) name:kiosk object:nil];
}

-(void) startSend
{
    [[dispatcherSingleton initialize] sendKiosk];
    [[dispatcherSingleton initialize] sendMailbox];
}

-(void)setMailbox:(NSNotification *)notification
{
    NSMutableData *mailboxPage = [[dispatcherSingleton initialize] getMailbox];
    
    [self setItem:nameRegex label:nameLabel begin:12 end:0 data:mailboxPage];
    [self setItem:SIDRegex label:SIDLabel begin:2 end:0 data:mailboxPage];
    [self setItem:mailboxRegex label:mailboxPinLabel begin:0 end:0 data:mailboxPage];
    [self setItem:resCollegeRegex label:resCollegeLabel begin:8 end:0 data:mailboxPage];
    [self setItem:roomRegex label:roomLabel begin:13 end:0 data:mailboxPage];
    
    [self setItem:address1Regex label:address1Label begin:10 end:0 data:mailboxPage];
    [self setItem:address2Regex label:address2Label begin:10 end:0 data:mailboxPage];
    [self setItem:address3Regex label:address3Label begin:10 end:0 data:mailboxPage];
    
}

-(void)setKiosk:(NSNotification *)notification
{
    NSMutableData *getKiosk = [[dispatcherSingleton initialize] getKiosk];
    
    [self setItem:kioskRegex label:kioskLabel begin:1 end:1 data:getKiosk];
}

-(void)setItem:(NSString*)regexString label:(UILabel *)label begin:(int)begin end:(int)end data:(NSMutableData*)data
{
    NSString *text = [parser parse:regexString fromBegin:[NSNumber numberWithInt:begin] fromEnd:[NSNumber numberWithInt:end] RawData:data];
    if (text == nil){
        [label setHighlighted:YES];
        [label setHighlightedTextColor:[UIColor redColor]];
        [label adjustsFontSizeToFitWidth];
        [label setText:@"Error"];
    }else{
        [label setText:text];
    }
    
     
}

@end
