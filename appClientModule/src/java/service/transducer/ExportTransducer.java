package src.java.service.transducer;

import java.io.IOException;
import java.util.List;

import src.java.params.BasicParams;
import src.java.service.CreateListService;
import src.java.tools.ReadFileTool;
import src.java.tools.RegexTool;
import src.java.tools.TransduceTool;

public class ExportTransducer {
	public static String run(String fn, String fc) throws IOException {
		String result = "Success";
		createSQLFile(fn, fc);
		CreateListService.createExportLst(fn, fc);
		CreateListService.createQualifyRank(fn, fc);
		CreateListService.createWithData(fn, fc);
		return result;
	}
	//SQL轉換產檔
	private static String createSQLFile(String fn, String fc) throws IOException {
		System.out.println("buildExportSQLFile");
		String result = "Success";
		//語法轉換
		List<String> lstSql = RegexTool.getRegexTarget("[Ss][Ee][Ll][Ee][Cc][Tt][^;]*;", fc);
		String content = "\r\nSET NOCOUNT ON;\r\n\r\n";
		for(String sql:lstSql) {
			content += TransduceTool.transduceSelectSQL(sql);
		}
		//產檔
		String file = BasicParams.getTargetFileNm(fn);
		String[] arfn = file.split("\\\\");
		String frn = arfn[arfn.length-1];
		String fnn = "exp_" + frn.replace(".pl", ".sql");
		file = file.replace(frn, fnn);
		ReadFileTool.createFile(file,content);
		return result;
	}
	
}
