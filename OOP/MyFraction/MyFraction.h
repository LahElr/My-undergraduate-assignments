#pragma once
#include <string>
#include <iostream>

#ifndef MY_FRACTION
#define MY_FRACTION
class myFraction
{
private:
	double value;	//value = numerator/denominator
	int denominator;
	int numerator;
private:
	void freshValue();
	void reduction();
	int gcd(int a, int b);
public:
	myFraction();
	myFraction(int a);
	myFraction(int a, int b);
	myFraction(char* str);
	myFraction(std::string str);
	myFraction(myFraction& a);
	void setFraction(const char* str);
	double getValue();
	friend myFraction operator+(const myFraction& f1, const myFraction& f2);
	friend myFraction operator-(const myFraction& f1, const myFraction& f2);
	friend myFraction operator*(const myFraction& f1, const myFraction& f2);
	friend myFraction operator/(const myFraction& f1, const myFraction& f2);
	friend bool operator>(const myFraction& f1, const myFraction& f2);
	friend bool operator<(const myFraction& f1, const myFraction& f2);
	friend bool operator>=(const myFraction& f1, const myFraction& f2);
	friend bool operator<=(const myFraction& f1, const myFraction& f2);
	friend bool operator!=(const myFraction& f1, const myFraction& f2);
	friend bool operator==(const myFraction& f1, const myFraction& f2);
	friend std::ostream& operator<<(std::ostream& out, const myFraction& f);
	friend std::istream& operator>>(std::istream& in, myFraction& f);
	myFraction& operator=(const myFraction& a);
	operator double();
	operator int();
	std::string myFrcToStr();

};
#endif