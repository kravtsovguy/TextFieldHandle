//
//  AppDelegate.m
//  TextFieldHandle
//
//  Created by Matvey Kravtsov on 06/02/2019.
//  Copyright © 2019 Kravtsov. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	self.window = [UIWindow new];
	self.window.rootViewController = [ViewController new];
	[self.window makeKeyAndVisible];
	
	return YES;
}


@end
