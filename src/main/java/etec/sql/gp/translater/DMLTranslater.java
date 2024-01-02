package etec.sql.gp.translater;

import etec.common.exception.UnknowSQLTypeException;

public class DMLTranslater {
	/**
	 * @author	Tim
	 * @since	2023年12月5日
	 * 
	 * DELETE TABLE 要加上 USING
	 * 
	 * */
	public String changeDeleteTableUsing(String sql) {
		String res = sql
			.replaceAll("(?i)DELETE\\s+FROM\\s+(\\S+)(\\s+\\S+)?\\s*,", "DELETE FROM $1$2\r\n USING ")//Locking
			;
		return res;
	}
	/**
	 * @author	Tim
	 * @throws UnknowSQLTypeException 
	 * @since	2023年12月26日
	 * 
	 * INSERT SELECT語法轉換
	 * 
	 * 
	 * */
	public String changeInsertSelect(String sql) throws UnknowSQLTypeException {
		String res = "";
		String insert = sql.replaceAll("(?i)(\\s*INSERT\\s+INTO\\s+\\S+\\s+)[\\S\\s]+", "$1");
		String select = sql.replaceAll("(?i)(\\s*INSERT\\s+INTO\\s+\\S+\\s+)", "");
		select = GreemPlumTranslater.dql.easyReplace(select);
		res = insert+select;
		return res;
	}
}
