//
//  MCHomeModel.h
//  Locations
//
//  Created by Matthew Chupp on 4/15/15.
//  Copyright (c) 2015 MattChupp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MCHomeModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end

@interface MCHomeModel : NSObject

@property (nonatomic, weak) id<MCHomeModelProtocol> delegate;

- (void)downloadItems; 

@end
