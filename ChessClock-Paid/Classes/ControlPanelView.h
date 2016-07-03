//
//  ControlPanelView.h
//  CClockProject-SharperCoding
//
//  Created by Gediz GÜRSU on 7/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ControlPanelView : UIView {
	UILabel *delayLabel;
	//UIButton *whitesButton, *blacksButton,*infoButtonExternal; //UI Interraction Buttons
	//UIButton *oneMinTypeButton, *fiveMinTypeButton, *fftMinTypeButton, *anHourTypeButton, *soundONOFFButton; //Game Type Button pointers
	//UIButton *hrminsecButton, *hrminsecButton2; //Passive Buttons pointers
	//UIButton *wIncHrB , *wIncMinB, *wIncSecB,* bIncHrB,* bIncMinB,* bIncSecB,* wDecHrB,* wDecMinB,* wDecSecB,* bDecHrB,* bDecMinB,* bDecSecB,
	//*increaseDelayButton, *decreaseDelayButton, *panelButton; //Time Adjustment Buttons pointers
	
}
@property (nonatomic,retain) IBOutlet UILabel *delayLabel;
//@property (nonatomic,retain) IBOutlet UIButton 
//*oneMinTypeButton, *fiveMinTypeButton, *fftMinTypeButton, *anHourTypeButton,
//*wIncHrB , *wIncMinB, *wIncSecB,* bIncHrB,* bIncMinB,* bIncSecB,* wDecHrB,* wDecMinB,* wDecSecB,* bDecHrB,* bDecMinB,* bDecSecB,
//*increaseDelayButton, *decreaseDelayButton,*soundONOFFButton;

@end
