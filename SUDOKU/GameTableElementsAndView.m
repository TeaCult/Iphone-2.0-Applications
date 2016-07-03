//
//  GameTableElementsAndView.m
//  SUDOKU1.0
//
//  Created by Gediz GÜRSU on 3/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GameTableElementsAndView.h"

#define SQUARE_SIZE SZ
#define S_Z 32

@implementation GameTableElementsAndView
@synthesize gameTable;
@synthesize tableElements;

- (id)init {
	[super init];
	return self;
} 

-(void)createGameTable {
	if(tableElements==nil)
		tableElements=[[NSMutableArray alloc] initWithCapacity:81];
	CGRect aRect=CGRectMake(15,75,S_Z*9,S_Z*9);
	gameTable=[[UIView alloc] initWithFrame:aRect];
	
		for(int i=0;i<81;++i) {
			CGRect myRect=CGRectMake(i%9*S_Z, i/9*S_Z, S_Z, S_Z);
			UIButton *squareView=[UIButton buttonWithType:UIButtonTypeCustom];
			[squareView setShowsTouchWhenHighlighted:TRUE];
			[squareView setUserInteractionEnabled:FALSE];
			[squareView setFrame:myRect];
			[squareView setTag:i];
			[squareView setFont:[UIFont fontWithName:@"Arial" size:22]];
			[squareView setTitle:@"" forState:UIControlStateNormal];
			[squareView setBackgroundImage:[UIImage imageNamed:@"ImageSudokuSubsquareWithAlpha.png"] forState:UIControlStateNormal];
			[squareView setBackgroundImage:[UIImage imageNamed:@"ImageSudokuSubSquarePressed.png"] forState:UIControlStateHighlighted];
			[squareView setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
			[squareView setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
			[squareView addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
			[tableElements addObject:squareView];
			[gameTable addSubview:squareView];
			[squareView release];
			
		}
}

-(void)redraw {
	[gameTable setNeedsDisplay];
}

-(void)buttonPressed:(id)sender {
	
}
-(void)setValue:(NSUInteger)ofSubSquare{
}

- (void)dealloc {
	[tableElements release];
	[gameTable release];
    [super dealloc];
}


@end
