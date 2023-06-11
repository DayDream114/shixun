package com.ecjtu.dao;

import com.ecjtu.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    //通过账号和密码查找用户
    User findUserByNameAndPsw(@Param(value = "username") String username,
                              @Param(value = "password") String password);
    //模糊查询的方法
    List<User> findUserByUser(User user);

    int addUser(User user);
    //删除用户
    int deleteUserById(int id);
    //批量删除用户的方法
    int deleteBatch(@Param("ids")int[] ids);
    //修改用户
    int updateUserByUser(User user);
    //查询单个
    User getUserById(int id);
}
