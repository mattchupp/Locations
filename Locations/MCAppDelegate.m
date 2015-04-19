//
//  AppDelegate.m
//  Locations
//
//  Created by Matthew Chupp on 4/15/15.
//  Copyright (c) 2015 MattChupp. All rights reserved.
//

#import "MCAppDelegate.h"
#import "MCLocationViewController.h"

@interface MCAppDelegate ()

@end

@implementation MCAppDelegate


- (BOOL)application:(UIApplication *)application
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds] ];
    
    MCLocationViewController *lvc = [[MCLocationViewController alloc]
                                    initWithStyle:UITableViewStylePlain];
    
    UINavigationController *masterNav = [[UINavigationController alloc]
                                         initWithRootViewController:lvc];
    
    MCWebViewController *wvc = [[MCWebViewController alloc] init];
    lvc.webViewController = wvc;
    
    self.window.rootViewController = masterNav;

    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
