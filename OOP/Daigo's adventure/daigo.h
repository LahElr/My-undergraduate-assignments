#include <string>

#pragma once
class daigo
{
public:
	std::string startMsg; //= "Welcome to The Great Castle.\nTo save the princess,you need to search the castle.\nBe careful of being found by the master of the castle.\nUse help command to learn how to play.\nGood luck!.\n";
	std::string helpMsg; //= "-------\nUse go command to move.\nThe parameter can be:u up d down w west e east n north s south.\n-------\nUse help command to get help message.\n-------\nThe commends are not case sensitive.\n-------\n";
	std::string noExitMsg;
	bool finedFlag;

	/*up-1,down-2,east-3,west-4,north-5,south-6
	errors:-1:
	*/
	static int findWay(std::string in);

	void die();

	void win();

	static void doNothing();

	static void printExits(int ino);

	static int findCmd(std::string cdi);

	daigo();

};