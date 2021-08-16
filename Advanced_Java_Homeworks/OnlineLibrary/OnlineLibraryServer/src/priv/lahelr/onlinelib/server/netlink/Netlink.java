package priv.lahelr.onlinelib.server.netlink;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import priv.lahelr.onlinelib.netlink.Message;
import priv.lahelr.onlinelib.server.utils.Utils;

/**
 * Class fot net processing,<br>
 * no instantiation is allowed
 * 
 * @author lahelr
 *
 */
public class Netlink {
	/**
	 * no instantiation
	 */
	private Netlink() {
	}

	/**
	 * get one message from the client
	 * 
	 * @param recvStream
	 * @return
	 */
	public static Message getMessage(ObjectInputStream recvStream) {
		Message ret = new Message();
		try {
			ret = (Message) recvStream.readObject();// read the Message from the stream
		} catch (ClassNotFoundException | IOException e) {
			Utils.showAlert(String.format("read stream failed for:\n%s.", Utils.sprintStackTrace(e)));
		}
		if (ret == null) {
			Utils.showAlert(String.format("read null object from stream."));
		}
		return ret;
	}

	/**
	 * send one message to the client
	 * 
	 * @param msg
	 * @param sendStream
	 * @return
	 */
	public static boolean sendMessage(Message msg, ObjectOutputStream sendStream) {
		boolean successed = true;
		try {
			// write the Message to the stream and flush, so it is sent
			sendStream.writeObject(msg);
			sendStream.flush();
		} catch (IOException e) {
			Utils.showAlert(String.format("read stream failed for:\n%s.", Utils.sprintStackTrace(e)));
			successed = false;
		}
		return successed;
	}
}
