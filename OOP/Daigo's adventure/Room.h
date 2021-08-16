#include <string>
#include "daigo.h"
#pragma once
#ifndef _ROOM_H_
#define _ROOM_H_
class Room
{
public:
	int exino;
	int exits[6];
	std::string hint;
private:
	void (*effect)();
	void(daigo::* effectd)();
	daigo* da;

public:
	Room();

	Room(int exin, int r1, int r2, int r3, int r4, int r5, int r6, std::string hin, void (*effecti)());

	Room(int exin, int r1, int r2, int r3, int r4, int r5, int r6, std::string hin, void(daigo::*effecti)(),daigo* dai);

	void execEffect();
};
	
namespace RoomD 
{
	const std::string despRoom = "It was somebody's bedroom,but after the monster occupied the castle,there's no one living here.";
	const std::string despRoomM = "A bedroom with no one living here.\nSomething's roaring.";
	const std::string despRoomSke = "It was somebody's bedroom.The skeletonon the floor may belongs to the one once lived here.";
	const std::string despRoomLord = "A big bedroom.Seems it belonged to the owner of the castle before the monster took the castle.";
	const std::string despGuard = "A room with broken weapon rack.Seems the room gurdians once worked.\nAre they alive now?";
	const std::string despVeranda = "A once-well-decorated veranda,from where people can see wonderful scene over far mountains.";
	const std::string despVerandaP = "A once-well-decorated veranda,from where people can see ... wait is that Her Highness?";
	const std::string despStairs1 = "A room of stairs at 1st floor.";
	const std::string despStairs2 = "A room of stairs at 2nd floor.";
	const std::string despStairs3 = "A room of stairs at 3rd floor.";
	const std::string despStair2M = "A room of stairs at 2nd floor.\nSomething's roaring.";
	const std::string despStorge = "A big room full of broken chests and barrels.";
	const std::string despLobby = "It's the lobby.";
	const std::string despKitchen = "A big room with broken pots and a barely usable hearth.";
	const std::string despMeetingRoom = "A well-decorated room, where the owner of the castle held banquets.";
	const std::string despWrongSpace = "Somewhere mysteries.Anyway,you should not have been appeared here.";
	const std::string despMonster = "The monster is standing there staring at you.The doors close back you,\nslamming.";
	const std::string despP = "There the Princess is.Now all you need to do is to take the orincess away,silently,and earn what you deserve from the king.";

	void fromVerandaP();
	void fromRoom();
	void fromStorge();
}

#endif