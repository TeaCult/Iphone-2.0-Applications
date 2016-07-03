		
		#define ResetElements 		ResetElementNo(1);\
		ResetElementNo(2);\
		ResetElementNo(3);\
		ResetElementNo(4);\
		ResetElementNo(5);\
		ResetElementNo(6);\
		ResetElementNo(7);\
		ResetElementNo(8);\
		ResetElementNo(9);\
		ResetElementNo(10);\
		ResetElementNo(11);\
		ResetElementNo(12);\
		ResetElementNo(13);\
		ResetElementNo(14);\
		ResetElementNo(15);\
		ResetElementNo(16);\
		ResetElementNo(17);\
		ResetElementNo(18);\
		ResetElementNo(19);\
		ResetElementNo(20);\
		ResetElementNo(21);\
		ResetElementNo(22);\
		ResetElementNo(23);\
		ResetElementNo(24);\
		ResetElementNo(25);\
		ResetElementNo(26);\
		ResetElementNo(27);\
		ResetElementNo(28);\
		ResetElementNo(29);\
		ResetElementNo(30);\
		ResetElementNo(31);\
		ResetElementNo(32);\
		ResetElementNo(33);\
		ResetElementNo(34);\
		ResetElementNo(35);\
		ResetElementNo(36);\
		ResetElementNo(37);\
		ResetElementNo(38);\
		ResetElementNo(39);\
		ResetElementNo(40);\
		ResetElementNo(41);\
		ResetElementNo(42);\
		ResetElementNo(43);\
		ResetElementNo(44);\
		ResetElementNo(45);\
		ResetElementNo(46);\
		ResetElementNo(47);\
		ResetElementNo(48);\
		ResetElementNo(49);\
		ResetElementNo(50);\
		ResetElementNo(51);\
		ResetElementNo(52);\
		ResetElementNo(53);\
		ResetElementNo(54);\
		ResetElementNo(55);\
		ResetElementNo(56);\
		ResetElementNo(57);\
		ResetElementNo(58);\
		ResetElementNo(59);\
		ResetElementNo(60);\
		ResetElementNo(61);\
		ResetElementNo(62);\
		ResetElementNo(63);\
		ResetElementNo(64);\
		ResetElementNo(65);\
		ResetElementNo(66);\
		ResetElementNo(67);\
		ResetElementNo(68);\
		ResetElementNo(69);\
		ResetElementNo(70);\
		ResetElementNo(71);\
		ResetElementNo(72);\
		ResetElementNo(73);\
		ResetElementNo(74);\
		ResetElementNo(75);\
		ResetElementNo(76);\
		ResetElementNo(77);\
		ResetElementNo(78);\
		ResetElementNo(79);\
		ResetElementNo(80);\
		ResetElementNo(81);

#define ResetElementNo(x)	NSString *buffer=[[NSString alloc]initWithFormat:@"%i", [gameEngine sudokuQuestionArray atIndex: ((x)-1) ] ] ];				\
[buttons.element##x setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];		\
[element##x setUserInteractionEnabled:FALSE];							\
if([gameEngine sudokuQuestionArray atIndex: ((x)-1)]]==0) {									\
buffer=@" ";											\
[element##x setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];		\
[element##x setUserInteractionEnabled:TRUE];							\
[gameEngine SetSudokuUserArray value:0 atIndex:((x)-1)];										\
}												\
[buttons.element##x setTitle:buffer forState: UIControlStateNormal];					\
[buttons.element##x  setHighlighted:TRUE];								\
[buttons.element##x setHighlighted:FALSE];								\
[buffer release];

#define setElements     		setElementNo(1);\
		setElementNo(2);\
		setElementNo(3);\
		setElementNo(4);\
		setElementNo(5);\
		setElementNo(6);\
		setElementNo(7);\
		setElementNo(8);\
		setElementNo(9);\
		setElementNo(10);\
		setElementNo(11);\
		setElementNo(12);\
		setElementNo(13);\
		setElementNo(14);\
		setElementNo(15);\
		setElementNo(16);\
		setElementNo(17);\
		setElementNo(18);\
		setElementNo(19);\
		setElementNo(20);\
		setElementNo(21);\
		setElementNo(22);\
		setElementNo(23);\
		setElementNo(24);\
		setElementNo(25);\
		setElementNo(26);\
		setElementNo(27);\
		setElementNo(28);\
		setElementNo(29);\
		setElementNo(30);\
		setElementNo(31);\
		setElementNo(32);\
		setElementNo(33);\
		setElementNo(34);\
		setElementNo(35);\
		setElementNo(36);\
		setElementNo(37);\
		setElementNo(38);\
		setElementNo(39);\
		setElementNo(40);\
		setElementNo(41);\
		setElementNo(42);\
		setElementNo(43);\
		setElementNo(44);\
		setElementNo(45);\
		setElementNo(46);\
		setElementNo(47);\
		setElementNo(48);\
		setElementNo(49);\
		setElementNo(50);\
		setElementNo(51);\
		setElementNo(52);\
		setElementNo(53);\
		setElementNo(54);\
		setElementNo(55);\
		setElementNo(56);\
		setElementNo(57);\
		setElementNo(58);\
		setElementNo(59);\
		setElementNo(60);\
		setElementNo(61);\
		setElementNo(62);\
		setElementNo(63);\
		setElementNo(64);\
		setElementNo(65);\
		setElementNo(66);\
		setElementNo(67);\
		setElementNo(68);\
		setElementNo(69);\
		setElementNo(70);\
		setElementNo(71);\
		setElementNo(72);\
		setElementNo(73);\
		setElementNo(74);\
		setElementNo(75);\
		setElementNo(76);\
		setElementNo(77);\
		setElementNo(78);\
		setElementNo(79);\
		setElementNo(80);\
		setElementNo(81);
		
#define setElementNo(x) NSString buffer=[[NSString alloc]initWithFormat:@"%i",[gameEngine sudokuAnswerArray atIndex:((x)-1) ] ] ];\
if(questionArray[((x)-1)]==10) buffer=@" ";\
[buttons.element##x setTitle:buffer forState: UIControlStateNormal];\
[buttons.element##x setHighlighted:TRUE];[buttons.element##x setHighlighted:FALSE];\
[buffer release];
