//
//  BalancesViewController.m
//  WUSTAC
//
//  Created by Jared Mayron on 5/12/13.
//  Copyright (c) 2013 Jared Mayron. All rights reserved.
//

#import "BalancesViewController.h"


@implementation BalancesViewController

static NSString *mealBalanceRegex=@"<span[^<]*id=[^<]*[pP]oint[bB]alance[^<]*(<.>)?(<font[^>]*>)?[0-9]*(.[0-9]{2})?";
static NSString *mealPlanRegex=@"<span[^<]*id=[^<]*[mM]eal[pP]lan[^<]*(<[^>]*>)?(<font[^>]*>)?[^<]*";
static NSString *campusCardRegex=@"span[^>]*[pP]oint[bB]alance[^>]>(<[^>]>)?(<font[^>]*>)?[0-9]*(.[0-9]{2})?";

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

-(void)initNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishSend:) name:main object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setMealPoints:) name:mealPoints object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setBearBux:) name:bearBux object:nil];
}

-(void)startSend
{
    
    if([[dispatcherSingleton initialize] sessionIDRecieved]){
        [self finishSend:nil];
    } else {
        [[dispatcherSingleton initialize] sendMainPage];
    }
}

-(void)finishSend:(NSNotification *)notification
{
    [[dispatcherSingleton initialize] sendMealPoints];
    [[dispatcherSingleton initialize] sendBearBux];
}

-(void)setMealPoints:(NSNotification *)notification
{
    NSMutableData *mealPointsData =[[dispatcherSingleton initialize] getMealPoints];
    [self setItem:mealPlanRegex label:mealPlanTypeLabel begin:54 end:0 data:mealPointsData];
    [self setItem:mealBalanceRegex label:mealPlanBalanceLabel begin:58 end:0 data:mealPointsData];
}

-(void)setBearBux:(NSNotification *)notification
{
    NSMutableData *campusCardData =[[dispatcherSingleton initialize] getBearBux];
    [self setItem:campusCardRegex label:campusCardLabel begin:57 end:0 data:campusCardData];
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
