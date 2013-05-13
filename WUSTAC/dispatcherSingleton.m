//
//  dispatcherSingleton.m
//  WUSTAC
//
//  Created by Jared Mayron on 5/11/13.
//  Copyright (c) 2013 Jared Mayron. All rights reserved.
//

#import "dispatcherSingleton.h"

@implementation dispatcherSingleton
static dispatcherSingleton *sharedSingleton;
static NSString *sessionIDRegex = @"str[sS]ession .*[0-9]*";
-(void) initLoadValuesWithoutSessionID
{
    //I'm accessing two web slices within webstac
    mainPageURL = [NSURL URLWithString:@"https://acadinfo.wustl.edu/Private/WebSTAC.asp"];
    mailboxURL = [NSURL URLWithString:@"https://acadinfo.wustl.edu/housing/currentAssignment/Housing_Info.aspx"];
    kioskURL = [NSURL URLWithString:@"https://acadinfo.wustl.edu/housing/RoomKiosk/default.aspx"];
    
    
    //Values related to loading
    numberOfFailedLoads = 0;
    maxNumberOfReloads = 9;
    timerInterval = 2;
    
}

-(void) initLoadValuesWithSessionID
{
    mealPointsURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?SID=%@",@"https://acadinfo.wustl.edu/WebSTAC/CBORD/CBORD_Start.aspx",sessionID]];
    bearBuxURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?SID=%@",@"https://acadinfo.wustl.edu/WebSTAC/CBORD/CBORD_CCA.aspx",sessionID]];
    
}
-(void) sendAll{
    [self sendMainPage];
    [self sendMailbox];
    [self sendKiosk];
    [self sendMealPoints];
    [self sendBearBux];
    [self sendClassScedule];
    [self sendClassMap];
}

-(void) forceReload{
    numberOfFailedLoads=0;
    [self sendAll];
}

-(void)sendMainPage
{
    NSURLRequest *mainRequest =
    [NSURLRequest requestWithURL:mainPageURL
                     cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                 timeoutInterval:10.0];
    
    NSURLConnection *mainConnection=[[NSURLConnection alloc] initWithRequest:mainRequest delegate:self];
    
    
    if (mainConnection) {
        mainPageData = [NSMutableData data];
    }
}

-(void) sendMailbox{
    NSURLRequest *mailboxRequest =
    [NSURLRequest requestWithURL:mailboxURL
                     cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                 timeoutInterval:10.0];
    
    NSURLConnection *mailboxConnection=[[NSURLConnection alloc] initWithRequest:mailboxRequest delegate:self];
    
    
    if (mailboxConnection) {
        mailboxData = [NSMutableData data];
    }
}

-(void) sendKiosk{
    NSURLRequest *kioskRequest =
    [NSURLRequest requestWithURL:kioskURL
                     cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                 timeoutInterval:10.0];
    
    NSURLConnection *kioskConnection=[[NSURLConnection alloc] initWithRequest:kioskRequest delegate:self];
    
    if (kioskConnection) {
        kioskData = [NSMutableData data];
    }
}

-(void) sendMealPoints{
    NSURLRequest *mealRequest =
    [NSURLRequest requestWithURL:mealPointsURL
                     cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                 timeoutInterval:10.0];
    
    NSURLConnection *mealConnection=[[NSURLConnection alloc] initWithRequest:mealRequest delegate:self];
    
    if (mealConnection) {
        mealPointsData = [NSMutableData data];
    }
}

-(void) sendBearBux{
    NSURLRequest *bearRequest =
    [NSURLRequest requestWithURL:bearBuxURL
                     cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                 timeoutInterval:10.0];
    
    NSURLConnection *bearConnection=[[NSURLConnection alloc] initWithRequest:bearRequest delegate:self];
    
    if (bearConnection) {
        bearBuxData = [NSMutableData data];
    }
    
}

-(void) sendClassScedule{
    //TODO
}

-(void) sendClassMap{
    //TODO
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSURL *myURL = [[connection currentRequest] URL];
    if([myURL isEqual:mainPageURL]){
        [mainPageData setData:data];
    }else if([myURL isEqual:kioskURL]){
        [kioskData setData:data];
    } else if ([myURL isEqual:mailboxURL]){
        [mailboxData setData:data];
    } else if ([myURL isEqual:mealPointsURL]){
        [mealPointsData setData:data];
    } else if([myURL isEqual:bearBuxURL]){
        [bearBuxData setData:data];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSURL *myURL = [[connection currentRequest] URL];
    if(numberOfFailedLoads<10){
        if([myURL isEqual:mainPageURL]){
            timer  = [NSTimer scheduledTimerWithTimeInterval:timerInterval target:self selector:@selector(sendMainPage) userInfo:nil repeats:NO];
        }else if([myURL isEqual:kioskURL]){
            timer  = [NSTimer scheduledTimerWithTimeInterval:timerInterval target:self selector:@selector(sendKiosk) userInfo:nil repeats:NO];
        } else if ([myURL isEqual:mailboxURL]){
            timer  = [NSTimer scheduledTimerWithTimeInterval:timerInterval target:self selector:@selector(sendMailbox) userInfo:nil repeats:NO];
        } else if ([myURL isEqual:mealPointsURL]){
            timer  = [NSTimer scheduledTimerWithTimeInterval:timerInterval target:self selector:@selector(sendMealPoints) userInfo:nil repeats:NO];
        } else if([myURL isEqual:bearBuxURL]){
            timer  = [NSTimer scheduledTimerWithTimeInterval:timerInterval target:self selector:@selector(sendBearBux) userInfo:nil repeats:NO];
        }
    }
    numberOfFailedLoads++;
    [[NSNotificationCenter defaultCenter] postNotificationName:loads object:nil];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSURL *myURL = [[connection currentRequest] URL];
    if([myURL isEqual:mainPageURL]){
        NSNumber *begin = [NSNumber numberWithInt:14];
        NSNumber *end = [NSNumber numberWithInt:2];
        sessionID = [parser parse:sessionIDRegex fromBegin:begin fromEnd:end RawData:mainPageData];
        [self initLoadValuesWithSessionID];
        [[NSNotificationCenter defaultCenter] postNotificationName:main object:nil];
    }else if([myURL isEqual:kioskURL]){
        [[NSNotificationCenter defaultCenter] postNotificationName:kiosk object:nil];
    } else if ([myURL isEqual:mailboxURL]){
        [[NSNotificationCenter defaultCenter] postNotificationName:mailbox object:nil];
    } else if ([myURL isEqual:mealPointsURL]){
        [[NSNotificationCenter defaultCenter] postNotificationName:mealPoints object:nil];
    } else if([myURL isEqual:bearBuxURL]){
        [[NSNotificationCenter defaultCenter] postNotificationName:bearBux object:nil];
    } else {
        NSLog(@"Unrecognized Load");
    }
}

-(NSMutableData*)getMainPageData{
    return mainPageData;
}


-(NSMutableData*) getMailbox{
    return mailboxData;
}

-(NSMutableData*) getKiosk{
    return kioskData;
    
}

-(NSMutableData*) getMealPoints{
    return mealPointsData;
}

-(NSMutableData*) getBearBux{
    return bearBuxData;
}

-(NSMutableData*) getClassScedule{
    return nil;
    //TODO
}

-(NSMutableData*) getClassMap {
    return nil;
    //TODO
}

-(NSInteger) getNumberOfFailedLoads{
    return numberOfFailedLoads;
}

-(BOOL) sessionIDRecieved
{
    return (sessionID!=nil);
}



+(dispatcherSingleton *)initialize{
    if(sharedSingleton == nil){
        sharedSingleton = [[dispatcherSingleton alloc] init];
        [sharedSingleton initLoadValuesWithoutSessionID];
    }
    
    return sharedSingleton;
}

@end
