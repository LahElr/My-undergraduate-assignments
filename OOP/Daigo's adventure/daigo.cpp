#include "daigo.h"
#include <string>
#include <algorithm>
#include <sstream>
#include <iostream>

/*up-1,down-2,east-3,west-4,north-5,south-6
	errors:-1:
	*/
int daigo::findWay(std::string ins)
{
	if (!(ins.compare("u") && ins.compare("up")))
	{
		return 1;
	}
	if (!(ins.compare("d") && ins.compare("down")))
	{
		return 2;
	}
	if (!(ins.compare("e") && ins.compare("east")))
	{
		return 3;
	}
	if (!(ins.compare("w") && ins.compare("west")))
	{
		return 4;
	}
	if (!(ins.compare("n") && ins.compare("north")))
	{
		return 5;
	}
	if (!(ins.compare("s") && ins.compare("south")))
	{
		return 6;
	}

	return -1;
}

void daigo::die()
{
	std::cout << "You died.\n";
	this->finedFlag = true;
	return;
}

void daigo::win()
{
	std::cout << "Congratulations!\n";
	this->finedFlag = true;
	return;
}

void daigo::doNothing()
{
	return;
}

void daigo::printExits(int ino)
{
	int ct = !!(ino & 1) + !!(ino & 2) + !!(ino & 4) + !!(ino & 8) + !!(ino & 16) + !!(ino & 32);
	int ctn = ct;
	std::cout << "There are " << ct << " exits: ";
	if (ino & 1)
	{
		if (ct > 2) { std::cout << "up, "; ct--; }
		else if (ct == 2) { std::cout << "up "; ct--; }
		else if (ct == 1 && ctn > 1) { std::cout << "and up."; ct--; }
		else if (ct == 1 && ctn < 2) { std::cout << "up."; ct--; }
	}
	if (ino & 2)
	{
		if (ct > 2) { std::cout << "down, "; ct--; }
		else if (ct == 2) { std::cout << "down "; ct--; }
		else if (ct == 1 && ctn > 1) { std::cout << "and down."; ct--; }
		else if (ct == 1 && ctn < 2) { std::cout << "down."; ct--; }
	}
	if (ino & 4)
	{
		if (ct > 2) { std::cout << "east, "; ct--; }
		else if (ct == 2) { std::cout << "east "; ct--; }
		else if (ct == 1 && ctn > 1) { std::cout << "and east."; ct--; }
		else if (ct == 1 && ctn < 2) { std::cout << "east."; ct--; }
	}
	if (ino & 8)
	{
		if (ct > 2) { std::cout << "west, "; ct--; }
		else if (ct == 2) { std::cout << "west "; ct--; }
		else if (ct == 1 && ctn > 1) { std::cout << "and west."; ct--; }
		else if (ct == 1 && ctn < 2) { std::cout << "west."; ct--; }
	}
	if (ino & 16)
	{
		if (ct > 2) { std::cout << "north, "; ct--; }
		else if (ct == 2) { std::cout << "north "; ct--; }
		else if (ct == 1 && ctn > 1) { std::cout << "and north."; ct--; }
		else if (ct == 1 && ctn < 2) { std::cout << "north."; ct--; }
	}
	if (ino & 32)
	{
		if (ct > 2) { std::cout << "south, "; ct--; }
		else if (ct == 2) { std::cout << "south "; ct--; }
		else if (ct == 1 && ctn > 1) { std::cout << "and south."; ct--; }
		else if (ct == 1 && ctn < 2) { std::cout << "south."; ct--; }
	}
	std::cout << "\n";
	return;
}

/*1:go,2:help,-1:error*/
int daigo::findCmd(std::string cdi)
{
	if (!cdi.compare("go"))
	{
		return 1;
	}
	if (!cdi.compare("help"))
	{
		return 2;
	}
	return -1;
}

daigo::daigo()
{
	startMsg = "Welcome to The Great Castle.\nTo save the princess,you need to search the castle.\nBe careful of being found by the master of the castle.\nUse help command to learn how to play.\nGood luck!.\n";
	helpMsg = "-------\nUse go command to move.\nThe parameter can be:u up d down w west e east n north s south.\n-------\nUse help command to get help message.\n-------\nThe commends are not case sensitive.\n-------\n";
	noExitMsg = "No such exit!";
	finedFlag = false;
}