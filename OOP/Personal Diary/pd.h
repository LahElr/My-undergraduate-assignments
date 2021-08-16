#pragma once
#include <iostream>
#include <fstream>
#ifndef PD_H
#define PD_H

#define PD_FILE_NAME "pd.pd"

class diary {
public:
	int year;
	int month;
	int day;
	std::string content;
	
public:
	diary(int y = 0, int m = 0, int d = 0);							//constructor with default parameters
	void setDate(int yyyy = 0, int mm = 1, int dd = 1);				//set date
	void setDateYear(int yyyy = 0);									//set year only
	void setDateMonth(int mm = 1);									//set month only
	void setDateDay(int dd = 1);									//set day only
	void printDiary();												//print diary, for user
	void printDiaryDate();											//print date
	friend std::ostream& operator<<(std::ostream& out, diary& tar);	//overloaded operator <<, aims at outputing the diary with the inputing format
	friend std::istream& operator>>(std::istream& in, diary& tar);	//overloaded operator >>, input a diary with the format
	friend bool operator< (diary& a, diary& b);						//reloaded operator <
	friend bool operator> (diary& a, diary& b);						//reloaded operator >
	friend bool operator>= (diary& a, diary& b);					//reloaded operator >=
	friend bool operator<= (diary& a, diary& b);					//reloaded operator <=
};

#endif
