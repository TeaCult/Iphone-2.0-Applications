//
//  HomeScreenViewController.m
//  Sudoku-Rearranged
//
//  Created by Gediz GÜRSU on 1/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HomeScreenViewController.h"


@implementation HomeScreenViewController

@synthesize gameViewController;

@synthesize creditsView;
@synthesize difficultyView;
@synthesize howtoView;
@synthesize checkUserAnswerView;
@synthesize showSolutionView;
@synthesize clearGameView;
@synthesize areYouSureViewForCheck;
@synthesize areYouSureViewForSolution;
@synthesize yourAnswerIsWrongView;
@synthesize yourAnswerIsCorrectView;

@synthesize homeViewSounds;

@synthesize difficultySlider;




////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)newGame:(id)sender {
	[self.view addSubview:difficultyView];
	[self.view bringSubviewToFront:difficultyView];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)startGame:(id)sender {
	[gameViewController startANewGame:sliderBuffer];
	[self.view bringSubviewToFront:gameViewController.gameViewCV];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)closeDifficultyView:(id)sender {
	[difficultyView removeFromSuperview];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)clearGame:(id)sender {
	[self.view bringSubviewToFront:gameViewController.gameViewCV];
	[gameViewController setQuestionToGrid];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)checkAnswer:(id)sender {
	[self.view bringSubviewToFront:gameViewController.gameViewCV];
	[self.view addSubview:areYouSureViewForCheck];
	[self.view bringSubviewToFront:areYouSureViewForCheck];
	
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)showSolution:(id)sender {
	[self.view bringSubviewToFront:gameViewController.gameViewCV];
	[self.view addSubview:areYouSureViewForSolution];
	[self.view bringSubviewToFront:areYouSureViewForSolution];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)howtoPlay:(id)sender {
	[self.view addSubview:howtoView];
	[self.view bringSubviewToFront:howtoView];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)credits:(id)sender {
	[self.view addSubview:creditsView];
	[self.view bringSubviewToFront:creditsView];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)goToGameView:(id)sender {
	[self.view bringSubviewToFront:gameViewController.gameViewCV];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)goToTheMainMenu:(id)sender{
	[self.view sendSubviewToBack:gameViewController.gameViewCV];
	[areYouSureViewForCheck removeFromSuperview];
	[areYouSureViewForSolution removeFromSuperview];
	[yourAnswerIsWrongView removeFromSuperview];
	[yourAnswerIsCorrectView removeFromSuperview];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)closeCreditsView:(id)sender {
	[creditsView removeFromSuperview];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)closeHowToView:(id)sender {
	[howtoView removeFromSuperview];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)setDifficulty:(id)sender {
	sliderBuffer=(NSInteger)[difficultySlider value];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)checkAnswerAfterConfirmation:(id)sender {
	if(![gameViewController checkUserAnswer])
		[self.view addSubview:yourAnswerIsWrongView];
	if([gameViewController checkUserAnswer])
		[self.view addSubview:yourAnswerIsCorrectView];
		
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)showSolutionAfterConfirmation:(id)sender {
	[gameViewController showSolution];
	[areYouSureViewForSolution removeFromSuperview];
}




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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
// View hierarchy override by GG
- (void)viewDidLoad {
	[super viewDidLoad];
	//if(self.view!=gameViewController.gameViewCV)
	[self.view addSubview:gameViewController.gameViewCV];
	[self.view sendSubviewToBack:gameViewController.gameViewCV];
	[homeViewSounds prepareSoundFiles];
	[homeViewSounds prepareMusicFiles];
	[homeViewSounds playAudio];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    
	[gameViewController release];
	[creditsView release];
	[difficultyView release];
	[howtoView release];
	[checkUserAnswerView release];
	[showSolutionView release];
	[clearGameView release];
	[areYouSureViewForCheck release];
	[areYouSureViewForSolution release];
	[yourAnswerIsCorrectView release];
	[yourAnswerIsWrongView release];
	[homeViewSounds release];
	[difficultySlider release];

	[super dealloc];
	
}


@end
