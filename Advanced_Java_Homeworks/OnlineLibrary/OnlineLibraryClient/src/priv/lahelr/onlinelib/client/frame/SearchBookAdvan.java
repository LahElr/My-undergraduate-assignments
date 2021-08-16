package priv.lahelr.onlinelib.client.frame;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Vector;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.border.EmptyBorder;

import priv.lahelr.onlinelib.client.dao.Dao;
import priv.lahelr.onlinelib.client.utils.Utils;

/**
 * the advanced searching window for searching books
 * 
 * @author lahelr
 *
 */
public class SearchBookAdvan extends JFrame {

	private static final long serialVersionUID = -5474490623496883158L;
	private JPanel contentPane;
	private JTextField textField;

	/**
	 * Create the frame.
	 */
	public SearchBookAdvan() {
		/**
		 * basic attrs of the frame
		 */
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		setTitle("Advanced search");
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);

		/**
		 * text field that accepts advanced searching statement
		 */
		textField = new JTextField();
		contentPane.add(textField, BorderLayout.CENTER);
		textField.setColumns(10);

		/**
		 * button that do the searching and it's listener
		 */
		JButton searchButton = new JButton("Search");
		searchButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				// gen the sql string
				String sqlstr = "select * from Library.book ";
				if (textField.getText().length() > 0) {
					sqlstr += ("where " + textField.getText() + ";");
				} else {
					sqlstr += ";";
				}
				Vector<Vector<String>> sheet = Dao.findForVector(sqlstr);
				try {
					SearchBookResult frame = new SearchBookResult(sheet);
					frame.setVisible(true);
				} catch (Exception e1) {
					Utils.showAlert(String.format("%s", Utils.sprintStackTrace(e1)));
				}
			}
		});
		contentPane.add(searchButton, BorderLayout.SOUTH);
	}
}
