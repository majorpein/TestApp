//
//  ArticleDetailController.h
//  TestApp
//
//  Created by Alexander Anosov on 25/03/15.
//  Copyright (c) 2015 Alexandro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleDetailController : UIViewController

@property (strong) UIImage *image;
@property (strong) NSString *titleString;
@property (strong) NSString *bodyString;
@property int articleID;

@end
