//
//  ViewController.h
//  Locations
//
//  Created by Matthew Chupp on 4/15/15.
//  Copyright (c) 2015 MattChupp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCHomeModel.h"

@interface MCViewController : UIViewController
    <UITableViewDataSource, UITableViewDelegate, MCHomeModelProtocol>

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end

