#include <iostream>
#include "MyFraction.h"

using namespace std;

int main()
{
    myFraction a, b,c;
    cout << "inpit a fraction like this: 7/2\n";
    cin >> a;
    cout << "It is : " << a << " = " << ((double)a) << "\n";
    cout << "input another one: ";
    cin >> b;
    cout << "It is : " << b << " = " << ((double)b) << "\n";
    cout << "+:" << (a + b);
    cout << "\n-:" << (a - b);
    cout << "\n*:" << (a * b);
    cout << "\n/:" << (a / b);
    cout << "\n>:" << (a > b);
    cout << "\n<:" << (a < b);
    cout << "\n>=:" << (a >= b);
    cout << "\n<=:" << (a <= b);
    cout << "\n==:" << (a == b);
    cout << "\n!=:" << (a != b);
    cout << "\ninput a finite decimal string: ";
    string i;
    cin >> i;
    c = myFraction(i);
    cout << "It is : " << c << "\n";
    cout << "It is : " << ((double)c) << "\n";
    
}
