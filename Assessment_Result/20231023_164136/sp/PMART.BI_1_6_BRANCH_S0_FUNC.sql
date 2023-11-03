REPLACE PROCEDURE PMART.BI_1_6_BRANCH_S0_FUNC
(
	P_TIME_ID NUMBER
)
SQL SECURITY INVOKER
SP:BEGIN
   DECLARE SQLSTR VARCHAR(1000) DEFAULT '';
      CALL PMART.P_DROP_TABLE ('#VT_BI_1_6_BRANCH_S0_FUNC');  
      SET SQLSTR = ' CREATE MULTISET VOLATILE TABLE #VT_BI_1_6_BRANCH_S0_FUNC  AS('
					+ ' SELECT A.ORG_ID, SUM(UPLOAD_STNUM) AS STNUM '
                  	+ ' FROM PMART.REMD_FACT_SUM A, '
                  	+ ' (SELECT B.L_DAY_ID,B.L_MONTH_ID '
                  	+ ' FROM PMART.YMWD_TIME A, PMART.YMWD_TIME B '
                  	+ ' WHERE A.L_WEEK_ID= '+P_TIME_ID 
                  	+ ' AND B.L_DAY_SERIAL= A.L_DAY_SERIAL-1) B '
                  	+ ' WHERE A.L_DAY_ID = B.L_DAY_ID '
                  	+ ' GROUP BY A.ORG_ID '
      				+ ' ) WITH DATA PRIMARY INDEX ( ORG_ID ) ON COMMIT PRESERVE ROWS;';
      EXECUTE IMMEDIATE SQLSTR;
END SP;