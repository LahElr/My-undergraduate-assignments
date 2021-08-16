package crawler;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.ConnectException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;
import java.util.Scanner;
import java.util.regex.Pattern;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.document.DoubleField;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.wltea.analyzer.lucene.IKAnalyzer;

import com.alibaba.fastjson.JSONObject;

public class main {
	private static String indexPath; // the dir where all lucene indices are stored
	private static File indexDir = null;
	private static String infoPath; // the dir where all fetched info are stored.
	private static Random rand = new Random(); // the random number generator
	private static int maxListPage = 2;// the max page number of the hot list we fetch.

	public static void main(String[] args) throws Exception {
		System.out.println("crawler started.");// hint
		String[] settings = { "..\\crawled", "..\\indices" };// default values
		try {
			settings = getSettings();// get actual settings from settings.json
			indexPath = settings[1];
			infoPath = settings[0];
		} catch (FileNotFoundException e) {
			// e.printStackTrace();
			System.out.println("settings.json lost.Default settings have been applied.");
		}
		// hint the settings.
		System.out.printf("Using %s as path to book records.\n", settings[0]);
		System.out.printf("Using %s as path to lucene indices.\n", settings[1]);
		System.out.printf("Using max list page number : %d.\n", maxListPage);

		// make sure the path exists and clean
		indexDir = new File(indexPath);
		if (!indexDir.exists()) {
			indexDir.mkdir();
		} else {
			try {
				utils.deleteFilesIn(indexDir);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		File infoDir = new File(infoPath);
		if (!infoDir.exists()) {
			infoDir.mkdir();
		} else {
			try {
				utils.deleteFilesIn(infoDir);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		// get these types of books:
		getBooksByType("n%3A658390051%2Cn%3A%21658391051%2Cn%3A658416051", "law");
		getBooksByType("n%3A658390051%2Cn%3A%21658391051%2Cn%3A658393051", "novel");
		getBooksByType("n%3A658390051%2Cn%3A%21658391051%2Cn%3A658409051", "children");
		getBooksByType("n%3A658390051%2Cn%3A%21658391051%2Cn%3A658429051", "science");
		getBooksByType("n%3A658390051%2Cn%3A%21658391051%2Cn%3A658414051", "IT");
		getBooksByType("n%3A658390051%2Cn%3A%21658391051%2Cn%3A658431051", "technology");
		getBooksByType("n%3A658390051%2Cn%3A%21658391051%2Cn%3A2045366051", "foreign");
		getBooksByType("n%3A658390051%2Cn%3A%21658391051%2Cn%3A658418051", "history");
		getBooksByType("n%3A658390051%2Cn%3A%21658391051%2Cn%3A118362071", "social");
		getBooksByType("n%3A658390051%2Cn%3A%21658391051%2Cn%3A658428051", "medicine");

		// hint
		System.out.println("crawler finished.");
	}

	/**
	 * get book infomation by the hot list of the type.
	 * 
	 * @param typeID   : the ID string of the type
	 * @param typeName : the name of the type
	 * @throws Exception
	 */
	private static void getBooksByType(String typeID, String typeName) throws Exception {
		// make store dir
		File typeEntry = new File(String.format("%s\\%s", infoPath, typeName));
		typeEntry.mkdir();

		// hint of running time
		System.out.printf("----------\n\n");
		Date startDate = new Date();
		long startTime = startDate.getTime();
		System.out.printf("Looking into type %s, start time: %s.\n", typeName, startDate.toString());
		System.out.printf("----------\n\n");

		/**
		 * Search for pages of hot lists of the type. We start from page 2 because the
		 * first page uses a different url and html structure
		 */
		for (int hotListIndex = 2; hotListIndex <= maxListPage; hotListIndex++) {
			// generate the url to the targeted page of the targeted type
			String hotListURL = utils.generateHotListURL(typeID, hotListIndex);
			try {
				// get the target page
				org.jsoup.nodes.Document hotListPage = utils.getDocument(hotListURL); // link and fetch

				/**
				 * Processing start.
				 */
				// select the urls of the hot books in this page, traverse the list and fetch
				// these all books
				Elements hots = hotListPage.select("div.s-result-list.s-search-results.sg-row").select("[data-asin]");
				for (int i = 0; i < hots.size(); i++) {
					Element hot = hots.get(i); // get the element
					Elements attrs = hot.select("[href]");
					String bookHref = attrs.attr("href"); // pick the hrefs in the list
					String ASIN = hot.attr("data-asin"); // pick the ASIN number of the book
					// filter out the urls point to books
					if (Pattern.matches("/dp/.*",
							bookHref) /* && !Pattern.matches(".*dchild=[1234567890]", bookHref) */) {
						String bookUrl = "http://amazon.cn" + bookHref; // the url to be used to link
						try {
							getBook(bookUrl, typeName, ASIN); // get the info of the book
						} catch (IOException e) {
							// e.printStackTrace();
							System.out.printf("Trying in getting book from %s failed \nfor %s.\n", bookUrl,
									e.toString());
						}
					}
				}
			} catch (IOException e) {
				// e.printStackTrace();
				System.out.printf("Trying in fetching list from %s failed \nfor %s.\n", hotListURL, e.toString());
			}
		}

		// notice the end time and the time cost in this type.
		System.out.printf("----------\n\n");
		Date endDate = new Date();
		long endTime = endDate.getTime();
		System.out.printf("Looking into type %s, start time: %s, end time: %s, time used: %d.\n", typeName,
				startDate.toString(), endDate.toString(), endTime - startTime);
		System.out.printf("----------\n\n");
	}

	/**
	 * get the book info by the url pointed to its detail page
	 * 
	 * @param bookUrl
	 * @param bookTypeName
	 * @param ASIN
	 * @throws IOException
	 */
	private static void getBook(String bookUrl, String bookTypeName, String ASIN) throws IOException {
		System.out.printf("looking at book at : %s\n", bookUrl); // notice
		// set the file to store and create it
		File bookFile = new File(String.format("%s\\%s\\%s.txt", infoPath, bookTypeName, ASIN));// the file to store
		/**
		 * check if this book already exists in this type if yes, we move to next book,
		 * else we create the file to record the book
		 */
		if (!bookFile.exists()) {
			bookFile.createNewFile();
		} else {
			System.out.println("this book already exists.");
			return;
		}

		org.jsoup.nodes.Document document = null;// the parsed document

		/**
		 * Continue fetching the page until there's no exception in it. in this
		 * particular condition, this means the page is finally fetches after some
		 * connection failures. If the connection problems can't be solved, it will move
		 * to next page after 7 tries. The captcha proplem will be handled in the
		 * utils.getDocument method.
		 */
		for (int i = 0; i < 7; i++) {
			try {
				document = utils.getDocument(bookUrl); // fetch the book page
			} catch (IOException e) {
				if (i >= 6) {
					return; // move to next page.
				}
				continue;
			}
			break;
		}

		// prepare the PrintWriter for writing the file.
		PrintWriter out = new PrintWriter(
				new BufferedWriter(new OutputStreamWriter(new FileOutputStream(bookFile), "utf-8")));

		// detail bullets including publishers, versions etc.
		Elements details = document.select(
				"div#detailBullets_feature_div > ul.a-unordered-list.a-nostyle.a-vertical.a-spacing-none.detail-bullet-list");
		// get the title of entries and their values, into two lists
		Elements detailKeys = details.select("span.a-text-bold");
		Elements detailValues = details.select("span:not(.a-text-bold):not(.a-list-item)");
		// if the number of entries and values are not the same
		if (detailKeys.size() != detailValues.size()) {
			System.out.printf("! details not aligned %d %d.\n", detailKeys.size(), detailValues.size());
			// It's a fault, but it's not necessary to quit.
			// If you quit here, remember to relese resources.
			// out.close();
			// bookFile.delete();
			// return;
		}
		int detailLen = Math.min(detailKeys.size(), detailValues.size());

		// ArrayList of Strings to store the keys and values.
		ArrayList<String> detailKeyStrings = new ArrayList<String>();
		ArrayList<String> detailValueStrings = new ArrayList<String>();

		// store them into the arraylists
		for (int i = 0; i < detailLen; i++) {
			Element detailKey = detailKeys.get(i);
			Element detailValue = detailValues.get(i);
			detailKeyStrings.add(detailKey.text());
			detailValueStrings.add(detailValue.text());
		}

		// the picture of the book
		Elements pic = document.select("div#ebooks-img-canvas.a-section > img");
		detailValueStrings.add(pic.attr("src"));
		detailKeyStrings.add("图片 :");

		// the title of the book, usually amazon will add some advertisment, at
		// everywhere the title appears, so it's impossible to filter them out.
		Elements title = document.select("h1#title.a-spacing-none.a-text-normal > span#productTitle");
		detailValueStrings.add(title.text());
		detailKeyStrings.add("标题 :");

		// the subtitle of the book, usually "Kindle电子书"
		Elements subTitle = document.select("h1#title.a-spacing-none.a-text-normal > span#productSubtitle");
		detailValueStrings.add(subTitle.text());
		detailKeyStrings.add("副标题 :");

		// the price of the book
		Elements price = document
				.select("td.a-color-price.a-size-medium.a-align-bottom > span.a-size-medium.a-color-price");
		String priceString = price.text().replaceAll("[^1234567890.]", ""); // use a regexpr to make sure it's a
																			// number
		detailValueStrings.add(priceString);
		detailKeyStrings.add("价格 :");

		/**
		 * The descriptions of the book, including intrduction, editorial reviews,
		 * etc.In most times, amazon would insert many unconcered info (mostly
		 * advertisments), mixed with useful info, we have to choose the last few items
		 * and the count must match the count of the subtitles.
		 */
		String patternString = "(("; // generate the regexpr used to split text by the subtitles of the descriptions
		// select the subtitles of the descriptions
		Elements descriptionTitles = document.select("div#bookDescription_feature_div.celwidget > noscript > div > h3");
		int descriptionTitleCt = 0; // the count of the subtitles of the descriptions

		// find the titles of the subjections, record them and count them.
		for (int i = 0; i < descriptionTitles.size(); i++) {
			// get the ith subtitle
			Element descriptionTitle = descriptionTitles.get(i);
			String descriptionTitleString = descriptionTitle.text();

			// filter out the titles of the subjections.
			// this regexpr cannot cover all format of these subtitles, but I tried
			if (!Pattern.matches(".*:|.*：|\\[.*\\]|【.*】|.*简介.*|.*推荐.*|.*内容.*", descriptionTitleString)) {
				continue;
			}
			descriptionTitleCt++; // count them
			detailKeyStrings.add(descriptionTitleString); // add to the list
			// add one item into the spliter regexpr
			patternString = patternString + (descriptionTitleCt == 1 ? "" : ")|(") + descriptionTitle.text();
		}
		// get the whole text of this part of the page
		Elements description = document.select("div#bookDescription_feature_div.celwidget > noscript > div");
		patternString = patternString + "))"; // finish the generation of the spliter regexpr

		// Split the text by the subtitles to find the contents of the subjections.
		String[] descriptions = description.text().split(patternString);

		if (descriptionTitleCt == 0 && descriptions.length > 0) {
			// there's no subtitle but description text
			detailValueStrings.add(description.text());
			detailKeyStrings.add("简介：");
		} else if (descriptions.length > 0) {
			// pick the last ones into the list
			for (int i = descriptions.length - descriptionTitleCt; i < descriptions.length; i++) {
				String descriptionSub = descriptions[i];
				detailValueStrings.add(descriptionSub);
			}
		} else {
			// there're subtitles but no contents
			for (int i = 0; i < descriptionTitleCt; i++) {
				detailKeyStrings.remove(detailKeyStrings.size() - 1); // pop them all
			}
		}

		// check if the count of the title and content are the same.
		if (detailKeyStrings.size() != detailValueStrings.size()) {
			System.out.printf("!! details not aligned %d %d.\n", detailKeyStrings.size(), detailValueStrings.size());
			// this fault is not severe that need to quit too, but if you want to quit,
			// remember to relese resources
		}

		// write all info into the file.
		StringBuilder content = new StringBuilder();
		for (int i = 0; i < detailKeyStrings.size(); i++) {
			String thisLine = String.format("%s %s\r\n", detailKeyStrings.get(i), detailValueStrings.get(i));
			out.print(thisLine);
			content.append(thisLine);
		}

		// flush and close the file
		out.flush();
		out.close();

		/**
		 * Sometimes the page has a different html structure, usually these pages are
		 * advertisment links mixed in the hot list, whose href is finished whth
		 * "d-child=" and an integer(usually 1), if we've fetches this kind of pages,
		 * the file would be an almost empty file, consists only the link to the picture
		 * and some titles, the feature is that the file would be small, usually smaller
		 * than 200 bytes. If this kind of pages have been fetched and parsed
		 * uncorrectly, we filter them out here.
		 */
		if (bookFile.length() < 200) {
			bookFile.delete();
			// hint
			System.out.printf("Wrong format page, ignored: \n%s\n", document.title());
		} else {
			/**
			 * Write the index. We first open the index and than add the record of this book
			 * into it. The infomation inserted into the indices consists: the record file
			 * path, the record file name, the ASIN code of this book, the price of this
			 * book, and the full content of this book. Notice that with the Chinese text
			 * analyzer IKAnzlyzer, all English words may not be indexed correctly and thus
			 * cannot be searches correctly.
			 */
			Directory dir = FSDirectory.open(indexDir);
			Analyzer analyzer = new IKAnalyzer();
			IndexWriterConfig conf = new IndexWriterConfig(Version.LUCENE_4_10_0, analyzer);
			IndexWriter iwr = new IndexWriter(dir, conf);// create index writer

			// open one lucene document. notice the class name.
			org.apache.lucene.document.Document indexDoc = new org.apache.lucene.document.Document();

			// add the string field of file name
			Field fileNameField = new StringField("filename",
					String.format("%s\\%s\\%s.txt", infoPath, bookTypeName, ASIN), Field.Store.YES);
			// add the text field of file content
			Field fileContentField = new TextField("filecontent", content.toString(), Field.Store.YES);
			indexDoc.add(fileNameField);
			indexDoc.add(fileContentField);
			try {
				// add the double field of file price
				Field filePriceField = new DoubleField("fileprice", Double.parseDouble(priceString), Field.Store.YES);
				indexDoc.add(filePriceField);
			} catch (NumberFormatException e) {
				// if the priceString cannot be parsed to double correctly
				Field filePriceField = new DoubleField("fileprice", (double) (0.0), Field.Store.YES);
				indexDoc.add(filePriceField);
			}
			// add the string field of ASIN code
			Field fileASINField = new StringField("fileasin", ASIN, Field.Store.YES);
			indexDoc.add(fileASINField);
			// add the string field of file type
			Field fileTypeField = new StringField("filetype", bookTypeName, Field.Store.YES);
			indexDoc.add(fileTypeField);
			// add the text field of file title
			Field fileTitleField = new TextField("filetitle", title.text(), Field.Store.YES);
			indexDoc.add(fileTitleField);
			// add the text field of file url
			Field fileUrlField = new TextField("fileurl", bookUrl, Field.Store.YES);
			indexDoc.add(fileUrlField);

			iwr.addDocument(indexDoc);// add the document to lucene lndices
			iwr.close();
			// notice
			System.out.printf("finished at looking at book %s.\n", document.title());
		}
	}

	/**
	 * read in the settings.json to know where to find indices and infos.
	 * 
	 * @return String[2], the [0] is the infoPath, the [1] is the indexPath.
	 * @throws FileNotFoundException
	 */
	private static String[] getSettings() throws FileNotFoundException {
		Scanner scanner = new Scanner(new File(".//settings.json"));
		StringBuilder strBuilder = new StringBuilder();
		while (scanner.hasNextLine()) {
			strBuilder.append(scanner.nextLine());
		}
		JSONObject json = JSONObject.parseObject(strBuilder.toString());
		String[] ret = new String[2];
		ret[0] = json.getString("infoPath");
		ret[1] = json.getString("indexPath");
		maxListPage = json.getIntValue("maxListPage");

		return ret;
	}

}
