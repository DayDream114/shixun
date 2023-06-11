package com.ecjtu.service;

import com.ecjtu.pojo.Room;

import java.util.List;

public interface RoomService {
    public List<Room> getAllRoom();
    public int addRoom(Room room);
    public int deleteRoom(int roomid);
    public int updateRoom(Room room);
    public List<Room> getRooms(Room room);
    public Room getRoom(int roomid);
}
