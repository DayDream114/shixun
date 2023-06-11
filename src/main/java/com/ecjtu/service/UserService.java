package com.ecjtu.service;

import com.ecjtu.pojo.User;

import java.util.List;

public interface UserService {
    //登录方法
    public User login(String username, String password);
    //查询用户的方法
    public List<User> getUsers(User user);
    //注册
    public int register(User user);
    //删除
    public int logoff(int id);
    //批量删除
    public int deleteBatch(int[] ids);
    //修改
    public int update(User user);
    //获取单个用户
    public User getUserInfo(int id);
}
