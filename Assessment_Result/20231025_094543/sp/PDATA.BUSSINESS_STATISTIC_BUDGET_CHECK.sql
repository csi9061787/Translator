REPLACE PROCEDURE PDATA.BUSSINESS_STATISTIC_BUDGET_CHECK
(
OUT DATA_CNT INTEGER,
OUT ERR_CNT INTEGER
)
SQL SECURITY INVOKER
SP:BEGIN
 CALL PMART.P_DROP_TABLE ('#TMP_BUSSINESS_STATISTIC_MAINTAIN');
CREATE MULTISET VOLATILE  TABLE #TMP_BUSSINESS_STATISTIC_MAINTAIN AS 
(
WITH TMP AS 
(
SELECT A.B_YEAR,A.BUDGET_TYPE AS BUDGET_TYPE_CODE,B.BUDGET_TYPE,A.ITEM_CODE,A.SUB_ITEM_CODE,CASE WHEN SUB_ITEM_CODE =-1 THEN '合計' ELSE PBM.STTP_TYPE_NM END STTP_TYPE_NM
FROM PSTAGE.BUSSINESS_STATISTIC_BUDGET_IF A
LEFT JOIN (SELECT DISTINCT BUDGET_TYPE,BUDGET_TYPE_CODE FROM  PDATA.BUSSINESS_STATISTIC_BUDGET_CODEMAP) B 
ON A.BUDGET_TYPE = B.BUDGET_TYPE_CODE
LEFT JOIN (SELECT DISTINCT STTP_TYPE,STTP_TYPE_NM FROM PDATA.PBMSTTP)PBM
ON A.SUB_ITEM_CODE = PBM.STTP_TYPE
)
SELECT  B_YEAR,BUDGET_TYPE_CODE,TMP.ITEM_CODE,SUB_ITEM_CODE,'不存在的指標' AS ERR_MSG
FROM TMP
LEFT JOIN (SELECT DISTINCT ITEM_CODE,ITEM_NAME FROM  PDATA.BUSSINESS_STATISTIC_BUDGET_CODEMAP) C 
ON TMP.ITEM_CODE = C.ITEM_CODE
WHERE C.ITEM_NAME IS NULL
)
WITH  DATA NO PRIMARY INDEX ON COMMIT PRESERVE ROWS;
UPDATE PSTAGE.BUSSINESS_STATISTIC_BUDGET_IF
FROM  #TMP_BUSSINESS_STATISTIC_MAINTAIN B
SET ERR_MSG = NVL(BUSSINESS_STATISTIC_BUDGET_IF.ERR_MSG,'')+','+ B.ERR_MSG
WHERE BUSSINESS_STATISTIC_BUDGET_IF.B_YEAR = B.B_YEAR
AND BUSSINESS_STATISTIC_BUDGET_IF.BUDGET_TYPE = B.BUDGET_TYPE_CODE
AND BUSSINESS_STATISTIC_BUDGET_IF.ITEM_CODE  = B.ITEM_CODE
AND BUSSINESS_STATISTIC_BUDGET_IF.SUB_ITEM_CODE = B.SUB_ITEM_CODE
;
 CALL PMART.P_DROP_TABLE ('#TMP_BUSSINESS_STATISTIC_MAINTAIN');
CREATE MULTISET VOLATILE  TABLE #TMP_BUSSINESS_STATISTIC_MAINTAIN AS 
(
WITH TMP AS 
(
SELECT DISTINCT B_YEAR,BUDGET_TYPE,ITEM_CODE
FROM PSTAGE.BUSSINESS_STATISTIC_BUDGET_IF
WHERE BUDGET_TYPE NOT IN (1,2)
)
SELECT B_YEAR,BUDGET_TYPE,COUNT(ITEM_CODE)ITEM_CNT
FROM TMP
GROUP BY 1,2
HAVING COUNT(ITEM_CODE)<(SELECT COUNT(DISTINCT PDEPT_NO)+1 FROM PMART.LAST_ORG_DIM)
)
WITH  DATA NO PRIMARY INDEX ON COMMIT PRESERVE ROWS;
INSERT INTO PSTAGE.BUSSINESS_STATISTIC_BUDGET_IF
SELECT B_YEAR,BUDGET_TYPE,''AS ITEM_CODE,''AS SUB_ITEM_CODE,NULL AS M1,NULL AS M2,NULL AS M3,NULL AS M4,NULL AS M5,NULL AS M6,NULL AS M7,NULL AS M8,
NULL AS M9,NULL AS M10,NULL AS M11,NULL AS M12,',指標不足，請檢查是否包含四本部及新開店代碼' AS ERR_MSG
FROM #TMP_BUSSINESS_STATISTIC_MAINTAIN
;
CALL PMART.P_DROP_TABLE ('#TMP_BUSSINESS_STATISTIC_MAINTAIN');
CREATE MULTISET VOLATILE  TABLE #TMP_BUSSINESS_STATISTIC_MAINTAIN AS 
(
SELECT  B_YEAR,BUDGET_TYPE,ITEM_CODE,SUB_ITEM_CODE,'不存在開發組織主檔中' AS ERR_MSG
FROM PSTAGE.BUSSINESS_STATISTIC_BUDGET_IF A
LEFT JOIN (SELECT DISTINCT PDEPT_NO FROM PMART.LAST_ORG_DIM WHERE PDEPT_NO IS NOT NULL) B
ON A.ITEM_CODE = B.PDEPT_NO
LEFT JOIN (SELECT DISTINCT DVB_BRANCH_NO FROM PMART.LAST_ORG_DIM WHERE DVB_BRANCH_NO IS NOT NULL) C
ON A.ITEM_CODE = C.DVB_BRANCH_NO
LEFT JOIN (SELECT DISTINCT TOT_ID FROM PMART.LAST_ORG_DIM) D
ON A.ITEM_CODE = TO_CHAR(D.TOT_ID)
LEFT JOIN (SELECT  DISTINCT P.PARENT_DEPT_ID FROM  PMART.LAST_ORG_DIM A
					LEFT JOIN PDATA.PBMDEPT P ON P.DEPT_ID=A.DVB_BRANCH_NO
					LEFT JOIN PDATA.PBMDEPT P2 ON P.PARENT_DEPT_ID=P2.DEPT_ID
				WHERE P.PARENT_DEPT_ID IS NOT NULL) E
ON A.ITEM_CODE = E.PARENT_DEPT_ID 
WHERE A.BUDGET_TYPE NOT IN (1,2)  AND ITEM_CODE NOT IN '9999'
AND COALESCE(B.PDEPT_NO, C.DVB_BRANCH_NO, TO_CHAR(D.TOT_ID), E.PARENT_DEPT_ID) IS NULL
)
WITH  DATA NO PRIMARY INDEX ON COMMIT PRESERVE ROWS;
UPDATE PSTAGE.BUSSINESS_STATISTIC_BUDGET_IF
FROM  #TMP_BUSSINESS_STATISTIC_MAINTAIN B
SET ERR_MSG = NVL(BUSSINESS_STATISTIC_BUDGET_IF.ERR_MSG,'')+','+ B.ERR_MSG
WHERE BUSSINESS_STATISTIC_BUDGET_IF.B_YEAR = B.B_YEAR
AND BUSSINESS_STATISTIC_BUDGET_IF.BUDGET_TYPE = B.BUDGET_TYPE
AND BUSSINESS_STATISTIC_BUDGET_IF.ITEM_CODE  = B.ITEM_CODE
AND BUSSINESS_STATISTIC_BUDGET_IF.SUB_ITEM_CODE = B.SUB_ITEM_CODE
; 
CALL PMART.P_DROP_TABLE ('#TMP_BUSSINESS_STATISTIC_MAINTAIN');
CREATE MULTISET VOLATILE  TABLE #TMP_BUSSINESS_STATISTIC_MAINTAIN AS 
(
SELECT  B_YEAR,BUDGET_TYPE,ITEM_CODE,SUB_ITEM_CODE,'不存在店型主檔中' AS ERR_MSG
FROM PSTAGE.BUSSINESS_STATISTIC_BUDGET_IF A
LEFT JOIN (SELECT DISTINCT STTP_TYPE FROM PDATA.PBMSTTP) B
ON A.SUB_ITEM_CODE = B.STTP_TYPE
WHERE SUB_ITEM_CODE NOT IN ('','-1')
AND B.STTP_TYPE IS NULL
)
WITH  DATA NO PRIMARY INDEX ON COMMIT PRESERVE ROWS;
UPDATE PSTAGE.BUSSINESS_STATISTIC_BUDGET_IF
FROM  #TMP_BUSSINESS_STATISTIC_MAINTAIN B
SET ERR_MSG = NVL(BUSSINESS_STATISTIC_BUDGET_IF.ERR_MSG,'')+','+ B.ERR_MSG
WHERE BUSSINESS_STATISTIC_BUDGET_IF.B_YEAR = B.B_YEAR
AND BUSSINESS_STATISTIC_BUDGET_IF.BUDGET_TYPE = B.BUDGET_TYPE
AND BUSSINESS_STATISTIC_BUDGET_IF.ITEM_CODE  = B.ITEM_CODE
AND BUSSINESS_STATISTIC_BUDGET_IF.SUB_ITEM_CODE = B.SUB_ITEM_CODE
; 
 CALL PMART.P_DROP_TABLE ('#TMP_BUSSINESS_STATISTIC_MAINTAIN');
 SET DATA_CNT = (SELECT COUNT(*) FROM PSTAGE.BUSSINESS_STATISTIC_BUDGET_IF);
 SET ERR_CNT = (SELECT COUNT(*) FROM PSTAGE.BUSSINESS_STATISTIC_BUDGET_IF WHERE  LENGTH(ERR_MSG)>0);
END SP;