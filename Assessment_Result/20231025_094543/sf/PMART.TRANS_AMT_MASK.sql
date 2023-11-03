REPLACE FUNCTION PMART.TRANS_AMT_MASK(AMT DECIMAL(15,3) ,TIME_ID INTEGER)
   RETURNS  DECIMAL(15,3)
   LANGUAGE SQL
   CONTAINS SQL
   DETERMINISTIC
   SQL SECURITY DEFINER
   COLLATION INVOKER
   INLINE TYPE 1
   RETURN
CASE 
   WHEN  LENGTH(CAST(TIME_ID AS VARCHAR(100)))=4 
      THEN   AMT* (CAST(SUBSTRING(CAST(TIME_ID AS VARCHAR(100)),4,1)AS INT)+ PMART.TRANS_AMT_MASK_ADD(CAST(SUBSTRING(CAST(TIME_ID AS VARCHAR(100)),4,1) AS INT)))
	    WHEN  LENGTH(CAST(TIME_ID AS VARCHAR(100)))=6  AND (SUBSTRING(CAST(TIME_ID AS VARCHAR(100)),5,2) *1)>=21
            THEN AMT * (CAST(SUBSTRING(CAST(TIME_ID AS VARCHAR(100)),6,1) AS INT)+ PMART.TRANS_AMT_MASK_ADD(CAST(SUBSTRING(CAST(TIME_ID AS VARCHAR(100)),6,1) AS INT)))
			  WHEN  LENGTH(CAST(TIME_ID AS VARCHAR(100)))=6 AND CAST (SUBSTRING(CAST(TIME_ID AS VARCHAR(100)),5,2) AS INT)<21
                 THEN AMT * (CAST(SUBSTRING(CAST(TIME_ID AS VARCHAR(100)),6,1) AS INT)+ PMART.TRANS_AMT_MASK_ADD(CAST(SUBSTRING(CAST(TIME_ID AS VARCHAR(100)),6,1) AS INT)))
   	       			 ELSE
                      AMT *  (CAST(SUBSTRING(CAST(TIME_ID AS VARCHAR(100)),8,1) AS INT)+  PMART.TRANS_AMT_MASK_ADD(CAST(SUBSTRING(CAST(TIME_ID AS VARCHAR(100)),8,1) AS INT)))
			 END;