REPLACE PROCEDURE PMART.NEW_TPX_MMA_SUM_MODULE_1
(FP_AMT_TYPE CHAR(1),FP_TIME_TYPE CHAR(1),
FP_TIME_LIST VARCHAR(2000),FP_LTIME_LIST VARCHAR(2000),
FP_PRD_TYPE CHAR(1),FP_PRD_LEVEL NUMBER,FP_PRD_LIST VARCHAR(5000),
FP_ORG_LEVEL NUMBER,FP_ORG_ID NUMBER,FP_MMA_LIST VARCHAR(2000))
SQL SECURITY INVOKER
SP:BEGIN
DECLARE SQLSTR  VARCHAR(64000);
   CALL PMART.P_DROP_TABLE ('#VT_NEW_TPX_MMA_SUM_MODULE_1'); 
   CALL PMART.NEW_TPX_MMA_MODULE_1(FP_AMT_TYPE,FP_TIME_TYPE,FP_TIME_LIST,FP_LTIME_LIST,FP_PRD_TYPE,FP_PRD_LEVEL,FP_PRD_LIST,FP_ORG_LEVEL,FP_ORG_ID,FP_MMA_LIST);
   SET SQLSTR = 'CREATE MULTISET VOLATILE TABLE #VT_NEW_TPX_MMA_SUM_MODULE_1  AS('+
                       'SELECT '+
                       'A.TIME_ID AS TIME_ID, '+
                       'A.PRD_ID AS PRD_ID, '+
                       '-2 AS MMA_ID, '+
                       'SUM(ORDER_EXTEND_STORE_NUM) AS ORDER_EXTEND_STORE_NUM, '+
                       'CAST(SUM(ORDER_EXTEND_STORE_NUM) AS DECIMAL(18,6)) /DECODE(SUM(MAST_STORE_NUM),0,NULL,SUM(MAST_STORE_NUM))*100 AS ORDER_EXTEND_STORE_RATE, '+
                       'SUM(SALES_EXTEND_STORE_NUM) AS SALES_EXTEND_STORE_NUM, '+
                       'CAST(SUM(SALES_EXTEND_STORE_NUM) AS DECIMAL(18,6)) /DECODE(SUM(MAST_STORE_NUM),0,NULL,SUM(MAST_STORE_NUM))*100 AS SALES_EXTEND_STORE_RATE, '+
                       'SUM(THROW_EXTEND_STORE_NUM) AS THROW_EXTEND_STORE_NUM, '+
                       'SUM(CUST_NUM) AS CUST_NUM, '+
                       'SUM(MAST_STORE_NUM) AS MAST_STORE_NUM, '+
                       'CAST(SUM(CUST_NUM) AS DECIMAL(18,6)) /COUNT(CUST_NUM)/DECODE(SUM(SALES_EXTEND_CNT),0,NULL,SUM(SALES_EXTEND_CNT)) AS BUY_EXTEND_RATE, '+
                       'SUM(LEAD_EXTEND_STORE_NUM) AS LEAD_EXTEND_STORE_NUM, '+
                       'CAST(SUM(LEAD_EXTEND_STORE_NUM) AS DECIMAL(18,6)) /DECODE(SUM(MAST_STORE_NUM),0,NULL,SUM(MAST_STORE_NUM))*100 AS LEAD_EXTEND_STORE_RATE, '+
                       'SUM(ORDER_EXTEND_AMT) AS ORDER_EXTEND_AMT, '+
                       'CAST(SUM(ORDER_EXTEND_AMT) AS DECIMAL(18,6)) /DECODE(SUM(ORDER_EXTEND_STORE_NUM),0,NULL,SUM(ORDER_EXTEND_STORE_NUM)) AS ORDER_EXTEND_AMT_AVG, '+
                       'SUM(LORDER_EXTEND_AMT) AS LORDER_EXTEND_AMT, '+
                       'SUM(LORDER_EXTEND_AMT_DIFF) AS LORDER_EXTEND_AMT_DIFF, '+
                       'SUM(LORDER_EXTEND_AMT_RATE) AS LORDER_EXTEND_AMT_RATE, '+
                       'SUM(SALES_EXTEND_AMT) AS SALES_EXTEND_AMT, '+
                       'CAST(SUM(SALES_EXTEND_AMT) AS DECIMAL(18,6)) /DECODE(SUM(SALES_EXTEND_STORE_NUM),0,NULL,SUM(SALES_EXTEND_STORE_NUM)) AS SALES_EXTEND_AMT_AVG, '+
                       'CAST(SUM(SALES_EXTEND_AMT) AS DECIMAL(18,6)) /DECODE(SUM(MAST_STORE_NUM),0,NULL,SUM(MAST_STORE_NUM)) AS SALES_EXTEND_AMT_MAST_AVG, '+
                       'SUM(LSALES_EXTEND_AMT) AS LSALES_EXTEND_AMT, '+
                       'SUM(LSALES_EXTEND_AMT_DIFF) AS LSALES_EXTEND_AMT_DIFF, '+
                       'SUM(LSALES_EXTEND_AMT_RATE) AS LSALES_EXTEND_AMT_RATE, '+
                       'SUM(THROW_EXTEND_AMT) AS THROW_EXTEND_AMT, '+
                       'CAST(SUM(THROW_EXTEND_AMT) AS DECIMAL(18,6)) /DECODE(SUM(THROW_EXTEND_STORE_NUM),0,NULL,SUM(THROW_EXTEND_STORE_NUM)) AS THROW_EXTEND_AMT_AVG, '+
                       'SUM(LTHROW_EXTEND_AMT) AS LTHROW_EXTEND_AMT, '+
                       'CAST(SUM(THROW_EXTEND_AMT) AS DECIMAL(18,6)) /DECODE(SUM(ORDER_EXTEND_AMT),0,NULL,SUM(ORDER_EXTEND_AMT))*100 AS THROW_EXTEND_AMT_RATE, '+
                       'SUM(ORDER_EXTEND_CNT) AS ORDER_EXTEND_CNT, '+
                       'CAST(SUM(ORDER_EXTEND_CNT) AS DECIMAL(18,6)) /DECODE(SUM(ORDER_EXTEND_STORE_NUM),0,NULL,SUM(ORDER_EXTEND_STORE_NUM)) AS ORDER_EXTEND_CNT_AVG, '+
                       'SUM(LORDER_EXTEND_CNT) AS LORDER_EXTEND_CNT, '+
                       'SUM(LORDER_EXTEND_CNT_DIFF) AS LORDER_EXTEND_CNT_DIFF, '+
                       'SUM(LORDER_EXTEND_CNT_RATE) AS LORDER_EXTEND_CNT_RATE, '+
                       'SUM(SALES_EXTEND_CNT) AS SALES_EXTEND_CNT, '+
                       'CAST(SUM(SALES_EXTEND_CNT) AS DECIMAL(18,6)) /DECODE(SUM(SALES_EXTEND_STORE_NUM),0,NULL,SUM(SALES_EXTEND_STORE_NUM)) AS SALES_EXTEND_CNT_AVG, '+
                       'CAST(SUM(SALES_EXTEND_CNT) AS DECIMAL(18,6)) /DECODE(SUM(MAST_STORE_NUM),0,NULL,SUM(MAST_STORE_NUM)) AS SALES_EXTEND_CNT_MAST_AVG,  '+
                       'SUM(LSALES_EXTEND_CNT) AS LSALES_EXTEND_CNT, '+
                       'SUM(LSALES_EXTEND_CNT_DIFF) AS LSALES_EXTEND_CNT_DIFF, '+
					   'SUM(LSALES_EXTEND_CNT_RATE) AS LSALES_EXTEND_CNT_RATE, '+
					   'SUM(THROW_EXTEND_CNT) AS THROW_EXTEND_CNT, '+
					   'CAST(SUM(THROW_EXTEND_CNT) AS DECIMAL(18,6)) /DECODE(SUM(THROW_EXTEND_STORE_NUM),0,NULL,SUM(THROW_EXTEND_STORE_NUM)) AS THROW_EXTEND_CNT_AVG, '+
					   'SUM(LTHROW_EXTEND_CNT) AS LTHROW_EXTEND_CNT, '+
					   'CAST(SUM(THROW_EXTEND_CNT) AS DECIMAL(18,6)) /DECODE(SUM(ORDER_EXTEND_CNT),0,NULL,SUM(ORDER_EXTEND_CNT))*100 AS THROW_EXTEND_CNT_RATE, '+
					   'SUM(SHOP_EXTEND_RECEIVED_NUM) AS SHOP_EXTEND_RECEIVED_NUM, '+
					   'CAST(SUM(SHOP_EXTEND_RECEIVED_NUM) AS DECIMAL(18,6)) /DECODE(SUM(MAST_STORE_NUM),0,NULL,SUM(MAST_STORE_NUM))*100 AS SHOP_EXTEND_RECEIVED_RATE, '+
					   'SUM(SHOP_EXTEND_RETURN_NUM) AS SHOP_EXTEND_RETURN_NUM, '+
				       'SUM(SHOP_EXTEND_TRANSFER_NUM) AS SHOP_EXTEND_TRANSFER_NUM, '+
					   'SUM(SHOP_EXTEND_TRANSFER_IN_NUM) AS SHOP_EXTEND_TRANSFER_IN_NUM, '+
					   'SUM(ITMRECEIVED_EXTEND_AMT) AS ITMRECEIVED_EXTEND_AMT, '+
		               'CAST(SUM(ITMRECEIVED_EXTEND_AMT) AS DECIMAL(18,6)) /DECODE(SUM(SHOP_EXTEND_RECEIVED_NUM),0,NULL,SUM(SHOP_EXTEND_RECEIVED_NUM)) AS ITMRECEIVED_EXTEND_AMT_AVG, '+
					   'SUM(ITMRECEIVED_EXTEND_PRE_AMT) AS ITMRECEIVED_EXTEND_PRE_AMT, '+
					   'SUM(ITMRETURN_EXTEND_AMT) AS ITMRETURN_EXTEND_AMT, '+
					   'SUM(ITMRETURN_EXTEND_PRE_AMT) AS ITMRETURN_EXTEND_PRE_AMT, '+
					   'SUM(ITMTRANSFER_EXTEND_AMT) AS ITMTRANSFER_EXTEND_AMT, '+
					   'SUM(ITMTRANSFER_EXTEND_PRE_AMT) AS ITMTRANSFER_EXTEND_PRE_AMT, '+
					   'SUM(DISCOUNT_EXTEND_AMT) AS DISCOUNT_EXTEND_AMT, '+
					   'SUM(LET_EXTEND_AMT) AS LET_EXTEND_AMT, '+
					   'SUM(ITMREFOUND_EXTEND_AMT) AS ITMREFOUND_EXTEND_AMT, '+
                       'SUM(ITMRECEIVED_EXTEND_NUM) AS ITMRECEIVED_EXTEND_NUM, '+
					   'CAST(SUM(ITMRECEIVED_EXTEND_NUM) AS DECIMAL(18,6)) /DECODE(SUM(SHOP_EXTEND_RECEIVED_NUM),0,NULL,SUM(SHOP_EXTEND_RECEIVED_NUM)) AS ITMRECEIVED_EXTEND_NUM_AVG, '+
					   'SUM(ITMRECEIVED_EXTEND_PRE_NUM) AS ITMRECEIVED_EXTEND_PRE_NUM, '+
					   'SUM(ITMRETURN_EXTEND_NUM) AS ITMRETURN_EXTEND_NUM, '+
					   'SUM(ITMRETURN_EXTEND_PRE_NUM) AS ITMRETURN_EXTEND_PRE_NUM, '+
					   'SUM(ITMTRANSFER_EXTEND_NUM) AS ITMTRANSFER_EXTEND_NUM, '+
					   'SUM(ITMTRANSFER_EXTEND_PRE_NUM) AS ITMTRANSFER_EXTEND_PRE_NUM '+
                       'FROM '+
                       '  #VT_NEW_TPX_MMA_MODULE_1 A '+
                       '  GROUP BY A.TIME_ID,A.PRD_ID '+
              ') WITH DATA NO PRIMARY INDEX ON COMMIT PRESERVE ROWS;';
	EXECUTE IMMEDIATE SQLSTR;
END SP;