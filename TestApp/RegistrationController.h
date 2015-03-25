//
//  RegistrationController.h
//  TestApp
//
//  Created by Alexander Anosov on 24/03/15.
//  Copyright (c) 2015 Alexander Anosov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthController.h"

#define kTextFieldTag 27

@interface RegistrationController : UITableViewController

@property (weak) AuthController *authController;

@end
