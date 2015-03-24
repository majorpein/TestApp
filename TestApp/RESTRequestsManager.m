//
//  RESTRequestsManager.m
//  TestApp
//
//  Created by Alexander Anosov on 24/03/15.
//  Copyright (c) 2015 Alexander Anosov. All rights reserved.
//

#import "RESTRequestsManager.h"
#import "DummyAPIClass.h"

@implementation RESTRequestsManager

NSString * const apiURL = @"http://dummyapi";

+ (NSData *) sendSynchroniousRequestWithString:(NSString *)appendingString method:(NSString *)method withParams:(NSDictionary *)params error:(NSError **)error {
    
    NSURL *url = [[NSURL URLWithString:apiURL] URLByAppendingPathComponent:appendingString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:method];
    
    for (NSString *key in [params allKeys]) {
        [request setValue:[params objectForKey:key] forHTTPHeaderField:key];
    }
    
    NSURLResponse *response;
    
    //here we have to use
    //NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

    //instead we will use dummy method
    
    NSData *data = [DummyAPIClass sendDummySynchronousRequest:appendingString returningResponse:&response error:error];
    
    return data;
}

@end
