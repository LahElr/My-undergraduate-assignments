package priv.lahelr.onlinelib.client.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

import com.alibaba.fastjson.JSONObject;

import priv.lahelr.onlinelib.client.frame.Alert;
import priv.lahelr.onlinelib.client.frame.ErrorAlert;

/**
 * the static class for sundry functions
 * 
 * @author lahelr
 *
 */
public class Utils {
	private Utils() {
	}

	/**
	 * read in the settings.json to know where to find indices and infos.
	 * 
	 * @return Object[2], the [0] is the serverName, String, the [1] is the port,
	 *         Integer.
	 * @throws FileNotFoundException
	 */
	public static Object[] getSettings() throws FileNotFoundException {
		Scanner scanner = new Scanner(new File(".//settings.json"));
		StringBuilder strBuilder = new StringBuilder();
		while (scanner.hasNextLine()) {
			strBuilder.append(scanner.nextLine());
		}
		JSONObject json = JSONObject.parseObject(strBuilder.toString());
		Object[] ret = new Object[2];
		ret[0] = json.getString("serverIP");
		ret[1] = json.getIntValue("port");

		return ret;
	}

	/**
	 * show error in one window and exit the program after the window is closed
	 * @param info
	 */
	public static void showError(String info) {
		try {
			ErrorAlert frame = new ErrorAlert(info);
			frame.setVisible(true);
			frame.pack();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * show alert or notice in one window
	 * @param info
	 */
	public static void showAlert(String info) {
		try {
			Alert frame = new Alert(info);
			frame.setVisible(true);
			frame.pack();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * print the name and stack trace of one exception to a string
	 * 
	 * @param e
	 * @return
	 */
	public static String sprintStackTrace(Exception e) {
		StringBuilder sb = new StringBuilder();
		sb.append(e.getClass().getName());
		sb.append("\n");
		for (StackTraceElement i : e.getStackTrace()) {
			sb.append(i.toString());
			sb.append("\n");
		}
		return sb.toString();
	}
}
