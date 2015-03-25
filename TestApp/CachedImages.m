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
    //NSLog(@"Cached images: %@", imgs);
    
    NSDictionary *cachedImg;
    
    for (NSDictionary *img in imgs) {
        if ([[img objectForKey:@"URL"] isEqualToString:imgURL])
            cachedImg = img;
    }
    
    //NSLog(@"Image found in cache: %@", cachedImg);
    if (![self isImageActual:cachedImg]) {
        
        if (cachedImg)
            [imgs removeObject:cachedImg];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *newImg = [self getFullImgFromURL:imgURL];
            NSDictionary *newImgDict = [NSDictionary dictionaryWithObjectsAndKeys:imgURL, @"URL", UIImagePNGRepresentation(newImg), @"image", nil];
            NSMutableArray *newImages = [NSMutableArray arrayWithArray:imgs];
            [newImages addObject:newImgDict];
            [[NSUserDefaults standardUserDefaults] setObject:newImages forKey:@"CachedImages"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            predicate();
            //NSLog(@"Image was out of date, downloaded new: %@", cachedImg);
        });
    }
    
    if (cachedImg != nil)
        return [UIImage imageWithData:[cachedImg objectForKey:@"image"]];
    return nil;
}

+ (UIImage *) getFullImgFromURL:(NSString *)imgURL {
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]];
    return [UIImage imageWithData:data];
}

+ (BOOL) isImageActual:(NSDictionary *)imgDict {
    if (!imgDict)
        return NO;
    
    return YES;
}

@end
