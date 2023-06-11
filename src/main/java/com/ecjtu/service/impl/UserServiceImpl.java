package com.ecjtu.service.impl;

import com.ecjtu.dao.UserMapper;
import com.ecjtu.pojo.User;
import com.ecjtu.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserMapper userMapper;
    @Override
    public User login(String username, String password) {
        return userMapper.findUserByNameAndPsw(username,password);
    }

    @Override
    public List<User> getUsers(User user) {
        return userMapper.findUserByUser(user);
    }

    @Override
    public int register(User user) {
        return userMapper.addUser(user);
    }

    @Override
    public int logoff(int id) {
        return userMapper.deleteUserById(id);
    }

    @Override
    public int deleteBatch(int[] ids) {
        return userMapper.deleteBatch(ids);
    }

    @Override
    public int update(User user) {
        return userMapper.updateUserByUser(user);
    }

    @Override
    public User getUserInfo(int id) {
        return userMapper.getUserById(id);
    }
}

