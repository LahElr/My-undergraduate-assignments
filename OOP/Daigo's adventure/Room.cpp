#include <iostream>
#include "Room.h"

Room::Room()
{
	exino = 0;
	exits[0] = 0;
	exits[1] = 0;
	exits[2] = 0;
	exits[3] = 0;
	exits[4] = 0;
	exits[5] = 0;
	hint = "";
}

Room::Room(int exin, int r1, int r2, int r3, int r4, int r5, int r6, std::string hin, void (*effecti)())
{
	exino = exin;
	exits[0] = r1;
	exits[1] = r2;
	exits[2] = r3;
	exits[3] = r4;
	exits[4] = r5;
	exits[5] = r6;
	hint = hin;
	effect = effecti;
	effectd = nullptr;
	da = nullptr;
}

Room::Room(int exin, int r1, int r2, int r3, int r4, int r5, int r6, std::string hin, void(daigo::* effecti)(),daigo* dai)
{
	exino = exin;
	exits[0] = r1;
	exits[1] = r2;
	exits[2] = r3;
	exits[3] = r4;
	exits[4] = r5;
	exits[5] = r6;
	hint = hin;
	effectd = effecti;
	effect = nullptr;
	da = dai;
}

void Room::execEffect()
{
	if (this->effectd != nullptr)
	{
		(da->*effectd)();
	}
	else if (this->effect != nullptr)
	{
		effect();
	}
	return;
}

void RoomD::fromVerandaP()
{
	std::cout << "You see the princess sitting in a room the other side of the castle.\nThere should be a way to reach her from here.\n";
	return;
}

void RoomD::fromRoom()
{
	std::cout << "You exited the room to the corridor.\n";
	return;
}

void RoomD::fromStorge()
{
	std::cout << "The smell of rotten woods and food filled the air.Ew\n";
	return;
}

