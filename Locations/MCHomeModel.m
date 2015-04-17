//
//  MCHomeModel.m
//  Locations
//
//  Created by Matthew Chupp on 4/15/15.
//  Copyright (c) 2015 MattChupp. All rights reserved.
//

#import "MCHomeModel.h"
#import "MCLocation.h"

@interface MCHomeModel ()

{
    NSMutableData *_downloadedData;
}

@end

@implementation MCHomeModel


// download and parse all of the JSON objects
- (void)downloadItems {
    
    // Download the JSON file
    NSString *URL = @"http://mattchupp.com/service.php";
    NSURL *jsonFileURL = [NSURL URLWithString:URL];
    
    // Create the request
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileURL];
    
    // Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

#pragma mark - NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection
    didReceiveResponse:(NSURLResponse *)response {
    
    // Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    // Create an array to store the locations
    NSMutableArray *_locations = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++) {
        
        NSDictionary *jsonElement = jsonArray[i];
        
        // Create a new location object and set its props to JsonElement properties
        MCLocation *newLocation = [[MCLocation alloc] init];
        newLocation.name = jsonElement[@"Name"];
        newLocation.address = jsonElement[@"Address"];
        newLocation.latitude = jsonElement[@"Latitude"];
        newLocation.longitude = jsonElement[@"Longitude"];
        
        // Add this question to the locations array
        [_locations addObject:newLocation];
    }
    
    // Ready to notify delegate that data is ready and pass back items
    if (self.delegate) {
        [self.delegate itemsDownloaded:_locations];
    }
}

@end
