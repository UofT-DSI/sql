--substring & instring together

SELECT 
'FirstWord, SecondWord, ThirdWord',
 SUBSTR('FirstWord, SecondWord, ThirdWord',0, INSTR('FirstWord, SecondWord, ThirdWord',',')) as FirstDelim
 --,SUBSTR('FirstWord, SecondWord, ThirdWord',0, 10) as FirstDelim -- same thing but not dynamic
 ,SUBSTR('FirstWord, SecondWord, ThirdWord', 
  INSTR('FirstWord, SecondWord, ThirdWord',',')+1,
  INSTR('FirstWord, SecondWord, ThirdWord',',')+1) as SecondDelim
  
  ,SUBSTR('FirstWord, SecondWord, ThirdWord',
  INSTR(
    (SUBSTR('FirstWord, SecondWord, ThirdWord',
    INSTR('FirstWord, SecondWord, ThirdWord',',')+1))
  ,',') + 
  INSTR('FirstWord, SecondWord, ThirdWord',',')+1) AS ThirdDelim