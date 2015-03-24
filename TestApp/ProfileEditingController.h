//
//  ProfileEditingController.h
//  TestApp
//
//  Created by Alexander Anosov on 24/03/15.
//  Copyright (c) 2015 Alexander Anosov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileController.h"

#define kImageViewTag 13
#define kTextFieldTag 27

@interface ProfileEditingController : UITableViewController

@property (weak) ProfileController *profileController;

@end
