#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <limits.h>
#include <string>
#include <cstdlib>
#include "pd.h"
using namespace std;

int main(int argc,char* argv[])
{
    ifstream fin(PD_FILE_NAME); //open file
    int pdNum = 0;              //the number of personal diaries
    fin >> pdNum;               //read it in

    //read the diaries in
    vector<diary> diaries(pdNum);
    for (int i = 0; i < pdNum; i++)
    {
        diary tar = diary();
        fin >> tar;
        diaries[i]=tar;
    }

    //see if the year,month,day is specified and get them
    int y, m, d;
    bool yearSpecified = false, monthSpecified = false, daySpecified = false;
            
    if (argc == 2) { yearSpecified = true; y = atoi(argv[1]); }
    if (argc == 3) { yearSpecified = true; y = atoi(argv[1]); monthSpecified = true; m = atoi(argv[2]); }
    if (argc >= 4) { yearSpecified = true; y = atoi(argv[1]); monthSpecified = true; m = atoi(argv[2]); daySpecified = true; d = atoi(argv[3]); }
            
            
    std::sort(diaries.begin(), diaries.end());  //sort the vector

    //output selected diaries
    for (int i = 0; i < diaries.size(); i++)
    {
        if ((yearSpecified && diaries[i].year == y && !monthSpecified) || ((yearSpecified && diaries[i].year == y) && (monthSpecified && diaries[i].month == m) && !daySpecified) || ((yearSpecified && diaries[i].year == y) && (monthSpecified && diaries[i].month == y) && (daySpecified && diaries[i].day == y)) || (!yearSpecified && !monthSpecified && !daySpecified))
        {
            diaries[i].printDiary();
        }
    }
    
    fin.close();    //close out file stream
    return 0;
}