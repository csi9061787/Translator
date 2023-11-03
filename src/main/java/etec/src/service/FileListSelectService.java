package etec.src.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.swing.DefaultListModel;

import etec.common.model.BasicParams;
import etec.common.utils.FileTool;

public class FileListSelectService {
	//取得檔案清單
	public static DefaultListModel<File> getFileList() throws IOException{
		DefaultListModel<File> dlm = new DefaultListModel<File>();
		List<File> lf = FileTool.getFileList(BasicParams.getInputPath());
		BasicParams.setListFile(lf);
		for (File f : lf) {
			dlm.addElement(f);
		}
		return dlm;
	}
}