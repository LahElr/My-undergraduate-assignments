package priv.lahelr.onlinelib.netlink;

/**
 * the message to be transmitted across the internet
 * 
 * @author lahelr
 *
 * @param <T>
 */
public class Message<T> implements java.io.Serializable {
	public int msgType;/// < the type of this message
	public int contentLength;/// < reserved field, no use
	public String contentClassStr;/// < the string contains the type of the content. content.getClass().getName()
	transient public Class<?> contentClass;/// < content.getClass()
	public int cmdType;/// < the type of the sql command (if exist)
	public T content;/// < the content of the message
	private static final long serialVersionUID = 272215825; /// < the serial version uid for distinguish the version of
															/// the object

	/**
	 * default ctor
	 */
	public Message() {
		msgType = MessageType.Content.ordinal();
		contentLength = 0;
		contentClassStr = "null";
		contentClass = null;
		cmdType = SQLCmdType.nocmd.ordinal();
		content = null;
	}

	/**
	 * ctor with a sql query
	 * 
	 * @param sql
	 * @param cmd
	 */
	public Message(T sql, SQLCmdType cmd) {
		if (sql.getClass() == String.class) {
			msgType = MessageType.SQL.ordinal();
			contentLength = ((String) sql).length();
			content = sql;
			contentClassStr = String.class.getName();
			contentClass = String.class;
			cmdType = cmd.ordinal();
		} else {
			content = null;
		}
	}

	/**
	 * ctor with an object to be transmitted
	 * 
	 * @param obj
	 */
	public Message(T obj) {
		contentClassStr = obj.getClass().getName();
		contentClass = obj.getClass();
		msgType = MessageType.Content.ordinal();
		contentLength = 0;
		content = obj;
		cmdType = SQLCmdType.nocmd.ordinal();
	}

	/**
	 * convert the message to string, with all content of it.
	 */
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("Message [msgType=");
		try {
			String msgtypestr = MessageType.values()[msgType].toString();
			sb.append(msgtypestr);
		} catch (IndexOutOfBoundsException e) {
			sb.append(msgType);
		}
		sb.append(", \ncontentLength=");
		sb.append(contentLength);
		sb.append(", \ncontentClassStr=");
		sb.append(contentClassStr);
		sb.append(", \ncontentClass=");
		try {
			String concla = contentClass.getName();
			sb.append(concla);
		} catch (NullPointerException w) {
			sb.append("null");
		}
		sb.append(", \ncmdType=");
		try {
			String msgcmdtype = SQLCmdType.values()[cmdType].toString();
			sb.append(msgcmdtype);
		} catch (IndexOutOfBoundsException e) {
			sb.append(cmdType);
		}
		sb.append(", \ncontent=");
		try {
			String con = content.toString();
			sb.append(con);
		} catch (NullPointerException w) {
			sb.append("null");
		}
		sb.append("\n].");
		return sb.toString();
	}
}
