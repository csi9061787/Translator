REPLACE PROCEDURE PMART.BASIC_EXTEND_TIME_USELF
(FP_TIME_TYPE CHAR(1) CASESPECIFIC,FP_TIME_LISTS VARCHAR(11) CASESPECIFIC,FP_TIME_LISTE VARCHAR(11) CASESPECIFIC,FP_ORG_ID NUMBER)
SQL SECURITY INVOKER
SP:BEGIN
DECLARE SQLSTR  VARCHAR(4000) DEFAULT ''; 
  CALL PMART.P_DROP_TABLE ('#VT_BASIC_EXTEND_TIME_USELF'); 
  CASE FP_TIME_TYPE
      WHEN 'I' THEN 
           SET SQLSTR = 
               'CREATE MULTISET VOLATILE TABLE #VT_BASIC_EXTEND_TIME_USELF  AS('+      
                        'SELECT DISTINCT L_DAY_ID AS TIME_ID,L_DAY_NAME AS TIME_NM,L_DAY_LAST_YEAR AS LTIME_ID, '+
                        ' (SELECT L_DAY_NAME FROM PMART.YMWD_TIME T2 WHERE T2.L_DAY_ID = T.L_DAY_LAST_YEAR) AS LTIME_NM, '+
                        ' 0 AS MAST_STORE_NUM,0 AS WEATHER,0 AS LWEATHER,NULL AS WEATH_NAME,NULL AS LWEATH_NAME '+
                        ' FROM PMART.YMWD_TIME T '+
                        ' WHERE L_DAY_ID >= ('+ FP_TIME_LISTS +') '+
                        '   AND L_DAY_ID <= ('+ FP_TIME_LISTE +') '+
               ') WITH DATA NO PRIMARY INDEX ON COMMIT PRESERVE ROWS;';
               	EXECUTE IMMEDIATE SQLSTR;          
   END CASE;  
END SP;