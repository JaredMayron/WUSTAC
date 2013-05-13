//
//  parser.m
//  WUSTAC
//
//  Created by Jared Mayron on 5/12/13.
//  Copyright (c) 2013 Jared Mayron. All rights reserved.
//

#import "parser.h"

@implementation parser
+(NSString*)parse:(NSString *)regexString fromBegin:(NSNumber *)fromBegin fromEnd:(NSNumber *)fromEnd RawData:(NSMutableData *)RawData
{
    NSString *data = [[NSString alloc] initWithData:RawData encoding:NSUTF8StringEncoding];
    @try {
        NSError *error = NULL;
        NSRegularExpression *regex = [[NSRegularExpression alloc] init];
        NSRange range;
        
        
        regex = [NSRegularExpression
                 regularExpressionWithPattern:regexString
                 options:0
                 error:&error];
        
        range   = [regex
                   rangeOfFirstMatchInString:data
                   options:0
                   range:NSMakeRange(0, [data length])];
        NSString *rawScrape = [data substringWithRange:range];
        NSInteger toValue = [rawScrape length]-fromEnd.intValue;
        return [[rawScrape substringToIndex:toValue] substringFromIndex:fromBegin.intValue];
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {}
}

@end
