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
import priv.lahelr.onlinelib.client.dao.InsertRet;
import priv.lahelr.onlinelib.client.utils.Utils;

/**
 * The window where user can add one book
 * 
 * @author lahelr
 *
 */
public class AddBook extends JFrame {

	private static final long serialVersionUID = -3478157439156851857L;
	private JPanel contentPane;

	/**
	 * Create the frame.
	 */
	public AddBook() {
		/*
		 * basic attrs of this frame
		 */
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

		/**
		 * names of attrs : label
		 */
		JLabel bookTitileLabel = new JLabel("book title", JLabel.CENTER);
		GridBagConstraints gbc_bookTitleLabel = new GridBagConstraints();
		gbc_bookTitleLabel.insets = new Insets(0, 0, 5, 5);
		gbc_bookTitleLabel.gridx = 0;
		gbc_bookTitleLabel.gridy = 0;
		gbc_bookTitleLabel.gridwidth = 2;
		gbc_bookTitleLabel.gridheight = 1;
		contentPane.add(bookTitileLabel, gbc_bookTitleLabel);

		JLabel isbnLabel1 = new JLabel("ISBN", JLabel.CENTER);
		GridBagConstraints gbc_isbnLabel = new GridBagConstraints();
		gbc_isbnLabel.insets = new Insets(0, 0, 5, 5);
		gbc_isbnLabel.gridx = 0;
		gbc_isbnLabel.gridy = 1;
		gbc_isbnLabel.gridwidth = 2;
		gbc_isbnLabel.gridheight = 1;
		contentPane.add(isbnLabel1, gbc_isbnLabel);

		JLabel writerNameLabel = new JLabel("writer name", JLabel.CENTER);
		GridBagConstraints gbc_writerNameLabel = new GridBagConstraints();
		gbc_writerNameLabel.insets = new Insets(0, 0, 5, 5);
		gbc_writerNameLabel.gridx = 0;
		gbc_writerNameLabel.gridy = 2;
		gbc_writerNameLabel.gridwidth = 2;
		gbc_writerNameLabel.gridheight = 1;
		contentPane.add(writerNameLabel, gbc_writerNameLabel);

		JLabel publisherLabel = new JLabel("publisher", JLabel.CENTER);
		GridBagConstraints gbc_publisherLabel = new GridBagConstraints();
		gbc_publisherLabel.insets = new Insets(0, 0, 5, 5);
		gbc_publisherLabel.gridx = 0;
		gbc_publisherLabel.gridy = 3;
		gbc_publisherLabel.gridwidth = 2;
		gbc_publisherLabel.gridheight = 1;
		contentPane.add(publisherLabel, gbc_publisherLabel);

		JLabel publishYearLabel = new JLabel("publish year", JLabel.CENTER);
		GridBagConstraints gbc_publishYearLabel = new GridBagConstraints();
		gbc_publishYearLabel.insets = new Insets(0, 0, 5, 5);
		gbc_publishYearLabel.gridx = 0;
		gbc_publishYearLabel.gridy = 4;
		gbc_publishYearLabel.gridwidth = 2;
		gbc_publishYearLabel.gridheight = 1;
		contentPane.add(publishYearLabel, gbc_publishYearLabel);

		/**
		 * contents of attrs : text field
		 */
		JTextField bookTitleTextField = new JTextField();
		GridBagConstraints gbc_bookTitleTextField = new GridBagConstraints();
		gbc_bookTitleTextField.insets = new Insets(0, 0, 5, 0);
		gbc_bookTitleTextField.fill = GridBagConstraints.HORIZONTAL;
		gbc_bookTitleTextField.gridx = 2;
		gbc_bookTitleTextField.gridy = 0;
		gbc_bookTitleTextField.gridwidth = 3;
		gbc_bookTitleTextField.gridheight = 1;
		bookTitleTextField.setColumns(10);
		contentPane.add(bookTitleTextField, gbc_bookTitleTextField);

		JTextField isbnTextField = new JTextField();
		GridBagConstraints gbc_isbnTextField1 = new GridBagConstraints();
		gbc_isbnTextField1.insets = new Insets(0, 0, 5, 0);
		gbc_isbnTextField1.fill = GridBagConstraints.HORIZONTAL;
		gbc_isbnTextField1.gridx = 2;
		gbc_isbnTextField1.gridy = 1;
		gbc_isbnTextField1.gridwidth = 3;
		gbc_isbnTextField1.gridheight = 1;
		isbnTextField.setColumns(10);
		contentPane.add(isbnTextField, gbc_isbnTextField1);

		JTextField writerTextField = new JTextField();
		GridBagConstraints gbc_writerTextField = new GridBagConstraints();
		gbc_writerTextField.insets = new Insets(0, 0, 5, 0);
		gbc_writerTextField.fill = GridBagConstraints.HORIZONTAL;
		gbc_writerTextField.gridx = 2;
		gbc_writerTextField.gridy = 2;
		gbc_writerTextField.gridwidth = 3;
		gbc_writerTextField.gridheight = 1;
		writerTextField.setColumns(10);
		contentPane.add(writerTextField, gbc_writerTextField);

		JTextField publisherTextField = new JTextField();
		GridBagConstraints gbc_publisherTextField = new GridBagConstraints();
		gbc_publisherTextField.insets = new Insets(0, 0, 5, 0);
		gbc_publisherTextField.fill = GridBagConstraints.HORIZONTAL;
		gbc_publisherTextField.gridx = 2;
		gbc_publisherTextField.gridy = 3;
		gbc_publisherTextField.gridwidth = 3;
		gbc_publisherTextField.gridheight = 1;
		publisherTextField.setColumns(10);
		contentPane.add(publisherTextField, gbc_publisherTextField);

		JTextField publishYearTextField = new JTextField();
		GridBagConstraints gbc_publishYeatTextField = new GridBagConstraints();
		gbc_publishYeatTextField.insets = new Insets(0, 0, 5, 0);
		gbc_publishYeatTextField.fill = GridBagConstraints.HORIZONTAL;
		gbc_publishYeatTextField.gridx = 2;
		gbc_publishYeatTextField.gridy = 4;
		gbc_publishYeatTextField.gridwidth = 3;
		gbc_publishYeatTextField.gridheight = 1;
		publishYearTextField.setColumns(10);
		contentPane.add(publishYearTextField, gbc_publishYeatTextField);

		/**
		 * the button show apply and it's listener
		 */
		JButton applyButton = new JButton("Apply");
		applyButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if (bookTitleTextField.getText().length() == 0 || isbnTextField.getText().length() == 0) {
					Utils.showAlert("Title and ISBN of the new book can't be null.");
				} else {
					InsertRet insertResult = Dao.addBook(bookTitleTextField.getText(), writerTextField.getText(),
							isbnTextField.getText(), publisherTextField.getText(), publishYearTextField.getText());
					boolean insertDone = insertResult.getDone();
					if (!insertDone) {
						Utils.showAlert("Insert failed for unknown reason.");
					} else {
						Utils.showAlert(String.format("The book ID for %s is %d.", bookTitleTextField.getText(),
								insertResult.getID()));

					}
				}
			}
		});
		GridBagConstraints gbc_applyButton = new GridBagConstraints();
		gbc_applyButton.insets = new Insets(0, 0, 0, 5);
		gbc_applyButton.gridx = 2;
		gbc_applyButton.gridy = 5;
		gbc_applyButton.gridwidth = 1;
		gbc_applyButton.gridheight = 1;
		contentPane.add(applyButton, gbc_applyButton);

	}

}
