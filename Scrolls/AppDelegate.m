//
//  AppDelegate.m
//  Scrolls
//
//  Created by Nathan Borror on 4/28/14.
//  Copyright (c) 2014 Nathan Borror. All rights reserved.
//

#import "AppDelegate.h"
#import "LockScreenViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

  LockScreenViewController *viewController = [[LockScreenViewController alloc] init];
  [_window setRootViewController:viewController];

  [_window setBackgroundColor:[UIColor whiteColor]];
  [_window makeKeyAndVisible];
  return YES;
}

@end
