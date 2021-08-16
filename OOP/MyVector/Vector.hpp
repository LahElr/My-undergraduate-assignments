/*This file concludes the definations of the Vector class's members*/
#include "Vector.h"

template <class T>
Vector<T>::Vector()// creates an empty vector
{
    m_pElements = new T[5];
    m_nCapacity = 5;
    m_nSize = 0;
    clear();
}

template<typename T>
Vector<T>::Vector(int vecSize)// creates a vector for holding 'size' elements
{
    m_pElements = new T[vecSize];
    m_nCapacity = vecSize;
    m_nSize = 0;
    clear();
}

template<typename T>
Vector<T>::Vector(const Vector& othV)// the copy ctor
{
    m_nCapacity = othV.m_nCapacity;
    m_nSize = othV.m_nSize;
    m_pElements = new T[m_nCapacity];
    
    for (int i = 0; i < m_nCapacity; i++)
    {
        m_pElements[i] = othV.m_pElements[i];
    }

}

template<typename T>
Vector<T>::~Vector()// destructs the vector
{
    delete m_pElements;
}

template<typename T>
T& Vector<T>::operator[](int vecIndex)// accesses the specified element without bounds checking
{
    return m_pElements[vecIndex];
}

template<typename T>
T& Vector<T>::at(int vecIndex)// accesses the specified element, throws an exception of type 'std::out_of_range' when index <0 or >=m_nSize
{
    if (vecIndex >= m_nSize || vecIndex < 0)
    {
        std::out_of_range excp("Vector: out of range.\n");
        throw excp;
    }
    else
    {
        return m_pElements[vecIndex];
    }
}

template<typename T>
int Vector<T>::size() const// return the size of the container
{
    return m_nSize;
}

template<typename T>
int Vector<T>::capacity() const// return the capacity of the container
{
    return m_nCapacity;
}

template<typename T>
void Vector<T>::push_back(const T& x)// adds an element to the end
{
    if (m_nSize < m_nCapacity)
    {
        m_pElements[m_nSize] = x;
        m_nSize++;
    }
    else
    {
        inflate();
        m_pElements[m_nSize] = x;
        m_nSize++;
    }
}

template<typename T>
void Vector<T>::clear()// clears the contents
{
    for (int i = 0; i < m_nCapacity; i++)
    {
        m_pElements[i] = NULL;
    }
    m_nSize = 0;
    return;
}

template<typename T>
bool Vector<T>::empty() const// checks whether the container is empty
{
    return m_nSize==0;
}

template<typename T>
void Vector<T>::inflate()// expand the storage of the container to a new capacity with 2 times space
{
    T* tempPEle = new T[m_nCapacity * 2];
    for (int i = 0; i < m_nCapacity; i++)
    {
        tempPEle[i] = m_pElements[i];
    }
    for (int i = m_nCapacity; i < m_nCapacity * 2; i++)
    {
        tempPEle[i] = NULL;
    }
    m_nCapacity *= 2;
    delete m_pElements;
    m_pElements = tempPEle;
    return;
}
