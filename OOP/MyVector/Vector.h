/*This file concludes the declartion of the Vector class*/
#pragma once

template <typename T>
class Vector
{
public:
    Vector();// creates an empty vector
    Vector(int vecSize); // creates a vector for holding 'size' elements
    Vector(const Vector& othV);// the copy ctor
    ~Vector();// destructs the vector
    T& operator[](int vecIndex);// accesses the specified element without bounds checking
    T& at(int vecIndex);// accesses the specified element, throws an exception of type 'std::out_of_range' when index <0 or >=m_nSize
    int size() const;// return the size of the container
    int capacity() const;// return the capacity of the container
    void push_back(const T& x);// adds an element to the end
    void clear();// clears the contents
    bool empty() const;// checks whether the container is empty
private:
    void inflate();// expand the storage of the container to a new capacity with 2 times space.
    T* m_pElements;// pointer to the dynamically allocated storage
    int m_nSize;// the number of elements in the container
    int m_nCapacity;// the number of elements that can be held in currently allocated storage
};

