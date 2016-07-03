//
//  GameTableElementsAndView.h
//  SUDOKU1.0
//
//  Created by Gediz GÜRSU on 3/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GameTableElementsAndView : NSObject {
	NSMutableArray *tableElements;
	UIView		*gameTable;
}
@property (nonatomic,retain) UIView	*gameTable; 
@property (nonatomic,retain) NSMutableArray *tableElements;


-(void)createGameTable;
-(void)buttonPressed:(id)sender;
-(void)redraw;
@end
