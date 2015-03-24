//
//  RESTRequestsManager.h
//  TestApp
//
//  Created by Alexander Anosov on 24/03/15.
//  Copyright (c) 2015 Alexander Anosov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RESTRequestsManager : NSObject

+ (NSData *) sendSynchroniousRequestWithString:(NSString *)appendingString method:(NSString *)method withParams:(NSDictionary *)params error:(NSError **)error;

@end
