//
//  SoundPlayer.h
//  I-Kelime
//
//  Created by Gediz GÜRSU on 2/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <AudioToolbox/AudioToolbox.h>
#include <AVFoundation/AVFoundation.h>

@interface SoundPlayer : NSObject <AVAudioPlayerDelegate> {
	
	CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
	AVAudioPlayer*	theAudio;
	BOOL			isAudioOn;
}
@property (readwrite)			CFURLRef		soundFileURLRef;
@property (readonly)			SystemSoundID	soundFileObject;
@property (nonatomic,retain)	AVAudioPlayer* theAudio;

- (void) prepareSoundFiles;
- (void) prepareMusicFiles;
- (IBAction)playSystemSound;
- (IBAction)playAlertSound;
- (IBAction)vibrate;
- (IBAction)playAudio;
- (IBAction)stopAudio;
- (IBAction)playOrStopAudio;

@end
