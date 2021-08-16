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
 * the window where users can search books
 * 
 * @author lahelr
 *
 */
public class SearchBook extends JFrame {

	private static final long serialVersionUID = -4955433151938433871L;
	private JPanel contentPane;

	public SearchBook() {
		/**
		 * basic attrs of the frame
		 */
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		setTitle("Search book");
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
		gbc_comboBox.gridx = 0;// 网格横向坐标
		gbc_comboBox.gridy = 0;// 网格纵向坐标
		gbc_comboBox.gridwidth = 1;// 元素宽度
		gbc_comboBox.gridheight = 1;// 元素高度
		comboBox.addItem("and");// 添加选项
		comboBox.addItem("or");
		contentPane.add(comboBox, gbc_comboBox);

		JComboBox<String> comboBox1 = new JComboBox<String>();
		GridBagConstraints gbc_comboBox1 = new GridBagConstraints();
		gbc_comboBox1.insets = new Insets(0, 0, 5, 5);
		gbc_comboBox1.anchor = GridBagConstraints.CENTER;
		gbc_comboBox1.fill = GridBagConstraints.BOTH;
		gbc_comboBox1.gridx = 0;// 网格横向坐标
		gbc_comboBox1.gridy = 1;// 网格纵向坐标
		gbc_comboBox1.gridwidth = 1;// 元素宽度
		gbc_comboBox1.gridheight = 1;// 元素高度;
		comboBox1.addItem("and");
		comboBox1.addItem("or");
		contentPane.add(comboBox1, gbc_comboBox1);

		JComboBox<String> comboBox2 = new JComboBox<String>();
		GridBagConstraints gbc_comboBox2 = new GridBagConstraints();
		gbc_comboBox2.insets = new Insets(0, 0, 5, 5);
		gbc_comboBox2.anchor = GridBagConstraints.CENTER;
		gbc_comboBox2.fill = GridBagConstraints.BOTH;
		gbc_comboBox2.gridx = 0;// 网格横向坐标
		gbc_comboBox2.gridy = 2;// 网格纵向坐标
		gbc_comboBox2.gridwidth = 1;// 元素宽度
		gbc_comboBox2.gridheight = 1;// 元素高度;
		comboBox2.addItem("and");
		comboBox2.addItem("or");
		contentPane.add(comboBox2, gbc_comboBox2);

		JComboBox<String> comboBox3 = new JComboBox<String>();
		GridBagConstraints gbc_comboBox3 = new GridBagConstraints();
		gbc_comboBox3.insets = new Insets(0, 0, 5, 5);
		gbc_comboBox3.anchor = GridBagConstraints.CENTER;
		gbc_comboBox3.fill = GridBagConstraints.BOTH;
		gbc_comboBox3.gridx = 0;// 网格横向坐标
		gbc_comboBox3.gridy = 3;// 网格纵向坐标
		gbc_comboBox3.gridwidth = 1;// 元素宽度
		gbc_comboBox3.gridheight = 1;// 元素高度;
		comboBox3.addItem("and");
		comboBox3.addItem("or");
		contentPane.add(comboBox3, gbc_comboBox3);

		JComboBox<String> comboBox4 = new JComboBox<String>();
		GridBagConstraints gbc_comboBox4 = new GridBagConstraints();
		gbc_comboBox4.insets = new Insets(0, 0, 5, 5);
		gbc_comboBox4.anchor = GridBagConstraints.CENTER;
		gbc_comboBox4.fill = GridBagConstraints.BOTH;
		gbc_comboBox4.gridx = 0;// 网格横向坐标
		gbc_comboBox4.gridy = 4;// 网格纵向坐标
		gbc_comboBox4.gridwidth = 1;// 元素宽度
		gbc_comboBox4.gridheight = 1;// 元素高度;
		comboBox4.addItem("and");
		comboBox4.addItem("or");
		contentPane.add(comboBox4, gbc_comboBox4);

		JComboBox<String> comboBox5 = new JComboBox<String>();
		GridBagConstraints gbc_comboBox5 = new GridBagConstraints();
		gbc_comboBox5.insets = new Insets(0, 0, 5, 5);
		gbc_comboBox5.anchor = GridBagConstraints.CENTER;
		gbc_comboBox5.fill = GridBagConstraints.BOTH;
		gbc_comboBox5.gridx = 0;// 网格横向坐标
		gbc_comboBox5.gridy = 5;// 网格纵向坐标
		gbc_comboBox5.gridwidth = 1;// 元素宽度
		gbc_comboBox5.gridheight = 1;// 元素高度;
		comboBox5.addItem("and");
		comboBox5.addItem("or");
		contentPane.add(comboBox5, gbc_comboBox5);

		/**
		 * the comboBoxes that chooses the attr names of the statements
		 */
		JComboBox<String> comboBox10 = new JComboBox<String>();
		GridBagConstraints gbc_comboBox10 = new GridBagConstraints();
		gbc_comboBox10.insets = new Insets(0, 0, 5, 5);
		gbc_comboBox10.anchor = GridBagConstraints.CENTER;
		gbc_comboBox10.fill = GridBagConstraints.BOTH;
		gbc_comboBox10.gridx = 1;// 网格横向坐标
		gbc_comboBox10.gridy = 0;// 网格纵向坐标
		gbc_comboBox10.gridwidth = 1;// 元素宽度
		gbc_comboBox10.gridheight = 1;// 元素高度;
		comboBox10.addItem("book name");
		comboBox10.addItem("ISBN");
		comboBox10.addItem("book id");
		comboBox10.addItem("writer name");
		comboBox10.addItem("publisher");
		comboBox10.addItem("publish year");
		contentPane.add(comboBox10, gbc_comboBox10);

		JComboBox<String> comboBox11 = new JComboBox<String>();
		GridBagConstraints gbc_comboBox11 = new GridBagConstraints();
		gbc_comboBox11.insets = new Insets(0, 0, 5, 5);
		gbc_comboBox11.anchor = GridBagConstraints.CENTER;
		gbc_comboBox11.fill = GridBagConstraints.BOTH;
		gbc_comboBox11.gridx = 1;// 网格横向坐标
		gbc_comboBox11.gridy = 1;// 网格纵向坐标
		gbc_comboBox11.gridwidth = 1;// 元素宽度
		gbc_comboBox11.gridheight = 1;// 元素高度;
		comboBox11.addItem("book name");
		comboBox11.addItem("ISBN");
		comboBox11.addItem("book id");
		comboBox11.addItem("writer name");
		comboBox11.addItem("publisher");
		comboBox11.addItem("publish year");
		contentPane.add(comboBox11, gbc_comboBox11);

		JComboBox<String> comboBox12 = new JComboBox<String>();
		GridBagConstraints gbc_comboBox12 = new GridBagConstraints();
		gbc_comboBox12.insets = new Insets(0, 0, 5, 5);
		gbc_comboBox12.anchor = GridBagConstraints.CENTER;
		gbc_comboBox12.fill = GridBagConstraints.BOTH;
		gbc_comboBox12.gridx = 1;// 网格横向坐标
		gbc_comboBox12.gridy = 2;// 网格纵向坐标
		gbc_comboBox12.gridwidth = 1;// 元素宽度
		gbc_comboBox12.gridheight = 1;// 元素高度;
		comboBox12.addItem("book name");
		comboBox12.addItem("ISBN");
		comboBox12.addItem("book id");
		comboBox12.addItem("writer name");
		comboBox12.addItem("publisher");
		comboBox12.addItem("publish year");
		contentPane.add(comboBox12, gbc_comboBox12);

		JComboBox<String> comboBox13 = new JComboBox<String>();
		GridBagConstraints gbc_comboBox13 = new GridBagConstraints();
		gbc_comboBox13.insets = new Insets(0, 0, 5, 5);
		gbc_comboBox13.anchor = GridBagConstraints.CENTER;
		gbc_comboBox13.fill = GridBagConstraints.BOTH;
		gbc_comboBox13.gridx = 1;// 网格横向坐标
		gbc_comboBox13.gridy = 3;// 网格纵向坐标
		gbc_comboBox13.gridwidth = 1;// 元素宽度
		gbc_comboBox13.gridheight = 1;// 元素高度;
		comboBox13.addItem("book name");
		comboBox13.addItem("ISBN");
		comboBox13.addItem("book id");
		comboBox13.addItem("writer name");
		comboBox13.addItem("publisher");
		comboBox13.addItem("publish year");
		contentPane.add(comboBox13, gbc_comboBox13);

		JComboBox<String> comboBox14 = new JComboBox<String>();
		GridBagConstraints gbc_comboBox14 = new GridBagConstraints();
		gbc_comboBox14.insets = new Insets(0, 0, 5, 5);
		gbc_comboBox14.anchor = GridBagConstraints.CENTER;
		gbc_comboBox14.fill = GridBagConstraints.BOTH;
		gbc_comboBox14.gridx = 1;// 网格横向坐标
		gbc_comboBox14.gridy = 4;// 网格纵向坐标
		gbc_comboBox14.gridwidth = 1;// 元素宽度
		gbc_comboBox14.gridheight = 1;// 元素高度;
		comboBox14.addItem("book name");
		comboBox14.addItem("ISBN");
		comboBox14.addItem("book id");
		comboBox14.addItem("writer name");
		comboBox14.addItem("publisher");
		comboBox14.addItem("publish year");
		contentPane.add(comboBox14, gbc_comboBox14);

		JComboBox<String> comboBox15 = new JComboBox<String>();
		GridBagConstraints gbc_comboBox15 = new GridBagConstraints();
		gbc_comboBox15.insets = new Insets(0, 0, 5, 5);
		gbc_comboBox15.anchor = GridBagConstraints.CENTER;
		gbc_comboBox15.fill = GridBagConstraints.BOTH;
		gbc_comboBox15.gridx = 1;// 网格横向坐标
		gbc_comboBox15.gridy = 5;// 网格纵向坐标
		gbc_comboBox15.gridwidth = 1;// 元素宽度
		gbc_comboBox15.gridheight = 1;// 元素高度;
		comboBox15.addItem("book name");
		comboBox15.addItem("ISBN");
		comboBox15.addItem("book id");
		comboBox15.addItem("writer name");
		comboBox15.addItem("publisher");
		comboBox15.addItem("publish year");
		contentPane.add(comboBox15, gbc_comboBox15);

		/**
		 * the text fields that accept contents of the statements
		 */
		JTextField textField = new JTextField();
		textField.setColumns(10);
		GridBagConstraints gbc_textField = new GridBagConstraints();
		gbc_textField.insets = new Insets(0, 0, 5, 0);
		gbc_textField.fill = GridBagConstraints.HORIZONTAL;
		gbc_textField.gridx = 2;// 网格横向坐标
		gbc_textField.gridy = 0;// 网格纵向坐标
		gbc_textField.gridwidth = 3;// 元素宽度
		gbc_textField.gridheight = 1;// 元素高度;
		contentPane.add(textField, gbc_textField);

		JTextField textField1 = new JTextField();
		textField1.setColumns(10);
		GridBagConstraints gbc_textField1 = new GridBagConstraints();
		gbc_textField1.insets = new Insets(0, 0, 5, 0);
		gbc_textField1.fill = GridBagConstraints.HORIZONTAL;
		gbc_textField1.gridx = 2;// 网格横向坐标
		gbc_textField1.gridy = 1;// 网格纵向坐标
		gbc_textField1.gridwidth = 3;// 元素宽度
		gbc_textField1.gridheight = 1;// 元素高度;
		contentPane.add(textField1, gbc_textField1);

		JTextField textField2 = new JTextField();
		textField2.setColumns(10);
		GridBagConstraints gbc_textField2 = new GridBagConstraints();
		gbc_textField2.insets = new Insets(0, 0, 5, 0);
		gbc_textField2.fill = GridBagConstraints.HORIZONTAL;
		gbc_textField2.gridx = 2;// 网格横向坐标
		gbc_textField2.gridy = 2;// 网格纵向坐标
		gbc_textField2.gridwidth = 3;// 元素宽度
		gbc_textField2.gridheight = 1;// 元素高度;
		contentPane.add(textField2, gbc_textField2);

		JTextField textField3 = new JTextField();
		textField3.setColumns(10);
		GridBagConstraints gbc_textField3 = new GridBagConstraints();
		gbc_textField3.insets = new Insets(0, 0, 5, 0);
		gbc_textField3.fill = GridBagConstraints.HORIZONTAL;
		gbc_textField3.gridx = 2;// 网格横向坐标
		gbc_textField3.gridy = 3;// 网格纵向坐标
		gbc_textField3.gridwidth = 3;// 元素宽度
		gbc_textField3.gridheight = 1;// 元素高度;
		contentPane.add(textField3, gbc_textField3);

		JTextField textField4 = new JTextField();
		textField4.setColumns(10);
		GridBagConstraints gbc_textField4 = new GridBagConstraints();
		gbc_textField4.insets = new Insets(0, 0, 5, 0);
		gbc_textField4.fill = GridBagConstraints.HORIZONTAL;
		gbc_textField4.gridx = 2;// 网格横向坐标
		gbc_textField4.gridy = 4;// 网格纵向坐标
		gbc_textField4.gridwidth = 3;// 元素宽度
		gbc_textField4.gridheight = 1;// 元素高度;
		contentPane.add(textField4, gbc_textField4);

		JTextField textField5 = new JTextField();
		textField5.setColumns(10);
		GridBagConstraints gbc_textField5 = new GridBagConstraints();
		gbc_textField5.insets = new Insets(0, 0, 5, 0);
		gbc_textField5.fill = GridBagConstraints.HORIZONTAL;
		gbc_textField5.gridx = 2;// 网格横向坐标
		gbc_textField5.gridy = 5;// 网格纵向坐标
		gbc_textField5.gridwidth = 3;// 元素宽度
		gbc_textField5.gridheight = 1;// 元素高度;
		contentPane.add(textField5, gbc_textField5);

		/**
		 * the button that do the search and the listener
		 */
		JButton searchButton = new JButton("Search");
		searchButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String strsql = Dao.searchBookStr(comboBox.getSelectedIndex(), comboBox1.getSelectedIndex(),
						comboBox2.getSelectedIndex(), comboBox3.getSelectedIndex(), comboBox4.getSelectedIndex(),
						comboBox5.getSelectedIndex(), comboBox10.getSelectedIndex(), comboBox11.getSelectedIndex(),
						comboBox12.getSelectedIndex(), comboBox13.getSelectedIndex(), comboBox14.getSelectedIndex(),
						comboBox15.getSelectedIndex(), textField.getText(), textField1.getText(), textField2.getText(),
						textField3.getText(), textField4.getText(), textField5.getText());
				Vector<Vector<String>> sheet = Dao.findForVector(strsql);

				try {
					SearchBookResult frame = new SearchBookResult(sheet);
					frame.setVisible(true);
				} catch (Exception e1) {
					Utils.showAlert(String.format("%s", Utils.sprintStackTrace(e1)));
				}
			}
		});
		GridBagConstraints gbc_searchButton = new GridBagConstraints();
		gbc_searchButton.insets = new Insets(0, 0, 0, 5);
		gbc_searchButton.gridx = 1;// 网格横向坐标
		gbc_searchButton.gridy = 6;// 网格纵向坐标
		contentPane.add(searchButton, gbc_searchButton);

		/**
		 * the button that guides to advanced searching and it's listener
		 */
		JButton advancedButton = new JButton("Advanced");
		advancedButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					SearchBookAdvan frame = new SearchBookAdvan();
					frame.setVisible(true);
				} catch (Exception e2) {
					Utils.showAlert(String.format("%s", Utils.sprintStackTrace(e2)));
				}
			}
		});
		GridBagConstraints gbc_advancedButton = new GridBagConstraints();
		gbc_advancedButton.insets = new Insets(0, 0, 0, 5);
		gbc_advancedButton.gridx = 2;// 网格横向坐标
		gbc_advancedButton.gridy = 6;// 网格纵向坐标
		contentPane.add(advancedButton, gbc_advancedButton);
	}

}
