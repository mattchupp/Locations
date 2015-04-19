//
//  MCLocationViewController.m
//  Locations
//
//  Created by Matthew Chupp on 4/17/15.
//  Copyright (c) 2015 MattChupp. All rights reserved.
//

#import "MCLocationViewController.h"

@interface MCLocationViewController () //<NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, copy) NSArray *locations;

@end


@implementation MCLocationViewController


- (instancetype)initWithStyle:(UITableViewStyle)style {
    
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"Locations";
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _session = [NSURLSession sessionWithConfiguration:config
                                                 delegate:nil
                                            delegateQueue:nil];
        
        [self fetchFeed];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)fetchFeed {
    
    NSString *requestString = @"http://bookapi.bignerdranch.com/courses.json";
//    NSString *requestString = @"http://mattchupp.com/service.php";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask =
    [self.session dataTaskWithRequest:req
                    completionHandler:
     ^(NSData *data, NSURLResponse *response, NSError *error) {
         
         NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:0
                                                                      error:nil];
         self.locations = jsonObject[@"courses"];
//         self.locations = jsonObject[@"Name"];
         
         NSLog(@"%@", self.locations);
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
         });
     }];
    [dataTask resume];
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
    
    return [self.locations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                    forIndexPath:indexPath];
    
    NSDictionary *location = self.locations[indexPath.row];
    cell.textLabel.text = location[@"title"];
//    cell.textLabel.text = location[@"Name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *location = self.locations[indexPath.row];
    NSURL *URL = [NSURL URLWithString:location[@"url"]];
    
    self.webViewController.title = location[@"title"];
//    self.webViewController.title = location[@"Name"];
    self.webViewController.URL = URL;
    [self.navigationController pushViewController:self.webViewController
                                         animated:YES];
}

//- (void)  URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
// didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
//   completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler {
//    
//    NSURLCredential *cred =
//    [NSURLCredential credentialWithUser:@"BigNerdRanch"
//                               password:@"AchieveNerdvana"
//                            persistence:NSURLCredentialPersistenceForSession];
//    completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
//}

@end
