package priv.lahelr.onlinelib.client.dao;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.sql.rowset.CachedRowSet;

import priv.lahelr.onlinelib.client.netlink.Netlink;
import priv.lahelr.onlinelib.client.utils.Utils;
import priv.lahelr.onlinelib.netlink.Message;
import priv.lahelr.onlinelib.netlink.SQLCmdType;

/**
 * Static class for accessing database over internet and processing data.<br>
 * No instantiation is allowed.
 * 
 * @author lahelr
 *
 */
public class Dao {

	/**
	 * private ctor so you can't instantiate it.
	 */
	private Dao() {
	}

	/**
	 * Do specified sql command and get a ResultSet from server<br>
	 * BLOCK UNTIL SERVER ANSWERS or exception occurs.
	 * 
	 * @param sql:String
	 * @return the ResultSet, or null, if any error occurs
	 */
	public static ResultSet findForResultSet(String sql) {
		// the message to be sent to the server.
		Message<String> msgToBeSent = new Message<String>(sql, SQLCmdType.findForResultSet);
		Netlink.sendMessage(msgToBeSent);// send it.
		Message<?> msgGot = Netlink.getMessage();// get the server answer.
		ResultSet ret = null;// what to return.

		if (!((msgGot.contentClassStr.equals(CachedRowSet.class.getName()))
				|| (msgGot.contentClassStr.equals("com.sun.rowset.CachedRowSetImpl")))) {
			// if it isn't a CachedRowSet Object.
			if ((msgGot.contentClassStr.equals(String.class.getName()))) {
				// a String means server sent a warning or error.
				Utils.showAlert(String.format("Notice from the server:%s.", (String) msgGot.content));
			} else {
				// something strange sent from the server.
				Utils.showError(String.format("Strange message from server:\n%s", msgGot.toString()));
			}
		} else {
			// it is a CachedRowSet Object.
			try {
				ret = ((CachedRowSet) (msgGot.content)).getOriginal(); // cast to ResultSet
			} catch (SQLException e) {
				// error
				Utils.showError(
						String.format("Error while casting RowSet to ResultSet:\n%s", Utils.sprintStackTrace(e)));
			}
		}
		return ret;
	}

	/**
	 * Do the insertion specified by the SQL command
	 * 
	 * @param sql : String, the sql command
	 * @return if the insertion successed
	 */
	public static boolean insert(String sql) {
		// send the sql
		Message<String> msgToBeSent = new Message<String>(sql, SQLCmdType.insert);
		Netlink.sendMessage(msgToBeSent);
		// get the sql
		Message<?> msgGot = Netlink.getMessage();

		if (msgGot.contentClassStr.equals(boolean.class.getName())
				|| msgGot.contentClassStr.equals(Boolean.class.getName())) {
			boolean ret = (Boolean) (msgGot.content);
			return ret;
		} else {
			if ((msgGot.contentClassStr.equals(String.class.getName()))) {
				// a String means server sent a warning or error.
				Utils.showAlert(String.format("Notice from the server:%s.", (String) msgGot.content));
			} else {
				// something strange sent from the server.
				Utils.showError(String.format("Strange message from server:\n%s", msgGot.toString()));
			}
			return false;
		}
	}

	/**
	 * Do the database update specified by the sql command
	 * 
	 * @param sql: String, the sql command
	 * @return how many lines has been updated
	 */
	public static int update(String sql) {
		// send the sql to server
		Message<String> msgToBeSent = new Message<String>(sql, SQLCmdType.update);
		Netlink.sendMessage(msgToBeSent);
		Message<?> msgGot = Netlink.getMessage();// get the server's answer
		if (msgGot.contentClassStr.equals(int.class.getName())
				|| msgGot.contentClassStr.equals(Integer.class.getName())) {
			int ret = (Integer) (msgGot.content);
			return ret;
		} else {
			if ((msgGot.contentClassStr.equals(String.class.getName()))) {
				// a String means server sent a warning or error.
				Utils.showAlert(String.format("Notice from the server:%s.", (String) msgGot.content));
			} else {
				// something strange sent from the server.
				Utils.showError(String.format("Strange message from server:\n%s", msgGot.toString()));
			}
			return 0;
		}
	}

	/**
	 * Get a list of lists of Strings, searched from the db on server<br>
	 * The content of this 2-d matrix is the value of the attributes.
	 * 
	 * @param sql: String, the sql command
	 * @return what we found from the server
	 */
	public static List<List<String>> findForList(String sql) {
		List<List<String>> list = new ArrayList<List<String>>();// prepare the matrix
		// do the query
		ResultSet rs = findForResultSet(sql);
		if(rs == null)
		{
			Utils.showAlert(String.format("find for list failed from %s.", sql));
			return list;
		}
		try {
			ResultSetMetaData metaData = rs.getMetaData();
			int colCount = metaData.getColumnCount();
			// package each line into the matrix
			while (rs.next()) {
				List<String> row = new ArrayList<String>();
				// fot each entry of the line
				for (int i = 1; i <= colCount; i++) {
					String str = rs.getString(i);
					if (str != null && !str.isEmpty())
						str = str.trim();
					row.add(str);
				}
				list.add(row);
			}
		} catch (Exception e) {
			Utils.showAlert(String.format("find for list failed from %s:\n%s", sql, Utils.sprintStackTrace(e)));
		}
		return list;
	}

	/**
	 * Get a vector of vectors of Strings, searched from the db on server<br>
	 * The content of this 2-d matrix is the value of the attributes.
	 * 
	 * @param sql: String, the sql command
	 * @return what we found from the server
	 */
	public static Vector<Vector<String>> findForVector(String sql) {
		Vector<Vector<String>> ret = new Vector<Vector<String>>();
		ResultSet rs = findForResultSet(sql);
		if(rs == null)
		{
			Utils.showAlert(String.format("find for vector failed from %s.", sql));
			return ret;
		}
		try {
			ResultSetMetaData metaData = rs.getMetaData();
			int colCount = metaData.getColumnCount();
			// package each line into the matrix
			while (rs.next()) {
				Vector<String> row = new Vector<String>(colCount);
				for (int i = 1; i <= colCount; i++) {
					// for each entry in this line
					String str = rs.getString(i);
					if (str != null && !str.isEmpty())
						str = str.trim();
					row.add(str);
				}
				ret.add(row);
			}
		} catch (Exception e) {
			Utils.showAlert(String.format("find for vector failed from %s:\n%s", sql, Utils.sprintStackTrace(e)));
		}
		return ret;
	}

	/**
	 * get the max id attr of the specified table
	 * 
	 * @param table: String, the table name
	 * @return int, the wanted max id, or -1 if error
	 */
	public static int getMaxID(String table) {
		// gen the sql string
		String idName = table + "_ID";
		String sqlstr = "select max(" + idName + ") from library." + table + ";";
		ResultSet res = findForResultSet(sqlstr);// do the query
		if(res == null)
		{
			Utils.showAlert(String.format("find for max id for table %s failed.", table));
			return -1;
		}
		String mID = null;
		try {
			res.next();
			mID = res.getString(1);
		} catch (SQLException e) {
			Utils.showAlert(String.format("find max id failed from %s:\n%s", sqlstr, Utils.sprintStackTrace(e)));
		}
		if (mID == null) {
			mID = "0";
		}
		int iMID = Integer.parseInt(mID); // parse it to int
		return iMID;
	}

	/**
	 * get the max id of table book
	 * 
	 * @return
	 */
	public static int getMaxBookID() {
		return getMaxID("book");
	}

	/**
	 * get the max id of table reader
	 * 
	 * @return
	 */
	public static int getMaxReaderID() {
		return getMaxID("reader");
	}

	/**
	 * query by one attr
	 * 
	 * @param tableName
	 * @param attri
	 * @param value
	 * @return
	 */
	public static List<List<String>> getInfoBySingleAttri(String tableName, String attri, String value) {
		String sqlstr = "select * from library." + tableName.trim() + " where " + attri + " = " + value + ";";
		List<List<String>> ret = findForList(sqlstr);
		return ret;
	}

	/**
	 * query by a ranged attr
	 * 
	 * @param tableName
	 * @param attri
	 * @param valueBegin
	 * @param valueEnd
	 * @return
	 */
	public static List<List<String>> getInfoByRangeAttri(String tableName, String attri, String valueBegin,
			String valueEnd) {
		String sqlstr = "select * from library." + tableName.trim() + " where (" + attri + " >= " + valueBegin + "and"
				+ attri + "<=" + valueEnd + ");";
		List<List<String>> ret = findForList(sqlstr);
		return ret;
	}

	/**
	 * query by a judge statement
	 * 
	 * @param tableName
	 * @param condi:    the String consists the judge statement
	 * @return
	 */
	public static List<List<String>> getInfoByCondi(String tableName, String condi) {
		String sqlstr = "select * from library." + tableName.trim() + " where (" + condi + ");";
		List<List<String>> ret = findForList(sqlstr);
		return ret;
	}

	/**
	 * add a reader
	 * 
	 * @param rName
	 * @return
	 */
	public static InsertRet addReader(String rName) {
		// get the id of the new one
		int rId = getMaxReaderID();
		if(rId == -1)
		{
			return new InsertRet(false,-1);
		}
		rId = rId + 1;
		String rID = Integer.toString(rId);

		// gen the sql
		String sqlstr = "insert into `library`.`reader` (`reader_name`, `reader_ID`) values('" + rName + "', '" + rID
				+ "');";
		boolean done = insert(sqlstr);
		InsertRet ret = new InsertRet(done, rId);
		return ret;
	}

	/**
	 * add one book
	 * 
	 * @param bName
	 * @param bWName
	 * @param ISBN
	 * @param bPublisher
	 * @param bYear
	 * @return
	 */
	public static InsertRet addBook(String bName, String bWName, String ISBN, String bPublisher, String bYear) {
		// get the id of this book
		int bId = getMaxBookID();
		if(bId == -1)
		{
			return new InsertRet(false,-1);
		}
		bId = bId + 1;
		String bID = Integer.toString(bId);
		Vector<String> attris = new Vector<String>(3);

		// gen the sql
		String sqlstr = "insert into library.book (`book_ID`,`book_name`,`ISBN`";
		if (bWName.length() > 0) {
			attris.add(bWName);
			sqlstr += ",`writer_name`";
		}
		if (bPublisher.length() > 0) {
			attris.add(bPublisher);
			sqlstr += ",`publisher`";
		}
		if (bYear.length() > 0) {
			attris.add(bYear);
			sqlstr += ",`publish_year`";
		}
		sqlstr += (") values('" + bID + "','" + bName + "','" + ISBN + "'");
		for (int i = 0; i < attris.size(); i++) {
			sqlstr += (",'" + attris.get(i) + "'");
		}
		sqlstr += ");";
		// do the insertion
		boolean done = insert(sqlstr);
		// package the return
		InsertRet ret = new InsertRet(done, bId);
		return ret;
	}

	/**
	 * borrowing
	 * 
	 * @param rID
	 * @param bID
	 * @return
	 */
	public static boolean addBorrowing(String rID, String bID) {
		// gen the sql and do the insertion
		String sqlstr = "insert into `library`.`borrowing` (`book_ID`, `reader_ID`) values('" + bID + "', '" + rID
				+ "');";
		return insert(sqlstr);
	}

	/**
	 * returning
	 * 
	 * @param rID
	 * @param bID
	 * @return
	 */
	public static int delBorrowing(String rID, String bID) {
		// gen the sql and do the removing
		String sqlstr = "delete from `library`.`borrowing` where (book_ID = " + bID + " and " + "reader_ID = " + rID
				+ ");";
		return update(sqlstr);
	}

	/**
	 * generate the sql query by the information got by the normal SearchBook window
	 * 
	 * @param ch   the choice of the 0th statement of the 0th col
	 * @param ch1  the choice of the 1st statement of the 0th col
	 * @param ch2  the choice of the 2nd statement of the 0th col
	 * @param ch3  the choice of the 3rd statement of the 0th col
	 * @param ch4  the choice of the 4th statement of the 0th col
	 * @param ch5  the choice of the 5th statement of the 0th col
	 * @param ch10 the choice of the 0th statement of the 1st col
	 * @param ch11 the choice of the 1st statement of the 1st col
	 * @param ch12 the choice of the 2nd statement of the 1st col
	 * @param ch13 the choice of the 3rd statement of the 1st col
	 * @param ch14 the choice of the 4th statement of the 1st col
	 * @param ch15 the choice of the 5th statement of the 1st col
	 * @param cd   the content of the 0th statement
	 * @param cd1  the content of the 1st statement
	 * @param cd2  the content of the 2nd statement
	 * @param cd3  the content of the 3rd statement
	 * @param cd4  the content of the 4th statement
	 * @param cd5  the content of the 5th statement
	 * @return
	 */
	public static String searchBookStr(int ch, int ch1, int ch2, int ch3, int ch4, int ch5, int ch10, int ch11,
			int ch12, int ch13, int ch14, int ch15, String cd, String cd1, String cd2, String cd3, String cd4,
			String cd5) {
		String ret = "select * from library.book";// start of query
		if (cd.length() == 0 && cd1.length() == 0 && cd2.length() == 0 && cd3.length() == 0 && cd4.length() == 0
				&& cd5.length() == 0) {
			// no condition is needed
			ret += ";";
			return ret;
		} else {
			// condition is needed
			ret += " where ( ";
		}
		// packaging
		int[] chs0 = { ch, ch1, ch2, ch3, ch4, ch5 };
		int[] chs1 = { ch10, ch11, ch12, ch13, ch14, ch15 };
		String[] cds = { cd, cd1, cd2, cd3, cd4, cd5 };
		boolean cdUsed = false;

		// link the condition statements
		for (int i = 0; i < 6; i++) {
			if (cds[i].length() == 0) {
				continue;
			}
			if (cdUsed) {
				ret += (chs0[i] == 0) ? " and " : " or ";
			} else {
				cdUsed = true;
			}
			ret += bookAttriCase(chs1[i]);
			ret += " like ";
			if (chs1[i] == 2 || chs1[i] == 5) {
				ret += cds[i];
			} else {
				ret += ("\"" + cds[i] + "\"");
			}

		}
		ret += " );";// finish

		return ret;
	}

	/**
	 * give the name of the attr of table book, by the number of the attr
	 * 
	 * @param index
	 * @return
	 */
	public static String bookAttriCase(int index) {
		String ret = new String();
		switch (index) {
		case 0: {
			ret = "book_name";
			break;
		}
		case 1: {
			ret = "ISBN";
			break;
		}
		case 2: {
			ret = "book_ID";
			break;
		}
		case 3: {
			ret = "writer_name";
			break;
		}
		case 4: {
			ret = "publisher";
			break;
		}
		case 5: {
			ret = "publish_year";
			break;
		}
		}
		return ret;
	}

	/**
	 * generate the sql query string by the information got from the normal
	 * ReaderSearch window
	 * 
	 * @param ch   the choice of the 0th statement of the 0th col
	 * @param ch1  the choice of the 1st statement of the 1st col
	 * @param ch10 the choice of the 0th statement of the 0th col
	 * @param ch11 the choice of the 1st statement of the 1st col
	 * @param cd   the content of the 0th statement
	 * @param cd1  the content of the 1st statement
	 * @return
	 */
	public static String searchReaderStr(int ch, int ch1, int ch10, int ch11, String cd, String cd1) {
		// reader name", "reader ID", "book ID", "book name", "book ISBN"
		String ret = "select * from library.reader";
		if (cd.length() == 0 && cd1.length() == 0) {
			// no statement
			ret += ";";
			return ret;
		} else {
			ret += " where ( ";
		}
		// packaging
		int[] chs0 = { ch, ch1 };
		int[] chs1 = { ch10, ch11 };
		String[] cds = { cd, cd1 };
		boolean cdUsed = false;

		// link the statements
		for (int i = 0; i < 2; i++) {
			if (cds[i].length() == 0) {
				continue;
			}
			if (cdUsed) {
				ret += (chs0[i] == 0) ? " and " : " or ";
			} else {
				cdUsed = true;
			}
			ret += readerAttriCase(chs1[i]);
			ret += " like ";
			if (chs1[i] == 1) {
				ret += cds[i];
			} else {
				ret += ("\"" + cds[i] + "\"");
			}

		}
		ret += " );";

		return ret;
	}

	/**
	 * give the name of the attr of the table reader by the number of the attr
	 * 
	 * @param index
	 * @return
	 */
	public static String readerAttriCase(int index) {
		String ret = new String();
		switch (index) {
		case 0: {
			ret = "library.reader.reader_name";
			break;
		}
		case 1: {
			ret = "library.reader.reader_ID";
			break;
		}
		}
		return ret;
	}

	// 根据检索借阅信息窗口的控制信息生成用于搜索的条件字符串
	/**
	 * generate the sql query string by the infomation got from the SearchBorrowing
	 * window
	 * 
	 * @param ch   the choice of the 0th statement of the 0th col
	 * @param ch1  the choice of the 1st statement of the 0th col
	 * @param ch2  the choice of the 2nd statement of the 0th col
	 * @param ch3  the choice of the 3rd statement of the 0th col
	 * @param ch4  the choice of the 4th statement of the 0th col
	 * @param ch5  the choice of the 5th statement of the 0th col
	 * @param ch6  the choice of the 6th statement of the 0th col
	 * @param ch7  the choice of the 7th statement of the 0th col
	 * @param ch10 the choice of the 0th statement of the 1st col
	 * @param ch11 the choice of the 1st statement of the 1st col
	 * @param ch12 the choice of the 2nd statement of the 1st col
	 * @param ch13 the choice of the 3rd statement of the 1st col
	 * @param ch14 the choice of the 4th statement of the 1st col
	 * @param ch15 the choice of the 5th statement of the 1st col
	 * @param ch16 the choice of the 6th statement of the 1st col
	 * @param ch17 the choice of the 7th statement of the 1st col
	 * @param cd   the content of the 0th statement
	 * @param cd1  the content of the 1st statement
	 * @param cd2  the content of the 2nd statement
	 * @param cd3  the content of the 3rd statement
	 * @param cd4  the content of the 4th statement
	 * @param cd5  the content of the 5th statement
	 * @param cd6  the content of the 6th statement
	 * @param cd7  the content of the 7th statement
	 * @return
	 */
	public static String checkBorrowingStr(int ch, int ch1, int ch2, int ch3, int ch4, int ch5, int ch6, int ch7,
			int ch10, int ch11, int ch12, int ch13, int ch14, int ch15, int ch16, int ch17, String cd, String cd1,
			String cd2, String cd3, String cd4, String cd5, String cd6, String cd7) {
		// the head of the query
		String ret = "select library.reader.reader_name,library.reader.reader_ID,library.book.book_ID,library.book.book_name,library.book.ISBN from library.book,library.reader,library.borrowing";
		ret += " where( library.book.book_ID=library.borrowing.book_ID and library.reader.reader_ID=library.borrowing.reader_ID )";
		if (cd.length() == 0 && cd1.length() == 0 && cd2.length() == 0 && cd3.length() == 0 && cd4.length() == 0
				&& cd5.length() == 0 && cd6.length() == 0 && cd7.length() == 0) {
			// no statement
			ret += ";";
			return ret;
		} else {
			ret += " and ( ";
		}
		// packaging
		int[] chs0 = { ch, ch1, ch2, ch3, ch4, ch5, ch6, ch7 };
		int[] chs1 = { ch10, ch11, ch12, ch13, ch14, ch15, ch16, ch17 };
		String[] cds = { cd, cd1, cd2, cd3, cd4, cd5, cd6, cd7 };
		boolean cdUsed = false;

		// link the statements
		for (int i = 0; i < 8; i++) {
			if (cds[i].length() == 0) {
				continue;
			}
			if (cdUsed) {
				ret += (chs0[i] == 0) ? " and " : " or ";
			} else {
				cdUsed = true;
			}
			ret += allAttriCase(chs1[i]);
			ret += " like ";
			if (chs1[i] == 2 || chs1[i] == 5 || chs1[i] == 6) {
				ret += cds[i];
			} else {
				ret += ("\"" + cds[i] + "\"");
			}

		}
		ret += " );";

		return ret;

	}

	/**
	 * give the name of the attr of the tabel of borrowing by the number of the attr
	 * 
	 * @param index
	 * @return
	 */
	public static String allAttriCase(int index) {
		String ret = new String();
		switch (index) {
		case 0: {
			ret = "book_name";
			break;
		}
		case 1: {
			ret = "ISBN";
			break;
		}
		case 2: {
			ret = "library.book.book_ID";
			break;
		}
		case 3: {
			ret = "writer_name";
			break;
		}
		case 4: {
			ret = "publisher";
			break;
		}
		case 5: {
			ret = "publish_year";
			break;
		}
		case 6: {
			ret = "library.reader.reader_id";
			break;
		}
		case 7: {
			ret = "reader_name";
			break;
		}
		}
		return ret;
	}

}