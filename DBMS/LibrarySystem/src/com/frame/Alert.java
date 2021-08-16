package com.frame;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;

public class Alert extends JFrame {

	private JPanel contentPane;

	public Alert(String AlertInfo) {

		JLabel lblNewLabel = new JLabel(AlertInfo, JLabel.CENTER);
		getContentPane().add(lblNewLabel, BorderLayout.CENTER);
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		setTitle("Notice");
		setBounds(540, 250, 450, 100);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		contentPane.add(lblNewLabel, BorderLayout.CENTER);
		setContentPane(contentPane);
	}

}
