package priv.lahelr.onlinelib.client.frame;

import java.awt.BorderLayout;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.border.EmptyBorder;

/**
 * the alert frame that shows one alert
 * 
 * @author lahelr
 *
 */
public class Alert extends JFrame {

	private static final long serialVersionUID = -7697398604457636508L;
	private JPanel contentPane;

	public Alert(String AlertInfo) {
		/**
		 * add one text area in a scroll pane and put the scroll pane into the content
		 * pane
		 */
		JTextArea contentText = new JTextArea(AlertInfo);
		getContentPane().add(contentText, BorderLayout.CENTER);
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		setTitle("Notice");
		setBounds(540, 250, 450, 400);
		JScrollPane scrollPane = new JScrollPane(contentText);
		scrollPane.setBounds(540, 250, 450, 400);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		contentPane.add(scrollPane, BorderLayout.CENTER);
		setContentPane(contentPane);
	}

}
