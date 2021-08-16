package com.frame;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;

import com.libm.dao.Dao;
import com.libm.dao.InsertRet;

import java.awt.GridBagLayout;
import javax.swing.JLabel;
import java.awt.GridBagConstraints;
import javax.swing.JTextField;
import java.awt.Insets;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class AddBook extends JFrame {

	private JPanel contentPane;
	private JTextField textField;

	/**
	 * Create the frame.
	 */
	public AddBook() {
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		setBounds(100, 100, 450, 210);
		setTitle("Add a book");
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		GridBagLayout gbl_contentPane = new GridBagLayout();
		gbl_contentPane.columnWidths = new int[] { 0, 0, 0 };
		gbl_contentPane.rowHeights = new int[] { 0, 0, 0, 0, 0, 0 };
		gbl_contentPane.columnWeights = new double[] { 0.0, Double.MIN_VALUE, 1.0 };
		gbl_contentPane.rowWeights = new double[] { 0.0, Double.MIN_VALUE, 0.0, 0.0, 0.0, 0.0 };
		contentPane.setLayout(gbl_contentPane);

		JLabel lblNewLabel = new JLabel("book title", JLabel.CENTER);
		GridBagConstraints gbc_lblNewLabel = new GridBagConstraints();
		gbc_lblNewLabel.insets = new Insets(0, 0, 5, 5);
		gbc_lblNewLabel.gridx = 0;
		gbc_lblNewLabel.gridy = 0;
		gbc_lblNewLabel.gridwidth = 2;
		gbc_lblNewLabel.gridheight = 1;
		contentPane.add(lblNewLabel, gbc_lblNewLabel);

		JLabel lblNewLabel1 = new JLabel("ISBN", JLabel.CENTER);
		GridBagConstraints gbc_lblNewLabel1 = new GridBagConstraints();
		gbc_lblNewLabel1.insets = new Insets(0, 0, 5, 5);
		gbc_lblNewLabel1.gridx = 0;
		gbc_lblNewLabel1.gridy = 1;
		gbc_lblNewLabel1.gridwidth = 2;
		gbc_lblNewLabel1.gridheight = 1;
		contentPane.add(lblNewLabel1, gbc_lblNewLabel1);

		JLabel lblNewLabel2 = new JLabel("writer name", JLabel.CENTER);
		GridBagConstraints gbc_lblNewLabel2 = new GridBagConstraints();
		gbc_lblNewLabel2.insets = new Insets(0, 0, 5, 5);
		gbc_lblNewLabel2.gridx = 0;
		gbc_lblNewLabel2.gridy = 2;
		gbc_lblNewLabel2.gridwidth = 2;
		gbc_lblNewLabel2.gridheight = 1;
		contentPane.add(lblNewLabel2, gbc_lblNewLabel2);

		JLabel lblNewLabel3 = new JLabel("publisher", JLabel.CENTER);
		GridBagConstraints gbc_lblNewLabel3 = new GridBagConstraints();
		gbc_lblNewLabel3.insets = new Insets(0, 0, 5, 5);
		gbc_lblNewLabel3.gridx = 0;
		gbc_lblNewLabel3.gridy = 3;
		gbc_lblNewLabel3.gridwidth = 2;
		gbc_lblNewLabel3.gridheight = 1;
		contentPane.add(lblNewLabel3, gbc_lblNewLabel3);

		JLabel lblNewLabel4 = new JLabel("publish year", JLabel.CENTER);
		GridBagConstraints gbc_lblNewLabel4 = new GridBagConstraints();
		gbc_lblNewLabel4.insets = new Insets(0, 0, 5, 5);
		gbc_lblNewLabel4.gridx = 0;
		gbc_lblNewLabel4.gridy = 4;
		gbc_lblNewLabel4.gridwidth = 2;
		gbc_lblNewLabel4.gridheight = 1;
		contentPane.add(lblNewLabel4, gbc_lblNewLabel4);

		JTextField textField = new JTextField();
		GridBagConstraints gbc_textField = new GridBagConstraints();
		gbc_textField.insets = new Insets(0, 0, 5, 0);
		gbc_textField.fill = GridBagConstraints.HORIZONTAL;
		gbc_textField.gridx = 2;
		gbc_textField.gridy = 0;
		gbc_textField.gridwidth = 3;
		gbc_textField.gridheight = 1;
		textField.setColumns(10);
		contentPane.add(textField, gbc_textField);

		JTextField textField1 = new JTextField();
		GridBagConstraints gbc_textField1 = new GridBagConstraints();
		gbc_textField1.insets = new Insets(0, 0, 5, 0);
		gbc_textField1.fill = GridBagConstraints.HORIZONTAL;
		gbc_textField1.gridx = 2;
		gbc_textField1.gridy = 1;
		gbc_textField1.gridwidth = 3;
		gbc_textField1.gridheight = 1;
		textField1.setColumns(10);
		contentPane.add(textField1, gbc_textField1);

		JTextField textField2 = new JTextField();
		GridBagConstraints gbc_textField2 = new GridBagConstraints();
		gbc_textField2.insets = new Insets(0, 0, 5, 0);
		gbc_textField2.fill = GridBagConstraints.HORIZONTAL;
		gbc_textField2.gridx = 2;
		gbc_textField2.gridy = 2;
		gbc_textField2.gridwidth = 3;
		gbc_textField2.gridheight = 1;
		textField2.setColumns(10);
		contentPane.add(textField2, gbc_textField2);

		JTextField textField3 = new JTextField();
		GridBagConstraints gbc_textField3 = new GridBagConstraints();
		gbc_textField3.insets = new Insets(0, 0, 5, 0);
		gbc_textField3.fill = GridBagConstraints.HORIZONTAL;
		gbc_textField3.gridx = 2;
		gbc_textField3.gridy = 3;
		gbc_textField3.gridwidth = 3;
		gbc_textField3.gridheight = 1;
		textField3.setColumns(10);
		contentPane.add(textField3, gbc_textField3);

		JTextField textField4 = new JTextField();
		GridBagConstraints gbc_textField4 = new GridBagConstraints();
		gbc_textField4.insets = new Insets(0, 0, 5, 0);
		gbc_textField4.fill = GridBagConstraints.HORIZONTAL;
		gbc_textField4.gridx = 2;
		gbc_textField4.gridy = 4;
		gbc_textField4.gridwidth = 3;
		gbc_textField4.gridheight = 1;
		textField4.setColumns(10);
		contentPane.add(textField4, gbc_textField4);

		JButton btnNewButton = new JButton("Apply");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if (textField.getText().length() == 0 || textField1.getText().length() == 0) {
					try {
						Alert frame = new Alert("Title and ISBN of the new book can't be null.");
						frame.setVisible(true);
					} catch (Exception e1) {
						e1.printStackTrace();
					}
				} else {
					InsertRet insertResult = Dao.addBook(textField.getText(), textField2.getText(), textField1.getText(),
							textField3.getText(), textField4.getText());
					boolean insertDone = insertResult.getDone();
					if (!insertDone) {
						try {
							Alert frame = new Alert("Insert failed for unknown reason.");
							frame.setVisible(true);
						} catch (Exception e1) {
							e1.printStackTrace();
						}
					}
					else
					{
						try {
							Alert frame = new Alert("The book ID for "+textField.getText()+" is "+ String.valueOf(insertResult.getID()) + ".");
							frame.setVisible(true);
						} catch (Exception e1) {
							e1.printStackTrace();
						}
					}
				}
			}
		});
		GridBagConstraints gbc_btnNewButton = new GridBagConstraints();
		gbc_btnNewButton.insets = new Insets(0, 0, 0, 5);
		gbc_btnNewButton.gridx = 2;
		gbc_btnNewButton.gridy = 5;
		gbc_btnNewButton.gridwidth = 1;
		gbc_btnNewButton.gridheight = 1;
		contentPane.add(btnNewButton, gbc_btnNewButton);

	}

}
