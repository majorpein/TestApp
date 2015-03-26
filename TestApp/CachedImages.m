//
//  CachedImages.m
//  TestApp
//
//  Created by Alexander Anosov on 25/03/15.
//  Copyright (c) 2015 Alexandro. All rights reserved.
//

#import "CachedImages.h"

@implementation CachedImages

+ (UIImage *) getImageFromURL:(NSString *)imgURL completion:(void (^)())predicate {
    
    NSMutableArray *imgs = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"CachedImages"]];
    
    NSDictionary *cachedImg;
    
    for (NSDictionary *img in imgs) {
        if ([[img objectForKey:@"URL"] isEqualToString:imgURL])
            cachedImg = img;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (![self isImageActual:cachedImg]) {
        
            if (cachedImg)
                [imgs removeObject:cachedImg];
        
            NSDictionary *newImg = [self getFullImgFromURL:imgURL];
            NSDictionary *newImgDict = [NSDictionary dictionaryWithObjectsAndKeys:imgURL, @"URL", UIImagePNGRepresentation([newImg objectForKey:@"image"]), @"image", [newImg objectForKey:@"length"], @"length", nil];
            NSMutableArray *newImages = [NSMutableArray arrayWithArray:imgs];
            [newImages addObject:newImgDict];
            [[NSUserDefaults standardUserDefaults] setObject:newImages forKey:@"CachedImages"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            dispatch_sync(dispatch_get_main_queue(), ^{
                predicate();
            });
        }
    });
    if (cachedImg != nil) {
        NSLog(@"returning cached image");
        return [UIImage imageWithData:[cachedImg objectForKey:@"image"]];
    }

    NSLog(@"returning nil");
    return nil;
}

+ (NSDictionary *) getFullImgFromURL:(NSString *)imgURL {
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]];
    return [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageWithData:data], @"image", [NSNumber numberWithUnsignedLong:[data length]], @"length", nil];
}

+ (BOOL) isImageActual:(NSDictionary *)imgDict {
    if (!imgDict)
        return NO;
    
    NSError *error;
    
    NSURL *url = [NSURL URLWithString:[imgDict objectForKey:@"URL"]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"HEAD"];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    
    NSURLResponse *response;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    unsigned long imageLength = [[imgDict objectForKey:@"length"] unsignedLongValue];
    
    long long contentLength = [response expectedContentLength];
    
    if (imageLength == contentLength) {
        NSLog(@"Image is actual");
        return YES;
    }
    NSLog(@"Image is not actual");
    return NO;
}

@end
