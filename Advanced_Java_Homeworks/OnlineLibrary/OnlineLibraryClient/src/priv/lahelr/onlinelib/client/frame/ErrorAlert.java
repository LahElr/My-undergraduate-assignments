package priv.lahelr.onlinelib.client.frame;

import java.awt.BorderLayout;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.border.EmptyBorder;

/**
 * the alert frame that shows one error
 * 
 * @author lahelr
 *
 */
public class ErrorAlert extends JFrame {

	private static final long serialVersionUID = -5828730189755969877L;
	private JPanel contentPane;

	public ErrorAlert(String AlertInfo) {
		/**
		 * add one text area in a scroll pane and put the scroll pane into the content
		 * pane
		 */
		JTextArea contentText = new JTextArea(AlertInfo);
		getContentPane().add(contentText, BorderLayout.CENTER);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setTitle("Error");
		setBounds(640, 250, 450, 400);
		JScrollPane scrollPane = new JScrollPane(contentText);
		scrollPane.setBounds(540, 250, 450, 400);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		contentPane.add(scrollPane, BorderLayout.CENTER);
		setContentPane(contentPane);
	}

}
