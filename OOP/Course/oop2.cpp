#include <algorithm>
#include <vector>
#include <iostream>
#include <iomanip>      //for cli word color
#include <string>
#include <sstream>
#include "course.h"

using namespace std;

string eom = "END";

bool compCourse(const Course& a, const Course& b);

int main()
{
    vector< vector<Course> >chart;
    //vector for students:(col)
    vector<string>names;        //student name
    vector<double>studentScore; //total score for sigle student
    //vectors for courses:(row)
    vector<string>courseNames;  //subject names
    vector<double>courseScores; //single-subject total score
    vector<int>courseNumbers;   //numbers of students chosen this subject
    vector<double>courseMin;    //max score in single subject
    vector<double>courseMax;    //min score for singe subject

    stringstream sft;               //string stream for translating
    unsigned int maxNameLength = 0;         //the length of langest student name
    unsigned int maxCourseNameLength = 0;   //the length of langest course name

    //hint message
    cout << "For every record,please input like this:name course_name score course_name score ... and end this record with \"END\"\n";
    cout << "In the names of courses and students, there shall not be spaces.\n";
    cout << "After inputing all records, input \"END\" as the name of next record to stop.\n";

    //input records
    int count = 0;  //number of students
    //for each record:
    while (true)
    {
        cout << "The record for the student No." << count + 1 << "?\n"; //hint message

        string name;
        cin >> name;    //input student name
        if (name.compare(eom) == 0)
        {
            break;  //stop
        }
        count++;    //a new record for a new student

        //refresh the longest name length
        if (name.size() > maxNameLength)
        {
            maxNameLength = name.size();
        }

        names.push_back(name);          //store this name
        studentScore.push_back(0.0);    //store his/her total score

        vector<Course>rec;              //a record for a single student

        //for each course
        while (true)
        {
            string corname; //course name
            string iscortt; //a string to be translated into int
            cin >> corname; //input the course's name
            if (corname.compare(eom) == 0)
            {
                break;  //stop
            }
            cin >> iscortt; //input the score for it
            if (iscortt.compare(eom) == 0)
            {
                break;  //stop
            }
            //translate string into double
            sft << iscortt;
            double scor;
            sft >> scor;
            sft.clear();

            //find the course id:
            int idfc = 0;   //id for course
            vector<string>::iterator iter = find(courseNames.begin(), courseNames.end(), corname);  //get an iterator points to the course

            if (iter == courseNames.end())  //not found
            {
                //store this course'name and create position for it's total、max、min scores
                courseNames.push_back(corname);
                courseScores.push_back(scor);
                courseMax.push_back(scor);
                courseMin.push_back(scor);
                courseNumbers.push_back(1);
                idfc = distance(courseNames.begin(), courseNames.end() - 1);    //id this course
                if (corname.size() > maxCourseNameLength)
                {
                    maxCourseNameLength = corname.size();   //refresh the longest course name length
                }
            }
            else//found
            {
                idfc = distance(courseNames.begin(), iter); //id this course
                //maintain relative data
                courseScores[idfc] += scor;
                courseNumbers[idfc]++;
                if (courseMax[idfc] < scor)
                {
                    courseMax[idfc] = scor;
                }
                if (courseMin[idfc] > scor)
                {
                    courseMin[idfc] = scor;
                }
            }

            Course c = Course(idfc, scor);      //zip the data
            *(studentScore.end() - 1) += scor;  //the studet's total score
            rec.push_back(c);                   //add this course for the student
        }
        chart.push_back(rec);   //add this student to the whole chart
    }

    int nn = names.size();          //number of students
    int nc = courseNames.size();    //number of courses

    //if the width of rows is to small,enlarge it
    if (maxCourseNameLength < 4) maxCourseNameLength = 4;
    if (maxNameLength < 7) maxNameLength = 7;
    //for the space after the words
    maxCourseNameLength++;
    maxNameLength++;

    for (int i = 0; i < nn; i++)
    {
        sort(chart[i].begin(), chart[i].end(), compCourse); //sort the courses by their id
    }

    //output
    //head
    cout << left;//left justifying
    cout << "\033[31mno. name\033[0m";                              //"no. name"
    for (int i = 0; i < maxNameLength - 4; i++)
    {
        cout << " ";
    }
    cout << "\033[31m";
    for (int i = 0; i < nc; i++)
    {
        cout << setw(maxCourseNameLength) << courseNames[i] << " "; //names of courses
    }
    cout << "average\033[0m\n";                                     //"average"

    //body:the chart part
    int tar = 0;
    for (int i = 0; i < nn; i++)    //for each student
    {
        cout << "\033[32m" << setw(3) << i + 1 << " ";                                                  //student id
        cout << "\033[31m" << setw(maxNameLength) << names[i];                                          //student name
        cout << "\033[32m";
        tar = 0;
        for (int ii = 0; ii < nc; ii++)
        {
            if (tar < chart[i].size() && chart[i][tar].id == ii)    //if this student has chosen this course
            { 
                cout << setw(maxCourseNameLength) << chart[i][tar].score << " ";                        //single subject score
                tar++;
            }
            else
            {
                cout << setw(maxCourseNameLength + 1) << " ";                                           //only space
            }
        }
        if(studentScore[i]>0) cout << setw(7) << ((double)studentScore[i] / (double)chart[i].size());   //average score for the student
        cout << "\n"; 
    }

    //body: the summary part
    cout << "    ";                                                                         //spaces for "no. "
    cout << "\033[31m" << setw(maxNameLength) << "average ";                                //"average"
    cout << "\033[32m";
    for (int i = 0; i < nc; i++)
    {
        cout << setw(maxCourseNameLength) << courseScores[i]/courseNumbers[i] << " ";       //average score for the course
    }
    cout << "\n";

    cout << "    ";                                                                         //spaces for "no. "
    cout << "\033[31m" << setw(maxNameLength) << "min ";                                    //"min"
    cout << "\033[32m";
    for (int i = 0; i < nc; i++)
    {
        cout << setw(maxCourseNameLength) << courseMin[i] << " ";                           //min score for the course
    }
    cout << "\n";
    
    cout << "    ";                                                                         //spaces for "no. "
    cout << "\033[31m" << setw(maxNameLength) << "max ";                                    //"max"
    cout << "\033[32m";
    for (int i = 0; i < nc; i++)
    {
        cout << setw(maxCourseNameLength) << courseMax[i] << " ";                           //max score for the course
    }
    cout << "\n";
    cout << "\033[0m" << endl;  //end
    return 0;
}

//function for sorting the records
bool compCourse(const Course& a, const Course& b)
{
    if (a.id < b.id)
    {
        return true;
    }
    return false;
}