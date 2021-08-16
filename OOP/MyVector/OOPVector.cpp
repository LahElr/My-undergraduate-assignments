#include <iostream>
#include "Vector.hpp"

int main()
{
    Vector<int> vec;
    vec.push_back(0);
    std::cout << vec[0] << "\n";
    std::cout << vec.size() << "\n";
    std::cout << vec.capacity() << "\n";
    vec.push_back(1);
    std::cout << vec.at(1) << "\n";

    try
    {
        std::cout << vec.at(2) << "\n";
    }
    catch (std::out_of_range& exp)
    {
        std::cout << exp.what();
    }

    vec.push_back(2);
    vec.push_back(3);
    vec.push_back(4);
    vec.push_back(5);
    vec.push_back(6);
    vec.push_back(7);
    vec.push_back(8);
    vec.push_back(9);
    vec.push_back(10);

    std::cout << vec[10] << "\n";

    Vector<int> vec2 = vec;
    vec.clear();
    std::cout << "---\n";
    std::cout << vec.size() << "\n";
    std::cout << vec.capacity() << "\n";
    std::cout << vec2.size() << "\n";
    std::cout << vec2.capacity() << "\n";
    std::cout << vec2[10] << "\n";
    std::cout << "---\n";
}


