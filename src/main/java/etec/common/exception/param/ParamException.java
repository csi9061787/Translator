package etec.common.exception.param;

/**
 * <h1>環境參數的父類別</h1>
 * <p></p>
 * <p></p>
 * 
 * <br>2024年2月17日	User	建立功能
 * 
 * @author	Tim
 * @since	1.0.0.0
 */
public class ParamException extends RuntimeException{

	public ParamException(String script) {
		super(script);
	}

	private static final long serialVersionUID = 1L;

	
}
