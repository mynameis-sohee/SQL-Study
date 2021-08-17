SELECT INS.ANIMAL_ID, INS.NAME FROM ANIMAL_INS INS
INNER JOIN (SELECT * FROM ANIMAL_OUTS) OUTS
ON INS.ANIMAL_ID =  OUTS.ANIMAL_ID
WHERE INS.DATETIME >= OUTS.DATETIME
ORDER BY INS.DATETIME
