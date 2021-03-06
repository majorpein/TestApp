//
//  EventsDetailController.m
//  TestApp
//
//  Created by Alexandro on 26/03/15.
//  Copyright (c) 2015 Alexandro. All rights reserved.
//

#import "EventsDetailController.h"
#import "RESTRequestsManager.h"
#import "ErrorHandler.h"
#import "CachedImages.h"

@interface EventsDetailController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *body;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation EventsDetailController

@synthesize imageView, titleLabel, body, date, indicator;

- (void)viewDidLoad {
    [self setKey:@"event"];
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
    [self.date setText:[dict objectForKey:@"date"]];
}

- (void) setActualImageViewFromURL:(NSString *)url {
    UIImage *img = [CachedImages getImageFromURL:url completion:^{
        [self setActualImageViewFromURL:url];
        NSLog(@"One more time");
    }];
    if (img) {
        [self.imageView setImage:img];
        [self.indicator setHidden:YES];
        [self.indicator stopAnimating];
    } else {
        [self.indicator setHidden:NO];
        [self.indicator startAnimating];
    }
}

- (IBAction) onRegisterClick:(id)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"AuthorizationToken"];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:token, @"token", nil];
        
        NSError *error;
        
        NSDictionary *result = [RESTRequestsManager sendSynchroniousRequestWithString:[NSString stringWithFormat:@"events/%d/register", self.myID] method:@"POST" withParams:params error:&error];
        
        if (result == nil) {
            [ErrorHandler handleError:error];
        } else {
            NSString *code = [result objectForKey:@"code"];
            if (![code isEqualToString:@"200"]) {
                [ErrorHandler handleError:error];
            }
        }
    });
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
