package priv.lahelr.onlinelib.server.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

import com.alibaba.fastjson.JSONObject;

/**
 * the static class for sundry functions
 * 
 * @author lahelr
 *
 */
public class Utils {

	/**
	 * no instantiation
	 */
	private Utils() {
	}

	/**
	 * read the setting.json and get the settings.
	 * 
	 * @return Object[], the 0th is the port, the 1st is the timeout, both int
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
		// ret[0] = json.getString("serverIP");
		ret[0] = json.getIntValue("port");
		ret[1] = json.getIntValue("timeout");

		return ret;
	}

	/**
	 * show one error message
	 * 
	 * @param info
	 */
	public static void showError(String info) {
		System.out.printf("-------\nerror:\n%s;\n-------\n", info);
	}

	/**
	 * show one alert message
	 * 
	 * @param info
	 */
	public static void showAlert(String info) {
		System.out.printf("-------\nalert:\n%s;\n-------\n", info);
	}

	/**
	 * print the name and stack trace of one exception to a string
	 * 
	 * @param e
	 * @return
	 */
	public static String sprintStackTrace(Exception e) {
		StringBuilder sb = new StringBuilder();
		// get the name of the Exception
		sb.append(e.getClass().getName());
		sb.append("\n");
		// get the stack trace
		for (StackTraceElement i : e.getStackTrace()) {
			sb.append(i.toString());
			sb.append("\n");
		}
		return sb.toString();
	}
}
