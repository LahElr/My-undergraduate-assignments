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
 * the window that shows the result of searching borrowing status
 * 
 * @author lahelr
 *
 */
public class SearchBorrowingResult extends JFrame {

	private static final long serialVersionUID = -4429328376803409518L;
	private JPanel contentPane;
	private JTable table;

	public SearchBorrowingResult(Vector<Vector<String>> sheet) {

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

		/**
		 * set up the result table
		 */
		String[] colNamesA = { "reader name", "reader ID", "book ID", "book name", "book ISBN" };
		Vector<String> colNames = new Vector<String>(5);
		for (int i = 0; i < 5; i++) {
			colNames.add(colNamesA[i]);
		}
		table = new JTable(sheet, colNames);
		table.setFillsViewportHeight(true);
		// table.setEnabled(false);

		TableColumn col = null;
		// set (the init scale of) width of columns of the result table
		for (int i = 0; i < 5; i++) {
			col = table.getColumnModel().getColumn(i);
			switch (i) {
			case 0: {
				col.setPreferredWidth(120);
				break;
			}
			case 1: {
				col.setPreferredWidth(30);
				break;
			}
			case 2: {
				col.setPreferredWidth(30);
				break;
			}
			case 3: {
				col.setPreferredWidth(150);
				break;
			}
			case 4: {
				col.setPreferredWidth(70);
				break;
			}
			}
		}
		table.setPreferredScrollableViewportSize(new Dimension(650, 402));
		/*
		 * scroll pane. add the table to the scroll pane and then add the scroll pane to
		 * the content pane
		 */
		JScrollPane scrollPane = new JScrollPane(table, JScrollPane.VERTICAL_SCROLLBAR_ALWAYS,
				JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED) {
			private static final long serialVersionUID = 3706697683703120720L;

			@Override
			public Dimension getPreferredSize() {
				return new Dimension(650, 402);
			}
		};

		panel.add(scrollPane);
		contentPane.add(panel, BorderLayout.CENTER);
	}

}
