//
//  JsonParser.m
//  CloudMadeApi
//
//  Created by Dmytro Golub on 8/4/09.
//  Copyright 2009 CloudMade. All rights reserved.
//

#import "JsonParser.h"


@implementation JsonParser

- (id)JSONValue:(NSString*) jsonStr
{
    SBJSON *json = [[SBJSON new] autorelease];
    
    NSError *error;
    id o = [json objectWithString:jsonStr error:&error];
    
    if (!o)
        PLog(@"%@", error);
    return o;
}

@end
