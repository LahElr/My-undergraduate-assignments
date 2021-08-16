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
 * the window where users using advanced searching to search readers
 * 
 * @author lahelr
 *
 */
public class SearchReaderAdvan extends JFrame {

	private static final long serialVersionUID = 5992137058750260295L;
	private JPanel contentPane;
	private JTextField textField;

	/**
	 * Create the frame.
	 */
	public SearchReaderAdvan() {
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
		 * the text field that accepts the advanced searching statement
		 */
		textField = new JTextField();
		contentPane.add(textField, BorderLayout.CENTER);
		textField.setColumns(10);

		/**
		 * the button that do searching
		 */
		JButton btnNewButton = new JButton("Search");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				// gen the sql string
				String sqlstr = "select * from Library.reader ";
				if (textField.getText().length() > 0) {
					sqlstr += ("where " + textField.getText() + ";");
				} else {
					sqlstr += ";";
				}
				Vector<Vector<String>> sheet = Dao.findForVector(sqlstr);
				try {
					SearchReaderResult frame = new SearchReaderResult(sheet);
					frame.setVisible(true);
				} catch (Exception e1) {
					Utils.showAlert(String.format("%s", Utils.sprintStackTrace(e1)));
				}
			}
		});
		contentPane.add(btnNewButton, BorderLayout.SOUTH);
	}
}
