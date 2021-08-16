package priv.lahelr.onlinelib.client.dao;

/**
 * the return of inserting one reader ot book into the table.
 * 
 * @author lahelr
 *
 */
public class InsertRet {

	private boolean done;/// < if the insertion is done successfully
	private int id;/// < the id of the newly inserted one

	public InsertRet(boolean done, int id) {
		this.done = done;
		this.id = id;
	}

	public boolean getDone() {
		return this.done;
	}

	public int getID() {
		return this.id;
	}

}
