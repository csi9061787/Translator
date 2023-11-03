CREATE PROCEDURE PMART.DO_SALES_TCFACT_DETAIL_NEWSTR(IN PROCDATE INT, IN PROCDATE1 INT)
BEGIN     
DECLARE M_SQL_ALL VARCHAR(10000);
LOCKING TABLE PMART.SALES_TCFACT_DETAIL FOR ACCESS;
INSERT INTO PMART.FACT_SALES_TIME_DETAIL
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '00', CNT_TR00, AMT_TR00, REAL_TR00,0, 0, 0 
FROM PMART.SALES_TCFACT_DETAIL 
WHERE TIME_ID >= PROCDATE AND TIME_ID <= PROCDATE1						   						  
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '01', CNT_TR01, AMT_TR01, REAL_TR01,0, 0, 0 
FROM PMART.SALES_TCFACT_DETAIL 
WHERE TIME_ID >= PROCDATE AND TIME_ID <= PROCDATE1 		
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '02', CNT_TR02, AMT_TR02, REAL_TR02,0, 0, 0
FROM PMART.SALES_TCFACT_DETAIL
WHERE TIME_ID >=PROCDATE AND TIME_ID <= PROCDATE1	
 UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '03', CNT_TR03, AMT_TR03, REAL_TR03,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   		
 UNION 
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '04', CNT_TR04, AMT_TR04, REAL_TR04,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   		
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '05', CNT_TR05, AMT_TR05, REAL_TR05,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   		
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '06', CNT_TR06, AMT_TR06, REAL_TR06,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   		
UNION 
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '07', CNT_TR07, AMT_TR07, REAL_TR07,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   		
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '08', CNT_TR08, AMT_TR08, REAL_TR08,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   		
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '09', CNT_TR09, AMT_TR09, REAL_TR09,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   		
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '10', CNT_TR10, AMT_TR10, REAL_TR10,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   		
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '11', CNT_TR11, AMT_TR11, REAL_TR11,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   		
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '12', CNT_TR12, AMT_TR12, REAL_TR12,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   		
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '13', CNT_TR13, AMT_TR13, REAL_TR13,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   		
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '14', CNT_TR14, AMT_TR14, REAL_TR14,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   	
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '15', CNT_TR15, AMT_TR15, REAL_TR15,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   		
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '16', CNT_TR16, AMT_TR16, REAL_TR16,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   		
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '17', CNT_TR17, AMT_TR17, REAL_TR17,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   		
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '18', CNT_TR18, AMT_TR18, REAL_TR18,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   		
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '19', CNT_TR19, AMT_TR19, REAL_TR19,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   	
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '20', CNT_TR20, AMT_TR20, REAL_TR20,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   		
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '21', CNT_TR21, AMT_TR21, REAL_TR21,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   	
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '22', CNT_TR22, AMT_TR22, REAL_TR22,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   		
UNION
SELECT  TIME_ID , ORG_ID , PRD_ID , CUST_TYPE, '23', CNT_TR23, AMT_TR23, REAL_TR23,0, 0, 0  
FROM PMART.SALES_TCFACT_DETAIL  
WHERE TIME_ID >=  PROCDATE  AND TIME_ID <=  PROCDATE1   ;	
END;