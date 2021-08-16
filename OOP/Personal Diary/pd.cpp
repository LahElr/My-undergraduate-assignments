#include <iostream>
#include <fstream>
#include <vector>
#include "pd.h"

//constructor with default parameters
diary::diary(int y, int m, int d)
{
    setDate(y, m, d);
}

//set date
void diary::setDate(int yyyy, int mm, int dd)
{
	year = yyyy;
	month = mm;
	day = dd;
	return;
}

//set year only
void diary::setDateYear(int yyyy)
{
    year = yyyy;
    return;
}

//set month only
void diary::setDateMonth(int mm)
{
    month = mm;
    return;
}

//set day only
void diary::setDateDay(int dd)
{
    day = dd;
    return;
}

//print diary, for user
void diary::printDiary()
{
	std::cout << "diary at " << year << ":" << month << ":" << day;
	std::cout << content;
	std::cout << "\n";
	return;
}

//print date
void diary::printDiaryDate()
{
    std::cout << year << ":" << month << ":" << day << "\n";
    return;
}

//overloaded operator <<, aims at outputing the diary with the inputing format
std::ostream& operator<<(std::ostream& out, diary& tar)
{
    out << tar.year << " " << tar.month << " " << tar.day;
    out << tar.content;
    out << "\n";
    return out;
}

//overloaded operator >>, input a diary with the format
std::istream& operator>>(std::istream& in, diary& tar)
{
    /*format:
    year month day
    line1...
    line2...
    .
    */
    std::vector<char> line; //line
    char ch;                //the char got
    //input the date
    in >> tar.year;
    in >> tar.month;
    in >> tar.day;
    
    bool UnEOFed = true;
    while (UnEOFed) //for every line
    {
        line.clear();   //start the new line
        while (UnEOFed) //for every char in a line
        {
            if (!in)    //EOF in,in a single line
            {
                tar.content.append("\n.\n");
                line.clear();
                line.push_back('.');
                line.push_back('\n');
                UnEOFed = false;
                break;
            }
            in.get(ch);
            if (ch == '\n') //end of a line
            {
                tar.content.append(1, ch);
                line.push_back(ch);
                break;
            }
            if (ch == (char)26) //EOF in,in a line
            {
                tar.content.append("\n.\n");
                line.clear();
                line.push_back('.');
                line.push_back('\n');
                UnEOFed = false;
                break;
            }
            tar.content.append(1, ch);
            line.push_back(ch);
        }

        //if this line is a single '.'
        if ((line.size() >= 2 && line[0] == '.' && line[1] == '\n') || (line.size() == 1 && line[0] == '.'))
        {
            UnEOFed = false;
            break;
        }
    }
    return in;
}

//reloaded operator <
bool operator<(diary& a, diary& b)
{
    if (a.year != b.year)
    {
        return a.year < b.year;
    }
    if (a.month != b.month)
    {
        return a.month < b.month;
    }
    return a.day < b.day;
}

//reloaded operator >
bool operator>(diary& a, diary& b)
{
    if (a.year != b.year)
    {
        return a.year > b.year;
    }
    if (a.month != b.month)
    {
        return a.month > b.month;
    }
    return a.day > b.day;
}

//reloaded operator >=
bool operator>=(diary& a, diary& b)
{
    return !(a < b);
}

//reloaded operator <=
bool operator<=(diary& a, diary& b)
{
    return !(a > b);
}

