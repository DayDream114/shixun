package com.ecjtu.dao;

import com.ecjtu.pojo.Room;

import java.util.List;

public interface RoomMapper {
    int addRoom(Room room);
    int deleteRoom(int roomid);
    int updateRoom(Room room);
    List<Room> getAllRoom();
    List<Room> findRoomByRoom(Room room);
    Room getRoom(int roomid);
}
