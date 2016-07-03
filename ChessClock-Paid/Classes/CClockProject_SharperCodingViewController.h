//
//  CClockProject_SharperCodingViewController.h
//  CClockProject-SharperCoding
//
//  Created by Gediz GÜRSU on 7/3/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountDownClock.h"
#import "ControlPanelView.h"
@interface CClockProject_SharperCodingViewController : UIViewController {
	CountDownClock *whiteClock;
	CountDownClock *blackClock;
	ControlPanelView *CCpanelView;
	UIButton *panelButton;
	UIView *aboutView;
	NSUInteger delay;
	UIView *aBrightnesAdjustmentView;
	BOOL SoundIsON;
}
- (IBAction)modeButtonTouched:(id)sender;
- (IBAction)increaseDelay:(id)sender;
- (IBAction)decreaseDelay:(id)sender;
- (IBAction)incWhiteHr:(id)sender;
- (IBAction)decWhiteHr:(id)sender;
- (IBAction)incWhiteMin:(id)sender;
- (IBAction)decWhiteMin:(id)sender;
- (IBAction)incWhiteSec:(id)sender;
- (IBAction)decWhiteSec:(id)sender;
- (IBAction)incBlackHr:(id)sender;
- (IBAction)decBlackHr:(id)sender;
- (IBAction)incBlackMin:(id)sender;
- (IBAction)decBlackMin:(id)sender;
- (IBAction)incBlackSec:(id)sender;
- (IBAction)decBlackSec:(id)sender;
- (IBAction)setOneMinGame:(id)sender;
- (IBAction)setFiveMinGame:(id)sender;
- (IBAction)setFifteenMinGame:(id)sender;
- (IBAction)setAnHourGame:(id)sender;
- (IBAction)setSoundOnOff:(id)sender;
- (IBAction)pauseResumeClocks:(id)sender;
- (IBAction)showAboutView:(id)sender;
- (IBAction)closeAboutView:(id)sender;
- (IBAction)increasePowerSave:(id)sender;
- (IBAction)decreasePowerSave:(id)sender;

@property(nonatomic,retain) CountDownClock *whiteClock,*blackClock;
@property(nonatomic,retain) IBOutlet ControlPanelView* CCpanelView;
@property(nonatomic,retain) IBOutlet UIButton *panelButton;
@property(nonatomic,retain) IBOutlet UIView *aboutView;
@end

