REPLACE PROCEDURE PMART.MGA_1_5_RPT_FUNC
(
	IN P_TIME_ID INTEGER,
	IN P_ORG_ID INTEGER
)
SQL SECURITY INVOKER
SP:BEGIN
	DECLARE SQLSTR  VARCHAR(8000) DEFAULT ''; 
	DECLARE V_TIME_ID  INTEGER; 
	CALL PMART.P_DROP_TABLE ('#VT_MGA_1_5_TEMP'); 
	CALL PMART.P_DROP_TABLE ('#VT_MGA_1_5_RPT_FUNC'); 
	SET V_TIME_ID = P_TIME_ID / 100;
	SET SQLSTR = 
		'CREATE MULTISET VOLATILE TABLE #VT_MGA_1_5_TEMP AS('+            
			'SELECT  '+
			'''GP1'' AS GP_ID '+
			',A.DD01 '+
			',A.DD02 '+
			',A.DD03 '+
			',A.DD04 '+
			',A.DD05 '+
			',A.DD06 '+
			',A.DD07 '+
			',A.DD08 '+
			',A.DD09 '+
			',A.DD10 '+
			',A.DD11 '+
			',A.DD12 '+
			',A.DD13 '+
			',A.DD14 '+
			',A.DD_SUM '+
			',A.DR01 '+
			',A.DR02 '+
			',A.DR03 '+
			',A.DR04 '+
			',A.DR05 '+
			',A.DR06 '+
			',A.DR07 '+
			',A.DR08 '+
			',A.DR09 '+
			',A.DR10 '+
			',A.DR11 '+
			',A.DR12 '+
			',A.DR13 '+
			',A.DR14 '+
			',A.DR_SUM '+
			'FROM PMART.MGA_1_5_REMD_DEPT A  '+
			'WHERE A.TIME_ID = '+ V_TIME_ID +' '+
			'AND A.ORG_ID = '+ P_ORG_ID +' '+
			'AND A.DD_SUM IS NOT NULL '+
			'UNION '+
			'SELECT  '+
			'''GP2'' AS GP_ID '+
			',A.DD01 '+
			',A.DD02 '+
			',A.DD03 '+
			',A.DD04 '+
			',A.DD05 '+
			',A.DD06 '+
			',A.DD07 '+
			',A.DD08 '+
			',A.DD09 '+
			',A.DD10 '+
			',A.DD11 '+
			',A.DD12 '+
			',A.DD13 '+
			',A.DD14 '+
			',A.DD_SUM '+
			',A.DR01 '+
			',A.DR02 '+
			',A.DR03 '+
			',A.DR04 '+
			',A.DR05 '+
			',A.DR06 '+
			',A.DR07 '+
			',A.DR08 '+
			',A.DR09 '+
			',A.DR10 '+
			',A.DR11 '+
			',A.DR12 '+
			',A.DR13 '+
			',A.DR14 '+
			',A.DR_SUM '+
			'FROM PMART.MGA_1_5_REMD_DEPT A  '+
			'WHERE A.TIME_ID = '+ P_TIME_ID +' '+
			'AND A.ORG_ID = '+ P_ORG_ID +' '+
			'AND A.DD_SUM IS NOT NULL '+
		') WITH DATA PRIMARY INDEX(GP_ID) ON COMMIT PRESERVE ROWS;';
    EXECUTE IMMEDIATE SQLSTR; 
	SET SQLSTR = 
		'CREATE MULTISET VOLATILE TABLE #VT_MGA_1_5_RPT_FUNC AS('+          
			'SELECT GP_ID+''_DD'' AS GP_NAME '+
			',CAST(DD01 AS DECIMAL(14,2)) AS DD01 '+
			',CAST(DD02 AS DECIMAL(14,2)) AS DD02 '+
			',CAST(DD03 AS DECIMAL(14,2)) AS DD03 '+
			',CAST(DD04 AS DECIMAL(14,2)) AS DD04 '+
			',CAST(DD05 AS DECIMAL(14,2)) AS DD05 '+
			',CAST(DD06 AS DECIMAL(14,2)) AS DD06 '+
			',CAST(DD07 AS DECIMAL(14,2)) AS DD07 '+
			',CAST(DD08 AS DECIMAL(14,2)) AS DD08 '+
			',CAST(DD09 AS DECIMAL(14,2)) AS DD09 '+
			',CAST(DD10 AS DECIMAL(14,2)) AS DD10 '+
			',CAST(DD11 AS DECIMAL(14,2)) AS DD11 '+
			',CAST(DD12 AS DECIMAL(14,2)) AS DD12 '+
			',CAST(DD13 AS DECIMAL(14,2)) AS DD13 '+
			',CAST(DD14 AS DECIMAL(14,2)) AS DD14 '+
			',CAST(DD_SUM AS DECIMAL(14,2)) AS DD_SUM '+
			'FROM #VT_MGA_1_5_TEMP  '+
			'UNION  '+
			'SELECT GP_ID+''_DR'' AS GP_NAME '+
			',CAST(DR01 AS DECIMAL(14,2)) AS DR01 '+
			',CAST(DR02 AS DECIMAL(14,2)) AS DR02 '+
			',CAST(DR03 AS DECIMAL(14,2)) AS DR03 '+
			',CAST(DR04 AS DECIMAL(14,2)) AS DR04 '+
			',CAST(DR05 AS DECIMAL(14,2)) AS DR05 '+
			',CAST(DR06 AS DECIMAL(14,2)) AS DR06 '+
			',CAST(DR07 AS DECIMAL(14,2)) AS DR07 '+
			',CAST(DR08 AS DECIMAL(14,2)) AS DR08 '+
			',CAST(DR09 AS DECIMAL(14,2)) AS DR09 '+
			',CAST(DR10 AS DECIMAL(14,2)) AS DR10 '+
			',CAST(DR11 AS DECIMAL(14,2)) AS DR11 '+
			',CAST(DR12 AS DECIMAL(14,2)) AS DR12 '+
			',CAST(DR13 AS DECIMAL(14,2)) AS DR13 '+
			',CAST(DR14 AS DECIMAL(14,2)) AS DR14 '+
			',CAST(DR_SUM AS DECIMAL(14,2)) AS DR_SUM '+
			'FROM #VT_MGA_1_5_TEMP  '+
		') WITH DATA NO PRIMARY INDEX ON COMMIT PRESERVE ROWS;';
    EXECUTE IMMEDIATE SQLSTR; 
END SP;