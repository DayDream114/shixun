package com.ecjtu.service;

import com.ecjtu.pojo.Recard;
import com.ecjtu.pojo.Room;

import java.util.List;

public interface RecardService {
    public int openRoom(Recard recard,Room room);
    public List<Room> getFreeRoom();
    public int update(Room room);
    public int checkOut(Recard recard,Room room);
    public List<Recard> getRecard();
}
