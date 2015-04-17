//
//  ViewController.m
//  Locations
//
//  Created by Matthew Chupp on 4/15/15.
//  Copyright (c) 2015 MattChupp. All rights reserved.
//

#import "MCViewController.h"
#import "MCLocation.h"
#import "MCAddressViewController.h"

@interface MCViewController ()
{
    MCHomeModel *_homeModel;
    NSArray *_feedItems;
}
@end

@implementation MCViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Set this view controller object as the delegate and data source for the table view
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    
    // Create array object and assign it to _feedItems variable
    _feedItems = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to _homeModel variable
    _homeModel = [[MCHomeModel alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _homeModel.delegate = self;
    
    // Call the download items method of the home model object
    [_homeModel downloadItems];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    
    // Set the downloaded items to the array
    _feedItems = items;
    
    // Reload the table view
    [self.listTableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//        // For the push segue, the sender is the UITableViewCell
//        NSIndexPath *ip = [self.tableView indexPathForCell:sender];
//        MCColorDescription *color = self.colors[ip.row];
//        
//        // Set the color, and also tell the view controller that this
//        // is an existing color
//        MCColorViewController *cvc =
//        (MCColorViewController *)segue.destinationViewController;
//        cvc.colorDescription = color;
//        cvc.existingColor = YES;
    
//    // For the push segue, the sender is the UITableViewCell
//    NSIndexPath *ip = [self.tableView indexPathForCell:sender];
//    MCColorDescription *color = self.colors[ip.row];
//    
//    // Set the color, and also tell the view controller that this
//    // is an existing color
//    MCColorViewController *cvc =
//    (MCColorViewController *)segue.destinationViewController;
//    cvc.colorDescription = color;
//    cvc.existingColor = YES;


}

#pragma mark Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of feed items (initially 0)
    return _feedItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Retrieve cell
    NSString *cellIdentifier = @"BasicCell";
    UITableViewCell *myCell =
        [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Get the location to be shown
    MCLocation *item = _feedItems[indexPath.row];
    
    // Get references to labels of cell
    myCell.textLabel.text = item.name;
    
    return myCell;
}

@end
