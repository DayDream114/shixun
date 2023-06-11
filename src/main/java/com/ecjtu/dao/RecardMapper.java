package com.ecjtu.dao;

import com.ecjtu.pojo.Recard;
import com.ecjtu.pojo.Room;

import java.util.List;

public interface RecardMapper {
    int openRoom(Recard recard);
    int update(Room room);
    List<Room> getFreeRoom();
    int checkOut(Recard recard);
    int Change(Room room);
    List<Recard> getRecard();
}

