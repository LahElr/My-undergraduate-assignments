#include <algorithm>
#include <iostream>
#include <string>
#include <sstream>
#include <vector>
#include <Windows.h>

#include "daigo.h"
#include "Map.h"
#include "Room.h"

void SplitString(const std::string& s, std::vector<std::string>& v, const std::string& c);

int main()
{
    daigo d =daigo();
    
    Map m(&d);
    std::cout << d.startMsg;
    
    int posi = 1;   //position
    int cdi = 0;    //command in
    int cdiw = 0;   //command in way
    char stcdl[31];  //string command line
    std::string stcdi;  //string command in
    std::string stcdiw; //string command in way
    while (true)
    {
        Sleep(732);
        std::cout << m.rooms[posi].hint << "\n";
        Sleep(732);
        m.rooms[posi].execEffect();
        daigo::printExits(m.rooms[posi].exino);
        std::cout << d.finedFlag;
        if (d.finedFlag)   //won or dead
        {
            break;
        }
        while (true) 
        {
            std::cout << "Enter your command:\n";
            std::cin.getline(stcdl, 30);
            
            int strct = 0;
            while (stcdl[strct] != '\0')
            {
                strct++;
            }
            std::string stcd(&stcdl[0], &stcdl[strct]);
            std::vector<std::string> v;
            SplitString(stcd, v, " ");
            v.push_back("");

            cdi = daigo::findCmd(v[0]);
            if (cdi == 1)   //go
            {
                cdiw = daigo::findWay(v[1]);
                if (!(m.rooms[posi].exino & (1 << (cdiw - 1))))
                {
                    std::cout << d.noExitMsg << "\n";
                    continue;
                }
                else
                {
                    break;
                }
            }
            else if (cdi == 2)  //help
            {
                std::cout << d.helpMsg;
            }
            else
            {
                std::cout << "Type in help command to see how to play.\n";
            }
        } 
        posi = m.rooms[posi].exits[cdiw - 1];
        
    }

}

void SplitString(const std::string& s, std::vector<std::string>& v, const std::string& c)
{
    std::string::size_type pos1, pos2;
    pos2 = s.find(c);
    pos1 = 0;
    while (std::string::npos != pos2)
    {
        v.push_back(s.substr(pos1, pos2 - pos1));

        pos1 = pos2 + c.size();
        pos2 = s.find(c, pos1);
    }
    if (pos1 != s.length())
        v.push_back(s.substr(pos1));
}
