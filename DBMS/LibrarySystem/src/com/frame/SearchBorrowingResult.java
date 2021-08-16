package com.frame;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.EventQueue;

import java.util.List;
import java.util.Vector;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.table.*;
import javax.swing.JScrollPane;
import javax.swing.JTable;

public class SearchBorrowingResult extends JFrame {

	private JPanel contentPane;
	private JTable table;

	public SearchBorrowingResult(Vector<Vector<String>> sheet) {

		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		setBounds(200, 200, 700, 500);
		setTitle("Result");
		contentPane = new JPanel();
		contentPane.setSize(700, 100);
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(new BorderLayout(0, 0));

		JPanel panel = new JPanel();

		String[] colNamesA = { "reader name", "reader ID", "book ID", "book name", "book ISBN" };
		Vector<String> colNames = new Vector<String>(5);
		for (int i = 0; i < 5; i++) {
			colNames.add(colNamesA[i]);
		}
		table = new JTable(sheet, colNames);
		table.setFillsViewportHeight(true);
		// table.setEnabled(false);

		TableColumn col = null;
		// 调整宽度（其实是初始比例）
		for (int i = 0; i < 5; i++) {
			col = table.getColumnModel().getColumn(i);
			switch (i) {
			case 0: {
				col.setPreferredWidth(120);
				break;
			}
			case 1: {
				col.setPreferredWidth(30);
				break;
			}
			case 2: {
				col.setPreferredWidth(30);
				break;
			}
			case 3: {
				col.setPreferredWidth(150);
				break;
			}
			case 4: {
				col.setPreferredWidth(70);
				break;
			}
			}
		}
		table.setPreferredScrollableViewportSize(new Dimension(650, 402));
		JScrollPane scrollPane = new JScrollPane(table, JScrollPane.VERTICAL_SCROLLBAR_ALWAYS,
				JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED) {
			@Override
			public Dimension getPreferredSize() {
				return new Dimension(650, 402);
			}
		};

		panel.add(scrollPane);
		contentPane.add(panel, BorderLayout.CENTER);
	}

}
