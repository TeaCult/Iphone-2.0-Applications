//
//  HomeScreenViewController.h
//  Sudoku-Rearranged
//
//  Created by Gediz GÜRSU on 1/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"
#import "SoundPlayer.h"


@interface HomeScreenViewController : UIViewController {
	
	GameViewController	*gameViewController;
	
	UIView				*creditsView;
	UIView				*difficultyView;
	UIView				*howtoView;
	UIView				*checkUserAnswerView;
	UIView				*showSolutionView;
	
	UIView				*clearGameView;
	UIView				*areYouSureViewForCheck;
	UIView				*areYouSureViewForSolution;
	UIView				*yourAnswerIsCorrectView;
	UIView				*yourAnswerIsWrongView;
	
	SoundPlayer			*homeViewSounds;
	
	UISlider			*difficultySlider;
	NSInteger			 sliderBuffer;
	BOOL				 IAmSure;

	
}
@property (nonatomic, retain) IBOutlet GameViewController	*gameViewController;


@property (nonatomic, retain) IBOutlet UIView				*creditsView;
@property (nonatomic, retain) IBOutlet UIView				*difficultyView;
@property (nonatomic, retain) IBOutlet UIView				*howtoView;
@property (nonatomic, retain) IBOutlet UIView				*checkUserAnswerView;
@property (nonatomic, retain) IBOutlet UIView				*showSolutionView;
@property (nonatomic, retain) IBOutlet UIView				*clearGameView;
@property (nonatomic, retain) IBOutlet UIView				*areYouSureViewForCheck;
@property (nonatomic, retain) IBOutlet UIView				*areYouSureViewForSolution;
@property (nonatomic, retain) IBOutlet UIView				*yourAnswerIsCorrectView;
@property (nonatomic, retain) IBOutlet UIView				*yourAnswerIsWrongView;

@property (nonatomic, retain) IBOutlet SoundPlayer			*homeViewSounds;

@property (nonatomic, retain) IBOutlet UISlider				*difficultySlider;


-(IBAction)newGame:(id)sender;
-(IBAction)startGame:(id)sender;
-(IBAction)clearGame:(id)sender;
-(IBAction)checkAnswer:(id)sender;
-(IBAction)showSolution:(id)sender;
-(IBAction)howtoPlay:(id)sender;
-(IBAction)credits:(id)sender;
-(IBAction)goToGameView:(id)sender;
-(IBAction)goToTheMainMenu:(id)sender;
-(IBAction)closeCreditsView:(id)sender;
-(IBAction)closeHowToView:(id)sender;
-(IBAction)closeDifficultyView:(id)sender;
-(IBAction)setDifficulty:(id)sender;
-(IBAction)checkAnswerAfterConfirmation:(id)sender;
-(IBAction)showSolutionAfterConfirmation:(id)sender;

@end
