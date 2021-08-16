#include "Map.h"
#include "Room.h"
#include "daigo.h"

Map::Map(daigo* d)
{
	void(daigo:: * di)();
	void(daigo:: * wi)();
	
	di = &daigo::die;
	wi = &daigo::win;

	//						 u, d, e, w, n, s
	rooms[0] = Room::Room(1, 1, 0, 0, 0, 0, 0, RoomD::despWrongSpace, daigo::doNothing);
	rooms[1] = Room::Room(28, 0, 0, 3, 2, 4, 0, RoomD::despLobby, daigo::doNothing);
	rooms[2] = Room::Room(20, 0, 0, 1, 0, 5, 0, RoomD::despGuard, daigo::doNothing);
	rooms[3] = Room::Room(24, 0, 0, 0, 1, 10, 0, RoomD::despKitchen, daigo::doNothing);
	rooms[4] = Room::Room(48, 0, 0, 0, 0, 6, 1, RoomD::despMeetingRoom, daigo::doNothing);
	rooms[5] = Room::Room(36, 0, 0, 6, 0, 0, 2, RoomD::despRoomM, RoomD::fromRoom);
	rooms[6] = Room::Room(44, 0, 0, 7, 5, 0, 4, RoomD::despRoomSke, RoomD::fromRoom);
	rooms[7] = Room::Room(12, 0, 0, 8, 6, 0, 0, RoomD::despRoom, RoomD::fromRoom);
	rooms[8] = Room::Room(44, 0, 0, 10, 7, 0, 9, RoomD::despRoom, RoomD::fromRoom);
	rooms[9] = Room::Room(17, 18, 0, 0, 0, 8, 0, RoomD::despStairs1, daigo::doNothing);
	rooms[10] = Room::Room(40, 0, 0, 0, 8, 0, 3, RoomD::despStorge, RoomD::fromStorge);
	rooms[11] = Room::Room(33, 24, 0, 0, 0, 0, 12, RoomD::despStair2M, daigo::doNothing);
	rooms[12] = Room::Room(20, 0, 0, 13, 0, 11, 0, RoomD::despRoom, RoomD::fromRoom);
	rooms[13] = Room::Room(44, 0, 0, 14, 12, 0, 17, RoomD::despRoom, RoomD::fromRoom);
	rooms[14] = Room::Room(12, 0, 0, 15, 13, 0, 0, RoomD::despRoomLord, RoomD::fromRoom);
	rooms[15] = Room::Room(44, 0, 0, 16, 14, 0, 18, RoomD::despRoomSke, RoomD::fromRoom);
	rooms[16] = Room::Room(40, 0, 0, 0, 15, 0, 19, RoomD::despVeranda, daigo::doNothing);
	rooms[17] = Room::Room(52, 0, 0, 18, 0, 13, 20, RoomD::despVeranda, daigo::doNothing);
	rooms[18] = Room::Room(58, 0, 9, 0, 17, 15, 22, RoomD::despStairs2, daigo::doNothing);
	rooms[19] = Room::Room(49, 29, 0, 0, 0, 16, 23, RoomD::despStairs2, daigo::doNothing);
	rooms[20] = Room::Room(20, 0, 0, 21, 0, 17, 0, RoomD::despRoomSke, RoomD::fromRoom);
	rooms[21] = Room::Room(12, 0, 0, 22, 20, 0, 0, RoomD::despRoomM, RoomD::fromRoom);
	rooms[22] = Room::Room(28, 0, 0, 23, 21, 18, 0, RoomD::despRoom, RoomD::fromRoom);
	rooms[23] = Room::Room(24, 0, 0, 0, 22, 19, 0, RoomD::despGuard, daigo::doNothing);
	rooms[24] = Room::Room(38, 0, 11, 25, 0, 0, 26, RoomD::despStairs3, daigo::doNothing);
	rooms[25] = Room::Room(0, 0, 0, 0, 0, 0, 0, RoomD::despMonster, di, d);
	rooms[26] = Room::Room(16, 0, 0, 0, 0, 24, 0, RoomD::despVerandaP, RoomD::fromVerandaP);
	rooms[27] = Room::Room(4, 0, 0, 28, 0, 0, 0, RoomD::despRoom, RoomD::fromRoom);
	rooms[28] = Room::Room(12, 0, 0, 29, 27, 0, 0, RoomD::despP, wi, d);
	rooms[29] = Room::Room(10, 0, 19, 0, 28, 0, 0, RoomD::despStairs3, daigo::doNothing);

}

