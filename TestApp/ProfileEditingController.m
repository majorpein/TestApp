//
//  ProfileEditingController.m
//  TestApp
//
//  Created by Alexander Anosov on 24/03/15.
//  Copyright (c) 2015 Alexander Anosov. All rights reserved.
//

#import "ProfileEditingController.h"

@interface ProfileEditingController ()

@property (weak) IBOutlet UITableViewCell *avatarCell;
@property (weak) IBOutlet UITableViewCell *nameCell;
@property (weak) IBOutlet UITableViewCell *emailCell;
@property (weak) IBOutlet UITableViewCell *phoneCell;

@end

@implementation ProfileEditingController

@synthesize profileController;
@synthesize avatarCell, nameCell, emailCell, phoneCell;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [(UITextField *)[self.nameCell.contentView viewWithTag:kTextFieldTag] setText:self.profileController.avatarNameCell.textLabel.text];
    [(UITextField *)[self.emailCell.contentView viewWithTag:kTextFieldTag] setText:self.profileController.emailCell.textLabel.text];
    [(UITextField *)[self.phoneCell.contentView viewWithTag:kTextFieldTag] setText:self.profileController.phoneCell.textLabel.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) onDoneClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) onCancelClick:(id)sender {
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [(UITextField *)[self.nameCell.contentView viewWithTag:kTextFieldTag] resignFirstResponder];
    [(UITextField *)[self.emailCell.contentView viewWithTag:kTextFieldTag] resignFirstResponder];
    [(UITextField *)[self.phoneCell.contentView viewWithTag:kTextFieldTag] resignFirstResponder];
}

@end