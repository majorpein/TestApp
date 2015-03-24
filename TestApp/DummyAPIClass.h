//
//  DummyAPIClass.h
//  TestApp
//
//  Created by Alexander Anosov on 24/03/15.
//  Copyright (c) 2015 Alexander Anosov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DummyAPIClass : NSObject

+ (NSData *)sendDummySynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse **)response error:(NSError **)error;

@end
