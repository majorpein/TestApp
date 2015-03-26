//
//  ArticlesController.m
//  TestApp
//
//  Created by Alexander Anosov on 24/03/15.
//  Copyright (c) 2015 Alexander Anosov. All rights reserved.
//

#import "ArticlesController.h"
#import "RESTRequestsManager.h"
#import "ErrorHandler.h"
#import "CachedImages.h"
#import "ArticleDetailController.h"

@interface ArticlesController ()

@end

@implementation ArticlesController

- (void)viewDidLoad {
    [self setKey:@"articles"];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleCell"];
    
    // Configure the cell...
    NSLog(@"Configuring cell");
    
    NSDictionary *dict = [self.items objectAtIndex:indexPath.row];
    
    UIImage *img = [CachedImages getImageFromURL:[dict objectForKey:@"image"] completion:^{
        [tableView reloadData];
        NSLog(@"Reloading Data");
    }];
    if (img) {
        [(UIImageView *)[cell.contentView viewWithTag:kImageTag] setImage:img];
        [(UIActivityIndicatorView *)[cell.contentView viewWithTag:kActivityTag] setHidden:YES];
        [(UIActivityIndicatorView *)[cell.contentView viewWithTag:kActivityTag] stopAnimating];
    } else {
        [(UIActivityIndicatorView *)[cell.contentView viewWithTag:kActivityTag] setHidden:NO];
        [(UIActivityIndicatorView *)[cell.contentView viewWithTag:kActivityTag] startAnimating];
    }
    [(UILabel *)[cell.contentView viewWithTag:kTitleTag] setText:[dict objectForKey:@"title"]];
    [(UILabel *)[cell.contentView viewWithTag:kBodyTag] setText:[dict objectForKey:@"body"]];
    
    return cell;
}


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

@end
