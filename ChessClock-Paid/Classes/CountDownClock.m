//
//  CountDownClock.m
//  CClockProject-SharperCoding
//
//  Created by Gediz GÜRSU on 7/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CountDownClock.h"
#import <QuartzCore/QuartzCore.h>


@interface CountDownClock (PrivateMethods)
-(void)updateClock;
-(void)updateString;
-(void)updateCounter;
-(void)updateAnalogClockAnimation;
-(NSString *)formatTimeString:(NSUInteger)cnt:(NSString *)str;
-(void)convertToAnalogClock;
-(void)convertToDigitalClock;
-(void)convertTo:(ClockMode)mode;
-(void)sendButtonClickedNotification;
-(void)audioInit;
-(void)updateSound;
@end

@interface CountDownClock (visualElements)
-(void)animateStringUpdate;

@end



@implementation CountDownClock
@synthesize clockButton,digitalClockColor,delay,counter,hr,min,sec;

///////////////////////////////////////////////////////////////////////////////////////////////
/////................PUBLIC//INTERFACE METHODS.............//////
///////////////////////////////////////////////////////////////////////////////////////////////
-(id)initWithFrame:(CGRect)frame ViewBackgroundImageName:(NSString *)vbin
AnalogBackgroundImageName:(NSString*)abin
AnalogBaseImageName:(NSString*)basein
	   HrImageName:(NSString*)hrin 
	  MinImageName:(NSString*)minin 
	  SecImageName:(NSString*)secin
DigitalBackgroundImageName:(NSString*)dbin
UserInterractionEnabled:(BOOL)usrAct{
	
	if(self=[super initWithFrame:frame]) {
	
		
		/// CHECK AND INIT PARAMETERS ///
		if (vbin)
			viewBackgroundImageName=[[NSString alloc] initWithString:vbin];
		if (abin)
			analogBackgroundImageName=[[NSString alloc] initWithString:abin];
		if (basein)
			analogBaseImageName=[[NSString alloc] initWithString:basein];
		if (hrin)
			hrImageName=[[NSString alloc] initWithString:hrin];
		if (minin)
			minImageName=[[NSString alloc] initWithString:minin];
		if (secin)
			secImageName=[[NSString alloc] initWithString:secin];
		if (dbin)
			digitalBackgroundImageName=[[NSString alloc] initWithString:dbin];
		
		digitalClockColor=[UIColor grayColor];
		
		/// INIT BACKGROUND and its IMAGE ///
		CGRect subFrame=CGRectMake(0,0,frame.size.width,frame.size.height);
		backgroundImage=[[UIImageView alloc] initWithFrame:subFrame];
		[backgroundImage setImage:[UIImage imageNamed:viewBackgroundImageName]];
		[self addSubview:backgroundImage];
		[self setBackgroundColor:[UIColor clearColor]];
		
		/// INIT CLOCK BUTTON ///
		clockButton=[UIButton buttonWithType:UIButtonTypeCustom];
		[clockButton setFrame:subFrame];
		[clockButton setBackgroundColor:[UIColor clearColor]];
		[clockButton setBackgroundImage:[UIImage imageNamed:digitalBackgroundImageName] forState:UIControlStateNormal];
		[self setClockToHours:0 Minutes:10 Seconds:0];
		[self updateClock];
		[self addSubview:clockButton];
		clockButton.titleLabel.font=[UIFont systemFontOfSize:frame.size.width/4];
		[clockButton setTitleColor:digitalClockColor forState:UIControlStateNormal]; 
		[clockButton addTarget:self action:@selector(sendButtonClickedNotification) forControlEvents:UIControlEventTouchUpInside];
		
		/// INIT VARIABLES ///
		[self setUserInteractionEnabled:usrAct];
		clockType=ClockModeDigital;
		delay=0;
		
		///AUDIO INIT///
		[self audioInit];
		[self enableSound];
		
		[self updateClock];
		
		return self;
    }
    return nil;
}
///////////////////////////////////////////////////////////////////////////////////////////////	
-(int)setClockToHours:(NSUInteger)hrs Minutes:(NSUInteger)mins Seconds:(NSUInteger)secs {
	hr=hrs;
	min=mins;
	sec=secs;
	counter=(hr*3600+min*60+sec)*10;
	[self updateClock];
	return 0;
}
///////////////////////////////////////////////////////////////////////////////////////////////			
-(int)startCountDown:(id)sender {
	clockTimer=[NSTimer scheduledTimerWithTimeInterval:0.1
												target:self 
											  selector:@selector(updateClock) 
											  userInfo:nil repeats:YES];
	counter+=delay*10;
	return 0;	
}
///////////////////////////////////////////////////////////////////////////////////////////////	
-(int)stopCountDown:(id)sender {
	if ([clockTimer isValid]) {
		[clockTimer invalidate];
		clockTimer=Nil;
		return 0;
	}
	return 1;
}
///////////////////////////////////////////////////////////////////////////////////////////////
-(int)increaseHourByOne:(id)sender		{ if(counter<ULONG_MAX) counter+=36000; counter-=counter%10; [self updateClock]; return 0; }
-(int)increaseMinutesByOne:(id)sender	{ if(counter<ULONG_MAX) counter+=600;  counter-=counter%10; [self updateClock]; return 0; }
-(int)increaseSecondsByOne:(id)sender	{ if(counter<ULONG_MAX) counter+=10;  counter-=counter%10; [self updateClock];return 0; }
-(int)decreaseHourByOne:(id)sender		{ if(counter>36000) { counter-=36000;  counter-=counter%10; [self updateClock]; return 0; } return 1; }
-(int)decreaseMinutesByOne:(id)sender	{ if(counter>600) { counter-=600;  counter-=counter%10; [self updateClock]; return 0; } return 1; }
-(int)decreaseSecondsByOne:(id)sender	{ if(counter>10) { counter-=10;  counter-=counter%10; [self updateClock]; return 0; } return 1; }
-(void)increaseDelayByOneSecond			{ if(delay!=UINT_MAX) delay++; }
-(void)decreaseDelayByOneSecond			{ if(delay>0) delay--; }
///////////////////////////////////////////////////////////////////////////////////////////////
-(void)setClockType:(ClockMode)mode {
	clockType=mode;
	[self convertTo:ClockModeAnalog];
	[self convertTo:clockType];
	
}
///////////////////////////////////////////////////////////////////////////////////////////////
-(void)switchClockMode {
	clockType=!clockType;
	[self convertTo:clockType];
	
}
///////////////////////////////////////////////////////////////////////////////////////////////
-(void)setNotificationStringWhenButtonPressed:(NSString*)notstr {
	buttonClickedNotificationString=[[NSString alloc] initWithString:notstr];
}
///////////////////////////////////////////////////////////////////////////////////////////////
-(void)sendButtonClickedNotification {
	[[NSNotificationCenter defaultCenter] postNotificationName:buttonClickedNotificationString object:self];
}
///////////////////////////////////////////////////////////////////////////////////////////////
-(void)enableSound {
	soundEnabled=TRUE;
}
///////////////////////////////////////////////////////////////////////////////////////////////
-(void)disableSound {
	soundEnabled=FALSE;
}
///////////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////
			/////................PRIVATE METHODS.............//////
///////////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////
-(void)audioInit {
	// Get the main bundle for the app
	CFBundleRef mainBundle;
	mainBundle = CFBundleGetMainBundle ();
	
	// Get the URL to the sound file to play
	soundFileURLRef  =	CFBundleCopyResourceURL (
												 mainBundle,
												 CFSTR ("tap"),
												 CFSTR ("aif"),
												 NULL
												 );
	
	// Create a system sound object representing the sound file
	AudioServicesCreateSystemSoundID (
									  soundFileURLRef,
									  &soundFileObject
									  );
	
}	
///////////////////////////////////////////////////////////////////////////////////////////////
-(void)updateClock {
	[self updateCounter];
	if(clockType==ClockModeDigital)
		[self updateString];
	if(clockType==ClockModeAnalog)
		[self updateAnalogClockAnimation];
	[self updateSound];
}
///////////////////////////////////////////////////////////////////////////////////////////////	
-(void)updateCounter { 
	if (counter>=2) {
		if ([self isClockWorking:self])	counter--;
		
		int totalSecs=counter/10;
		sec=totalSecs%60;
		min=(totalSecs/60)%60;
		hr=(totalSecs/3600)%24;
	}
	else {
		[self stopCountDown:self];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"Countdown is over!" object:self];
	}
	
}
///////////////////////////////////////////////////////////////////////////////////////////////		
-(void)updateSound {
	if(counter%10==0 && soundEnabled)
		AudioServicesPlaySystemSound(soundFileObject);
}
///////////////////////////////////////////////////////////////////////////////////////////////
-(void)updateString {	
	[clockButton setTitle:[self formatTimeString:counter :clockString] forState:UIControlStateNormal];
	
}
///////////////////////////////////////////////////////////////////////////////////////////////
-(void)updateAnalogClockAnimation {
	CGFloat hrRot,minRot,secRot;
	hrRot=2*M_PI*(1-(float)(12-hr)/12);
	minRot=2*M_PI*((float)(60-min)/60);
	secRot=2*M_PI*(1-(float)sec/60);
	CGAffineTransform T1,T2,T3;
	T1=CGAffineTransformMakeRotation(hrRot);
	T2=CGAffineTransformMakeRotation(minRot);
	T3=CGAffineTransformMakeRotation(secRot);
	[hrView.layer setAffineTransform:T1];
	[minView.layer setAffineTransform:T2];
	[secView.layer setAffineTransform:T3];
	[self setNeedsDisplay];
}
///////////////////////////////////////////////////////////////////////////////////////////////		
-(NSString *)formatTimeString:(NSUInteger)cnt:(NSString *)str { 
	int secx=sec;
	int minx=min;
	int hrx=hr;
	
	NSMutableString* hrStr=[NSString stringWithFormat:@"%i",hrx];
	if(hrx<10)
		hrStr=[NSString stringWithFormat:@"0%i",hrx];
	
	NSMutableString* minStr=[NSString stringWithFormat:@"%i",minx];
	if(minx<10)
		minStr=[NSString stringWithFormat:@"0%i",minx];
	
	NSMutableString* secStr=[NSString stringWithFormat:@"%i",secx];
	if(secx<10)
		secStr=[NSString stringWithFormat:@"0%i",secx];
	
	str=[NSString stringWithFormat:@"%@:%@:%@:%i",hrStr,minStr,secStr,cnt%10];
	clockButton.titleLabel.font=[UIFont systemFontOfSize:self.frame.size.width/5];
	
	if(!hrx) {
		str=[NSString stringWithFormat:@"%@:%@:%i",minStr,secStr,cnt%10];
		clockButton.titleLabel.font=[UIFont systemFontOfSize:self.frame.size.width/4];
	}
	
	if(!hrx && !minx) {
		str=[NSString stringWithFormat:@"%@:%i",secStr,cnt%10];
		clockButton.titleLabel.font=[UIFont systemFontOfSize:self.frame.size.width/3];
	}
	[clockButton setTitleColor:digitalClockColor forState:UIControlStateNormal];
	
	
	
	return str;
}
///////////////////////////////////////////////////////////////////////////////////////////////
-(void)convertToAnalogClock {
	
	[self stopCountDown:nil];
	[clockButton removeFromSuperview];
	[self setNeedsDisplay];
	
	CGRect subFrame=CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
	
	clockButton=[UIButton buttonWithType:UIButtonTypeCustom];
	[clockButton setFrame:subFrame];
	[clockButton setBackgroundColor:[UIColor clearColor]];
	[clockButton setBackgroundImage:[UIImage imageNamed:analogBackgroundImageName] forState:UIControlStateNormal];

	
	CGFloat myHeight=subFrame.size.height-subFrame.size.height/3;
	CGFloat myWidth=subFrame.size.width -subFrame.size.width/3;
	
	if(myHeight>myWidth)
		myHeight=myWidth;
	if(myWidth>myHeight)
		myWidth=myHeight;
	
	CGFloat shiftHeight=self.frame.size.height/10;
	CGFloat newWidth=(subFrame.size.width-myWidth)/2;
	CGFloat newHeight=(subFrame.size.height-myHeight)/2+shiftHeight;
	
	
	CGRect newSubFrame=CGRectMake(newWidth,newHeight,myWidth,myHeight);
	//override for chess Clock
	subFrame.size.height=subFrame.size.width;
	newSubFrame=subFrame;
	// override finished
	
	[clockButton setBackgroundImage:[UIImage imageNamed:analogBackgroundImageName] forState:UIControlStateNormal];
	baseView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:analogBaseImageName]];
	hrView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:hrImageName]];
	minView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:minImageName]];
	secView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:secImageName]];
	[baseView setFrame:newSubFrame];
	[hrView setFrame:newSubFrame];
	[minView setFrame:newSubFrame];
	[secView setFrame:newSubFrame];
	[clockButton addSubview:baseView];
	[clockButton addSubview:secView];
	[clockButton addSubview:minView];
	[clockButton addSubview:hrView];
	
	//optional
	[backgroundImage setAlpha:0];
	//optional
	
	[self addSubview:clockButton];
	[clockButton addTarget:self action:@selector(sendButtonClickedNotification) forControlEvents:UIControlEventTouchUpInside];
}
///////////////////////////////////////////////////////////////////////////////////////////////
-(void)convertToDigitalClock {
	CGRect subFrame=CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
	[self stopCountDown:nil];
	[clockButton removeFromSuperview];
	[self setNeedsDisplay];
	clockButton=[UIButton buttonWithType:UIButtonTypeCustom];
	[clockButton setBackgroundColor:[UIColor clearColor]];
	[clockButton setFrame:subFrame];
	[clockButton setBackgroundImage:[UIImage imageNamed:digitalBackgroundImageName] forState:UIControlStateNormal];
	[clockButton setTitleColor:digitalClockColor forState:UIControlStateNormal];
	[self updateString];
	[self addSubview:clockButton];
	[backgroundImage setAlpha:1];
	[clockButton addTarget:self action:@selector(sendButtonClickedNotification) forControlEvents:UIControlEventTouchUpInside];
}
///////////////////////////////////////////////////////////////////////////////////////////////
-(void)convertTo:(ClockMode)mode {
	if(mode==ClockModeDigital)
		[self convertToDigitalClock];
	if(mode==ClockModeAnalog)
		[self convertToAnalogClock];
	[self updateClock];
}
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
///////////////////////////////////////////////////////////////////////////////////////////////	



-(BOOL)isClockWorking:(id)sender{
	if ([clockTimer isValid])
		return YES;
	return NO;
}

-(void)dealloc {
	[super dealloc];
}

@end
