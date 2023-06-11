package com.ecjtu.pojo;

import java.util.List;

public class DataVo {
    //封装给layui接收的数据类型
    int code;//状态码,成功的为0
    String msg;//信息
    List<Object> data;
    int count;//显示数据的数量

    public DataVo() {
    }

    public DataVo(List<Object> data, int count) {
        this.code = 0;
        this.msg = "成功";
        this.data = data;
        this.count = count;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public List<Object> getData() {
        return data;
    }

    public void setData(List<Object> data) {
        this.data = data;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
