//
//  AuthController.h
//  TestApp
//
//  Created by Alexander Anosov on 24/03/15.
//  Copyright (c) 2015 Alexander Anosov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthController : UIViewController

+ (void) presentAuthController;
- (void) showAnimatingIndicator;
- (void) tryToLoginWithResult:(NSDictionary *)result error:(NSError *)error;

@end
