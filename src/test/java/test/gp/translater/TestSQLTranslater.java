package test.gp.translater;

import etec.sql.gp.translater.GreemPlumTranslater;

/**
 * @author	Tim
 * @since	2023年11月30日
 * @version	4.0.0.0
 * 
 * 測試 gp 的 SQLTranslater
 * 
 * */
public class TestSQLTranslater {
	public static String run() {
		String res = "";
		
		testAddMonths();
		//CASE3
		String q3 = "";
		String a3 = "";
		
		return res;
	}
	
	private static void testAddMonths() {
//CASE1 : ADD_MONTHS
		String q1 = "ADD_MONTHS(a.RPT_DT,-1) = c.RPT_DT";
		String a1 = "CAST(a.RPT_DT-INTERVAL'1 MONTH' AS DATE) = c.RPT_DT";
		System.out.println("CASE  1 : "+a1.equals(GreemPlumTranslater.sql.easyReplase(q1)));
//		System.out.println("CASE 1 : "+GreemPlumTranslater.sql.easyReplase(q1));
//CASE2 : ADD_MONTHS
		String q2 = "PAYMENT_DUE_DATE <=ADD_MONTHS(DATE'${TX4Y-M}-01',4) -1";
		String a2 = "PAYMENT_DUE_DATE <=CAST(DATE'${TX4Y-M}-01'+INTERVAL'4 MONTH' AS DATE) -1";
		System.out.println("CASE  2 : "+a2.equals(GreemPlumTranslater.sql.easyReplase(q2)));
//		System.out.println("CASE 2 : "+GreemPlumTranslater.sql.easyReplase(q2));
//CASE3 : DATE_FORMAT
		String q3 = "CAST((A.AP_PAYM_PLAN_PAID_DT (FORMAT 'YYYY-MM')) as CHAR(7)) AS AP_PAYM_AMT_ORIG_PAID_MN,";
		String a3 = "CAST((TO_CHAR(A.AP_PAYM_PLAN_PAID_DT, 'YYYY-MM')) as CHAR(7)) AS AP_PAYM_AMT_ORIG_PAID_MN,";
		System.out.println("CASE  3 : "+a3.equals(GreemPlumTranslater.sql.easyReplase(q3)));
//		System.out.println("CASE 3 : "+a3);
//		System.out.println("CASE 3 : "+GreemPlumTranslater.sql.easyReplase(q3));
//CASE4 : DATE_FORMAT
		String q4 = "PLAN_DATE (FORMAT 'YYYY-MM')(CHAR(7)) >= (SELECT MIN(PLAN_DATE)(FORMAT 'YYYY-MM')(CHAR(7)))";
		String a4 = "CAST(TO_CHAR(PLAN_DATE, 'YYYY-MM') AS CHAR(7)) >= (SELECT CAST(TO_CHAR(MIN(PLAN_DATE), 'YYYY-MM') AS CHAR(7)))";
		System.out.println("CASE  4 : "+a4.equals(GreemPlumTranslater.sql.easyReplase(q4)));
//		System.out.println("CASE 4 : "+a4);
//		System.out.println("CASE 4 : "+GreemPlumTranslater.sql.easyReplase(q4));
//CASE5 : ADD_MONTHS
		String q5 = "A.PLAN_PAY_DATE BETWEEN CAST(CAST(CAST(CAST(CREATE_NO AS DATE) AS FORMAT 'YYYY-MM') AS VARCHAR(7))||'-01' AS DATE) AND CAST(CREATE_NO AS DATE)-91";
		String a5 = "A.PLAN_PAY_DATE BETWEEN CAST(TO_CHAR(CAST(CREATE_NO AS DATE), 'YYYY-MM')||'-01' AS DATE) AND CAST(CREATE_NO AS DATE)-91";
		System.out.println("CASE  5 : "+a5.equals(GreemPlumTranslater.sql.easyReplase(q5)));
//		System.out.println("CASE 5 : "+a5);
//		System.out.println("CASE 5 : "+GreemPlumTranslater.sql.easyReplase(q5));
//CASE6 : ADD_MONTHS
//		String q6 = "SUBSTR(CAST(CAST CLNDR_DT AS DATE FORMAT 'YYYYMMDD')+1 AS DATE FORMAT 'YYYY-MM-DD'),9,2)=1";
//		String a6 = "";
//		System.out.println("CASE  6 : "+a6.equals(GreemPlumTranslater.sql.easyReplase(q6)));
//CASE7 : ADD_MONTHS
		String q7 = "";
		String a7 = "";
		System.out.println("CASE  7 : "+a7.equals(GreemPlumTranslater.sql.easyReplase(q7)));
//CASE8 : ADD_MONTHS
//		String q8 = "";
//		String a8 = "";
//		System.out.println("CASE  8 : "+a8.equals(GreemPlumTranslater.sql.easyReplase(q8)));
//CASE9 : ADD_MONTHS
//		String q9 = "";
//		String a9 = "";
//		System.out.println("CASE  9 : "+a9.equals(GreemPlumTranslater.sql.easyReplase(q9)));
//CASE10 : ADD_MONTHS
//		String q10 = "";
//		String a10 = "";
//		System.out.println("CASE 10 : "+a10.equals(GreemPlumTranslater.sql.easyReplase(q10)));
//CASE11 : 
//		String q11 = "";
//		String a11 = "";
//		System.out.println("CASE 11 : "+a11.equals(GreemPlumTranslater.sql.easyReplase(q11)));
//CASE12 : 
//		String q12 = "";
//		String a12 = "";
//		System.out.println("CASE 12 : "+a12.equals(GreemPlumTranslater.sql.easyReplase(q12)));
//CASE13 : 
//		String q13 = "";
//		String a13 = "";
//		System.out.println("CASE 13 : "+a13.equals(GreemPlumTranslater.sql.easyReplase(q13)));
//CASE14 : 
//		String q14 = "";
//		String a14 = "";
//		System.out.println("CASE 14 : "+a14.equals(GreemPlumTranslater.sql.easyReplase(q14)));
//CASE15 : 
//		String q15 = "";
//		String a15 = "";
//		System.out.println("CASE 15 : "+a15.equals(GreemPlumTranslater.sql.easyReplase(q15)));
//CASE16 : 
//		String q16 = "";
//		String a16 = "";
//		System.out.println("CASE 16 : "+a16.equals(GreemPlumTranslater.sql.easyReplase(q16)));
//CASE17 : 
//		String q17 = "";
//		String a17 = "";
//		System.out.println("CASE 17 : "+a17.equals(GreemPlumTranslater.sql.easyReplase(q17)));
//CASE18 : 
//		String q18 = "";
//		String a18 = "";
//		System.out.println("CASE 18 : "+a18.equals(GreemPlumTranslater.sql.easyReplase(q18)));
//CASE19 : 
//		String q19 = "";
//		String a19 = "";
//		System.out.println("CASE 19 : "+a19.equals(GreemPlumTranslater.sql.easyReplase(q19)));
//CASE20 : 
//		String q20 = "";
//		String a20 = "";
//		System.out.println("CASE 20 : "+a20.equals(GreemPlumTranslater.sql.easyReplase(q20)));
//CASE21 : 
//		String q21 = "";
//		String a21 = "";
//		System.out.println("CASE 21 : "+a21.equals(GreemPlumTranslater.sql.easyReplase(q21)));
//CASE22 : 
//		String q22 = "";
//		String a22 = "";
//		System.out.println("CASE 22 : "+a22.equals(GreemPlumTranslater.sql.easyReplase(q22)));
//CASE23 : 
		String q23 = "CASE WHEN A.SUBINV_LOC_ID LIKE ANY ('%RG','%RC','%SP')";
		String a23 = "CASE WHEN A.SUBINV_LOC_ID LIKE ANY (ARRAY['%RG','%RC','%SP'])";
		System.out.println("CASE 23 : "+a23.equals(GreemPlumTranslater.sql.easyReplase(q23)));
//CASE24 : 
		String q24 = "SUBSTR(A.MAIN_EXPN_DESC,0,INDEX(A.MAIN_EXPN_DESC,'-'))";
		String a24 = "SUBSTR(A.MAIN_EXPN_DESC,0,POSITION('-' IN A.MAIN_EXPN_DESC))";
		String r24 = GreemPlumTranslater.sql.easyReplase(q24);
//		System.out.println(r24);
		System.out.println("CASE 24 : "+a24.equals(r24));
//CASE25 : 
//		String q25 = "";
//		String a25 = "";
//		System.out.println("CASE 25 : "+a25.equals(GreemPlumTranslater.sql.easyReplase(q25)));
//CASE26 : 
		String q26 = "ZEROIFNULL (A.PLAN_ETD_QTY) AS X.PLAN_QTY";
		String a26 = "COALESCE(A.PLAN_ETD_QTY,0) AS X.PLAN_QTY";
		System.out.println("CASE 26 : "+a26.equals(GreemPlumTranslater.sql.easyReplase(q26)));
//CASE27 : 
//		String q27 = "";
//		String a27 = "";
//		System.out.println("CASE 27 : "+a27.equals(GreemPlumTranslater.sql.easyReplase(q27)));
//CASE28 : 
		String q28 = "SEL CAST('${TXDATE}' AS DATE FORMAT 'YYYY-MM-DD') AS SNPSHT_DT";
		String a28 = "SELECT CAST('${TXDATE}' AS DATE FORMAT 'YYYY-MM-DD') AS SNPSHT_DT";
		System.out.println("CASE 28 : "+a28.equals(GreemPlumTranslater.sql.easyReplase(q28)));
//CASE29 : 
		String q29 = "REPLACE VIEW ${VIEW_NCMO_DB}.RPT_EXP_EXPN_JE_LN_ALC AS\r\n" + 
				"LOCKING TABLE ${BIMART_DB}.BI_FM_EXPN_JE_LN_ALC FOR ACCESS\r\n" + 
				"SELECT A.*, '比例' AS RM_FLAG FROM ${BIMART_DB}.BI_FM_EXPN_JE_LN_ALC A\r\n" + 
				"UNION ALL\r\n" + 
				"SELECT B.*, '金額' AS RM_FLAG FROM ${BIMART_DB}.BI_FM_EXPN_JE_LN_ALC B";
		String a29 = "DROP VIEW IF EXISTS ${VIEW_NCMO_DB}.RPT_EXP_EXPN_JE_LN_ALC;\r\n" + 
				"CREATE VIEW ${VIEW_NCMO_DB}.RPT_EXP_EXPN_JE_LN_ALC AS\r\n" + 
				"/*LOCKING TABLE ${BIMART_DB}.BI_FM_EXPN_JE_LN_ALC FOR ACCESS*/\r\n" + 
				"SELECT A.*, '比例' AS RM_FLAG FROM ${BIMART_DB}.BI_FM_EXPN_JE_LN_ALC A\r\n" + 
				"UNION ALL\r\n" + 
				"SELECT B.*, '金額' AS RM_FLAG FROM ${BIMART_DB}.BI_FM_EXPN_JE_LN_ALC B";
		String r29 = GreemPlumTranslater.ddl.changeReplaceView(q29);
		r29 = GreemPlumTranslater.sql.easyReplase(r29);
		r29 = GreemPlumTranslater.other.changeLockingTable(r29);
//		System.out.println(r29);
		System.out.println("CASE 29 : "+a29.equals(r29));
//CASE30 : 
//		String q30 = "";
//		String a30 = "";
//		System.out.println("CASE 30 : "+a30.equals(GreemPlumTranslater.sql.easyReplase(q30)));
//CASE31 : 
//		String q31 = "";
//		String a31 = "";
//		System.out.println("CASE 31 : "+a31.equals(GreemPlumTranslater.sql.easyReplase(q31)));
//CASE32 : 
//		String q32 = "";
//		String a32 = "";
//		System.out.println("CASE 32 : "+a32.equals(GreemPlumTranslater.sql.easyReplase(q32)));
//CASE33 : 
//		String q33 = "";
//		String a33 = "";
//		System.out.println("CASE 33 : "+a33.equals(GreemPlumTranslater.sql.easyReplase(q33)));
//CASE34 : 
//		String q34 = "";
//		String a34 = "";
//		System.out.println("CASE 34 : "+a34.equals(GreemPlumTranslater.sql.easyReplase(q34)));
//CASE35 : 
//		String q35 = "";
//		String a35 = "";
//		System.out.println("CASE 35 : "+a35.equals(GreemPlumTranslater.sql.easyReplase(q35)));
//CASE36 : 
//		String q36 = "";
//		String a36 = "";
//		System.out.println("CASE 36 : "+a36.equals(GreemPlumTranslater.sql.easyReplase(q36)));
//CASE37 : 
		String q37 = "A.PLANT_TYPE_CD = 'TFT' AND COALESCE(PROC_CATG_CD,'') IN 'TOD','DDD','AAA'";
		String a37 = "A.PLANT_TYPE_CD = 'TFT' AND COALESCE(PROC_CATG_CD,'') IN ('TOD','DDD','AAA')";
		String r37 = GreemPlumTranslater.sql.easyReplase(q37);
//		System.out.println(r37);
		System.out.println("CASE 37 : "+a37.equals(r37));
//CASE38 : 
//		String q38 = "";
//		String a38 = "";
//		System.out.println("CASE 38 : "+a38.equals(GreemPlumTranslater.sql.easyReplase(q38)));
//CASE39 : 
//		String q39 = "";
//		String a39 = "";
//		System.out.println("CASE 39 : "+a39.equals(GreemPlumTranslater.sql.easyReplase(q39)));
//CASE40 : 
//		String q40 = "";
//		String a40 = "";
//		System.out.println("CASE 40 : "+a40.equals(GreemPlumTranslater.sql.easyReplase(q40)));
//CASE41 : 
//		String q41 = "";
//		String a41 = "";
//		System.out.println("CASE 41 : "+a41.equals(GreemPlumTranslater.sql.easyReplase(q41)));
//CASE42 : 
		String q42 = "NULLIFZERO(SUM( CASE WHEN LCM_LAM_GRD_WYLD BETWEEN 0 AND 1 THEN LCM_GRD_QTY END) OVER (PARTITION BY PROD_TD,Y.APPLICATION_CD, FAB_LOC_ID /*Q.CMS_SYS*/,Y.AR_FAB ,PROD_CAT))";
		String a42 = "NULLIF(SUM( CASE WHEN LCM_LAM_GRD_WYLD BETWEEN 0 AND 1 THEN LCM_GRD_QTY END) OVER (PARTITION BY PROD_TD,Y.APPLICATION_CD, FAB_LOC_ID /*Q.CMS_SYS*/,Y.AR_FAB ,PROD_CAT),0)";
		System.out.println("CASE 42 : "+a42.equals(GreemPlumTranslater.sql.easyReplase(q42)));
//CASE43 : 
		String q43 = "SUBSTR(STRTOK(STRTOK(OREPLACE(OREPLACE(A.ITEM_ID,'TOD',''),'CELL',''),'_',1),'-',1),1,4)";
		String a43 = "SUBSTR(SPLIT_PART(SPLIT_PART(REPLACE(REPLACE(A.ITEM_ID,'TOD',''),'CELL',''),'_',1),'-',1),1,4)";
		System.out.println("CASE 43 : "+a43.equals(GreemPlumTranslater.sql.easyReplase(q43)));
//CASE44 : 
//		String q44 = "";
//		String a44 = "";
//		System.out.println("CASE 44 : "+a44.equals(GreemPlumTranslater.sql.easyReplase(q44)));
//CASE45 : 
		String q45 = "CREATE TABLE ${MART_NCMO_DB}.BI_FM_EXPN_NON_OP_DTL_NEW\r\n" + 
				"		  AS <>\r\n" + 
				"SELECT * FROM ${MART_NCMO_DB}.BI_FM_EXPN_NON_OP_DTL<> WITH NO DATA";
		String a45 = "CREATE TABLE IF NOT EXISTS ${MART_NCMO_DB}.BI_FM_EXPN_NON_OP_DTL_NEW\r\n" + 
				"(LIKE <>\r\n" + 
				"SELECT * FROM ${MART_NCMO_DB}.BI_FM_EXPN_NON_OP_DTL<> )";
		String r45 = GreemPlumTranslater.ddl.changeCreateTableIfNotExist(q45);
//		System.out.println(r45);
		System.out.println("CASE 45 : "+a45.equals(r45));
//CASE46_1 : 
		String q46_1 = "DROP TABLE ${MART_NCMO_DB}.BI_FM_EXPN_NON_OP_DTL\r\n;";
		String a46_1 = "DROP TABLE IF EXISTS ${MART_NCMO_DB}.BI_FM_EXPN_NON_OP_DTL;";
		System.out.println("CASE 461: "+a46_1.equals(GreemPlumTranslater.ddl.changeDropTableIfExist(q46_1)));
//CASE46_2 : 
		String q46_2 = "RENAME TABLE ${MART_NCMO_DB}.BI_FM_EXPN_NON_OP_DTL_NEW\r\n" + 
				"		  TO ${MART_NCMO_DB}.BI_FM_EXPN_NON_OP_DTL\r\n" + 
				";";
		String a46_2 = "ALTER TABLE ${MART_NCMO_DB}.BI_FM_EXPN_NON_OP_DTL_NEW\r\n" + 
				"RENAME TO BI_FM_EXPN_NON_OP_DTL;";
		String r46_2 = GreemPlumTranslater.ddl.changeRenameTable(q46_2);
//		System.out.println(r46_2);
		System.out.println("CASE 462: "+a46_2.equals(r46_2));
//CASE47 : 
//		String q47 = "";
//		String a47 = "";
//		System.out.println("CASE 47 : "+a47.equals(GreemPlumTranslater.sql.easyReplase(q47)));
//CASE48 : 
//		String q48 = "";
//		String a48 = "";
//		System.out.println("CASE 48 : "+a48.equals(GreemPlumTranslater.sql.easyReplase(q48)));
//CASE49 : 
//		String q49 = "";
//		String a49 = "";
//		System.out.println("CASE 49 : "+a49.equals(GreemPlumTranslater.sql.easyReplase(q49)));
//CASE50 : 
//		String q50 = "";
//		String a50 = "";
//		System.out.println("CASE 50 : "+a50.equals(GreemPlumTranslater.sql.easyReplase(q50)));
//CASE51 : 
//		String q51 = "";
//		String a51 = "";
//		System.out.println("CASE 51 : "+a51.equals(GreemPlumTranslater.sql.easyReplase(q51)));
//CASE52 : 
//		String q52 = "";
//		String a52 = "";
//		System.out.println("CASE 52 : "+a52.equals(GreemPlumTranslater.sql.easyReplase(q52)));
//CASE53 : 
//		String q53 = "";
//		String a53 = "";
//		System.out.println("CASE 53 : "+a53.equals(GreemPlumTranslater.sql.easyReplase(q53)));

	}
	
}
