//
//  GameViewController.m
//  Sudoku-Rearranged
//
//  Created by Gediz GÜRSU on 1/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "GameTableElementsAndView.h"


@implementation GameViewController

@synthesize gameViewCV;
@synthesize numberPicker;
@synthesize numberPickerIndicatorButton;
@synthesize currentSelection;
@synthesize gameTableView;


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


/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view addSubview:self.gameViewCV];
	[self.view bringSubviewToFront:self.gameViewCV];
}
 */


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)setQuestionToGrid {
	int i;
		
	for(i=0;i<81;i++) {
			int val=[gameEngine sudokuQuestionArray:i];
			NSString *valString=[NSString stringWithFormat:@"%d",val];
			id curObj=[[gameTableView tableElements] objectAtIndex:i];
			[(UIButton *)curObj setTitle:valString forState:UIControlStateNormal];
				if (!val) {
					[(UIButton *)curObj setUserInteractionEnabled:TRUE];
					[(UIButton *)curObj setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
					[(UIButton *)curObj setTitle:@"" forState:UIControlStateNormal];
				}
		}
	[gameTableView redraw];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)showUsersGame {
	int i=0;
	for(i=0;i<81;i++) {
		int val=[gameEngine sudokuUserArray:i];
		NSString *valString=[NSString stringWithFormat:@"%d",val];
		id curObj=[[gameTableView tableElements] objectAtIndex:i];
		[(UIButton *)curObj setTitle:valString forState:UIControlStateNormal];
		if ( (!val) || (val==10)) 
			[(UIButton *)curObj setTitle:@"" forState:UIControlStateNormal];
		
		if ([gameEngine sudokuQuestionArray:i]==0) {
			[curObj setUserInteractionEnabled:TRUE];
			[(UIButton *)curObj setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
		}
		
	}
	[gameTableView redraw];
}
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)showSolution {
	int i=0;
		for(i=0;i<81;i++) {
			int val=[gameEngine sudokuAnswerArray:i];
			NSString *valString=[NSString stringWithFormat:@"%d",val];
			id curObj=[[gameTableView tableElements] objectAtIndex:i];
			[(UIButton *)curObj setTitle:valString forState:UIControlStateNormal];
			[(UIButton *)curObj setUserInteractionEnabled:FALSE];
			[(UIButton *)curObj setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
			
				if(val==10)
					[(UIButton *)curObj setTitle:@"" forState:UIControlStateNormal];
		}
	[gameTableView redraw];

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)startANewGame:(NSInteger)difficultyLevel {
	if(gameEngine!=nil)
		[gameEngine release];
	if(gameTableView!=nil)
		[gameTableView release];

	gameEngine=[[SudokuGenerator alloc] init];
	[gameEngine setDifficulty:difficultyLevel];
	[gameEngine generateTable];
	gameTableView=[[GameTableElementsAndView alloc] init];
	[gameTableView createGameTable];
		for(UIButton *ptr in gameTableView.tableElements)
			[ptr addTarget:self action:@selector(userTouchesToButton:) forControlEvents:UIControlEventTouchUpInside];
	[gameViewCV addSubview:gameTableView.gameTable];
	
	[self setQuestionToGrid];

}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)pickNumber:(id)sender {
	 selectedNumberPickerCellIndex=[numberPicker selectedSegmentIndex];
	[currentSelection setText:[NSString stringWithFormat:@"Seçili:%i",selectedNumberPickerCellIndex+1]];
	CGPoint IndicatorXchangedPoint=CGPointMake (selectedNumberPickerCellIndex*29+30,395);
	[numberPickerIndicatorButton setCenter:IndicatorXchangedPoint];
	[numberPickerIndicatorButton setHighlighted:YES];
	[numberPickerIndicatorButton setHighlighted:NO];
	if(selectedNumberPickerCellIndex==9)
	[currentSelection setText:@"Seçili:Sil"];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(IBAction)userTouchesToButton:(id)sender {
	NSInteger val=selectedNumberPickerCellIndex+1;
	NSInteger index=[sender tag];

	[gameEngine setSudokuUserArray:index :val];
		if(val!=10) {
	[(UIButton *)sender setTitle:[NSString stringWithFormat:@"%i",val] forState:UIControlStateNormal];
	}

	if(val==10) {
	[(UIButton *)sender setTitle:@"" forState:UIControlStateNormal];
	[gameEngine  setSudokuUserArray:index :0];
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(BOOL)checkUserAnswer {
	if([gameEngine checkAnswerValidity])
	return TRUE;
	return FALSE;

}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	[gameViewCV release];
	[GameViewController release];
    [super dealloc];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@end
