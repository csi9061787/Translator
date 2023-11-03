REPLACE PROCEDURE PMART.MT_TCFACT_FUNC(
FP_TIME_ID NUMBER,
FP_ORG_LEVEL NUMBER,FP_ORG_ID NUMBER,
FP_PRD_LEVEL NUMBER,FP_PRD_ID VARCHAR(7),
FP_MMA_LIST VARCHAR(1000))
SQL SECURITY INVOKER
SP:BEGIN
DECLARE SQLSTR  VARCHAR(4000);
DECLARE V_PARAM VARCHAR(200);
   CALL PMART.P_DROP_TABLE ('#VT_MT_TCFACT_FUNC'); 
   IF FP_ORG_LEVEL=0 THEN
      SET V_PARAM = 'TOT_ID='+ FP_ORG_ID +' AND MMA_ID IN ('+ FP_MMA_LIST +') ';
   ELSEIF FP_ORG_LEVEL=1 THEN
      SET V_PARAM = 'DEPT_ID='+ FP_ORG_ID +' AND MMA_ID IN ('+ FP_MMA_LIST +') ';
   ELSEIF FP_ORG_LEVEL=2 THEN
      SET V_PARAM = 'BRANCH_ID='+ FP_ORG_ID +' AND MMA_ID IN ('+ FP_MMA_LIST +') ';
   END IF;    
    SET SQLSTR = 'CREATE MULTISET VOLATILE TABLE #VT_MT_TCFACT_FUNC  AS('+
      'SELECT '+
      'CAST(B.MMA_ID AS NUMBER) AS MMA_ID,A.TR_ID, '+
      'SUM(A.S_CNT) AS CNT,SUM(A.S_AMT) AS AMT '+
      'FROM ( '+
      ' SELECT CAST(A.TIME_ID AS NUMBER) AS TIME_ID,A.ORG_ID,A.PRD_ID,CAST(H.X AS NUMBER )AS TR_ID, '+
	  ' CASE WHEN A.TIME_RANGE = H.X THEN CAST(A.S_CNT AS NUMBER) ELSE CAST(0 AS NUMBER) END AS S_CNT, '+
	  ' CASE WHEN A.TIME_RANGE = H.X THEN CAST(A.S_AMT AS NUMBER) ELSE CAST(0 AS NUMBER) END AS S_AMT '+
	  ' FROM PMART.FACT_SALES_TIME A '+
	  ' CROSS JOIN (SELECT CAST(DAY_OF_CALENDAR AS INTEGER) -1 AS X FROM SYS_CALENDAR.CALENDAR  WHERE X BETWEEN 0 AND 23 ) AS H'+
      ' WHERE A.TIME_ID='+ FP_TIME_ID + ' '+
      ' AND A.ORG_ID IN (SELECT OSTORE_ID FROM PMART.LAST_ORG_MMA_DIM '+
      ' WHERE '+ V_PARAM + ') '+
      ' AND A.PRD_ID='''+ FP_PRD_ID + ''' '+
      ' ) A, PMART.LAST_ORG_MMA_DIM B ' +
      ' WHERE A.ORG_ID=B.OSTORE_ID '+
      ' GROUP BY B.MMA_ID,A.TR_ID '+ 
    ') WITH DATA NO PRIMARY INDEX ON COMMIT PRESERVE ROWS;';
	EXECUTE IMMEDIATE SQLSTR;
END SP;