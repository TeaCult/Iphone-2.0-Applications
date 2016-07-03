//
//  GameViewController.h
//  Sudoku-Rearranged
//
//  Created by Gediz GÜRSU on 1/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "buttons.h"
#import "SudokuGenerator.h"

@class GameTableElementsAndView;

@interface GameViewController : UIViewController {

	UIView				*gameViewCV;
	UISegmentedControl	*numberPicker;
	SudokuGenerator		*gameEngine;
	UIButton			*numberPickerIndicatorButton;
	UILabel				*currentSelection;
	
	NSInteger			selectedNumberPickerCellIndex;
	NSInteger			lastTouchedButtonTag;
	NSInteger			lastSelectedNumberPickerCellIndex;
	GameTableElementsAndView		*gameTableView;
	
}

@property (nonatomic,retain) IBOutlet UIView				*gameViewCV;
@property (nonatomic,retain) IBOutlet UISegmentedControl	*numberPicker;
@property (nonatomic,retain) IBOutlet UIButton				*numberPickerIndicatorButton;
@property (nonatomic,retain) IBOutlet UILabel				*currentSelection;
@property (nonatomic,retain) GameTableElementsAndView		*gameTableView;

-(void)startANewGame:(NSInteger)difficultyLevel;
-(void)setQuestionToGrid;
-(void)showSolution;
-(void)showUsersGame;
-(IBAction)pickNumber:(id)sender;
-(IBAction)userTouchesToButton:(id)sender;
-(IBAction)showUsersGame;
-(BOOL)checkUserAnswer;
-(void)generateTable;




@end
