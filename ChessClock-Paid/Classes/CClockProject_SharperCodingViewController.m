//
//  CClockProject_SharperCodingViewController.m
//  CClockProject-SharperCoding
//
//  Created by Gediz GÜRSU on 7/3/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "CClockProject_SharperCodingViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CClockProject_SharperCodingViewController (privateMethods)
-(void)whiteClockButtonTouched;
-(void)blackClockButtonTouched;
-(void)bringControlPanel;
-(void)stdButtonAnimation:(UIView*)aView;
@end


@implementation CClockProject_SharperCodingViewController
@synthesize whiteClock,blackClock,panelButton,CCpanelView,aboutView;
//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////	
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itsOver) name:@"Countdown is over!" object:whiteClock];
	
	whiteClock=[[CountDownClock alloc] initWithFrame:CGRectMake(60,60,200,200)
							 ViewBackgroundImageName:@"whiteMovesButton.png"
						   AnalogBackgroundImageName:nil 
								 AnalogBaseImageName:@"clockBase.png" 
										 HrImageName:@"clockhr.png" MinImageName:@"clockmin.png" SecImageName:@"clocksec.png" DigitalBackgroundImageName:nil
							 UserInterractionEnabled:YES];
	
	blackClock=[[CountDownClock alloc] initWithFrame:CGRectMake(60,260,200,200)
							 ViewBackgroundImageName:@"blackMovesButton.png"
						   AnalogBackgroundImageName:nil 
								 AnalogBaseImageName:@"clockBase.png" 
										 HrImageName:@"clockhr.png" MinImageName:@"clockmin.png" SecImageName:@"clocksec.png" DigitalBackgroundImageName:nil
							 UserInterractionEnabled:YES];
	
	[whiteClock setNotificationStringWhenButtonPressed:@"wcb touched"];
	[blackClock setNotificationStringWhenButtonPressed:@"bcb touched"];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whiteClockButtonTouched) name:@"wcb touched" object:whiteClock];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(blackClockButtonTouched) name:@"bcb touched" object:blackClock];
	
	//[whiteClock setClockToHours:0 Minutes:10 Seconds:0];
	//[blackClock setClockToHours:0 Minutes:10 Seconds:0];
	
	[self.view addSubview:whiteClock];
	[self.view addSubview:blackClock];
	
	
	[whiteClock setDigitalClockColor:[UIColor blackColor]];
	[blackClock setDigitalClockColor:[UIColor whiteColor]];
	
	whiteClock.transform=CGAffineTransformRotate(whiteClock.transform, M_PI/2);
	blackClock.transform=CGAffineTransformRotate(blackClock.transform, M_PI/2);
	
	[panelButton addTarget:self action:@selector(moveControlPanel) forControlEvents:UIControlEventTouchUpInside];
	[CCpanelView setBackgroundColor:[UIColor clearColor]];
	CCpanelView.transform=CGAffineTransformRotate(CCpanelView.transform, M_PI/2);
	[CCpanelView setFrame:CGRectMake(0,60, 120, 400)];
	
	
	CCpanelView.hidden=TRUE;
	[whiteClock.clockButton setUserInteractionEnabled:FALSE];
	aBrightnesAdjustmentView=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	aBrightnesAdjustmentView.backgroundColor=[UIColor blackColor];
	aBrightnesAdjustmentView.alpha=0;
	//aBrightnesAdjustmentView.exclusiveTouch=NO;
	aBrightnesAdjustmentView.userInteractionEnabled=NO;
	[self.view addSubview:aBrightnesAdjustmentView];
	SoundIsON=TRUE;
	

}
- (IBAction)increasePowerSave:(id)sender {
	if(aBrightnesAdjustmentView.alpha<0.9)
		aBrightnesAdjustmentView.alpha+=0.1;
	[self stdButtonAnimation:sender];
}
//////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)decreasePowerSave:(id)sender {
	if(aBrightnesAdjustmentView.alpha>0);
	aBrightnesAdjustmentView.alpha-=0.1;
	[self stdButtonAnimation:sender];
}
//////////////////////////////////////////////////////////////////////////////////////////////////
-(void)itsOver {
	UIAlertView* anAlertView=[[UIAlertView alloc] init];
	if(whiteClock.counter>3) 
		[anAlertView setTitle:NSLocalizedString(@"Black Won ! \n In order to continue readjust timers and hit either resume or touch active pad",@"blackWon message")];
	[anAlertView setTitle:NSLocalizedString(@"White Won ! \n In order to continue readjust timers and hit either resume or touch active pad",@"whiteWon message")];
	[anAlertView addButtonWithTitle:NSLocalizedString(@"OK",@"OK message")];
	[anAlertView show];
}
//////////////////////////////////////////////////////////////////////////////////////////////////
- (void)whiteClockButtonTouched {
	[whiteClock stopCountDown:whiteClock];
	[blackClock startCountDown:whiteClock];
	[UIView beginAnimations:@"white fades out black fades in" context:nil]; 
	whiteClock.alpha=0.6;
	blackClock.alpha=1;
	[UIView commitAnimations];
	
	[whiteClock.clockButton setUserInteractionEnabled:FALSE];
	[blackClock.clockButton setUserInteractionEnabled:TRUE];
}
//////////////////////////////////////////////////////////////////////////////////////////////////
- (void)blackClockButtonTouched {
	[whiteClock startCountDown:whiteClock];
	[blackClock stopCountDown:blackClock];
	[UIView beginAnimations:@"black fades out white fades in" context:nil]; 
	whiteClock.alpha=1;
	blackClock.alpha=0.6;
	[UIView commitAnimations];
	[whiteClock.clockButton setUserInteractionEnabled:TRUE];
	[blackClock.clockButton setUserInteractionEnabled:FALSE];
}
//////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)modeButtonTouched:(id)sender {
	[whiteClock switchClockMode];
	[blackClock switchClockMode];
	[self stdButtonAnimation:sender];
}
//////////////////////////////////////////////////////////////////////////////////////////////////
-(void)moveControlPanel {
	[self stdButtonAnimation:panelButton];
	BOOL temp=CCpanelView.hidden;
	if(temp) {
		CCpanelView.alpha=0;
		CCpanelView.hidden=FALSE;
		[UIView beginAnimations:@"panel appears" context:nil]; 
		CCpanelView.alpha=1;
		whiteClock.transform=CGAffineTransformTranslate(whiteClock.transform, 0, -60);
		blackClock.transform=CGAffineTransformTranslate(blackClock.transform, 0, -60);
		[UIView commitAnimations];
	
	}
	if(!temp) {
		[UIView beginAnimations:@"panel dissappears" context:nil]; 
		CCpanelView.alpha=0;
		whiteClock.transform=CGAffineTransformTranslate(whiteClock.transform, 0, 60);
		blackClock.transform=CGAffineTransformTranslate(blackClock.transform, 0, 60);
		[UIView commitAnimations];
		CCpanelView.hidden=TRUE;
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)increaseDelay:(id)sender { [whiteClock increaseDelayByOneSecond];[blackClock increaseDelayByOneSecond];
[CCpanelView.delayLabel setText:[NSString stringWithFormat:@"%i",whiteClock.delay]];[self stdButtonAnimation:sender]; }
- (IBAction)decreaseDelay:(id)sender { [whiteClock decreaseDelayByOneSecond];[blackClock decreaseDelayByOneSecond];
[CCpanelView.delayLabel setText:[NSString stringWithFormat:@"%i",whiteClock.delay]]; [self stdButtonAnimation:sender];}
- (IBAction)incWhiteHr:(id)sender		{[whiteClock increaseHourByOne:self];[self stdButtonAnimation:sender];}
- (IBAction)decWhiteHr:(id)sender		{[whiteClock decreaseHourByOne:self];[self stdButtonAnimation:sender];}
- (IBAction)incWhiteMin:(id)sender		{[whiteClock increaseMinutesByOne:self];[self stdButtonAnimation:sender];}
- (IBAction)decWhiteMin:(id)sender		{[whiteClock decreaseMinutesByOne:self];[self stdButtonAnimation:sender];}
- (IBAction)incWhiteSec:(id)sender		{[whiteClock increaseSecondsByOne:self];[self stdButtonAnimation:sender];}
- (IBAction)decWhiteSec:(id)sender		{[whiteClock decreaseSecondsByOne:self];[self stdButtonAnimation:sender];}
- (IBAction)incBlackHr:(id)sender		{[blackClock increaseHourByOne:self];[self stdButtonAnimation:sender];}
- (IBAction)decBlackHr:(id)sender		{[blackClock decreaseHourByOne:self];[self stdButtonAnimation:sender];}
- (IBAction)incBlackMin:(id)sender		{[blackClock increaseMinutesByOne:self];[self stdButtonAnimation:sender];}
- (IBAction)decBlackMin:(id)sender		{[blackClock decreaseMinutesByOne:self];[self stdButtonAnimation:sender];}
- (IBAction)incBlackSec:(id)sender		{[blackClock increaseSecondsByOne:self];[self stdButtonAnimation:sender];}
- (IBAction)decBlackSec:(id)sender		{[blackClock decreaseSecondsByOne:self];[self stdButtonAnimation:sender];}
- (IBAction)setOneMinGame:(id)sender	{[blackClock setClockToHours:0 Minutes:1 Seconds:0];[whiteClock setClockToHours:0 Minutes:1 Seconds:0];[self stdButtonAnimation:sender];}
- (IBAction)setFiveMinGame:(id)sender	{[blackClock setClockToHours:0 Minutes:5 Seconds:0];[whiteClock setClockToHours:0 Minutes:5 Seconds:0];[self stdButtonAnimation:sender];}
- (IBAction)setFifteenMinGame:(id)sender{[blackClock setClockToHours:0 Minutes:15 Seconds:0];[whiteClock setClockToHours:0 Minutes:15 Seconds:0];[self stdButtonAnimation:sender];}
- (IBAction)setAnHourGame:(id)sender	{[blackClock setClockToHours:1 Minutes:0 Seconds:0];[whiteClock setClockToHours:1 Minutes:0 Seconds:0];[self stdButtonAnimation:sender];}
- (IBAction)showAboutView:(id)sender	{[self.view addSubview:aboutView]; [self stdButtonAnimation:sender];}
- (IBAction)closeAboutView:(id)sender	{[aboutView removeFromSuperview]; [self stdButtonAnimation:sender];}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)setSoundOnOff:(id)sender	 { 
	BOOL temp=SoundIsON; 
	if(temp) { [whiteClock disableSound]; [blackClock disableSound]; SoundIsON=!temp; }
	if(!temp){ [whiteClock enableSound]; [blackClock enableSound]; SoundIsON=!temp; }
	[self stdButtonAnimation:sender];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)pauseResumeClocks:(id)sender		{
	[self stdButtonAnimation:sender];
	if(![whiteClock isClockWorking:self] && ![blackClock isClockWorking:self] ) {
		if(blackClock.alpha==1 && whiteClock.alpha==1) {
			[self blackClockButtonTouched]; return;
		}
		if(whiteClock.alpha==1) [whiteClock startCountDown:self];
		if(blackClock.alpha==1) [blackClock startCountDown:self];
	}
	else {
		[whiteClock stopCountDown:sender];
		[blackClock stopCountDown:sender];
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)stdButtonAnimation:(UIView*)aView {
	
	CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	theAnimation.fromValue=[NSNumber numberWithFloat:1];
	theAnimation.toValue = [NSNumber numberWithFloat:0];
	theAnimation.duration=0.4;
	[aView.layer addAnimation:theAnimation forKey:nil];
	
	[UIView beginAnimations:@"std button scale forward animation" context:nil];
	aView.transform=CGAffineTransformScale(aView.transform, 2, 2);
	[UIView commitAnimations];
	[aView.layer addAnimation:theAnimation forKey:nil];
	
	[UIView beginAnimations:@"std button scale reversed animation" context:nil];
	aView.transform=CGAffineTransformScale(aView.transform, 0.5, 0.5);
	[UIView commitAnimations];
	
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}
//////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}
//////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	[whiteClock dealloc];
	[super dealloc];
	
}

//////////////////////////////////////////////////////////////////////////////////////////////////
//OBSELETE AT THE MOMENT 
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */
/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */
@end
