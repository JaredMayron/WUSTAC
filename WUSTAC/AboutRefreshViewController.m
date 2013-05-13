//
//  AboutRefreshViewController.m
//  WUSTAC
//
//  Created by Jared Mayron on 5/12/13.
//  Copyright (c) 2013 Jared Mayron. All rights reserved.
//

#import "AboutRefreshViewController.h"


@implementation AboutRefreshViewController

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
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appDisplayName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *majorVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *minorVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    [versionLabel setText:[NSString stringWithFormat:@"%@, Version %@ (%@)",
                           appDisplayName, majorVersion, minorVersion]];
	[self initNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) initNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNumberOfLoads:) name:loads object:nil];
}

-(void) startSend {}

- (IBAction)refreshAll:(id)sender
{
    [[dispatcherSingleton initialize] forceReload];
}
                                                                     
-(void)setNumberOfLoads:(NSNotification *)notification
{
    [numLoadsLabel setText:[NSString stringWithFormat:@"%i",[[dispatcherSingleton initialize]  getNumberOfFailedLoads]]];
}
@end
