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

    if ([request isEqualToString:@"auth"] || [request isEqualToString:@"user"]) {
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObjectsAndKeys:@"200", @"code", @"fcac1a3b62cb51374123de565dc12e16", @"token", nil] forKey:@"result"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:error];
        return data;
    }
    if ([request isEqualToString:@"articles"]) {
        
        NSDictionary *article1 = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"id", @"Заголовок статьи 1", @"title", @"<p>Текст статьи в формате HTML</p>", @"body", @"http://www.ricciadams.com/articles/osx-color-conversions/test_image.png", @"image", nil];
        NSDictionary *article2 = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"id", @"Заголовок статьи 2", @"title", @"<p>Текст статьи в формате HTML</p>", @"body", @"http://www.ricciadams.com/articles/osx-color-conversions/test_image.png", @"image", nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObjectsAndKeys:@"200", @"code", [NSArray arrayWithObjects:article1, article2, nil], @"articles", nil] forKey:@"result"];
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:error];
        return data;
    }
    if ([request hasPrefix:@"articles/"]) {
        
        NSString *artID = [request substringFromIndex:9];
        NSLog(@"Article id: %@", artID);
        NSDictionary *article1 = [NSDictionary dictionaryWithObjectsAndKeys:artID, @"id", [NSString stringWithFormat:@"Заголовок статьи %@", artID], @"title", @"<p>Текст статьи в формате HTML</p>", @"body", @"http://www.ricciadams.com/articles/osx-color-conversions/test_image.png", @"image", nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObjectsAndKeys:@"200", @"code", article1, @"article", nil] forKey:@"result"];
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:error];
        return data;
    }
    
    return nil;
}

@end
