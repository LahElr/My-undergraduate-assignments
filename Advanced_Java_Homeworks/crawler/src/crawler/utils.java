package crawler;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.Scanner;
import java.util.concurrent.TimeUnit;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.select.Elements;

import com.alibaba.fastjson.JSONObject;

public class utils {
	// the random number generator, initialized when utils is first used.
	private static Random rand = new Random();

	// the Scanner used to accept input
	private static Scanner sc = new Scanner(System.in);

	/**
	 * generate the url to the hot list page with the targeted type and page number.
	 * 
	 * @param rh
	 * @param index : the targeted page number.
	 * @return
	 */
	public static String generateHotListURL(String rh, int index) {
		String UNIXTimestamp = Long.toString(System.currentTimeMillis() / 1000L);
		String url = String.format("http://www.amazon.cn/s?rh=%s&page=%d&qid=%s&ref=lp_658393051_pg_%d", rh, index,
				UNIXTimestamp, index);
		return url;
	}

	/**
	 * user-agents for different internet explorers
	 */
	private static final String[] ua = { "Mozilla/5.0 (Windows NT 6.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1",
			"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.16 Safari/537.36",
			"Mozilla/5.0 (Windows NT 6.1; Intel Mac OS X 10.6; rv:7.0.1) Gecko/20100101 Firefox/7.0.1",
			"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36 OPR/18.0.1284.68",
			"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0)",
			"Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)",
			"Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)",
			"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36",
			"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:2.0.1) Gecko/20100101 Firefox/4.0.1",
			"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:7.0.1) Gecko/20100101 Firefox/7.0.1",
			"Opera/9.80 (Macintosh; Intel Mac OS X 10.9.1) Presto/2.12.388 Version/12.16",
			"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36 OPR/18.0.1284.68",
			"Mozilla/5.0 (iPad; CPU OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) CriOS/30.0.1599.12 Mobile/11A465 Safari/8536.25",
			"Mozilla/5.0 (iPad; CPU OS 8_0 like Mac OS X) AppleWebKit/600.1.3 (KHTML, like Gecko) Version/8.0 Mobile/12A4345d Safari/600.1.4",
			"Mozilla/5.0 (iPad; CPU OS 7_0_2 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A501 Safari/9537.53",
			"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_8; en-us) AppleWebKit/534.50 (KHTML, like Gecko) Version/5.1 Safari/534.50",
			"User-Agent:Mozilla/5.0 (Windows; U; Windows NT 6.1; en-us) AppleWebKit/534.50 (KHTML, like Gecko) Version/5.1 Safari/534.50",
			"User-Agent:Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)",
			"User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)",
			"User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:2.0.1) Gecko/20100101 Firefox/4.0.1",
			"User-Agent:Mozilla/5.0 (Windows NT 6.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1",
			"User-Agent:Opera/9.80 (Macintosh; Intel Mac OS X 10.6.8; U; en) Presto/2.8.131 Version/11.11",
			"User-Agent:Opera/9.80 (Windows NT 6.1; U; en) Presto/2.8.131 Version/11.11",
			"User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.56 Safari/535.11",
			"User-Agent: Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Maxthon 2.0)",
			"User-Agent: Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; TencentTraveler 4.0)",
			"User-Agent: Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)",
			"User-Agent: Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; The World)",
			"User-Agent: Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; SE 2.X MetaSr 1.0; SE 2.X MetaSr 1.0; .NET CLR 2.0.50727; SE 2.X MetaSr 1.0)",
			"User-Agent: Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; 360SE)",
			"User-Agent: Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Avant Browser)",
			"User-Agent: Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)",
			"User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36 Edg/87.0.664.60" };

	/**
	 * Fetch the page and see if it's capthca page, if so, handle it.
	 * 
	 * @param url
	 * @return the fetched page
	 * @throws IOException
	 */
	public static org.jsoup.nodes.Document getDocument(String url) throws IOException {
		org.jsoup.nodes.Document document = linkTo(url);

		// captch handle
		if (document.title().equals("Amazon.cn")) {
			System.out.println("!");
			Elements captcha = document.select("div.a-row.a-text-center > img");
			String img_src = captcha.attr("src");
			System.out.println(img_src); // give the url to the captcha picture
			String captchaStr = sc.nextLine(); // get the captcha answer

			// generate the captcha answer url
			Elements ackUrlAttrs = document.select("div.a-box-inner.a-padding-extra-large > form > input");
			ArrayList<String> attrs = new ArrayList<String>();
			for (var ack : ackUrlAttrs) {
				var att = ack.attr("value");
				attrs.add(att);
			}

			// answer captcha
			org.jsoup.nodes.Document doc = linkTo("http://www.amazon.cn/" + "errors/validateCaptcha?" + "amzn="
					+ convertToUrlFormat(attrs.get(0)) + "&" + "amzn-r=" + convertToUrlFormat(attrs.get(1)) + "&"
					+ "field-keywords=" + captchaStr.strip());

			// output the captcha page and the answer for checking.
			PrintWriter blankOut = new PrintWriter(new BufferedWriter(
					new OutputStreamWriter(new FileOutputStream(new File(".\\blankPage.html")), "utf-8")));
			blankOut.write(document.toString());
			blankOut.flush();
			blankOut.close();

			PrintWriter blankAckOut = new PrintWriter(new BufferedWriter(
					new OutputStreamWriter(new FileOutputStream(new File(".\\blankAck.html")), "utf-8")));
			blankAckOut.write(doc.toString());
			blankAckOut.flush();
			blankAckOut.close();
		}
		return document;
	}

	/**
	 * convert a normal string to the specified format so it can be safely embedded
	 * into a url
	 * 
	 * @param original
	 * @return
	 */
	private static String convertToUrlFormat(String original) {
		StringBuilder strb = new StringBuilder();
		int len = original.length();
		for (int i = 0; i < len; i++) {
			Character ch = original.charAt(i);
			if (isUrlSafe(ch)) {
				strb.append(ch);

			} else {
				Integer asc = (int) ch.charValue();
				strb.append('%');
				strb.append(Integer.toString(asc, 16).toUpperCase().strip());
			}
		}
		return strb.toString();
	}

	/**
	 * see if this character can be safely embedded into a url
	 * @param ch
	 * @return
	 */
	private static boolean isUrlSafe(Character ch) {
		int chv = (int) ch.charValue();
		return ((chv <= (int) '9' && chv >= (int) '0') || (chv <= (int) 'z' && chv >= (int) 'a')
				|| (chv <= (int) 'Z' && chv >= (int) 'A') || chv == (int) '-' || chv == (int) '_');
	}

	/**
	 * pretend to be a random explorer, access the the url, fetch the page, and wait
	 * a random time.
	 * 
	 * @param url
	 * @return
	 * @throws IOException
	 */
	private static org.jsoup.nodes.Document linkTo(String url) throws IOException {
		// init connect
		Connection connect = Jsoup.connect(url);
		Map<String, String> header = new HashMap<String, String>();
		//forge a request header used by the browser
		header.put("Host", "http://info.bet007.com");
		String userAgent = ua[Math.abs(rand.nextInt(ua.length))];
		header.put("User-Agent", userAgent);
		header.put("Accept",
				"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9");
		header.put("Accept-Language", "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6,ja;q=0.5");
		header.put("Accept-Encoding", "gzip, deflate, br");
		header.put("Connection", "close"); //declare that the connection will be closed after the response
		header.put("DNT", "1");
		Connection data = connect.headers(header);
		//forge a cookie used by the browser
		Map<String, String> cookies = new HashMap<String, String>();
		cookies.put("session-id", "462-7637617-0706360");
		cookies.put("i18n-prefs", "CNY");
		cookies.put("ubid-acbcn", "459-7842879-4931662");
		cookies.put("session-token",
				"wl6R3H4MTk4TbZHU7AqgeLF9unf/wv71t7CgeMEu8nHryaKsdTubHhRi7R9B6LC8Fi/Y1ZvJ8o7d+cJKIfzOoTZLqeWUL7aSLG+g2T04v8kvKXqdtjN55Lr+/bE2XL1RTZF0vnRA7isIuyisMju6jmRc8hHOZza1Rhp+jCK5XKNYdXLnexMZzyxsywaYtqki");
		cookies.put("session-id-time", "2082729601l");
		cookies.put("csm-hit", "tb:s-M234GHEVSFW8KJ7SH9Z3|1607929456337&t:1607929456955&adb:adblk_no");
		cookies.put("ext_pgvwcount", "-0.1");
		org.jsoup.nodes.Document document = null;
		for (int i = 0; i < 10; i++) {
			try {
				// start connection and get the responce, than close the connection
				document = data.cookies(cookies).timeout(60000).get();
				break;
			} catch (java.net.SocketTimeoutException e) {
				System.out.printf("socket time out no. %d.\n", i);
			}
		}
		waitRandomMilliseconds();
		return document;
	}

	/**
	 * wait random time between 1450ms to 2450ms.
	 */
	public static void waitRandomMilliseconds() {
		try {
			TimeUnit.MILLISECONDS.sleep(1450 + rand.nextInt(1000));
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	/**
	 * delete all files in one folder but not delete this folder
	 * @param file
	 * @throws IOException
	 */
	public static void deleteFilesIn(File file) throws IOException {
		if (file == null || !file.exists()) {
			throw new IOException("file not exist!");
		}
		var files = file.listFiles();
		if (files.length == 0) {
			return;
		}
		for (File f : files) {
			if (f.isDirectory()) {
				deleteFilesIn(f);
				if (!f.delete()) {
					throw new IOException("file delete fail");
				}

			} else {
				if (!f.delete()) {
					throw new IOException("file delete fail");
				}
			}
		}
		return;
	}

}
