package priv.lahelr.onlinelib.client.frame;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.util.Vector;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.border.EmptyBorder;
import javax.swing.table.TableColumn;

/**
 * the window that shows the result of searching readers
 * 
 * @author lahelr
 *
 */
public class SearchReaderResult extends JFrame {

	private static final long serialVersionUID = 2089843626023497503L;
	private JPanel contentPane;
	private JTable table;

	public SearchReaderResult(Vector<Vector<String>> sheet) {
		/**
		 * basic attrs of the frame
		 */
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		setBounds(200, 200, 700, 500);
		setTitle("Result");
		contentPane = new JPanel();
		contentPane.setSize(700, 100);
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(new BorderLayout(0, 0));

		/**
		 * the panel tha consists the result table
		 */
		JPanel panel = new JPanel();
		panel.setPreferredSize(new Dimension(700, 1000));

		/**
		 * set up the result table
		 */
		String[] colNamesA = { "reader id", "reader name" };
		Vector<String> colNames = new Vector<String>(2);
		for (int i = 0; i < 2; i++) {
			colNames.add(colNamesA[i]);
		}
		table = new JTable(sheet, colNames);
		table.setFillsViewportHeight(true);

		TableColumn col = null;
		// set (the init scale of) width of columns of the result table
		for (int i = 0; i < 2; i++) {
			col = table.getColumnModel().getColumn(i);
			switch (i) {
			case 0: {
				col.setPreferredWidth(150);
				break;
			}
			case 1: {
				col.setPreferredWidth(30);
				break;
			}
			}
		}

		table.setPreferredScrollableViewportSize(new Dimension(650, 402));// size of the table
		/*
		 * scroll pane. add the table to the scroll pane and then add the scroll pane to
		 * the content pane
		 */
		JScrollPane scrollPane = new JScrollPane(table, JScrollPane.VERTICAL_SCROLLBAR_ALWAYS,
				JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED) {
			private static final long serialVersionUID = 7226771644394597746L;

			@Override
			public Dimension getPreferredSize() {
				return new Dimension(650, 402);// set the scroll pane size
			}
		};

		panel.add(scrollPane);
		contentPane.add(panel, BorderLayout.CENTER);
	}

}
