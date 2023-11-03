REPLACE PROCEDURE PMART.BI_1_6_OSTORE_S_FUNC
(
   P_WEEK_ID NUMBER,
   P_RESPON_ID NUMBER
)
SQL SECURITY INVOKER
SP:BEGIN
	DECLARE SQLSTR VARCHAR(10000);
	CALL PMART.P_DROP_TABLE ('#VT_BI_1_6_OSTORE_S_FUNC');
	CALL PMART.BI_1_6_OSTORE_S0_FUNC(P_WEEK_ID);
	SET SQLSTR = 'CREATE MULTISET VOLATILE TABLE #VT_BI_1_6_OSTORE_S_FUNC  AS( ' 
				+ ' SELECT A.PRD_ID, B.ORG_ID, '
				+ ' A.ORDER_AMT ORD_AMT, '
				+ ' A.SALES_AMT, '
				+ ' A.BUG_SAL_AMT*1.2*F.STNUM AS BUG_SAL_ALL_AMT, '
				+ ' CAST(A.ORDER_AMT AS DECIMAL(12,2)) / F.STNUM AS ORDER_AMT_AVG, ' 
				+ ' CAST(A.SALES_AMT AS DECIMAL(12,2)) / F.STNUM AS SALES_AMT_AVG,' 
				+ ' A.BUG_SAL_AMT*1.2 AS BUG_SAL_AMT, ' 
				+ ' (CASE WHEN A.ORDER_AMT=0 THEN 100 ELSE CAST(A.SALES_AMT AS DECIMAL(12,2)) *100 / A.ORDER_AMT END) AS ORDSAL_M, ' 
				+ ' (CASE WHEN A.BUG_SAL_AMT*1.2*F.STNUM <> 0 THEN CAST(A.SALES_AMT AS DECIMAL(12,2)) * 100  / A.BUG_SAL_AMT*1.2*F.STNUM ELSE NULL END) AS ACCU, '
				+ ' A.ORDER_CNT, '
				+ ' A.SALES_CNT, '
				+ ' CAST(A.ORDER_CNT AS DECIMAL(12,2)) / F.STNUM AS ORDER_CNT_AVG, '
				+ ' CAST(A.SALES_CNT AS DECIMAL(12,2)) / F.STNUM AS SALES_CNT_AVG '
				+ ' FROM '
       			+ ' 	(SELECT  ORG_ID , PRD_ID '
          		+ ' 	FROM '
				+ ' 		(SELECT DISTINCT OSTORE_ID AS ORG_ID FROM PMART.LAST_ORG_DIM WHERE RESPON_ID= ' + P_RESPON_ID + ') ORG, '
				+ ' 		(SELECT PRD_ID FROM PMART.BI_CODE WHERE PRD_ID <> ''17'' '
				+ ' 		UNION '
				+ ' 		SELECT ''176''  FROM (SELECT 1 AS "DUMMY") AS "DUAL" ) PRD '
         		+ ' ) B, '
				+ ' PMART.BASIC_MFACT_ORD1 A, '
				+ ' #VT_BI_1_6_OSTORE_S0_FUNC F '
   				+ ' WHERE A.TIME_ID = ' + P_WEEK_ID
      			+ ' AND A.ORG_ID = B.ORG_ID '
      			+ ' AND A.PRD_ID = B.PRD_ID '
				+ ' AND A.ORG_ID = F.ORG_ID '
				+ ' ) WITH DATA PRIMARY  CHARINDEX( ORG_ID,PRD_ID) ON COMMIT PRESERVE ROWS;'; 
	EXECUTE IMMEDIATE SQLSTR;  
END SP;