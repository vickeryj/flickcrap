//
//  MasterViewController.m
//  flickcrap
//
//  Created by Joshua Vickery on 12/10/12.
//  Copyright (c) 2012 Joshua Vickery. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "FlickrManager.h"
#import "UIImageView+AFNetworking.h"
#import "FlickrFeedItem.h"

@interface MasterViewController ()

@property (strong, nonatomic) NSArray *feedItems;

@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Flickr";
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *spinnerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    spinner.frame = CGRectMake(160-(spinner.frame.size.width/2), 30-(spinner.frame.size.height/2), spinner.frame.size.width, spinner.frame.size.width);
    [spinnerView addSubview:spinner];
    self.tableView.tableHeaderView = spinnerView;
    FlickrManager *flickrManager = [[FlickrManager alloc] init];
    [flickrManager fetchFeedWithCallback:^(NSArray *flickrItems) {
        self.feedItems = flickrItems;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableView.tableHeaderView = nil;
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.feedItems count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    cell.textLabel.text = [[self.feedItems objectAtIndex:indexPath.row] title];
    

    NSURLRequest *imageRequest = [[self.feedItems objectAtIndex:indexPath.row] imageRequest];
    if (nil != imageRequest) {
        UITableViewCell *weakCell = cell;
        [cell.imageView setImageWithURLRequest:imageRequest
                              placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                  weakCell.imageView.image = image;
                                  [weakCell setNeedsLayout];
                              } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                  
                              }];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    self.detailViewController.feedItem = [self.feedItems objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end
