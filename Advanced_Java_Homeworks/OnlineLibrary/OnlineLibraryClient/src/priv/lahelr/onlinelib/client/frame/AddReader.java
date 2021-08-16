package priv.lahelr.onlinelib.client.frame;

import java.awt.BorderLayout;
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
 * the window that allows user to add one user.
 * 
 * @author lahelr
 *
 */
public class AddReader extends JFrame {

	private static final long serialVersionUID = 1187332818703924870L;
	private JPanel contentPane;
	private JTextField readerNameTextField;

	/**
	 * Create the frame.
	 */
	public AddReader() {
		/**
		 * basic attrs of the frame
		 */
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		setTitle("Welcome a new reader");
		setBounds(100, 100, 450, 100);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);

		JLabel readerNameLabel = new JLabel("Reader Name", JLabel.CENTER);
		contentPane.add(readerNameLabel, BorderLayout.WEST);

		readerNameTextField = new JTextField();
		contentPane.add(readerNameTextField, BorderLayout.CENTER);
		readerNameTextField.setColumns(10);

		/**
		 * the button shows Apply and it's listener
		 */
		JButton applyButton = new JButton("Apply");
		applyButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if (readerNameTextField.getText().length() == 0) {
					Utils.showAlert("Name of the new reader can't be null.");
				} else {
					InsertRet insertResult = Dao.addReader(readerNameTextField.getText());
					boolean insertDone = insertResult.getDone();
					if (!insertDone) {
						Utils.showAlert("Insert failed for unknown reason.");
					} else {
						Utils.showAlert(String.format("The reader ID for %s is %d.", readerNameTextField.getText(),
								insertResult.getID()));
					}
				}
			}
		});
		contentPane.add(applyButton, BorderLayout.SOUTH);
	}

}
