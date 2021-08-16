package com.libm.dao;

import com.libm.dao.InsertRet;

import java.sql.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.Vector;

//用于访问数据库的类，包含所需各静态方法，不允许实例化。
public class Dao {
	protected static String dbClassName = "com.mysql.cj.jdbc.Driver";
	protected static String dbUrl = "jdbc:mysql://localhost:3306/Library?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
	protected static String dbUser = "root";
	protected static String dbPwd = "9144567mysql";
	protected static String second = null;
	public static Connection conn = null;
	// 连接数据库
	static {
		try {
			if (conn == null) {
				Class.forName(dbClassName);
				conn = DriverManager.getConnection(dbUrl, dbUser, dbPwd);
			}
		} catch (Exception ee) {
			ee.printStackTrace();
		}
	}

	// 禁止实例化
	private Dao() {
	}

	// 进行指定查询并返回一个结果集
	public static ResultSet findForResultSet(String sql) {
		if (conn == null)
			return null;
		long time = System.currentTimeMillis();
		ResultSet rs = null;
		try {
			Statement stmt = null;
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			second = ((System.currentTimeMillis() - time) / 1000d) + "";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}

	// 进行指定插入，返回成功与否
	public static boolean insert(String sql) {
		boolean result = false;
		try {
			Statement stmt = conn.createStatement();
			result = (stmt.executeUpdate(sql) > 0);// 插入的数量比0多，则为成功
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	// 进行指定数据库修改，返回涉及的行数
	public static int update(String sql) {
		int result = 0;
		try {
			Statement stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	// 得到多行，作为一个列表，
	// 成员是列表，成员的成员是字符串，内容是属性的值，深度根据表属性自动调整
	public static List<List<String>> findForList(String sql) {
		List<List<String>> list = new ArrayList<List<String>>();
		ResultSet rs = findForResultSet(sql);
		try {
			ResultSetMetaData metaData = rs.getMetaData();
			int colCount = metaData.getColumnCount();
			//打包每一行并添加到总表
			while (rs.next()) {
				List<String> row = new ArrayList<String>();
				for (int i = 1; i <= colCount; i++) {
					String str = rs.getString(i);
					if (str != null && !str.isEmpty())
						str = str.trim();
					row.add(str);
				}
				list.add(row);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 得到多行，是一个二维列表，
	// 成员是列表，成员的成员是字符串，内容是属性的值，深度根据表属性自动调整
	public static Vector<Vector<String>> findForVector(String sql) {
		Vector<Vector<String>> ret = new Vector<Vector<String>>();
		ResultSet rs = findForResultSet(sql);
		try {
			ResultSetMetaData metaData = rs.getMetaData();
			int colCount = metaData.getColumnCount();
			//打包每一行并添加到总表
			while (rs.next()) {
				Vector<String> row = new Vector<String>(colCount);
				for (int i = 1; i <= colCount; i++) {
					String str = rs.getString(i);
					if (str != null && !str.isEmpty())
						str = str.trim();
					row.add(str);
				}
				ret.add(row);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}

	//得到某表的最大id属性
	public static int getMaxID(String table) {
		String idName = table + "_ID";
		String sqlstr = "select max(" + idName + ") from library." + table + ";";
		ResultSet res = findForResultSet(sqlstr);
		String mID = null;
		try {
			res.next();
			mID = res.getString(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (mID == null) {
			mID = "0";
		}
		int iMID = Integer.parseInt(mID);
		return iMID;
	}

	// 得到最大书籍编号
	public static int getMaxBookID() {
		return getMaxID("book");
	}

	// 得到最大读者编号
	public static int getMaxReaderID() {
		return getMaxID("reader");
	}

	// 单一属性值查询
	public static List<List<String>> getInfoBySingleAttri(String tableName, String attri, String value) {
		String sqlstr = "select * from library." + tableName.trim() + " where " + attri + " = " + value + ";";
		List<List<String>> ret = findForList(sqlstr);
		return ret;
	}

	// 范围属性值查询
	public static List<List<String>> getInfoByRangeAttri(String tableName, String attri, String valueBegin, String valueEnd) {
		String sqlstr = "select * from library." + tableName.trim() + " where (" + attri + " >= " + valueBegin + "and"
				+ attri + "<=" + valueEnd + ");";
		List<List<String>> ret = findForList(sqlstr);
		return ret;
	}

	// 条件语句查询
	public static List<List<String>> getInfoByCondi(String tableName, String condi) {
		String sqlstr = "select * from library." + tableName.trim() + " where (" + condi + ");";
		List<List<String>> ret = findForList(sqlstr);
		return ret;
	}

	// 添加读者
	public static InsertRet addReader(String rName) {
		int rId = getMaxReaderID();
		rId = rId + 1;
		String rID = Integer.toString(rId);

		String sqlstr = "insert into `library`.`reader` (`reader_name`, `reader_ID`) values('" + rName + "', '" + rID
				+ "');";
		boolean done = insert(sqlstr);
		InsertRet ret = new InsertRet(done, rId);
		return ret;
	}

	// 添加书籍
	public static InsertRet addBook(String bName, String bWName, String ISBN, String bPublisher, String bYear) {
		int bId = getMaxBookID();
		bId = bId + 1;
		String bID = Integer.toString(bId);
		Vector<String> attris = new Vector<String>(3);

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
		// System.out.println(sqlstr);
		boolean done = insert(sqlstr);
		InsertRet ret = new InsertRet(done, bId);
		return ret;
	}

	// 借书
	public static boolean addBorrowing(String rID, String bID) {
		String sqlstr = "insert into `library`.`borrowing` (`book_ID`, `reader_ID`) values('" + bID + "', '" + rID
				+ "');";
		// System.out.println(sqlstr);
		return insert(sqlstr);
	}

	// 还书
	public static int delBorrowing(String rID, String bID) {
		String sqlstr = "delete from `library`.`borrowing` where (book_ID = " + bID + " and " + "reader_ID = " + rID
				+ ");";
		// System.out.println(sqlstr);
		return update(sqlstr);
	}

	// 根据一般搜索书籍窗口的控制信息生成用于搜索的条件字符串
	public static String searchBookStr(int ch, int ch1, int ch2, int ch3, int ch4, int ch5, int ch10, int ch11,
			int ch12, int ch13, int ch14, int ch15, String cd, String cd1, String cd2, String cd3, String cd4,
			String cd5) {
		String ret = "select * from library.book";
		if (cd.length() == 0 && cd1.length() == 0 && cd2.length() == 0 && cd3.length() == 0 && cd4.length() == 0
				&& cd5.length() == 0) {
			ret += ";";
			return ret;
		} else {
			ret += " where ( ";
		}
		int[] chs0 = { ch, ch1, ch2, ch3, ch4, ch5 };
		int[] chs1 = { ch10, ch11, ch12, ch13, ch14, ch15 };
		String[] cds = { cd, cd1, cd2, cd3, cd4, cd5 };
		boolean cdUsed = false;

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
		ret += " );";

		return ret;
	}

	// 根据编号给出书籍的属性名
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

	// 根据一般搜索读者窗口的控制信息生成用于搜索的条件字符串
	public static String searchReaderStr(int ch, int ch1, int ch10, int ch11, String cd, String cd1) {
		// reader name", "reader ID", "book ID", "book name", "book ISBN"
		String ret = "select * from library.reader";
		if (cd.length() == 0 && cd1.length() == 0) {
			ret += ";";
			return ret;
		} else {
			ret += " where ( ";
		}
		int[] chs0 = { ch, ch1 };
		int[] chs1 = { ch10, ch11 };
		String[] cds = { cd, cd1 };
		boolean cdUsed = false;

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

	// 根据编号给出读者的属性名
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
	public static String checkBorrowingStr(int ch, int ch1, int ch2, int ch3, int ch4, int ch5, int ch6, int ch7,
			int ch10, int ch11, int ch12, int ch13, int ch14, int ch15, int ch16, int ch17, String cd, String cd1,
			String cd2, String cd3, String cd4, String cd5, String cd6, String cd7) {
		String ret = "select library.reader.reader_name,library.reader.reader_ID,library.book.book_ID,library.book.book_name,library.book.ISBN from library.book,library.reader,library.borrowing";
		ret += " where( library.book.book_ID=library.borrowing.book_ID and library.reader.reader_ID=library.borrowing.reader_ID )";
		if (cd.length() == 0 && cd1.length() == 0 && cd2.length() == 0 && cd3.length() == 0 && cd4.length() == 0
				&& cd5.length() == 0 && cd6.length() == 0 && cd7.length() == 0) {
			ret += ";";
			return ret;
		} else {
			ret += " and ( ";
		}
		int[] chs0 = { ch, ch1, ch2, ch3, ch4, ch5, ch6, ch7 };
		int[] chs1 = { ch10, ch11, ch12, ch13, ch14, ch15, ch16, ch17 };
		String[] cds = { cd, cd1, cd2, cd3, cd4, cd5, cd6, cd7 };
		boolean cdUsed = false;

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

	// 根据编号给出读者和书籍的属性名
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