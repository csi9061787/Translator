REPLACE PROCEDURE PMART.POSK1_4_2_FUNC_RUBY(P_L_Y_ID VARCHAR(10000),
									 P_L_DAY_ID VARCHAR(10000))
SQL SECURITY INVOKER
SP:BEGIN
   DECLARE SQLSTR VARCHAR(64000);
   DECLARE V_SELECT_SUM VARCHAR(20000);
   CALL PMART.P_DROP_TABLE ('#VT_POSK1_4_2_FUNC'); 
   SET SQLSTR =' CREATE MULTISET VOLATILE TABLE #VT_POSK1_4_2_FUNC  AS('+
		' SELECT TIME_ID,PRD_ID,XDIM_ID,SUM(S_CNT) AS CNT,SUM(S_AMT) AS AMT FROM ( '+
        ' SELECT A.TIME_ID,A.PRD_ID,H.X AS XDIM_ID, '+
		' CASE WHEN A.TIME_RANGE = H.X THEN A.S_CNT ELSE 0 END AS S_CNT, '+
		' CASE WHEN A.TIME_RANGE = H.X THEN A.S_AMT ELSE 0 END AS S_AMT '+
		' FROM PMART.FACT_SALES_TIME A '+
		' CROSS JOIN (SELECT CAST(DAY_OF_CALENDAR AS INTEGER) -1 AS X FROM SYS_CALENDAR.CALENDAR  WHERE X BETWEEN 0 AND 23 ) AS H'+
        ' WHERE TIME_ID IN('+ P_L_DAY_ID +') '+
        ' AND A.ORG_ID = -1 '+
        ' AND A.PRD_ID IN('+ P_L_Y_ID +') '+
        ' )S GROUP BY TIME_ID,PRD_ID,XDIM_ID '+
   ') WITH DATA NO PRIMARY INDEX ON COMMIT PRESERVE ROWS;'; 
   INSERT INTO PMART.T1('POSK1_4_2_FUNC:', 'SQLSTR:'+SQLSTR );
	EXECUTE IMMEDIATE SQLSTR;
END SP;