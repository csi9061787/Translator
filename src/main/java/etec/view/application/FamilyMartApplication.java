package etec.view.application;

import etec.src.sql.az.controller.FamilyMartController;
import etec.view.frame.SearchFunctionFrame;

public class FamilyMartApplication {
	public static void run() {
		new SearchFunctionFrame("全家轉換",new FamilyMartController());
	}
}