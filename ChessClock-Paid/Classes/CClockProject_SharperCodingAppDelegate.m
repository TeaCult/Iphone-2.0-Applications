//
//  CClockProject_SharperCodingAppDelegate.m
//  CClockProject-SharperCoding
//
//  Created by Gediz GÜRSU on 7/3/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "CClockProject_SharperCodingAppDelegate.h"
#import "CClockProject_SharperCodingViewController.h"
#import "CountDownClock.h"
@implementation CClockProject_SharperCodingAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
	[window makeKeyAndVisible];
	[[UIApplication sharedApplication] setIdleTimerDisabled:YES];
	firstLaunch=TRUE;
	
	
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[viewController.whiteClock stopCountDown:nil];
	[viewController.blackClock stopCountDown:nil];
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
	if (firstLaunch) {
		UIAlertView* anAlertView=[[UIAlertView alloc] init];
		NSString* aString=NSLocalizedString(@"Hit either Pause/Resume button or touch black pad to start.\n In order to activate adjustment panel please hit the adjust button...",@"HowToActivateMessage");
		[anAlertView setTitle: aString];
		[anAlertView addButtonWithTitle:NSLocalizedString(@"OK",@"OK Message")];
		[anAlertView show];

		
	}
	if (!firstLaunch) {
	UIAlertView* anAlertView=[[UIAlertView alloc] init];
	[anAlertView setTitle:NSLocalizedString(@"Countdown is stopped due to interruption.",@"stopped message")];
	[anAlertView addButtonWithTitle:NSLocalizedString(@"OK",@"OK Message")];
	[anAlertView show];
	}
}
	
- (void)applicationWillResignActive:(UIApplication *)application {
	[viewController.whiteClock stopCountDown:nil];
	[viewController.blackClock stopCountDown:nil];
	firstLaunch=FALSE;
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
