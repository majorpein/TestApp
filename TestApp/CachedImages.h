//
//  CachedImages.h
//  TestApp
//
//  Created by Alexander Anosov on 25/03/15.
//  Copyright (c) 2015 Alexandro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CachedImages : NSObject

+ (UIImage *) getImageFromURL:(NSString *)imgURL completion: ( void(^)( ))predicate;

@end
