//
//  SoundPlayer.m
//  I-Kelime
//
//  Created by Gediz GÜRSU on 2/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SoundPlayer.h"

@implementation SoundPlayer

@synthesize soundFileObject;
@synthesize soundFileURLRef;
@synthesize theAudio;


/////////////////////////////////////////SOUND ACTIONS///////////////////////////////////////////
- (void) prepareSoundFiles {
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

-(void)prepareMusicFiles {
	NSString *path = [[NSBundle mainBundle] pathForResource:@"myGameMP3" ofType:@"mp3"];  
	theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];  
	theAudio.delegate = self;  
}

-(void)dealloc {
	[theAudio release];
	[super dealloc];
}

// Respond to a tap on the System Sound button
- (IBAction) playSystemSound {
	
	AudioServicesPlaySystemSound (self.soundFileObject);
}

// Respond to a tap on the Alert Sound button
- (IBAction) playAlertSound {
	
	AudioServicesPlayAlertSound (self.soundFileObject);
}

-(IBAction)vibrate {
	
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}

- (IBAction)playAudio {
	if (isAudioOn==FALSE) {
		[theAudio play]; 
		isAudioOn=TRUE;
		
	}
	
}
- (IBAction)stopAudio {
	if (isAudioOn==TRUE) {
		[theAudio stop];
		isAudioOn=FALSE;
	}
}
- (IBAction)playOrStopAudio {
	if (isAudioOn==TRUE)
		[theAudio stop];
	if (isAudioOn==FALSE) 
		[theAudio play]; 
	isAudioOn=!isAudioOn;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
	[theAudio play];
}

	

@end