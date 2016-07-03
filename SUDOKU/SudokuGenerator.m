//
//  SudokuGenerator.m
//  Sudoku-Rearranged
//
//  Created by Gediz GÜRSU on 1/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SudokuGenerator.h"
#import <time.h>

@implementation SudokuGenerator

////////////////////////////////////////////////////////////////////////////////
-(id)init {
	[super init];
	return self;
}
/////////////////// GETTERS AND SETTERS for OPAQUE TYPES/////////////////////
-(NSInteger)sudokuUserArray:(NSInteger)atIndex {
	return sudokuUserArray[atIndex];
}
-(NSInteger)sudokuQuestionArray:(NSInteger)atIndex {
	return sudokuQuestionArray[atIndex];
}
-(NSInteger)sudokuAnswerArray:(NSInteger)atIndex {
	return sudokuAnswerArray[atIndex];
}
-(void)setSudokuUserArray:(NSInteger)atIndex:(NSInteger)value {
	sudokuUserArray[atIndex]=value;
}	
-(void)setSudokuQuestionArray:(NSInteger)atIndex:(NSInteger)value {
		sudokuQuestionArray[atIndex]=value;
}
-(void)setSudokuAnswerArray:(NSInteger)atIndex:(NSInteger)value {
	sudokuAnswerArray[atIndex]=value;
}

////////////////////// END OF GETTERS AND SETTERS for OPAQUE TYPES /////////////////////

-(NSInteger) difficulty {
	return difficulty;
}
///////////////////////////////////////////////////////////////////////////////////////
-(void)setDifficulty:(NSInteger)diff{
	difficulty=diff;
}
///////////////////////////////////////////////////////////////////////////////////////
-(void)generateTable {
	[self setRootSquare];
	[self generateAnswer];
	[self generateQuestion];
	[self prepareUserArray];

}
/////////////////////////////////////////////////////////////////////////////
-(void)generateAnswer{
	
	int i;
	srand((unsigned)time(0));
	
	for(i=0;i<SHUFFLE_DEPTH_INT;++i) {
		int index1,index2,index3;
		NSInteger temp[NUMBER_OF_COLUMN_OR_ROW];
		
		index1=rand()%NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN;
		index2=rand()%NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN;
		index3=rand()%NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN;
		memcpy(&temp,&sudokuAnswerArray[index1*NUMBER_OF_COLUMN_OR_ROW+index3*27],NUMBER_OF_COLUMN_OR_ROW*sizeof(sudokuAnswerArray[0]));
		memcpy(&sudokuAnswerArray[index1*NUMBER_OF_COLUMN_OR_ROW+index3*27],&sudokuAnswerArray[index2*NUMBER_OF_COLUMN_OR_ROW+index3*27],NUMBER_OF_COLUMN_OR_ROW*sizeof(sudokuAnswerArray[0]));
		memcpy(&sudokuAnswerArray[index2*NUMBER_OF_COLUMN_OR_ROW+index3*27],&temp, NUMBER_OF_COLUMN_OR_ROW*sizeof(sudokuAnswerArray[0]));
	}
	
	for(i=0;i<SHUFFLE_DEPTH_INT;++i) {
		int k,randNSInteger;
		
		randNSInteger=rand()%NUMBER_OF_COLUMN_OR_ROW+1;
		for(k=0;k<NUMBER_OF_SUDOKU_SUBSQUARES;++k) {
			if(sudokuAnswerArray[k]==randNSInteger)
				sudokuAnswerArray[k]=0;
		}
		for(k=0;k<NUMBER_OF_SUDOKU_SUBSQUARES;++k) {
			if(sudokuAnswerArray[k]==1) 
				sudokuAnswerArray[k]=randNSInteger;
		}
		for(k=0;k<NUMBER_OF_SUDOKU_SUBSQUARES;++k) {
			if(sudokuAnswerArray[k]==0)
				sudokuAnswerArray[k]=1;
		}
		///FOR COLUMNS
		for(i=0;i<SHUFFLE_DEPTH_INT;++i) {
			int k,cub,col1,col2;
			NSInteger temp[NUMBER_OF_COLUMN_OR_ROW];
			col1=rand()%NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN;
			col2=rand()%NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN;
			cub= rand()%NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN;
			
			for(k=0;k<NUMBER_OF_COLUMN_OR_ROW;++k) {
				
				temp[k]=sudokuAnswerArray[col1+cub*NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN+k*NUMBER_OF_COLUMN_OR_ROW];
				sudokuAnswerArray[col1+cub*NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN+k*NUMBER_OF_COLUMN_OR_ROW]=sudokuAnswerArray[col2+cub*NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN+k*NUMBER_OF_COLUMN_OR_ROW];
				sudokuAnswerArray[col2+cub*NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN+k*NUMBER_OF_COLUMN_OR_ROW]=temp[k];
			}	
		}
	}
	
}
///////////////////////////////////////////////////////////////////////////////////////
-(void)generateQuestion {
	int indx,cnt;
	
	cnt=51+(int)difficulty;
	memcpy(sudokuQuestionArray,sudokuAnswerArray,NUMBER_OF_SUDOKU_SUBSQUARES*sizeof(sudokuQuestionArray[0]));
	srand((unsigned)time(0));
	while(cnt--) {
		indx=rand()%NUMBER_OF_SUDOKU_SUBSQUARES;
		if(!sudokuQuestionArray[indx])
			cnt++;
		sudokuQuestionArray[indx]=0;
	
	}
	memcpy(sudokuUserArray,sudokuQuestionArray,NUMBER_OF_SUDOKU_SUBSQUARES*sizeof(sudokuQuestionArray[0]));
}
///////////////////////////////////////////////////////////////////////////////////////
-(void)prepareUserArray {
	memcpy(sudokuUserArray,sudokuQuestionArray,NUMBER_OF_SUDOKU_SUBSQUARES*sizeof(sudokuQuestionArray[0]));
}	
///////////////////////////////////////////////////////////////////////////////////////
-(void)setRootSquare {
	
	NSInteger RootSquare[NUMBER_OF_SUDOKU_SUBSQUARES]= {
		1,2,3,4,5,6,7,8,9,
		4,5,6,7,8,9,1,2,3,
		7,8,9,1,2,3,4,5,6,
		2,3,4,5,6,7,8,9,1,
		5,6,7,8,9,1,2,3,4,
		8,9,1,2,3,4,5,6,7,
		3,4,5,6,7,8,9,1,2,
		6,7,8,9,1,2,3,4,5,
		9,1,2,3,4,5,6,7,8
	};
	memcpy(sudokuAnswerArray,RootSquare,sizeof(RootSquare));
		
}

-(BOOL)checkRows {
	//////// CORRECT FOR MULTIPLE SOLUTIONS //////////
	int i,j,k;
	for(j=0;j<NUMBER_OF_SUDOKU_SUBSQUARES;j+=NUMBER_OF_COLUMN_OR_ROW) {
		for(k=j+1;k<j+NUMBER_OF_COLUMN_OR_ROW;++k) {
			for(i=j;i<k;++i) {
				if(sudokuUserArray[i]==sudokuUserArray[k])
					return FALSE;
			}}}
	return TRUE;
}
/////////////////////////////////////////////////////////////////////////
-(BOOL)checkColumns {
	int i,j,k;
	for(j=0;j<NUMBER_OF_COLUMN_OR_ROW;j++) {
		for(k=j+NUMBER_OF_COLUMN_OR_ROW;k<NUMBER_OF_SUDOKU_SUBSQUARES;k+=NUMBER_OF_COLUMN_OR_ROW) {
			for(i=j;i<k;i+=NUMBER_OF_COLUMN_OR_ROW) {
				if(sudokuUserArray[i]==sudokuUserArray[k])
					return FALSE;
			}}}
	return TRUE;	
}
/////////////////////////////////////////////////////////////////////////////
-(BOOL)checkCubes {	
	int i,j,k;
	NSInteger Cube[NUMBER_OF_SUDOKU_SUBSQUARES];
	//////Convert to Cube//////
	for(j=0;j<NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN;++j) {
		for(i=0;i<NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN;++i) {
			for(k=0;k<NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN;++k)
				memcpy(&Cube[j*27+i*NUMBER_OF_COLUMN_OR_ROW+k*NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN],&sudokuUserArray[j*27+NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN*i+k*NUMBER_OF_COLUMN_OR_ROW], NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN*sizeof(Cube[0]));
		}}
	for(j=0;j<NUMBER_OF_SUDOKU_SUBSQUARES;j+=NUMBER_OF_COLUMN_OR_ROW) {
		for(k=j+1;k<j+NUMBER_OF_COLUMN_OR_ROW;++k) {
			for(i=j;i<k;++i) {
				if(Cube[i]==Cube[k])
					return FALSE;
			}}}
	return TRUE;
}
////////////////////////////////////////////////////////////////////////////
-(BOOL)checkAnswerValidity{
	BOOL colCheck=[self checkColumns];
	BOOL rowCheck=[self checkRows];
	BOOL cubeCheck=[self checkCubes];
	return rowCheck && colCheck && cubeCheck;
}

////////////////////////////////// ACCESSOR OVERRIDES if NEEDED ////////////////////////////////////
-(void)getAnswerArray:(NSInteger *)array {
	memcpy(array,sudokuAnswerArray,NUMBER_OF_SUDOKU_SUBSQUARES*sizeof(sudokuAnswerArray[0]));
}
/////////////////////////////////////////////////////////////////////////////
-(void)getQuestionArray:(NSInteger *)array {
	memcpy(array,sudokuQuestionArray,NUMBER_OF_SUDOKU_SUBSQUARES*sizeof(sudokuQuestionArray[0]));
}
/////////////////////////////////////////////////////////////////////////////
-(void)getUserArray:(NSInteger *)array{
	memcpy(array,sudokuUserArray,NUMBER_OF_SUDOKU_SUBSQUARES*sizeof(sudokuUserArray[0]));
}
/////////////////////////////////////////////////////////////////////////////
-(void)setUserArray:(NSInteger *)array{
	memcpy(sudokuUserArray,array,NUMBER_OF_SUDOKU_SUBSQUARES*sizeof(sudokuUserArray[0]));
}
//////////////////////////////////TO DEBUGGING CONSOLE /////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
-(void)showAnswerArrayPretty {
	int i;
	for(i=0;i<NUMBER_OF_SUDOKU_SUBSQUARES;++i) {
		printf("%d ",sudokuAnswerArray[i]);
		if(!((i+1)%NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN))
			printf("|");
		if(!((i+1)%NUMBER_OF_COLUMN_OR_ROW))
			printf(" \n");
		if(!((i+1)%27))
			printf("-------------------\n");
	}
}
/////////////////////////////////////////////////////////////////////////////
-(void)showQuestionArrayPretty {
	int i;
	for(i=0;i<NUMBER_OF_SUDOKU_SUBSQUARES;++i) {
		printf("%d ",sudokuQuestionArray[i]);
		if(!((i+1)%NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN))
			printf("|");
		if(!((i+1)%NUMBER_OF_COLUMN_OR_ROW))
			printf(" \n");
		if(!((i+1)%27))
			printf("-------------------\n");
	}
}
//////////////////////////////////////////////////////////////////////////////
-(void)showUserArrayPretty {
	int i;
	for(i=0;i<NUMBER_OF_SUDOKU_SUBSQUARES;++i) {
		printf("%d ",sudokuUserArray[i]);
		if(!((i+1)%NUMBER_OF_SUPERSQUARE_ROW_OR_COLUMN))
			printf("|");
		if(!((i+1)%NUMBER_OF_COLUMN_OR_ROW))
			printf(" \n");
		if(!((i+1)%27))
			printf("-------------------\n");
	}
}
@end
