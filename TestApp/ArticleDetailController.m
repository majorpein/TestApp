//
//  ArticleDetailController.m
//  TestApp
//
//  Created by Alexander Anosov on 25/03/15.
//  Copyright (c) 2015 Alexandro. All rights reserved.
//

#import "ArticleDetailController.h"
#import "RESTRequestsManager.h"
#import "ErrorHandler.h"
#import "CachedImages.h"

@interface ArticleDetailController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *body;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ArticleDetailController

@synthesize imageView, titleLabel, body, activityIndicator;

- (void)viewDidLoad {
    [self setKey:@"article"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.imageView setImage:self.image];
    [self.titleLabel setText:self.titleString];
    [self.body setText:self.bodyString];
}

- (void) setInterface:(NSDictionary *)dict {
    [self setActualImageViewFromURL:[dict objectForKey:@"image"]];
    [self.titleLabel setText:[dict objectForKey:@"title"]];
    [self.body setText:[dict objectForKey:@"body"]];
}

- (void) setActualImageViewFromURL:(NSString *)url {
    UIImage *img = [CachedImages getImageFromURL:url completion:^{
        [self setActualImageViewFromURL:url];
        NSLog(@"One more time");
    }];
    if (img) {
        [self.imageView setImage:img];
        [self.activityIndicator setHidden:YES];
        [self.activityIndicator stopAnimating];
    } else {
        [self.activityIndicator setHidden:NO];
        [self.activityIndicator startAnimating];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
