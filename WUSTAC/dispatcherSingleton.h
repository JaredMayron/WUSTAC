//
//  dispatcherSingleton.h
//  WUSTAC
//
//  Created by Jared Mayron on 5/11/13.
//  Copyright (c) 2013 Jared Mayron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DCViewController.h"
#import "parser.h"

@interface dispatcherSingleton : NSObject {
    
    
    NSString *sessionID;
    
    NSURL *mainPageURL;
    NSURL *mailboxURL;
    NSURL *kioskURL;
    //To Implmenet Later
    NSURL *mealPointsURL;
    NSURL *bearBuxURL;
    NSURL *classSceduleURL;
    NSURL *classMapURL;
    
    NSMutableData *mainPageData;
    NSMutableData *mailboxData;
    NSMutableData *kioskData;
    //To Implement
    NSMutableData *mealPointsData;
    NSMutableData *bearBuxData;
    NSMutableData *classSceduleData;
    NSMutableData *classMapData;
    
    
    NSTimer *timer;
    NSInteger timerInterval;
    NSInteger numberOfFailedLoads;
    NSInteger maxNumberOfReloads;
    
}
//Already Implemented
-(void)initLoadValuesWithoutSessionID;
-(void)initLoadValuesWithSessionID;
-(void)forceReload;
-(void)sendAll;

-(void)sendMainPage;
-(void)sendMailbox;
-(void)sendKiosk;
//To Implement Later
-(void)sendMealPoints;
-(void)sendBearBux;
-(void)sendClassScedule;
-(void)sendClassMap;

-(NSMutableData*)getMainPageData;
-(NSMutableData*)getMailbox;
-(NSMutableData*)getKiosk;
-(NSMutableData*)getMealPoints;
-(NSMutableData*)getBearBux;
-(NSMutableData*)getClassScedule;
-(NSMutableData*)getClassMap;

-(BOOL)sessionIDRecieved;
-(NSInteger)getNumberOfFailedLoads;


//Singleton Method
+(dispatcherSingleton *)initialize;

@end
