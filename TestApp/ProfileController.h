//
//  ProfileController.h
//  TestApp
//
//  Created by Alexander Anosov on 24/03/15.
//  Copyright (c) 2015 Alexander Anosov. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kProfileImageTag 17
#define kProfileLabelTag 7

@interface ProfileController : UITableViewController

@property (weak, readonly) IBOutlet UITableViewCell *avatarNameCell;
@property (weak, readonly) IBOutlet UITableViewCell *emailCell;
@property (weak, readonly) IBOutlet UITableViewCell *phoneCell;

- (void) updateProfile;

@end
