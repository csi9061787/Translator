REPLACE PROCEDURE PMART.FUNC_FACT_MMK_BONUS_PRD_DIM
(
   IN P_SHOWTYPE INTEGER,  
   IN P_BONUS_PRD_ID VARCHAR(7)
)
SP:BEGIN
    DECLARE SQLSTR  VARCHAR(2000) ;
    CALL PMART.P_DROP_TABLE ('#VT_FUNC_FACT_MMK_BONUS_PRD_DIM');
    SET SQLSTR = 'CREATE MULTISET VOLATILE TABLE #VT_FUNC_FACT_MMK_BONUS_PRD_DIM ( '
						 +'BONUS_PRD_ID VARCHAR(7), '
	                     +'BONUS_PRD_NAME VARCHAR(50)   '
						 +') UNIQUE PRIMARY INDEX(BONUS_PRD_ID) ON COMMIT PRESERVE ROWS; ';
    EXECUTE IMMEDIATE SQLSTR;   
    IF P_SHOWTYPE = 2 THEN 
		SET SQLSTR = 'INSERT INTO #VT_FUNC_FACT_MMK_BONUS_PRD_DIM(BONUS_PRD_ID,BONUS_PRD_NAME) VALUES(CAST('''+ '-1' + ''' AS VARCHAR(7)),CAST('''+'合計'+'''  AS VARCHAR(50))); ';
	ELSE 
	    SET SQLSTR = 'INSERT INTO #VT_FUNC_FACT_MMK_BONUS_PRD_DIM(BONUS_PRD_ID,BONUS_PRD_NAME) VALUES(CAST('''+ '-1' + ''' AS VARCHAR(7)),CAST('''+'
    END IF;	
	EXECUTE IMMEDIATE SQLSTR;
	SET SQLSTR =' INSERT INTO #VT_FUNC_FACT_MMK_BONUS_PRD_DIM(BONUS_PRD_ID,BONUS_PRD_NAME)  '
                         +'   SELECT DISTINCT PRODUCT_NO,PRODUCT_NAME '
                         +'      FROM PDATA.MMK_BONUS_PRD  ';
    IF P_SHOWTYPE = 1  AND TRIM(P_BONUS_PRD_ID)<>'-1' THEN 
	    SET SQLSTR = SQLSTR + ' WHERE PRODUCT_NO =''' + P_BONUS_PRD_ID+'''';
	END IF;
    EXECUTE IMMEDIATE SQLSTR;   
END SP;