#include <string>
#include "Room.h"
#include "daigo.h"

#pragma once
#ifndef _MAP_H_
#define _MAP_H_

#define ROOMN 30

class Map
{
public:
	Room rooms[ROOMN];

public:
	Map(daigo* d);
	
	//Map(std::string* a);
	//Map();
};

#endif