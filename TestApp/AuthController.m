//
//  AuthController.m
//  TestApp
//
//  Created by Alexander Anosov on 24/03/15.
//  Copyright (c) 2015 Alexander Anosov. All rights reserved.
//

#import "AuthController.h"
#import "RESTRequestsManager.h"
#import "ErrorHandler.h"
#import "RegistrationController.h"

@interface AuthController ()

@property (weak) IBOutlet UITextField *email;
@property (weak) IBOutlet UITextField *pass;
@property (weak) IBOutlet UIActivityIndicatorView *indicator;
@property (weak) IBOutlet UIView *shade;

@end

@implementation AuthController

@synthesize email, pass, indicator, shade;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void) presentAuthController {
    
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AuthController *authController = [sb instantiateViewControllerWithIdentifier:@"AuthController"];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:authController animated:YES completion:nil];
}

- (IBAction) onLoginClick:(id)sender {
    
    [self showAnimatingIndicator];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        NSDictionary *result = [RESTRequestsManager sendSynchroniousRequestWithString:@"auth" method:@"POST" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[email text], @"email", [pass text], @"password", nil] error:&error];
        
        [self tryToLoginWithResult:result error:error];
    });
}

- (void) showAnimatingIndicator {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(void){
        [self.shade setHidden:NO];
    } completion:^(BOOL finished){}];
    
    [self.indicator setHidden:NO];
    [self.indicator startAnimating];
}

- (void) tryToLoginWithResult:(NSDictionary *)result error:(NSError *)error {
    
    if (result == nil) {
        [ErrorHandler handleError:error];
    } else {
        [self.indicator stopAnimating];
        [self.indicator setHidden:YES];
        [self.shade setHidden:YES];
        
        NSString *code = [result objectForKey:@"code"];
        NSString *token = [result objectForKey:@"token"];
        if (![code isEqualToString:@"200"]) {
            [ErrorHandler handleError:error];
        } else {
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"AuthorizationToken"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"RegistrationSegue"]) {
        UINavigationController *v = [segue destinationViewController];
        RegistrationController *reg = (RegistrationController *)v.visibleViewController;
        [reg setAuthController:self];
    }
}


@end
