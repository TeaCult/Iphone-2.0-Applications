//
//  SudokuGenerator.h
//  Sudoku-Rearranged
//
//  Created by Gediz GÜRSU on 1/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#define NUMBER_OF_COLUMN_OR_ROW					9
#define NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN 	3
#define NUMBER_OF_SUPERSQUARES					9
#define NUMBER_OF_SUDOKU_SUBSQUARES				81
#define SHUFFLE_DEPTH_INT						10


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>


@interface SudokuGenerator : NSObject {
NSInteger sudokuAnswerArray		[NUMBER_OF_SUDOKU_SUBSQUARES];
NSInteger sudokuQuestionArray	[NUMBER_OF_SUDOKU_SUBSQUARES];
NSInteger sudokuUserArray		[NUMBER_OF_SUDOKU_SUBSQUARES];

NSInteger difficulty;

}



//GETTERS AND SETTERS //
-(NSInteger)sudokuUserArray:(NSInteger)atIndex;
-(NSInteger)sudokuQuestionArray:(NSInteger)atIndex;
-(NSInteger)sudokuAnswerArray:(NSInteger)atIndex;
-(void)setSudokuUserArray:(NSInteger)atIndex:(NSInteger)value;
-(void)setSudokuQuestionArray:(NSInteger)atIndex:(NSInteger)value;
-(void)setSudokuAnswerArray:(NSInteger)atIndex:(NSInteger)value;

-(NSInteger) difficulty;
-(void)setDifficulty:(NSInteger)diff;
-(BOOL)checkAnswerValidity;

@end
