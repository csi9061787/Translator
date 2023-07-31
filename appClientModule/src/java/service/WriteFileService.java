package src.java.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import etec.common.enums.RunStatusEnum;
import src.java.element.WriteFileElement;
import src.java.params.BasicParams;

public class WriteFileService {
	public static void writeFile() {
		try {
			List<File> lf = BasicParams.getListFile();
			String rootPath = BasicParams.getInputPath();
			String targetPath = BasicParams.getOutputPath();
			WriteFileElement.setLog("產檔開始...");
			WriteFileElement.setStatus(RunStatusEnum.WORKING);
			WriteFileElement.setLog("原始目錄：" + rootPath);
			WriteFileElement.setLog("目標目錄：" + targetPath);
			int cntf = lf.size();
			int i = 0;
			for (File f : lf) {
				i++;
				// 讀檔案
				WriteFileElement.setLog("讀取檔案：" + f.getPath());
				// 置換
				FileTransduceService.run(f);
				// 寫檔案
				WriteFileElement.setLog("產製檔案：" + BasicParams.getTargetFileNm(f.getPath()));
				WriteFileElement.setProgressBar(i * 100 / cntf);
			}
			WriteFileElement.setLog("產生完成");
			WriteFileElement.setStatus(RunStatusEnum.SUCCESS);
		} catch (IOException e) {
			WriteFileElement.setLog("產生失敗");
			WriteFileElement.setStatus(RunStatusEnum.FAIL);
			e.printStackTrace();
		}
	}
}