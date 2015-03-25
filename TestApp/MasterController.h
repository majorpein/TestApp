//
//  MasterController.h
//  TestApp
//
//  Created by Alexandro on 26/03/15.
//  Copyright (c) 2015 Alexandro. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kImageTag 7
#define kTitleTag 17
#define kBodyTag 27
#define kActivityTag 37

@interface MasterController : UITableViewController

@property NSString *key;
@property NSArray *items;

@end
