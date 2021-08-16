/*
OOP Assignment-1 8-1 StudentsI (10)
Write a program that asks you 10 records of students. 
Each record consists of a name (w/o space), and scores 
for three courses (in integer, 1 to 5). Output a list 
as following and calculate average score (in float) 
of each student and each course. Output the lowest and 
highest score for each course.

no      name    score1  score2  score3  average
1       K.Weng  5       5       5       5
2       T.Dixon 4       3       2       3
3       V.Chu   3       4       5       4
4       L.Tson  4       3       4       3.66667
5       L.Lee   3       4       3       3.33333
6       I.Young 4       2       5       3.66667
7       K.Hiro  4       2       1       2.33333
8       G.Ping  4       4       4       4
9       H.Gu    2       3       4       3
10      J.Jon   5       4       3       4
		average 3.8     3.4     3.6
		min     2       2       1
		max     5       5       5

Evaluation standard
result correctness
c++ code quality (compact and reasonable)
comments quality (clean and accurate)
c functions like printf and scanf are not allowed
Required Files: source code, makefile (Mac, Linux), exe (Windows)

test sample:

K.Weng 5 5 5
T.Dixon 4 3 2
V.CHu 3 4 5
L.Tson 4 3 4
L.Lee 3 4 3
I.Young 4 2 5
K.Hiro 4 2 1
G.Ping 4 4 4
J.Kaito 5 4 3
H.Haru 2 3 4

*/

#include <iostream>
#include <iomanip>
using namespace std;

int main()
{
	//define variables:
	string name[10];
	int score1[10];
	int score2[10];
	int score3[10];
	double averageOfStudent[10];
	double averageOfScore[3];
	int max[3] = { 0,0,0 };//score>0
	int min[3] = { 5,5,5 };//score<=5
	int maxNameLength = 8;

	//hint
	cout << "For every record,please input like this:name score1 score2 score3\n";
	//input record.
	for (int i = 0; i < 10; i++)
	{
		cout << "The record for the student No." << i + 1 << "?\n";
		cin >> name[i];//there's no space in name.
		
		if (name[i].length() > maxNameLength)
		{
			maxNameLength = name[i].length();
		}

		//It's a simple way,we can add a test whether the input is an integer.
		cin >> score1[i];
		cin >> score2[i];
		cin >> score3[i];

		//Calculate average score for every student.
		//Though a warning C26451 is shown down here,it won't matter because score<=5.
		averageOfStudent[i] = (double)(score1[i] + score2[i] + score3[i]) / 3;

		//Calculate the max and the min score for every subject.
		if (max[0] < score1[i])
		{
			max[0] = score1[i];
		}
		if (max[1] < score2[i])
		{
			max[1] = score2[i];
		}
		if (max[2] < score3[i])
		{
			max[2] = score3[i];
		}

		if (min[0] > score1[i])
		{
			min[0] = score1[i];
		}
		if (min[1] > score2[i])
		{
			min[1] = score2[i];
		}
		if (min[2] > score3[i])
		{
			min[2] = score3[i];
		}
	}

	//Calculate the average score for every subject.
	//Though a warning C26451 is shown down here,it won't matter because score<=5.
	averageOfScore[0] = (double)(score1[0] + score1[1] + score1[2] + score1[3] + score1[4] + score1[5] + score1[6] + score1[7] + score1[8] + score1[9]) / 10;
	averageOfScore[1] = (double)(score2[0] + score2[1] + score2[2] + score2[3] + score2[4] + score2[5] + score2[6] + score2[7] + score2[8] + score2[9]) / 10;
	averageOfScore[2] = (double)(score3[0] + score3[1] + score3[2] + score3[3] + score3[4] + score3[5] + score3[6] + score3[7] + score3[8] + score3[9]) / 10;

	//output
	//head
	cout << "\033[31mno name\033[0m";
	for (int i = 0; i < maxNameLength-4; i++)
	{
		cout << " ";
	}
	cout<<"\033[31mscore1 score2 score3 average\033[0m\n";

	cout << left;//left justifying

	//body:the upper part
	for (int i = 0; i < 10; i++)
	{
		cout << "\033[32m" << setw(3) << i + 1;
		cout << "\033[31m" << setw(maxNameLength) << name[i];
		cout << "\033[32m" << setw(7) << score1[i];
		cout << setw(7) << score2[i];
		cout << setw(7) << score3[i];
		cout << averageOfStudent[i];
		cout << "\n";
	}

	//body:the lowwer part
	cout << "   ";
	cout << "\033[31m" << setw(maxNameLength) << "average ";
	cout << "\033[32m" << setw(7) << averageOfScore[0];
	cout << setw(7) << averageOfScore[1];
	cout << setw(7) << averageOfScore[2];
	cout << "\n";

	cout << "   ";
	cout << "\033[31m" << setw(maxNameLength) << "min ";
	cout << "\033[32m" << setw(7) << min[0];
	cout << setw(7) << min[1];
	cout << setw(7) << min[2];
	cout << "\n";

	cout << "   ";
	cout << "\033[31m" << setw(maxNameLength) << "max ";
	cout << "\033[32m" << setw(7) << max[0];
	cout << setw(7) << max[1];
	cout << setw(7) << max[2];
	cout << "\n";

	//finish
	cout << "\033[0m" << endl;
	return 0;
}
