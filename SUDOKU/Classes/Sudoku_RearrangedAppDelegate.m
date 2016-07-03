//
//  Sudoku_RearrangedAppDelegate.m
//  Sudoku-Rearranged
//
//  Created by Gediz GÜRSU on 1/9/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "Sudoku_RearrangedAppDelegate.h"
#import "ASingletonClass.h"

@implementation Sudoku_RearrangedAppDelegate

@synthesize window;
@synthesize homeScreenViewController;
@synthesize codaSplashView;



- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	
    // Override point for customization after application launch
	
	ASingletonClass *aSInstance=[ASingletonClass sharedManager];
	[[UIApplication sharedApplication] setIdleTimerDisabled:TRUE];
	SEL bstf=@selector(addSubview:); 
	
	[window addSubview:codaSplashView];
	[window performSelector:bstf withObject:homeScreenViewController.view afterDelay:(NSTimeInterval)1];
	[window makeKeyAndVisible];

}


- (void)dealloc {
	[codaSplashView release];
	[homeScreenViewController release];
	[window release];
    [super dealloc];
}


@end
