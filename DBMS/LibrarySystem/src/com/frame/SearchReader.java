package com.frame;

import java.util.List;
import java.util.Vector;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.border.EmptyBorder;

import com.libm.dao.Dao;

import java.awt.GridBagLayout;
import javax.swing.JButton;
import java.awt.GridBagConstraints;
import javax.swing.JComboBox;
import javax.swing.JTextPane;
import java.awt.Insets;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class SearchReader extends JFrame {

	private JPanel contentPane;
	private JTextField textField;

	public SearchReader() {
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		setTitle("Search reader");
		setBounds(100, 100, 485, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		GridBagLayout gbl_contentPane = new GridBagLayout();
		gbl_contentPane.columnWidths = new int[] { 0, 0, 0, 0 };
		gbl_contentPane.rowHeights = new int[] { 191, 67, 0, 0, 0, 0, 0 };
		gbl_contentPane.columnWeights = new double[] { 1.0, 1.0, 1.0, 1.0 };
		gbl_contentPane.rowWeights = new double[] { 1.0, Double.MIN_VALUE, 0.0, 0.0, 0.0, 0.0, 0.0 };
		contentPane.setLayout(gbl_contentPane);

		JComboBox<String> comboBox = new JComboBox<String>();
		GridBagConstraints gbc_comboBox = new GridBagConstraints();
		gbc_comboBox.insets = new Insets(0, 0, 5, 5);
		gbc_comboBox.anchor = GridBagConstraints.CENTER;
		gbc_comboBox.fill = GridBagConstraints.BOTH;
		gbc_comboBox.gridx = 0;
		gbc_comboBox.gridy = 0;
		gbc_comboBox.gridwidth = 1;
		gbc_comboBox.gridheight = 1;
		comboBox.addItem("and");
		comboBox.addItem("or");
		contentPane.add(comboBox, gbc_comboBox);

		JComboBox<String> comboBox1 = new JComboBox<String>();
		GridBagConstraints gbc_comboBox1 = new GridBagConstraints();
		gbc_comboBox1.insets = new Insets(0, 0, 5, 5);
		gbc_comboBox1.anchor = GridBagConstraints.CENTER;
		gbc_comboBox1.fill = GridBagConstraints.BOTH;
		gbc_comboBox1.gridx = 0;
		gbc_comboBox1.gridy = 1;
		gbc_comboBox1.gridwidth = 1;
		gbc_comboBox1.gridheight = 1;
		comboBox1.addItem("and");
		comboBox1.addItem("or");
		contentPane.add(comboBox1, gbc_comboBox1);

		JComboBox<String> comboBox10 = new JComboBox<String>();
		GridBagConstraints gbc_comboBox10 = new GridBagConstraints();
		gbc_comboBox10.insets = new Insets(0, 0, 5, 5);
		gbc_comboBox10.anchor = GridBagConstraints.CENTER;
		gbc_comboBox10.fill = GridBagConstraints.BOTH;
		gbc_comboBox10.gridx = 1;
		gbc_comboBox10.gridy = 0;
		gbc_comboBox10.gridwidth = 1;
		gbc_comboBox10.gridheight = 1;
		comboBox10.addItem("reader name");
		comboBox10.addItem("reader id");
		contentPane.add(comboBox10, gbc_comboBox10);

		JComboBox<String> comboBox11 = new JComboBox<String>();
		GridBagConstraints gbc_comboBox11 = new GridBagConstraints();
		gbc_comboBox11.insets = new Insets(0, 0, 5, 5);
		gbc_comboBox11.anchor = GridBagConstraints.CENTER;
		gbc_comboBox11.fill = GridBagConstraints.BOTH;
		gbc_comboBox11.gridx = 1;
		gbc_comboBox11.gridy = 1;
		gbc_comboBox11.gridwidth = 1;
		gbc_comboBox11.gridheight = 1;
		comboBox11.addItem("reader name");
		comboBox11.addItem("reader id");
		contentPane.add(comboBox11, gbc_comboBox11);

		JTextField textField = new JTextField();
		textField.setColumns(10);
		GridBagConstraints gbc_textField = new GridBagConstraints();
		gbc_textField.insets = new Insets(0, 0, 5, 0);
		gbc_textField.fill = GridBagConstraints.HORIZONTAL;
		gbc_textField.gridx = 2;
		gbc_textField.gridy = 0;
		gbc_textField.gridwidth = 3;
		gbc_textField.gridheight = 1;
		contentPane.add(textField, gbc_textField);

		JTextField textField1 = new JTextField();
		textField1.setColumns(10);
		GridBagConstraints gbc_textField1 = new GridBagConstraints();
		gbc_textField1.insets = new Insets(0, 0, 5, 0);
		gbc_textField1.fill = GridBagConstraints.HORIZONTAL;
		gbc_textField1.gridx = 2;
		gbc_textField1.gridy = 1;
		gbc_textField1.gridwidth = 3;
		gbc_textField1.gridheight = 1;
		contentPane.add(textField1, gbc_textField1);

		JButton btnNewButton = new JButton("Search");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String strsql = Dao.searchReaderStr(comboBox.getSelectedIndex(), comboBox1.getSelectedIndex(),
						comboBox10.getSelectedIndex(), comboBox11.getSelectedIndex(), textField.getText(),
						textField1.getText());
				// System.out.println(strsql);
				Vector<Vector<String>> sheet = Dao.findForVector(strsql);
				// System.out.println(sheet.get(0).get(0));

				try {
					SearchReaderResult frame = new SearchReaderResult(sheet);
					frame.setVisible(true);
				} catch (Exception e1) {
					e1.printStackTrace();
				}

			}
		});
		GridBagConstraints gbc_btnNewButton = new GridBagConstraints();
		gbc_btnNewButton.insets = new Insets(0, 0, 0, 5);
		gbc_btnNewButton.gridx = 1;
		gbc_btnNewButton.gridy = 6;
		contentPane.add(btnNewButton, gbc_btnNewButton);

		JButton btnNewButton_1 = new JButton("Advanced");
		btnNewButton_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					SearchReaderAdvan frame = new SearchReaderAdvan();
					frame.setVisible(true);
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
		});
		GridBagConstraints gbc_btnNewButton_1 = new GridBagConstraints();
		gbc_btnNewButton_1.insets = new Insets(0, 0, 0, 5);
		gbc_btnNewButton_1.gridx = 2;
		gbc_btnNewButton_1.gridy = 6;
		contentPane.add(btnNewButton_1, gbc_btnNewButton_1);
	}

}
