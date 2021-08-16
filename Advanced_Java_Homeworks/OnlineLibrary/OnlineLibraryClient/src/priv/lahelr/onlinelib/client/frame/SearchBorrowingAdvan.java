package priv.lahelr.onlinelib.client.frame;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Vector;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.border.EmptyBorder;

import priv.lahelr.onlinelib.client.dao.Dao;
import priv.lahelr.onlinelib.client.utils.Utils;

/**
 * the window where users using advanced searching to search borrowing status
 * 
 * @author lahelr
 *
 */
public class SearchBorrowingAdvan extends JFrame {

	private static final long serialVersionUID = -310866017928649411L;
	private JPanel contentPane;
	private JTextField textField;

	/**
	 * Create the frame.
	 */
	public SearchBorrowingAdvan() {
		/**
		 * basic attrs of the frame
		 */
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		setTitle("Advanced search");
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);

		/**
		 * the text field that accepts the advanced searching statement
		 */
		textField = new JTextField();
		contentPane.add(textField, BorderLayout.CENTER);
		textField.setColumns(10);

		/**
		 * the button that do searching
		 */
		JButton searchButton = new JButton("Search");
		searchButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				// gen the sql string
				String sqlstr = "select library.reader.reader_name,library.reader.reader_ID,library.book.book_ID,library.book.book_name,library.book.ISBN from library.book,library.reader,library.borrowing";
				sqlstr += " where( library.book.book_ID=library.borrowing.book_ID and library.reader.reader_ID=library.borrowing.reader_ID )";
				if (textField.getText().length() > 0) {
					sqlstr += ("and( " + textField.getText() + ");");
				} else {
					sqlstr += ";";
				}
				Vector<Vector<String>> sheet = Dao.findForVector(sqlstr);

				try {
					SearchBorrowingResult frame = new SearchBorrowingResult(sheet);
					frame.setVisible(true);
				} catch (Exception e1) {
					Utils.showAlert(String.format("%s", Utils.sprintStackTrace(e1)));
				}
			}
		});
		contentPane.add(searchButton, BorderLayout.SOUTH);
	}
}
