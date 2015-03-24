//
//  DummyAPIClass.m
//  TestApp
//
//  Created by Alexander Anosov on 24/03/15.
//  Copyright (c) 2015 Alexander Anosov. All rights reserved.
//

#import "DummyAPIClass.h"

@implementation DummyAPIClass

+ (NSData *)sendDummySynchronousRequest:(NSString *)request returningResponse:(NSURLResponse **)response error:(NSError **)error {

    if ([request isEqualToString:@"auth"]) {
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObjectsAndKeys:@"200", @"code", @"fcac1a3b62cb51374123de565dc12e16", @"token", nil] forKey:@"result"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:error];
        return data;
    }
    
    return nil;
}

@end
