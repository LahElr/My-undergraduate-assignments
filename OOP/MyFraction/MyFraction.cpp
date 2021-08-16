#include <iostream>
#include <string>
#include <sstream>
#include "MyFraction.h"

void myFraction::freshValue()	//refresh the value
{
	value = (double)numerator / (double)denominator;
	return;
}

void myFraction::reduction()	//reduction
{
	int g = gcd(numerator, denominator);
	g = (g > 0) ? g : -g;
	numerator /= g;
	denominator /= g;
	return;
}

int myFraction::gcd(int a, int b)	//euclidean algorithm
{
	int c;
	if (a < b)
	{
		c = a;
		a = b;
		b = c;
	}
	c = a % b;
	while (a % b != 0)
	{
		a = b;
		b = c;
		c = a % b;
	}
	return b;
}

myFraction::myFraction()	//default ctor
{
	value = 0.0;
	denominator = 1.0;
	numerator = 0.0;
}

myFraction::myFraction(int a)	//ctor with one int, take it as the value
{
	value = (double)a;
	denominator = 1.0;
	numerator = 0.0;
}

myFraction::myFraction(int a, int b)	//ctor with two int, take them as denominator and numerator
{
	value = (double)a / (double)b;
	denominator = (double)b;
	numerator = (double)a;
	reduction();
}

myFraction::myFraction(char* str)	//a string
{
	setFraction(str);
}

myFraction::myFraction(std::string str)	//a string
{
	setFraction(str.c_str());
}

myFraction::myFraction(myFraction& a)	//copy ctor
{
	value = a.value;
	denominator = a.denominator;
	numerator = a.numerator;
}

double myFraction::getValue()	//function to visit private value
{
	return value;
}

myFraction& myFraction::operator=(const myFraction& a)
{
	if (this != &a)
	{
		this->value = a.value;
		this->denominator = a.denominator;
		this->numerator = a.numerator;
	}
	return *this;
}

myFraction::operator double()	//convert to double
{
	return value;
}

myFraction::operator int()	//convert to int
{
	return (int)value;
}

std::string myFraction::myFrcToStr()	//print to string
{
	std::string ret;
	std::stringstream ss;
	ss.clear();
	ss << numerator << "/" << denominator;
	ss >> ret;
	return ret;
}

void myFraction::setFraction(const char* str)	//read from a string
{
	value = 0.0;
	denominator = 1;
	numerator = 0;
	int i = 0;
	char t;
	double fracP = 1.0;
	bool dotted = false;
	bool minusFlag = false;
	while (true)
	{
		t = str[i];
		if (t <= '9' && t >= '0')
		{
			if (dotted)	// integer part
			{
				fracP /= 10.0;
				denominator *= 10;
				value += fracP * (double)(t - '0');
			}
			else
			{
				value *= 10.0;
				value += (double)(t - '0');
			}
			numerator *= 10;
			numerator += (t - '0');
			i++;
			continue;
		}
		else if (t == '.')	//mark the dot
		{
			if (dotted)
			{
				break;	//if there's already a dot before it
			}
			else
			{
				dotted = true;
				i++;
				continue;
			}
		}
		else if (t == '-')
		{
			if (i != 0)
			{
				break;	// if the '-' appears not at the start place
			}
			else
			{
				minusFlag = true;
			}
		}
		else
		{
			break;	//it's not readable char
		}
	}
	reduction();
	if (minusFlag)	//if it's a minus number read in
	{
		numerator = -numerator;
		value = -value;
	}
}

myFraction operator+(const myFraction& f1, const myFraction& f2)	//overloaded operator +
{
	myFraction ret;
	ret = myFraction(f1.numerator * f2.denominator + f1.denominator * f2.numerator, f1.denominator * f2.denominator);
	return ret;
}

myFraction operator-(const myFraction& f1, const myFraction& f2)	//overloaded operator -
{
	myFraction ret;
	ret = myFraction(f1.numerator * f2.denominator - f1.denominator * f2.numerator, f1.denominator * f2.denominator);
	return ret;
}

myFraction operator*(const myFraction& f1, const myFraction& f2)	//overloaded operator *
{
	myFraction ret;
	ret = myFraction(f1.numerator * f2.numerator, f1.denominator * f2.denominator);
	return ret;
}

myFraction operator/(const myFraction& f1, const myFraction& f2)	//overloaded operator /
{
	myFraction ret;
	ret = myFraction(f1.numerator * f2.denominator, f1.denominator * f2.numerator);
	return ret;
}

bool operator>(const myFraction& f1, const myFraction& f2)	//overloaded operator >
{
	return f1.value > f2.value;
}

bool operator<(const myFraction& f1, const myFraction& f2)	//overloaded operator <
{
	return f1.value < f2.value;
}

bool operator>=(const myFraction& f1, const myFraction& f2)	//overloaded operator >=
{
	return !(f1 < f2);
}

bool operator<=(const myFraction& f1, const myFraction& f2)	//overloaded operator <=
{
	return !(f1 > f2);
}

bool operator!=(const myFraction& f1, const myFraction& f2)	//overloaded operator !=
{
	return !(f1 == f2);
}

bool operator==(const myFraction& f1, const myFraction& f2)	//overloaded operator ==
{
	return (f1.denominator == f2.denominator && f1.numerator && f2.numerator);
}

std::ostream& operator<<(std::ostream& out, const myFraction& f)	//overloaded operator <<
{
	out << f.numerator << "/" << f.denominator;
	return out;
}

std::istream& operator>>(std::istream& in, myFraction& f)	//overloaded operator >>
{
	std::string inStr;
	in >> inStr;
	for (int i = 0; i < inStr.size(); i++)
	{
		if (inStr[i] == '/' || inStr[i] == '\\')
		{
			f.numerator = atoi(inStr.c_str());
			f.denominator = atoi(inStr.c_str() + i + 1);
			f.freshValue();
			f.reduction();
			break;
		}
	}
	return in;
}
