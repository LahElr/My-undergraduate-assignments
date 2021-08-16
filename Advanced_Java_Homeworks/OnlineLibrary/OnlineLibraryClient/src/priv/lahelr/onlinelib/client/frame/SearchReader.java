package priv.lahelr.onlinelib.client.frame;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Vector;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.border.EmptyBorder;

import priv.lahelr.onlinelib.client.dao.Dao;
import priv.lahelr.onlinelib.client.utils.Utils;

/**
 * the window where user can search readers
 * 
 * @author lahelr
 *
 */
public class SearchReader extends JFrame {

	private static final long serialVersionUID = 6066522273298379950L;
	private JPanel contentPane;

	public SearchReader() {
		/**
		 * basic attrs of the frame
		 */
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

		/**
		 * combo boxes that chooses the logical opers between statements
		 */
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

		/**
		 * the comboBoxes that chooses the attr names of the statements
		 */
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

		/**
		 * the text fields that accept contents of the statements
		 */
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

		/**
		 * the button that do the search and the listener
		 */
		JButton searchButton = new JButton("Search");
		searchButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String strsql = Dao.searchReaderStr(comboBox.getSelectedIndex(), comboBox1.getSelectedIndex(),
						comboBox10.getSelectedIndex(), comboBox11.getSelectedIndex(), textField.getText(),
						textField1.getText());
				Vector<Vector<String>> sheet = Dao.findForVector(strsql);
				try {
					SearchReaderResult frame = new SearchReaderResult(sheet);
					frame.setVisible(true);
				} catch (Exception e1) {
					Utils.showAlert(String.format("%s", Utils.sprintStackTrace(e1)));
				}

			}
		});
		GridBagConstraints gbc_searchButton = new GridBagConstraints();
		gbc_searchButton.insets = new Insets(0, 0, 0, 5);
		gbc_searchButton.gridx = 1;
		gbc_searchButton.gridy = 6;
		contentPane.add(searchButton, gbc_searchButton);

		/**
		 * the button that guides to advanced searching and it's listener
		 */
		JButton advancedButton = new JButton("Advanced");
		advancedButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					SearchReaderAdvan frame = new SearchReaderAdvan();
					frame.setVisible(true);
				} catch (Exception e2) {
					Utils.showAlert(String.format("%s", Utils.sprintStackTrace(e2)));
				}
			}
		});
		GridBagConstraints gbc_advancedButton = new GridBagConstraints();
		gbc_advancedButton.insets = new Insets(0, 0, 0, 5);
		gbc_advancedButton.gridx = 2;
		gbc_advancedButton.gridy = 6;
		contentPane.add(advancedButton, gbc_advancedButton);
	}

}
