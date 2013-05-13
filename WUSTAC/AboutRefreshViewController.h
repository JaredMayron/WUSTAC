//
//  AboutRefreshViewController.h
//  WUSTAC
//
//  Created by Jared Mayron on 5/12/13.
//  Copyright (c) 2013 Jared Mayron. All rights reserved.
//

#import "DCViewController.h"
#import "dispatcherSingleton.h"

@interface AboutRefreshViewController : DCViewController{
    IBOutlet UILabel *versionLabel;
    IBOutlet UILabel *numLoadsLabel;
}

-(void)setNumberOfLoads:(NSNotification*) notification;

@end
