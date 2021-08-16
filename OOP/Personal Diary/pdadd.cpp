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

    //hint and input the new one from std::cin
    cout << "Type in the diary in the format following:\nyear month day\nYour words,finished with a dot in one line or EOF.\n";
    diary tar = diary();
    cin >> tar;
    diaries.push_back(tar);
    
    fin.close();    //close in file stream

    ofstream fout(PD_FILE_NAME);
    pdNum = diaries.size();
    fout << pdNum << "\n";
    for (int i = 0; i < pdNum; i++)
    {
        fout << diaries[i];
        //tar->printDiary();
    }

    fout.close();
    return 0;
}