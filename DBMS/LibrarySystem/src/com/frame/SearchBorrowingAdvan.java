package com.frame;

import java.awt.BorderLayout;
import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Vector;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.border.EmptyBorder;

import com.libm.dao.Dao;

public class SearchBorrowingAdvan extends JFrame {

	private JPanel contentPane;
	private JTextField textField;

	/**
	 * Create the frame.
	 */
	public SearchBorrowingAdvan() {
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		setTitle("Advanced search");
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);

		textField = new JTextField();
		contentPane.add(textField, BorderLayout.CENTER);
		textField.setColumns(10);

		JButton btnNewButton = new JButton("Search");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String sqlstr = "select library.reader.reader_name,library.reader.reader_ID,library.book.book_ID,library.book.book_name,library.book.ISBN from library.book,library.reader,library.borrowing";
				sqlstr += " where( library.book.book_ID=library.borrowing.book_ID and library.reader.reader_ID=library.borrowing.reader_ID )";
				if (textField.getText().length() > 0) {
					sqlstr += ("and( " + textField.getText() + ");");
				} else {
					sqlstr += ";";
				}
				Vector<Vector<String>> sheet = Dao.findForVector(sqlstr);

				// System.out.println(sheet.get(0).get(0));
				try {
					SearchBorrowingResult frame = new SearchBorrowingResult(sheet);
					frame.setVisible(true);
				} catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		});
		contentPane.add(btnNewButton, BorderLayout.SOUTH);
	}
}
