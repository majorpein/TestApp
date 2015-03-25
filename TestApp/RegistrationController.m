//
//  RegistrationController.m
//  TestApp
//
//  Created by Alexander Anosov on 24/03/15.
//  Copyright (c) 2015 Alexander Anosov. All rights reserved.
//

#import "RegistrationController.h"
#import "RESTRequestsManager.h"

@interface RegistrationController ()

@property (weak) IBOutlet UITableViewCell *nameCell;
@property (weak) IBOutlet UITableViewCell *emailCell;
@property (weak) IBOutlet UITableViewCell *phoneCell;
@property (weak) IBOutlet UITableViewCell *passCell;

@end

@implementation RegistrationController

@synthesize authController;
@synthesize nameCell, emailCell, phoneCell, passCell;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) onDoneClick:(id)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[(UITextField *)[self.nameCell.contentView viewWithTag:kTextFieldTag] text], @"fio", [(UITextField *)[self.emailCell.contentView viewWithTag:kTextFieldTag] text], @"email", [(UITextField *)[self.phoneCell.contentView viewWithTag:kTextFieldTag] text], @"phone", [(UITextField *)[self.passCell.contentView viewWithTag:kTextFieldTag] text], @"password", nil];
        
        NSError *error;
        
        NSDictionary *result = [RESTRequestsManager sendSynchroniousRequestWithString:@"user" method:@"POST" withParams:params error:&error];
        
        [self dismissViewControllerAnimated:YES completion:^{
            [self.authController tryToLoginWithResult:result error:error];
        }];
    });
}

- (IBAction) onCancelClick:(id)sender {
    
    [(UITextField *)[self.nameCell.contentView viewWithTag:kTextFieldTag] setText:@""];
    [(UITextField *)[self.emailCell.contentView viewWithTag:kTextFieldTag] setText:@""];
    [(UITextField *)[self.phoneCell.contentView viewWithTag:kTextFieldTag] setText:@""];
    [(UITextField *)[self.passCell.contentView viewWithTag:kTextFieldTag] setText:@""];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
*/
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [(UITextField *)[self.nameCell.contentView viewWithTag:kTextFieldTag] resignFirstResponder];
    [(UITextField *)[self.emailCell.contentView viewWithTag:kTextFieldTag] resignFirstResponder];
    [(UITextField *)[self.phoneCell.contentView viewWithTag:kTextFieldTag] resignFirstResponder];
    [(UITextField *)[self.passCell.contentView viewWithTag:kTextFieldTag] resignFirstResponder];
}

@end
