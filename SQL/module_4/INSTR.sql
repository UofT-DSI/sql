--instr

SELECT 

INSTR('FirstWord, SecondWord, ThirdWord',','),

SUBSTR('FirstWords, SecondWord, ThirdWord',0, 10),

SUBSTR('FirstWords, SecondWord, ThirdWord',0, 
	INSTR('FirstWords, SecondWord, ThirdWord',',')) as FirstDelim
	
,SUBSTR('FirstWord, SecondWord, ThirdWord', 
  INSTR('FirstWord, SecondWord, ThirdWord',',')+1,
  INSTR('FirstWord, SecondWord, ThirdWord',',')+1) as SecondDelim