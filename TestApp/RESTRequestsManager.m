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

+ (NSDictionary *) sendSynchroniousRequestWithString:(NSString *)appendingString method:(NSString *)method withParams:(NSDictionary *)params error:(NSError **)error {
    
    NSURL *url = [[NSURL URLWithString:apiURL] URLByAppendingPathComponent:appendingString];
    NSLog(@"Request URL: %@", url);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:method];
    NSLog(@"Request method: %@", method);
    
    NSLog(@"With params: %@", params);
    for (NSString *key in [params allKeys]) {
        [request setValue:[params objectForKey:key] forHTTPHeaderField:key];
    }
    
    NSURLResponse *response;
    
    //here we have to use
    //NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

    //instead we will use dummy method
    
    NSData *data = [DummyAPIClass sendDummySynchronousRequest:appendingString returningResponse:&response error:error];
    
    if (data == nil) {
        return nil;
    }
    id dataDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:error];
    NSLog(@"Answer: %@", dataDic);
    if ([dataDic isKindOfClass:[NSDictionary class]] && [dataDic count]) {
        id result = [dataDic objectForKey:@"result"];
        if ([result isKindOfClass:[NSDictionary class]] && [result count]) {
            return result;
        }
    }
    return nil;
}

@end
