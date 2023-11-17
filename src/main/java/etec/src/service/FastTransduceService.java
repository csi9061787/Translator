package etec.src.service;

import java.io.IOException;

import etec.common.enums.SQLTypeEnum;
import etec.common.exception.UnknowSQLTypeException;
import etec.common.utils.TransduceTool;
import etec.src.transducer.DDLTransducer;

/**
 * @author	Tim
 * @since	2023年11月17日
 * @version	3.4.1.1
 * 
 * 全家的城市轉換
 * */
public class FastTransduceService {
	
	/**
	 * @author	Tim
	 * @since	2023年11月17日
	 * 判斷是否為 SET 語句
	 * */
	public static boolean isSetSQL(String script) {
		return script.matches("(?i)SET\\s+@\\S+\\s*=\\s*'[\\S\\s]+");
	}
	/**
	 * @author	Tim
	 * @throws IOException 
	 * @throws UnknowSQLTypeException 
	 * @since	2023年11月13日
	 * @param	boolean	isEncode	true會回傳SET 字串語法 false回傳SQL語句
	 * 
	 * */
	public static String transduceSetExcute(String sql,boolean isEncode,String sqlType) throws UnknowSQLTypeException, IOException {
		String res = sql;
		//將字串轉為SQL
		String paramNm = sql.replaceAll("(?i)SET\\s+([^=\\s]+)\\s*=[\\S\\s]+","$1");
		String script = sql
				.replaceAll("(?i)SET\\s+[^=\\s]+\\s*=\\s*'", "")
				.replaceAll(";\\s*'\\s*;?",";")
				.replaceAll("'\\s*\\+\\s*'","\t\r\n\t")
				.replaceAll("'\\s*\\+\\s*","'+")
				.replaceAll("\\s*\\+\\s*'","+'")
				;
		boolean isCTAS = SQLTypeEnum.CREATE_INSERT.equals(TransduceTool.getSQLType(script));
		script = FamilyMartFileTransduceService.transduceSQLScript(script);
		if(isCTAS&&"ms".equals(sqlType)) {
			script = DDLTransducer.runCTASToSelectInto(script);
		}
		//將SQL轉為字串
		if(isEncode) {
			script = "SET " + paramNm + " = '" + script
					.replaceAll("\r\n", " '\r\n\t+ ' ")
					.replaceAll("\\s*'\\s*\n", " '\r\n")
					.replaceAll("\\s+;", ";';")
					;
		}
		res = script;
		return res;
	}
//case SET_EXECUTE:
//	result = OtherTransducer.transduceSetExcute(result,true);
//	break;
	
//	else if(sql.matches("(?i)SET\\s+@\\S+\\s*=\\s*'[\\S\\s]+")) {
//		res = SQLTypeEnum.SET_EXECUTE;
//	}
}