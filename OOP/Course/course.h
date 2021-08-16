#pragma once
#ifndef Course
class Course
{
public:
    int id;
    double score;

public:
    Course(int n, double s)
    {
        id = n;
        score = s;
    }
};
#endif