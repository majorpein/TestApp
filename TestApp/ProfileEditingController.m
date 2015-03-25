//
//  ProfileEditingController.m
//  TestApp
//
//  Created by Alexander Anosov on 24/03/15.
//  Copyright (c) 2015 Alexander Anosov. All rights reserved.
//

#import "ProfileEditingController.h"
#import "RESTRequestsManager.h"
#import "ErrorHandler.h"

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
    [(UIImageView *)[self.avatarCell.contentView viewWithTag:kImageViewTag] setImage:[(UIImageView *)[self.profileController.avatarNameCell.contentView viewWithTag:kProfileImageTag] image]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized)];
    tap.numberOfTouchesRequired = 1;
    [self.avatarCell addGestureRecognizer:tap];
    
    [(UITextField *)[self.nameCell.contentView viewWithTag:kTextFieldTag] setText:[(UILabel *)[self.profileController.avatarNameCell.contentView viewWithTag:kProfileLabelTag] text]];
    [(UITextField *)[self.emailCell.contentView viewWithTag:kTextFieldTag] setText:self.profileController.emailCell.textLabel.text];
    [(UITextField *)[self.phoneCell.contentView viewWithTag:kTextFieldTag] setText:self.profileController.phoneCell.textLabel.text];
}

- (void)tapRecognized {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) onDoneClick:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"AuthorizationToken"];
        
        NSString *base64image = [UIImagePNGRepresentation([(UIImageView *)[self.avatarCell.contentView viewWithTag:kImageViewTag] image]) base64EncodedStringWithOptions:0];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:token, @"token", [(UITextField *)[self.nameCell.contentView viewWithTag:kTextFieldTag] text], @"fio", [(UITextField *)[self.emailCell.contentView viewWithTag:kTextFieldTag] text], @"email", [(UITextField *)[self.phoneCell.contentView viewWithTag:kTextFieldTag] text], @"phone", base64image, @"avatar", nil];
        
        NSError *error;
        
        NSDictionary *result = [RESTRequestsManager sendSynchroniousRequestWithString:@"edit" method:@"POST" withParams:params error:&error];
        
        if (result == nil) {
            [ErrorHandler handleError:error];
        } else {
            NSString *code = [result objectForKey:@"code"];
            if (![code isEqualToString:@"200"]) {
                [ErrorHandler handleError:error];
            }
        }
        
        [self dismissViewControllerAnimated:YES completion:^{
            [self.profileController updateProfile];
        }];
    });
}

- (IBAction) onCancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [(UIImageView *)[self.avatarCell.contentView viewWithTag:kImageViewTag] setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
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
