REPLACE PROCEDURE PMART.REMD_O3_SAGE_FUNC(P_DAY_ID NUMBER,P_SAGE_ID NUMBER)
SQL SECURITY INVOKER
SP:BEGIN
DECLARE SQLSTR  VARCHAR(4000) DEFAULT ''; 
  CALL PMART.P_DROP_TABLE ('#VT_REMD_O3_SAGE_FUNC'); 
      SET SQLSTR = 
          'CREATE MULTISET VOLATILE TABLE #VT_REMD_O3_SAGE_FUNC AS('+ 
               'SELECT '+
               'A.OSTORE_ID AS OSTORE_ID, '+
               'A.TOT_AMT  AS TOT_AMT_LAST_YEAR, '+
               'A.TOT_CUST_NUM AS TOT_CUST_NUM_LAST_YEAR, '+
               'A.TOT_TKSL AS TOT_TKSL_LAST_YEAR '+
               'FROM '+
               '(SELECT * '+
               'FROM PMART.REMD_FACT WHERE L_DAY_ID=ROUND('+P_DAY_ID+'/100)*100+1-10000) A, '+
               '(SELECT DISTINCT OSTORE_ID FROM PMART.STORE_TYPE_DIM WHERE SAGE_ID='+P_SAGE_ID+') B '+
               'WHERE A.OSTORE_ID=B.OSTORE_ID '+
          ') WITH DATA NO PRIMARY INDEX ON COMMIT PRESERVE ROWS;';
    EXECUTE IMMEDIATE SQLSTR; 
END SP;