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

    //get the start and end dates
    diary startDiary = diary(INT_MIN, INT_MIN, INT_MIN);
    diary endDiary = diary(INT_MAX, INT_MAX, INT_MAX);

    if (argc == 2) { startDiary.setDateYear(atoi(argv[1])); }
    if (argc == 3) { startDiary.setDateYear(atoi(argv[1])); endDiary.setDateYear(atoi(argv[2])); }
    if (argc == 4) { startDiary.setDateYear(atoi(argv[1])); startDiary.setDateMonth(atoi(argv[2])); endDiary.setDateYear(atoi(argv[3])); }
    if (argc == 5) { startDiary.setDateYear(atoi(argv[1])); startDiary.setDateMonth(atoi(argv[2])); endDiary.setDateYear(atoi(argv[3])); endDiary.setDateMonth(atoi(argv[4])); }
    if (argc == 6) { startDiary.setDateYear(atoi(argv[1])); startDiary.setDateMonth(atoi(argv[2])); startDiary.setDateDay(atoi(argv[3])); endDiary.setDateYear(atoi(argv[4])); endDiary.setDateMonth(atoi(argv[5])); }
    if (argc >= 7) { startDiary.setDateYear(atoi(argv[1])); startDiary.setDateMonth(atoi(argv[2])); startDiary.setDateDay(atoi(argv[3])); endDiary.setDateYear(atoi(argv[4])); endDiary.setDateMonth(atoi(argv[5])); endDiary.setDateDay(atoi(argv[6])); }
            
    diary& startDiaryT = (startDiary > endDiary) ? endDiary : startDiary;
    diary& endDiaryT = (startDiary > endDiary) ? startDiary : endDiary;
        
    std::sort(diaries.begin(), diaries.end());  //sort the vector

    //output selected info
    for (int i = 0; i < diaries.size(); i++)
    {
        if (diaries[i] >= startDiaryT && diaries[i] <= endDiaryT)
        {
            cout << "Diary at:" << i << ":";
            diaries[i].printDiaryDate();
        }
    }
    cout << "All selected listed\n";
    fin.close();    //close in file stream
    
    return 0;
}