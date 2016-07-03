//
//  Sudoku_RearrangedAppDelegate.h
//  Sudoku-Rearranged
//
//  Created by Gediz GÜRSU on 1/9/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeScreenViewController.h"

@interface Sudoku_RearrangedAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	HomeScreenViewController *homeScreenViewController;
	UIView *codaSplashView;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HomeScreenViewController *homeScreenViewController;
@property (nonatomic, retain) IBOutlet UIView *codaSplashView;

@end

