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
    if ([request hasPrefix:@"profile"] || [request hasPrefix:@"edit"]) {
        
        NSDictionary *profile = [NSDictionary dictionaryWithObjectsAndKeys:@"Пупкин Василий Петрович", @"fio", @"pupkin@blablabla.com", @"email", @"+79269101010", @"phone", @"http://www.ricciadams.com/articles/osx-color-conversions/test_image.png", @"avatar", nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObjectsAndKeys:@"200", @"code", profile, @"user", nil] forKey:@"result"];
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:error];
        return data;
    }
    if ([request isEqualToString:@"events"]) {
        
        NSDictionary *event1 = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"id", @"Название мероприятия 1", @"title", @"<p>Описание мероприятия в формате HTML</p>", @"body", @"http://www.ricciadams.com/articles/osx-color-conversions/test_image.png", @"image", @"2013-03-01T23:59:59", @"date", nil];
        NSDictionary *event2 = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"id", @"Название мероприятия 2", @"title", @"<p>Описание мероприятия в формате HTML</p>", @"body", @"http://www.ricciadams.com/articles/osx-color-conversions/test_image.png", @"image", @"2015-04-01T23:59:59", @"date", nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObjectsAndKeys:@"200", @"code", [NSArray arrayWithObjects:event1, event2, nil], @"events", nil] forKey:@"result"];
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:error];
        return data;
    }
    if ([request hasPrefix:@"events/"] && ![request hasSuffix:@"register"]) {
        
        NSString *evID = [request substringFromIndex:7];
        NSLog(@"Event id: %@", evID);
        NSDictionary *event1 = [NSDictionary dictionaryWithObjectsAndKeys:evID, @"id", [NSString stringWithFormat:@"Название мероприятия %@", evID], @"title", @"<p>Описание мероприятия в формате HTML</p>", @"body", @"http://www.ricciadams.com/articles/osx-color-conversions/test_image.png", @"image", @"2013-03-01T23:59:59", @"date", nil];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObjectsAndKeys:@"200", @"code", event1, @"event", nil] forKey:@"result"];
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:error];
        return data;
    }
    if ([request hasPrefix:@"events/"] && [request hasSuffix:@"register"]) {
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObjectsAndKeys:@"200", @"code", nil] forKey:@"result"];
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:error];
        return data;
    }
    
    return nil;
}

@end
