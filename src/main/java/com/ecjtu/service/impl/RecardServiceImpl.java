package com.ecjtu.service.impl;

import com.ecjtu.dao.RecardMapper;
import com.ecjtu.dao.RoomMapper;
import com.ecjtu.pojo.Recard;
import com.ecjtu.pojo.Room;
import com.ecjtu.service.RecardService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class RecardServiceImpl implements RecardService {
    @Resource
    RecardMapper recardMapper;
    @Resource
    RoomMapper roomMapper;
    @Override
    public List<Room> getFreeRoom(){ return recardMapper.getFreeRoom(); }
    @Override
    public int openRoom(Recard recard,Room room){
    recardMapper.update(room);
    return recardMapper.openRoom(recard);
    }
    @Override
    public int update(Room room){ return  recardMapper.update(room);}
    @Override
    public int checkOut(Recard recard,Room room){recardMapper.Change(room);
    return recardMapper.checkOut(recard);}
    @Override
    public List<Recard> getRecard(){return recardMapper.getRecard();}
}
