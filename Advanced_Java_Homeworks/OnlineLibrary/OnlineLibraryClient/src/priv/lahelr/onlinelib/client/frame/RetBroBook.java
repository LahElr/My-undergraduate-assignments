package priv.lahelr.onlinelib.client.frame;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.border.EmptyBorder;

import priv.lahelr.onlinelib.client.dao.Dao;
import priv.lahelr.onlinelib.client.utils.Utils;

/**
 * the window where user can return or borrow one book
 * 
 * @author lahelr
 *
 */
public class RetBroBook extends JFrame {

	private static final long serialVersionUID = -7346930423710479112L;
	private JPanel contentPane;
	private JTextField bookIDTextField;
	private JTextField readerIDTextField;

	/**
	 * Create the frame.
	 */
	public RetBroBook() {
		/**
		 * basic attrs of the window
		 */
		setTitle("Return/Borrow a book");
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		setBounds(100, 100, 450, 200);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		GridBagLayout gbl_contentPane = new GridBagLayout();
		gbl_contentPane.columnWidths = new int[] { 0, 0, 0 };
		gbl_contentPane.rowHeights = new int[] { 0, 0, 0, 0 };
		gbl_contentPane.columnWeights = new double[] { 0.0, 1.0, Double.MIN_VALUE };
		gbl_contentPane.rowWeights = new double[] { 0.0, 0.0, 0.0, Double.MIN_VALUE };
		contentPane.setLayout(gbl_contentPane);

		/**
		 * label and text field that hints and accepts book id
		 */
		JLabel bookIDLabel = new JLabel("Book id", JLabel.CENTER);
		GridBagConstraints gbc_bookIDLabel = new GridBagConstraints();
		gbc_bookIDLabel.anchor = GridBagConstraints.EAST;
		gbc_bookIDLabel.insets = new Insets(0, 0, 5, 5);
		gbc_bookIDLabel.gridx = 0;
		gbc_bookIDLabel.gridy = 0;
		contentPane.add(bookIDLabel, gbc_bookIDLabel);

		bookIDTextField = new JTextField();
		GridBagConstraints gbc_bookIDTextField = new GridBagConstraints();
		gbc_bookIDTextField.insets = new Insets(0, 0, 5, 0);
		gbc_bookIDTextField.fill = GridBagConstraints.HORIZONTAL;
		gbc_bookIDTextField.gridx = 1;
		gbc_bookIDTextField.gridy = 0;
		gbc_bookIDTextField.gridwidth = 6;
		gbc_bookIDTextField.gridheight = 1;
		contentPane.add(bookIDTextField, gbc_bookIDTextField);
		bookIDTextField.setColumns(10);

		/**
		 * label and text field that hints and accepts reader id
		 */
		JLabel readerIDLabel = new JLabel("Reader id", JLabel.CENTER);
		GridBagConstraints gbc_readerIDLabel = new GridBagConstraints();
		gbc_readerIDLabel.anchor = GridBagConstraints.EAST;
		gbc_readerIDLabel.insets = new Insets(0, 0, 5, 5);
		gbc_readerIDLabel.gridx = 0;
		gbc_readerIDLabel.gridy = 1;
		contentPane.add(readerIDLabel, gbc_readerIDLabel);

		readerIDTextField = new JTextField();
		GridBagConstraints gbc_readerIDTextField = new GridBagConstraints();
		gbc_readerIDTextField.insets = new Insets(0, 0, 5, 0);
		gbc_readerIDTextField.fill = GridBagConstraints.HORIZONTAL;
		gbc_readerIDTextField.gridx = 1;
		gbc_readerIDTextField.gridy = 1;
		gbc_readerIDTextField.gridwidth = 6;
		gbc_readerIDTextField.gridheight = 1;
		contentPane.add(readerIDTextField, gbc_readerIDTextField);
		readerIDTextField.setColumns(10);

		/**
		 * the button that do returning
		 */
		JButton retBookButton = new JButton("Return book");
		retBookButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if (bookIDTextField.getText().length() == 0 || readerIDTextField.getText().length() == 0) {
					Utils.showAlert("The reader id and the book id can't be null.");
				} else {
					int res = Dao.delBorrowing(readerIDTextField.getText(), bookIDTextField.getText());
					if (res > 0) {
						Utils.showAlert("Successed.");
					} else {
						Utils.showAlert("Failed.");
					}
				}
			}
		});
		GridBagConstraints gbc_retBookButton = new GridBagConstraints();
		gbc_retBookButton.insets = new Insets(0, 0, 0, 5);
		gbc_retBookButton.gridx = 1;
		gbc_retBookButton.gridy = 2;
		contentPane.add(retBookButton, gbc_retBookButton);

		/**
		 * the button that do borrowing
		 */
		JButton borBookButton = new JButton("Borrow book");
		borBookButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if (bookIDTextField.getText().length() == 0 || readerIDTextField.getText().length() == 0) {
					Utils.showAlert("The reader id and the book id can't be null.");
				} else {
					boolean res = Dao.addBorrowing(readerIDTextField.getText(), bookIDTextField.getText());
					if (res) {
						Utils.showAlert("Successed.");
					} else {
						Utils.showAlert("Failed.");
					}
				}
			}
		});
		GridBagConstraints gbc_borBookButton = new GridBagConstraints();
		gbc_borBookButton.insets = new Insets(0, 0, 0, 5);
		gbc_borBookButton.gridx = 2;
		gbc_borBookButton.gridy = 2;
		contentPane.add(borBookButton, gbc_borBookButton);

		/**
		 * put an unseen JLable to control the position of buttons
		 */
		JLabel unseenLabel = new JLabel("                                ", JLabel.CENTER);
		GridBagConstraints gbc_unseenLabel = new GridBagConstraints();
		gbc_unseenLabel.insets = new Insets(0, 0, 0, 5);
		gbc_unseenLabel.gridx = 3;
		gbc_unseenLabel.gridy = 2;
		contentPane.add(unseenLabel, gbc_unseenLabel);
	}

}
