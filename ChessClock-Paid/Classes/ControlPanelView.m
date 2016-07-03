//
//  ControlPanelView.m
//  CClockProject-SharperCoding
//
//  Created by Gediz GÜRSU on 7/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ControlPanelView.h"


@implementation ControlPanelView

@synthesize delayLabel;
//oneMinTypeButton, fiveMinTypeButton, fftMinTypeButton, anHourTypeButton,
//wIncHrB , wIncMinB, wIncSecB, bIncHrB, bIncMinB, bIncSecB, wDecHrB, wDecMinB, wDecSecB, bDecHrB, bDecMinB, bDecSecB,
//increaseDelayButton, decreaseDelayButton, soundONOFFButton;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)dealloc {
    [super dealloc];
}

@end
