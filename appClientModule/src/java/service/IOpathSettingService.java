package src.java.service;

import src.java.params.BasicParams;

public class IOpathSettingService {
	//讀黨產黨路徑設定
	public static void setPath(String input,String output){
		BasicParams.setInputPath(input);
		BasicParams.setOutputPath(output);
	}
}