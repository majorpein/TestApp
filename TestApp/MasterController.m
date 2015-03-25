//
//  MasterController.m
//  TestApp
//
//  Created by Alexandro on 26/03/15.
//  Copyright (c) 2015 Alexandro. All rights reserved.
//

#import "MasterController.h"
#import "RESTRequestsManager.h"
#import "ErrorHandler.h"
#import "CachedImages.h"
#import "DetailController.h"

@interface MasterController ()

@end

@implementation MasterController

@synthesize items, key;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.items = [[NSUserDefaults standardUserDefaults] objectForKey:self.key];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"AuthorizationToken"];
        
        NSError *error;
        
        NSDictionary *result = [RESTRequestsManager sendSynchroniousRequestWithString:self.key method:@"GET" withParams:[NSDictionary dictionaryWithObject:token forKey:@"token"] error:&error];
        
        if (result == nil) {
            [ErrorHandler handleError:error];
        } else {
            
            NSString *code = [result objectForKey:@"code"];
            self.items = [result objectForKey:self.key];
            if (![code isEqualToString:@"200"]) {
                [ErrorHandler handleError:error];
            } else {
                [[NSUserDefaults standardUserDefaults] setObject:items forKey:self.key];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.tableView reloadData];
            }
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"ArticleDetailSegue"]) {
        UINavigationController *v = [segue destinationViewController];
        DetailController *artDet = (DetailController *)v.visibleViewController;
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            
            [artDet setImage:[(UIImageView *)[(UITableViewCell *)[sender contentView] viewWithTag:kImageTag] image]];
            [artDet setTitleString:[(UILabel *)[(UITableViewCell *)[sender contentView] viewWithTag:kTitleTag] text]];
            [artDet setBodyString:[(UILabel *)[(UITableViewCell *)[sender contentView] viewWithTag:kBodyTag] text]];
            
            NSDictionary *dict = [self.items objectAtIndex:[self.tableView indexPathForCell:sender].row];
            [artDet setMyID:[[dict objectForKey:@"id"] intValue]];
        }
    }
}


@end