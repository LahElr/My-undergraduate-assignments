package priv.lahelr.onlinelib.client.netlink;

import java.io.BufferedInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;

import priv.lahelr.onlinelib.client.utils.Utils;
import priv.lahelr.onlinelib.netlink.Message;

/**
 * the static class that contains all functions about network
 * 
 * @author lahelr
 *
 */
public class Netlink {

	static Socket socketClient = null;
	static ObjectOutputStream sendStream = null;
	static ObjectInputStream recvStream = null;

	static {
		connect();
	}

	/**
	 * no instantiation
	 */
	private Netlink() {
	}

	/**
	 * get one message from the server
	 * 
	 * @return Message
	 */
	public static Message<?> getMessage() {
		assureConnection();// assure the connection
		Message ret = new Message();
		try {
			ret = (Message) recvStream.readObject();// read one object from the server
		} catch (ClassNotFoundException | IOException e) {
			Utils.showAlert(String.format("read stream failed for:\n%s.", Utils.sprintStackTrace(e)));
		}
		if (ret == null) {
			Utils.showAlert(String.format("read null object from stream."));
		}
		return ret;
	}

	/**
	 * send a message to the server
	 * 
	 * @param msg
	 * @return
	 */
	public static boolean sendMessage(Message msg) {
		assureConnection();// assure the connection
		boolean successed = true;
		try {
			sendStream.writeObject(msg);// write one object to the server
			sendStream.flush();// flush so the object is sent
		} catch (IOException e) {
			Utils.showAlert(String.format("read stream failed for:\n%s.", Utils.sprintStackTrace(e)));
			successed = false;
		}
		return successed;
	}

	/**
	 * connect to the server
	 * 
	 * @return
	 */
	private static Socket connectToServer() {
		// read the settings.json
		Object[] settings = { "127.0.0.1", 2653 };
		try {
			settings = Utils.getSettings();
		} catch (FileNotFoundException e) {
			Utils.showAlert("settings.json not found! Default settings are in use.");
		}
		String serverIP = (String) settings[0];
		int port = (int) settings[1];

		// get connection to the server by socket
		Socket client = null;
		try {
			client = new Socket(serverIP, port);
		} catch (Exception e) {
			Utils.showError(
					String.format("Connecting to server %s:%d failed.\n%s", serverIP, port, Utils.sprintStackTrace(e)));
		}
		Utils.showAlert(
				String.format("Connected to server %s:%d at: %s.", serverIP, port, client.getRemoteSocketAddress()));
		return client;
	}

	/**
	 * connect to server and init the input and output stream
	 */
	private static void connect() {
		socketClient = connectToServer();// connect and get the socket
		try {
			// init the stream
			sendStream = new ObjectOutputStream(socketClient.getOutputStream());
			recvStream = new ObjectInputStream(new BufferedInputStream(socketClient.getInputStream()));
		} catch (IOException e) {
			// report the error and exit
			Utils.showError(String.format("Creating stream to server failed:\n%s", Utils.sprintStackTrace(e)));
		}
	}

	/**
	 * assure that the connection is set
	 */
	private static void assureConnection() {
		try {
			// try send one byte to server, the urgent data will be discarded in default
			// setting of the server
			socketClient.sendUrgentData(255);
		} catch (IOException e) {
			// if the link failed, it means that the connection has stoped
			connect();
		}
	}

}
