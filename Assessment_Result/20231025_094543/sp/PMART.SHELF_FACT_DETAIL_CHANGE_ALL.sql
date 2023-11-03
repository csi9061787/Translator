REPLACE PROCEDURE PMART.SHELF_FACT_DETAIL_CHANGE_ALL (P_DAY_ID NUMBER)
SQL SECURITY INVOKER
SP:BEGIN
 CALL PMART.SHELF_FACT_DETAIL_CHANGE_1(P_DAY_ID); 
 CALL PMART.SHELF_FACT_DETAIL_CHANGE_2(P_DAY_ID); 
DELETE FROM PMART.SHELF_FACT
WHERE TIME_ID IN (SELECT TIME_ID FROM PMART.SHELF_FACT_CHANGE )
;
DELETE FROM PMART.SHELF_FACT_DETAIL
WHERE TIME_ID IN (SELECT TIME_ID FROM PMART.SHELF_FACT_DETAIL_CHANGE )
;
INSERT INTO PMART.SHELF_FACT
SELECT * FROM PMART.SHELF_FACT_CHANGE
;
INSERT INTO PMART.SHELF_FACT_DETAIL
SELECT * FROM PMART.SHELF_FACT_DETAIL_CHANGE
;
END SP;