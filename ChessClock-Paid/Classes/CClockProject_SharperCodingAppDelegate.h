//
//  CClockProject_SharperCodingAppDelegate.h
//  CClockProject-SharperCoding
//
//  Created by Gediz GÜRSU on 7/3/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CClockProject_SharperCodingViewController;

@interface CClockProject_SharperCodingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CClockProject_SharperCodingViewController *viewController;
	BOOL firstLaunch;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CClockProject_SharperCodingViewController *viewController;

@end

