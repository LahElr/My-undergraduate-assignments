package crawlerSearcher;

import java.awt.Desktop;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.LinkedList;
import java.util.Random;
import java.util.Scanner;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;
import org.wltea.analyzer.lucene.IKAnalyzer;

import com.alibaba.fastjson.JSONObject;

public class main {
	private static String indexPath; // the dir where all lucene indices are stored
	private static String infoPath; // the dir where all fetched info are stored.
	private static Scanner in = new Scanner(System.in); // the Scanner used to accept input
	private static int resultHitCount = 1; // how many results to be reserved in searching. default 1
	private static boolean openFiles = false; // whether open the file(s) searched or not, default not open

	public static void main(String[] args) {
		// notice
		System.out.println("Searcher started.");
		String[] settings = { "..\\crawler\\crawled", "..\\crawler\\indices" }; // default value
		// get settings from settings.json
		try {
			settings = getSettings();
			indexPath = settings[1];
			infoPath = settings[0];
		} catch (FileNotFoundException e) {
			// e.printStackTrace();
			System.out.println("No settings.json found!");
		}
		// notice the using settings
		System.out.printf("Using %s as path to book records.\n", settings[0]);
		System.out.printf("Using %s as path to lucene indices.\n", settings[1]);
		System.out.printf("Using result count: %d, open files or not: %b.\n", resultHitCount, openFiles);

		// notice and print help message
		System.out.println("Searcher prepared.");
		printHelp();

		while (true) {
			// get choose
			String input = in.nextLine();
			input = input.strip();
			input = input.toLowerCase();

			// call handlers to handle the chooses
			if (input.equals("s") || input.equals("search")) {
				search();
			} else if (input.equals("a") || input.equals("advancedsearch")) {
				adSearch();
			} else if (input.equals("?") || input.equals("help")) {
				printHelp();
			} else if (input.equals("r") || input.equals("reset")) {
				// load the settings.json
				try {
					settings = getSettings();
					indexPath = settings[1];
					infoPath = settings[0];
					System.out.printf("Using %s as path to book records.\n", settings[0]);
					System.out.printf("Using %s as path to lucene indices.\n", settings[1]);
					System.out.printf("Using result count: %d, open files or not: %b.\n", resultHitCount, openFiles);
				} catch (FileNotFoundException e) {
					// e.printStackTrace();
					System.out.println("No settings.json found!");
				}
			} else if (input.equals("q") || input.equals("quit")) {
				// notice
				System.out.println("Searcher finished.");
				return;
			} else {
				// notice
				System.out.println("Unknown command!");
			}
		}

	}

	/**
	 * search in full content filed
	 */
	public static void search() {
		System.out.println("enter your query:");
		String query = in.nextLine();
		var filesFound = luceneSearch("filecontent", query, resultHitCount);
		showSearchResult(filesFound);
	}

	/**
	 * search in specified field
	 */
	public static void adSearch() {
		// get the query string
		System.out.println("enter your query:");
		String query = in.nextLine();
		// get the field to search in
		System.out
				.printf("choose the field,\n" + "there're 5 fields can be shosen:\n" + "1: filepath, 2: full-content,\n"
						+ "3: type, 4: title, and 5: detail page url.\n" + "Input a number to choose one.\n");
		int fieldN = Integer.parseInt(in.nextLine().replaceAll("[^1234567890]", ""));
		String field;
		switch (fieldN) {
		case (1):
			field = "filename";
			break;
		case (2):
			field = "filecontent";
			break;
		case (3):
			field = "filetype";
			break;
		case (4):
			field = "filetitle";
			break;
		case (5):
			field = "fileurl";
			break;
		default:
			field = "filecontent";
			break;
		}
		// search
		var filesFound = luceneSearch(field, query, resultHitCount);
		showSearchResult(filesFound);
	}

	/**
	 * show search results
	 * 
	 * @param filesFound
	 */
	private static void showSearchResult(LinkedList<String> filesFound) {
		// no result
		if (filesFound.size() == 0) {
			System.out.println("No result!");
			return;
		}

		// traverse the list and show results
		System.out.println("These files are searched:");
		if (!openFiles) {
			// do not open files searches
			for (String fileFound : filesFound) {
				System.out.println(fileFound);
			}
		} else {
			// open files searched.
			for (String fileFound : filesFound) {
				System.out.println(fileFound);
				try {
					// open
					Desktop.getDesktop().open(new File(fileFound));
				} catch (IOException e) {
					// e.printStackTrace();
					System.out.printf("opening file %s failed.\n", fileFound);
				}
			}
		}
	}

	/**
	 * search in lucence indices
	 * 
	 * @param fildToSearch : the fild to search in
	 * @param queryStr     : the query string
	 * @param resultCt     : how many results do we reserve?
	 * @return
	 */
	public static LinkedList<String> luceneSearch(String fildToSearch, String queryStr, int resultCt) {
		File f = new File(indexPath);
		LinkedList<String> ret = new LinkedList<String>();
		try {
			// open index
			IndexSearcher searcher = new IndexSearcher(DirectoryReader.open(FSDirectory.open(f)));
			Analyzer analyzer = new IKAnalyzer();
			QueryParser parser = new QueryParser(Version.LUCENE_4_10_0, fildToSearch, analyzer);

			// parse query
			Query query = parser.parse(queryStr);
			// search
			TopDocs hits = searcher.search(query, resultCt);
			// for all result, parse them into path to record file
			for (ScoreDoc doc : hits.scoreDocs) {
				org.apache.lucene.document.Document d = searcher.doc(doc.doc);
				String filePath = String.format("%s\\%s\\%s.txt", infoPath, d.get("filetype"), d.get("fileasin"));
				ret.add(filePath);
			}
		} catch (IOException | ParseException e) {
			// e.printStackTrace();
			System.out.println("Problem in searching.");
		}
		return ret;
	}

	/**
	 * read in the settings.json to know where to find indices and infos.
	 * 
	 * @return String[2], the [0] is the infoPath, the [1] is the indexPath.
	 * @throws FileNotFoundException
	 */
	public static String[] getSettings() throws FileNotFoundException {
		// read in all contents of settings.json
		Scanner scanner = new Scanner(new File(".//settings.json"));
		StringBuilder strBuilder = new StringBuilder();
		while (scanner.hasNextLine()) {
			strBuilder.append(scanner.nextLine());
		}
		// parse to json object
		JSONObject json = JSONObject.parseObject(strBuilder.toString());
		String[] ret = new String[2];
		// get settings
		ret[0] = json.getString("infoPath");
		ret[1] = json.getString("indexPath");
		resultHitCount = json.getIntValue("resultHitCount");
		openFiles = json.getBooleanValue("openFiles");

		return ret;
	}

	/**
	 * print help message.
	 */
	public static void printHelp() {
		System.out.println("Input 's' or 'search' to search;");
		System.out.println("Input 'a' or 'advancedsearch' to start advanced search;");
		System.out.println("Input '?' or 'help' to see this help message;");
		System.out.println("Input 'r' or 'reset' to load the settings.json;");
		System.out.println("Input 'q' or 'quit' to quit;");
		System.out.println(
				"Set the count of results shown in each search by modifying settings.json file, key \"resultHitCount\";");
		System.out.println(
				"Switch whether open all searched book info files or not by modifying settings.json file, key \"openFiles\";");
		System.out.println(
				"Set the path to indices or book info by modifying settings.json file, key \"infoPath\" and \"indexPath\";");
		System.out.println("All inputs accepted are case insensitive.");
	}

}
