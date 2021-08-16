package priv.lahelr.onlinelib.client.frame;

import java.awt.EventQueue;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;
import javax.swing.border.EmptyBorder;

import priv.lahelr.onlinelib.client.utils.Utils;

/**
 * the main window of the whole client
 * 
 * @author lahelr
 *
 */
public class MainFrame extends JFrame {

	private static final long serialVersionUID = 1507630239649683782L;
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
		/**
		 * basic attrs of this window: close oper, size, ui, content pane, layout and
		 * title
		 */
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		// set UI styles
		try {
			// UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());//系统风格
			// UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");//win风格
			UIManager.setLookAndFeel(UIManager.getCrossPlatformLookAndFeelClassName());// 默认跨平台风格
			// UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsClassicLookAndFeel");//旧win风格
		} catch (ClassNotFoundException | InstantiationException | IllegalAccessException
				| UnsupportedLookAndFeelException e7) {
			e7.printStackTrace();
		}
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(new GridLayout(3, 2, 2, 2));
		setTitle("Library System");

		/**
		 * 6 buttons that guide to different functions
		 */
		JButton addBookButton = new JButton("Add book");
		addBookButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					AddBook frame = new AddBook();
					frame.setVisible(true);
				} catch (Exception e3) {
					Utils.showError(String.format("%s", Utils.sprintStackTrace(e3)));
				}
			}
		});
		contentPane.add(addBookButton);

		JButton searchBookButton = new JButton("Search book");
		searchBookButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					SearchBook frame = new SearchBook();
					frame.setVisible(true);
				} catch (Exception e1) {
					Utils.showError(String.format("%s", Utils.sprintStackTrace(e1)));
				}
			}
		});
		contentPane.add(searchBookButton);

		JButton addReaderButton = new JButton("Add reader");
		addReaderButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					AddReader frame = new AddReader();
					frame.setVisible(true);
				} catch (Exception e4) {
					Utils.showError(String.format("%s", Utils.sprintStackTrace(e4)));
				}
			}
		});
		contentPane.add(addReaderButton);

		JButton searchReaderButton = new JButton("Search reader");
		searchReaderButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					SearchReader frame = new SearchReader();
					frame.setVisible(true);
				} catch (Exception e2) {
					Utils.showError(String.format("%s", Utils.sprintStackTrace(e2)));
				}
			}
		});
		contentPane.add(searchReaderButton);

		JButton checkBorrowingButton = new JButton("Check borrowing");
		checkBorrowingButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					CheckBorrowing frame = new CheckBorrowing();
					frame.setVisible(true);
				} catch (Exception e5) {
					Utils.showError(String.format("%s", Utils.sprintStackTrace(e5)));
				}
			}
		});
		contentPane.add(checkBorrowingButton);

		JButton changeBorrowingButton = new JButton("Return/borrow book");
		changeBorrowingButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					RetBroBook frame = new RetBroBook();
					frame.setVisible(true);
				} catch (Exception e6) {
					e6.printStackTrace();
				}
			}
		});
		contentPane.add(changeBorrowingButton);

	}

}
