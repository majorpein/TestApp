//
//  EventsDetailController.h
//  TestApp
//
//  Created by Alexandro on 26/03/15.
//  Copyright (c) 2015 Alexandro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsDetailController : UIViewController

@property (strong) UIImage *image;
@property (strong) NSString *titleString;
@property (strong) NSString *bodyString;
@property (strong) NSString *dateString;
@property int eventID;

@end
