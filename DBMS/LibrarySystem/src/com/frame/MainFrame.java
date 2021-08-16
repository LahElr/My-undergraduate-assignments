package com.frame;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;
import javax.swing.border.EmptyBorder;
import java.awt.GridLayout;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class MainFrame extends JFrame {

	private JPanel contentPane;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					MainFrame frame = new MainFrame();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public MainFrame() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		//设定UI风格
		try {
			//UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());//系统风格
			//UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");//win风格
			UIManager.setLookAndFeel(UIManager.getCrossPlatformLookAndFeelClassName());//默认跨平台风格
			//UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsClassicLookAndFeel");//旧win风格
		} catch (ClassNotFoundException e7) {
			// TODO Auto-generated catch block
			e7.printStackTrace();
		} catch (InstantiationException e7) {
			// TODO Auto-generated catch block
			e7.printStackTrace();
		} catch (IllegalAccessException e7) {
			// TODO Auto-generated catch block
			e7.printStackTrace();
		} catch (UnsupportedLookAndFeelException e7) {
			// TODO Auto-generated catch block
			e7.printStackTrace();
		}
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(new GridLayout(3, 2, 2, 2));
		setTitle("Library System");

		JButton btnNewButton = new JButton("Add book");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					AddBook frame = new AddBook();
					frame.setVisible(true);
				} catch (Exception e3) {
					e3.printStackTrace();
				}
			}
		});
		contentPane.add(btnNewButton);

		JButton btnNewButton_2 = new JButton("Search book");
		btnNewButton_2.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					SearchBook frame = new SearchBook();
					frame.setVisible(true);
				} catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		});
		contentPane.add(btnNewButton_2);

		JButton btnNewButton_1 = new JButton("Add reader");
		btnNewButton_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					AddReader frame = new AddReader();
					frame.setVisible(true);
				} catch (Exception e4) {
					e4.printStackTrace();
				}
			}
		});
		contentPane.add(btnNewButton_1);

		JButton btnNewButton_3 = new JButton("Search reader");
		btnNewButton_3.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					SearchReader frame = new SearchReader();
					frame.setVisible(true);
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
		});
		contentPane.add(btnNewButton_3);

		JButton btnNewButton_4 = new JButton("Check borrowing");
		btnNewButton_4.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					CheckBorrowing frame = new CheckBorrowing();
					frame.setVisible(true);
				} catch (Exception e5) {
					e5.printStackTrace();
				}
			}
		});
		contentPane.add(btnNewButton_4);

		JButton btnNewButton_5 = new JButton("Return/borrow book");
		btnNewButton_5.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					RetBroBook frame = new RetBroBook();
					frame.setVisible(true);
				} catch (Exception e6) {
					e6.printStackTrace();
				}
			}
		});
		contentPane.add(btnNewButton_5);

	}

}
