package priv.lahelr.onlinelib.server;

import java.io.BufferedInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.sql.SQLException;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import javax.sql.rowset.CachedRowSet;
import javax.sql.rowset.RowSetFactory;
import javax.sql.rowset.RowSetProvider;

import priv.lahelr.onlinelib.netlink.Message;
import priv.lahelr.onlinelib.netlink.MessageType;
import priv.lahelr.onlinelib.netlink.SQLCmdType;
import priv.lahelr.onlinelib.server.dba.Dba;
import priv.lahelr.onlinelib.server.utils.Utils;

/**
 * main class of the server
 * 
 * @author lahelr
 *
 */
public class ServerMain {
	/*
	 * volatile boolean to announce that the server is stoped. this var doesnot need
	 * a lock to protect it because it will only be written once, at only one
	 * place, and all other operations to it will be read
	 */
	volatile private static boolean stop = false;
	volatile private static Integer clientCount = 0;

	/**
	 * entry of the server
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		// read settings.json
		Object[] settings = {2653,777};
		int port;
		int timeout;
		try {
			settings = Utils.getSettings();
		} catch (FileNotFoundException e) {
			Utils.showError("Unable to find settings.json file!");
		}
		port = (Integer) settings[0];
		timeout = (Integer) settings[1];
		Utils.showAlert(String.format("server started. Using port: %d. Using Timeout: %dms\n", port, timeout));

		/**
		 * Start listening
		 */
		final ServerSocket serSocket;
		try {
			serSocket = new ServerSocket(port);
		} catch (IOException e1) {
			Utils.showError(String.format("Cannot create server socket:\n%s", Utils.sprintStackTrace(e1)));
			return;
		}

		/**
		 * the exiter thread: wait for a 'q' character is inputed, then call all threads
		 * to stop
		 */
		new Thread(new Runnable() {
			public void run() {
				while (true) {
					char i = 0;
					try {
						i = (char) System.in.read();
					} catch (IOException e) {
					}
					if (i == 'q') {
						try {
							serSocket.close();
						} catch (IOException e) {
						}
						/**
						 * announce that the server is quitting and request all listening threads
						 * release resources and stop
						 */
						stop = true;
						break;
						// System.exit(0);
					}
				}
			}
		}).start();

		/**
		 * while loop to accept clients and start their listening threads
		 */
		boolean ser_fin_main = false;
		while (true) {
			Socket cliSocket;
			try {
				cliSocket = serSocket.accept();
				cliSocket.setSoTimeout(timeout);
				handleClient(cliSocket);// handle this client
			} catch (IOException e) {
				Utils.showError(String.format("An I/O error occurs when waiting for a connection:\n%s",
						Utils.sprintStackTrace(e)));
			}
			if (stop) {
				break;
			}
		}

	}

	/**
	 * start a new thread to handle this client, stop after socket timeout or the
	 * user quits
	 * 
	 * @param socket
	 */
	private static void handleClient(final Socket socket) {
		new Thread(new Runnable() {
			public void run() {
				int clientID;
				boolean ser_fin_1 = false;
				boolean ser_fin_2 = false;
				synchronized (clientCount) {
					// notice
					clientCount++;
					clientID = clientCount;
					System.out.printf("Caught client no.%d at %s.\n", clientCount, socket.toString());
				}
				ObjectInputStream recvStream = null;
				ObjectOutputStream sendStream = null;

				try {
					recvStream = new ObjectInputStream(new BufferedInputStream(socket.getInputStream()));
					sendStream = new ObjectOutputStream(socket.getOutputStream());

					while (true) {

						Message<?> msg = null;
						try {
							msg = (Message<?>) recvStream.readObject(); // read one object sent from the client
						} catch (ClassNotFoundException e) {
							Utils.showError(String.format("Error in reading object:\n%s", Utils.sprintStackTrace(e)));
						}
						Message sendBackMsg = handleMessage(msg);// what should i send back
						sendStream.writeObject(sendBackMsg);
						sendStream.flush();
						Utils.showAlert(String.format("Finished sending message to %s.\n", socket.toString()));

						/*
						 * the readObject() function will block until timeout, so it is impossible to
						 * watch on the stop to stop this thread
						 */

					}
				} catch (SocketTimeoutException e) {
					Utils.showError(
							String.format("Connection to client at %s stoped due to timeout.", socket.toString()));
				} catch (IOException e) {
					Utils.showError(String.format("Connection to client at %s stoped:\n%s", socket.toString(),
							Utils.sprintStackTrace(e)));
				} finally {
					// release resource
					try {
						recvStream.close();
					} catch (IOException e) {
						// e.printStackTrace();
					}
					try {
						sendStream.close();
					} catch (IOException e) {
						// e.printStackTrace();
					}
					try {
						socket.close();
					} catch (IOException e) {
						// e.printStackTrace();
					}

					synchronized (clientCount) {
						clientCount--;
						if (clientCount <= 0) {
							ser_fin_1 = true;
						}
					}
					// notice
					Utils.showAlert(String.format("Connection to client no.%d at %s has been released.", clientID,
							socket.toString()));
					if (ser_fin_1 && stop) {
						Utils.showAlert("All threads has finished and server is now safely quited.");
					}
				}

			}
		}).start();

	}

	/**
	 * see what should we do to the message sent from the client
	 * 
	 * @param msg
	 * @return the message to be sent back
	 */
	private static Message<?> handleMessage(Message<?> msg) {
		if (!(msg.contentClassStr.equals(String.class.getName()))) {
			// if it is not a string, which means, it's not a sql command, then we should
			// send an error message back
			Message<String> ret = new Message<String>();
			ret.cmdType = SQLCmdType.nocmd.ordinal();
			ret.msgType = MessageType.Error.ordinal();
			ret.content = "Unknown type.";
			ret.contentClassStr = ret.content.getClass().getName();
			ret.contentClass = ret.content.getClass();
			try {
				Utils.showAlert(String.format("Finished handling message %s:%s.\n",
						MessageType.values()[msg.cmdType].toString(), msg.content.toString()));
			} catch (ArrayIndexOutOfBoundsException e) {
				Utils.showAlert(
						String.format("Finished handling message %s:%s.\n", msg.cmdType, msg.content.toString()));
			}
			return ret;
		}
		if (msg.cmdType == SQLCmdType.findForResultSet.ordinal()) {
			// the client wants us to handle the query with the findForResultSet function
			Message<CachedRowSet> ret = new Message<CachedRowSet>();
			ret.cmdType = msg.cmdType;
			ret.msgType = MessageType.Content.ordinal();
			// do the query and convert the ResultSet to a CachedRowSet so that it can be
			// sent to the client
			try {
				RowSetFactory rowSetFac = RowSetProvider.newFactory();
				ret.content = rowSetFac.createCachedRowSet();
				ret.content.populate(Dba.findForResultSet((String) msg.content));
			} catch (SQLException e) {
				Utils.showError(String.format("SQL access error while handling message %s:%s:\n%s\n",
						MessageType.values()[msg.cmdType], msg.content.toString(), Utils.sprintStackTrace(e)));
				// send an error message back
				Message<String> err = new Message<String>();
				err.cmdType = SQLCmdType.nocmd.ordinal();
				err.content = "Unable to search by this term.";
				err.contentClass = String.class;
				err.contentClassStr = String.class.getName();
				err.msgType = MessageType.Error.ordinal();
				return err;
			}
			ret.contentClassStr = ret.content.getClass().getName();
			ret.contentClass = ret.content.getClass();
			try {
				Utils.showAlert(String.format("Finished handling message %s:%s.\n",
						MessageType.values()[msg.cmdType].toString(), msg.content.toString()));
			} catch (ArrayIndexOutOfBoundsException e) {
				Utils.showAlert(
						String.format("Finished handling message %s:%s.\n", msg.cmdType, msg.content.toString()));
			}
			return ret;
		} else if (msg.cmdType == SQLCmdType.insert.ordinal()) {
			// the client wants us to handle the query with the insert function
			Message<Boolean> ret = new Message<Boolean>();
			ret.cmdType = msg.cmdType;
			ret.msgType = MessageType.Content.ordinal();
			ret.content = Dba.insert((String) msg.content);// do the query
			ret.contentClassStr = ret.content.getClass().getName();
			ret.contentClass = ret.content.getClass();
			try {
				Utils.showAlert(String.format("Finished handling message %s:%s.\n",
						MessageType.values()[msg.cmdType].toString(), msg.content.toString()));
			} catch (ArrayIndexOutOfBoundsException e) {
				Utils.showAlert(
						String.format("Finished handling message %s:%s.\n", msg.cmdType, msg.content.toString()));
			}
			return ret;
		} else if (msg.cmdType == SQLCmdType.update.ordinal()) {
			// the client wants us to handle the query with the update function
			Message<Integer> ret = new Message<Integer>();
			ret.cmdType = msg.cmdType;
			ret.msgType = MessageType.Content.ordinal();
			ret.content = Dba.update((String) msg.content);// do the query
			ret.contentClassStr = ret.content.getClass().getName();
			ret.contentClass = ret.content.getClass();
			try {
				Utils.showAlert(String.format("Finished handling message %s:%s.\n",
						MessageType.values()[msg.cmdType].toString(), msg.content.toString()));
			} catch (ArrayIndexOutOfBoundsException e) {
				Utils.showAlert(
						String.format("Finished handling message %s:%s.\n", msg.cmdType, msg.content.toString()));
			}
			return ret;
		} else {
			// the client sent something strange and we don't know what the client want to
			// do, so we send an error message back
			Message<String> ret = new Message<String>();
			ret.cmdType = SQLCmdType.nocmd.ordinal();
			ret.msgType = MessageType.Error.ordinal();
			ret.content = "Unknown cmd.";
			ret.contentClassStr = ret.content.getClass().getName();
			ret.contentClass = ret.content.getClass();
			try {
				Utils.showAlert(String.format("Finished handling message %s:%s.\n",
						MessageType.values()[msg.cmdType].toString(), msg.content.toString()));
			} catch (ArrayIndexOutOfBoundsException e) {
				Utils.showAlert(
						String.format("Finished handling message %s:%s.\n", msg.cmdType, msg.content.toString()));
			}
			return ret;
		}
	}
}
