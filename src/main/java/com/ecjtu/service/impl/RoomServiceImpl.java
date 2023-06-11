package com.ecjtu.service.impl;

import com.ecjtu.dao.RoomMapper;
import com.ecjtu.pojo.Room;
import com.ecjtu.pojo.User;
import com.ecjtu.service.RoomService;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class RoomServiceImpl implements RoomService {
    @Resource
    RoomMapper roomMapper;
    @Override
    public List<Room> getAllRoom(){ return roomMapper.getAllRoom(); }
    @Override
    public int addRoom(Room room){ return roomMapper.addRoom(room);}
    @Override
    public int deleteRoom(int roomid){return roomMapper.deleteRoom(roomid);}
    @Override
    public int updateRoom(Room room){return roomMapper.updateRoom(room);}
    @Override
    public List<Room> getRooms(Room room) {
        return roomMapper.findRoomByRoom(room);
    }
    @Override
    public Room getRoom(int roomid) {
        return roomMapper.getRoom(roomid);
    }
}
