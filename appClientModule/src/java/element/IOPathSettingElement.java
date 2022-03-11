package src.java.element;

import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JLabel;
import javax.swing.JTextField;

public class IOPathSettingElement {
	// 物件
	public static JFileChooser fcIp;
	public static JFileChooser fcOp;
	public static JButton btnIp;
	public static JButton btnOp;
	public static JButton btnSub;
	public static JTextField tfIp;
	public static JTextField tfOp;
	public static JLabel lblIp;
	public static JLabel lblOp;
	
	public static void init() {
		fcIp = new JFileChooser();
		fcOp = new JFileChooser();
		tfIp = new JTextField(50);
		tfOp = new JTextField(50);
		btnIp = new JButton("路徑");
		btnOp = new JButton("路徑");
		btnSub = new JButton("確認");
		lblIp = new JLabel("來源路徑:");
		lblOp = new JLabel("產檔路徑:");
	}
}
