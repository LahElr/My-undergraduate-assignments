package com.frame;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;

import com.libm.dao.Dao;
import com.libm.dao.InsertRet;

import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class AddReader extends JFrame {

	private JPanel contentPane;
	private JTextField textField;

	/**
	 * Create the frame.
	 */
	public AddReader() {
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		setTitle("Welcome a new reader");
		setBounds(100, 100, 450, 100);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);

		JLabel lblNewLabel = new JLabel("Reader Name", JLabel.CENTER);
		contentPane.add(lblNewLabel, BorderLayout.WEST);

		textField = new JTextField();
		contentPane.add(textField, BorderLayout.CENTER);
		textField.setColumns(10);

		JButton btnNewButton = new JButton("Apply");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if (textField.getText().length() == 0) {
					try {
						Alert frame = new Alert("Name of the new reader can't be null.");
						frame.setVisible(true);
					} catch (Exception e1) {
						e1.printStackTrace();
					}
				} else {
					InsertRet insertResult = Dao.addReader(textField.getText());
					boolean insertDone = insertResult.getDone();
					if (!insertDone) {
						try {
							Alert frame = new Alert("Insert failed for unknown reason.");
							frame.setVisible(true);
						} catch (Exception e1) {
							e1.printStackTrace();
						}
					} else {
						try {
							Alert frame = new Alert("The reader ID for " + textField.getText() + " is "
									+ String.valueOf(insertResult.getID()) + ".");
							frame.setVisible(true);
						} catch (Exception e1) {
							e1.printStackTrace();
						}
					}
				}
			}
		});
		contentPane.add(btnNewButton, BorderLayout.SOUTH);
	}

}
