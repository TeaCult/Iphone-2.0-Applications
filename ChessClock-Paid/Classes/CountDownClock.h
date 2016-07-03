//
//  CountDownClock.h
//  CClockProject-SharperCoding
//
//  Created by Gediz GÜRSU on 7/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>

typedef enum _ClockMode {
	ClockModeDigital=0,
	ClockModeAnalog =1,
} ClockMode ;

@interface CountDownClock : UIView {
	UIButton *clockButton;
	UIColor *digitalClockColor;
	NSUInteger delay;
	NSUInteger counter,hr,min,sec;
@private
	NSString *hrImageName,*minImageName,*secImageName,*analogBackgroundImageName,*digitalBackgroundImageName,*analogBaseImageName,*viewBackgroundImageName,
	*buttonClickedNotificationString;
	NSString *clockString;
	NSTimer  *clockTimer;
	UIImageView *hrView,*minView,*secView,*baseView;
	UIImageView *backgroundImage;
	
	CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
	BOOL soundEnabled;
	ClockMode clockType;
}

@property (nonatomic,retain)UIButton *clockButton;
@property (nonatomic,retain)UIColor *digitalClockColor;
@property NSUInteger delay,counter,hr,min,sec;

-(int)setClockToHours:(NSUInteger)hrs Minutes:(NSUInteger)mins Seconds:(NSUInteger)secs;
-(int)startCountDown:(id)sender;
-(int)stopCountDown:(id)sender;
-(int)increaseHourByOne:(id)sender;
-(int)increaseMinutesByOne:(id)sender;
-(int)increaseSecondsByOne:(id)sender;
-(int)decreaseHourByOne:(id)sender;
-(int)decreaseMinutesByOne:(id)sender;
-(int)decreaseSecondsByOne:(id)sender;
-(void)increaseDelayByOneSecond;	
-(void)decreaseDelayByOneSecond;	
-(BOOL)isClockWorking:(id)sender;
-(void)setClockType:(ClockMode)mode;
-(void)switchClockMode;
-(void)setNotificationStringWhenButtonPressed:(NSString*)notstr;
-(void)setDigitalClockColor:(UIColor*)aColor;
-(void)enableSound;
-(void)disableSound;

-(void)dealloc;
-(id) initWithFrame:(CGRect)frame ViewBackgroundImageName:(NSString *)vbin
	AnalogBackgroundImageName:(NSString*)abin
	AnalogBaseImageName:(NSString*)basein
	HrImageName:(NSString*)hrin 
	MinImageName:(NSString*)minin 
	SecImageName:(NSString*)secin
	DigitalBackgroundImageName:(NSString*)dbin
	UserInterractionEnabled:(BOOL)usrAct;
@end
