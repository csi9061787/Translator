REPLACE FUNCTION PDATA.SUBSIDY_INPRD_SALES_QTY_FUNC(L_ORDER_MQTY INTEGER,L_INPRD_CNT INTEGER,L_SALES_CNT INTEGER,L_ITEM_KIND VARCHAR(2))
   RETURNS INTEGER
   LANGUAGE SQL
   CONTAINS SQL
   DETERMINISTIC
   SQL SECURITY DEFINER
   COLLATION INVOKER
   INLINE TYPE 1
   RETURN
CASE 
		WHEN L_ITEM_KIND IN ('F','F2','F3','F4') THEN L_INPRD_CNT
		WHEN L_ITEM_KIND NOT IN ('F','F2','F3','F4') AND L_ORDER_MQTY > L_INPRD_CNT THEN L_INPRD_CNT
		WHEN L_ITEM_KIND NOT IN ('F','F2','F3','F4') AND L_ORDER_MQTY <=L_INPRD_CNT THEN L_ORDER_MQTY
		ELSE L_ORDER_MQTY END 
		- L_SALES_CNT;