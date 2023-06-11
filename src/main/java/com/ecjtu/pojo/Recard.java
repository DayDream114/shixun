package com.ecjtu.pojo;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Recard {
    private String name;
    private String idcard;
    private int roomid;
    private String roomtype;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date Stime;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date Etime;

    public Recard() {
    }

    public Recard(String name, int roomid, String roomtype, Date stime) {
        this.name = name;
        this.roomid = roomid;
        this.roomtype = roomtype;
        Stime = stime;
    }

    public Recard(String name, String idcard, int roomid, String roomtype, Date stime) {
        this.name = name;
        this.idcard = idcard;
        this.roomid = roomid;
        this.roomtype = roomtype;
        Stime = stime;
    }

    public Recard(String name, String idcard, int roomid, String roomtype,Date stime, Date etime) {
        this.name = name;
        this.idcard = idcard;
        this.roomid = roomid;
        this.roomtype = roomtype;
        Stime = stime;
        Etime = etime;
    }

    @Override
    public String toString() {
        return "recard{" +
                "name='" + name + '\'' +
                ", idcard='" + idcard + '\'' +
                ", roomid=" + roomid +
                ", roomtype='" + roomtype + '\'' +
                ", Stime=" + Stime +
                ", Etime=" + Etime +
                '}';
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public int getRoomid() {
        return roomid;
    }

    public void setRoomid(int roomid) {
        this.roomid = roomid;
    }

    public String getRoomtype() {
        return roomtype;
    }

    public void setRoomtype(String roomtype) {
        this.roomtype = roomtype;
    }

    public Date getStime() {
        return Stime;
    }

    public void setStime(Date stime) {
        Stime = stime;
    }

    public Date getEtime() {
        return Etime;
    }

    public void setEtime(Date etime) {
        Etime = etime;
    }
}
