package src.java.transducer;

import java.io.IOException;
import java.util.List;

import etec.common.utils.RegexTool;

public class DDLTransducer {
	// create table
	public static String runCreateTable(String sql) throws IOException {
		// create語法轉換
		String create = sql;
		create = replaceCreateTitle(create);
		create = replaceTDsql(create);
		create = replaceColumn(create);
		create = create.trim();
		// Index語法轉換
		String with = addWith(sql);
		// drop if exist
		String drop = "";
		create = drop + create+with+"\r\n;";
		return create;
	}
	// CTAS
	public static String runCTAS(String sql) throws IOException {
		String res = "";
		String create = "";
		String select = "";
		String with = "";
		// create
		create = RegexTool.getRegexTarget("CREATE(\\s+VOLATILE)?\\s+TABLE\\s+\\S+", sql).get(0).replaceAll("\\s+VOLATILE\\s+", " ");
		// with
		List<String> lstPrimaryIndex = RegexTool.getRegexTarget("UNIQUE\\s+PRIMARY\\s+INDEX\\s+\\([^\\)]+\\)", sql);
		List<String> lstIndex = RegexTool.getRegexTarget("PRIMARY\\s+INDEX\\s+\\([^\\)]+\\)", sql);
		String column = "";
		if (!lstPrimaryIndex.isEmpty()) {
			String indexCol = lstPrimaryIndex.get(0).replaceAll("UNIQUE\\s+PRIMARY\\s+INDEX\\s+\\(", "")
					.replaceAll("\\)", "").replaceAll("\\s", "").trim();
			column += indexCol;
		}
		if (!lstIndex.isEmpty()) {
			if (!lstPrimaryIndex.isEmpty()) {
				column += ",";
			}
			String indexCol = lstIndex.get(0).replaceAll("PRIMARY\\s+INDEX\\s+\\(", "").replaceAll("\\)", "")
					.replaceAll("\\s", "").trim();
			column += indexCol;
		}
		String hash = "DISTRIBUTION = " + ("".equals(column) ? "REPLICATE" : "HASH(" + column + ")");
		with = "WITH (" + "\r\n\tCLUSTERED COLUMNSTORE INDEX," + "\r\n\t" + hash + "\r\n)";
		// select
		String oldselect = sql
				.replaceAll("CREATE(\\s+VOLATILE)?\\s+TABLE\\s+\\S+\\s+AS\\s*\\(", "")
				.replaceAll("\\)\\s*WITH\\s+DATA\\s*[^;]+", "")
				.replaceAll("TtEeSsTt", "%;%").trim();
		select = DQLTransducer.transduceSelectSQL(oldselect);
		res = create.trim() + "\r\n" + with.trim() + "\r\nAS\r\n" + select.trim()+"\r\n;";
		return res;
	}
	// create table
	public static String runDropTable(String sql) throws IOException {
		String res = "";
		sql = sql.replaceAll(";", "");
		String tableNm = sql.replaceAll("DROP\\s+TABLE", "").trim();
		tableNm = tableNm.replace("#", "tempdb..#");
		res = "\r\nIF OBJECT_ID(N'" + tableNm + "') IS NOT NULL \r\n" + "DROP TABLE " + tableNm + ";\r\n";
		return res;
	}
	// ReplaceView
	public static String runReplaceView(String sql) throws IOException {
		String res = "";
		res = sql.replaceAll("REPLACE\\s+VIEW", "ALTER VIEW")+ "\r\n;";
		return res;
	}
	// 轉換create table
	private static String replaceCreateTitle(String sql) {
		String result = sql.replaceAll("\\s*,\\s*NO\\s*FALLBACK\\s*", " ")
				.replaceAll("\\s*,\\s*NO\\s*[A-Za-z]+\\s*JOURNAL\\s*", " ")
				.replaceAll("\\s*,\\s*CHECKSUM\\s*=\\s*[A-Za-z]+\\s*", " ")
				.replaceAll("\\s*,\\s*DEFAULT\\s*MERGEBLOCKRATIO\\s*", " ").replaceAll("CHARACTER SET \\S+", " ")
				.replaceAll("(NOT\\s+)?CASESPECIFIC", " ").replaceAll("TITLE\\s+'[^']+'", " ");
		return result;
	}
	// 轉換 index with
	private static String addWith(String sql) {
		String result = "\r\nWITH (" + "\r\n\tCLUSTERED COLUMNSTORE INDEX,";
		String temp = sql.toUpperCase();
		// 取得欄位
		List<String> lstPrimaryIndex = RegexTool.getRegexTarget("UNIQUE\\s+PRIMARY\\s+INDEX\\s+\\([^\\)]+\\)", temp);
		temp = temp.replaceAll("UNIQUE\\s+PRIMARY\\s+INDEX\\s+\\([^\\)]+\\)", "");
		List<String> lstIndex = RegexTool.getRegexTarget("PRIMARY\\s+INDEX\\s+\\([^\\)]+\\)", temp);
		// 添加欄位
		String column = "";
		if (!lstPrimaryIndex.isEmpty()) {
			String indexCol = lstPrimaryIndex.get(0).replaceAll("UNIQUE\\s+PRIMARY\\s+INDEX\\s+\\(", "")
					.replaceAll("\\)", "").replaceAll("\\s", "").trim();
			column += indexCol;
		}
		if (!lstIndex.isEmpty()) {
			if (!lstPrimaryIndex.isEmpty()) {
				column += ",";
			}
			String indexCol = lstIndex.get(0).replaceAll("PRIMARY\\s+INDEX\\s+\\(", "").replaceAll("\\)", "")
					.replaceAll("\\s", "").trim();
			column += indexCol;
		}
		String hash = "\r\n\tDISTRIBUTION = " + ("".equals(column) ? "REPLICATE" : "HASH(" + column + ")");
		result += hash + "\r\n)";
		return result;
	}
	// 清除TD特有的語法
	private static String replaceTDsql(String sql) {
		String result = sql.replaceAll(RegexTool.getReg("CREATE MULTISET TABLE"), "CREATE TABLE")// MULTISET
				.replaceAll(RegexTool.getReg("CREATE SET TABLE"), "CREATE TABLE")// SET TABLE
				.replaceAll("(UNIQUE\\s+)?(PRIMARY\\s+)?INDEX\\s+\\([^\\)]+\\)", " ")// UNIQUE PRIMARY INDEX
				.replaceAll(RegexTool.getReg("NO PRIMARY INDEX"), "")
				.replaceAll(RegexTool.getReg("RANGE_N") + "\\s*\\([^\\)]+\\)", " ")// PARTITION BY
				.replaceAll(RegexTool.getReg("PARTITION BY") + "(\\s*\\([^\\)]*\\))?", " ")// PARTITION BY
		;
		return result;
	}
	// 清除欄位的多餘設定
	private static String replaceColumn(String sql) {
		String result = sql.replaceAll("CHARACTER SET \\S+", " ").replaceAll("NOT CASESPECIFIC", " ")
				.replaceAll("TITLE\\s+'[^']+'", " ").replaceAll("\\s*FORMAT\\s+'[^']+'\\s*", " ")
				.replaceAll("TIMESTAMP\\s*\\(\\s*[0-9]+\\s*\\)", "DATETIME").replaceAll("VARBYTE", "VARBINARY")
				.replaceAll(" +,", ",");
		return result;
	}
}
