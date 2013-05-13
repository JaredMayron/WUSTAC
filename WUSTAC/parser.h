//
//  parser.h
//  WUSTAC
//
//  Created by Jared Mayron on 5/12/13.
//  Copyright (c) 2013 Jared Mayron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface parser : NSObject
+(NSString*) parse:(NSString *)regexString fromBegin:(NSNumber*)fromBegin fromEnd:(NSNumber*)fromEnd RawData:(NSMutableData*)RawData;
@end
