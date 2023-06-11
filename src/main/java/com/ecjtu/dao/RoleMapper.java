package com.ecjtu.dao;

import com.ecjtu.pojo.Role;

import java.util.List;

public interface RoleMapper {
    //增
    int addRole(Role role);
    //改
    int updateRole(Role role);
    List<Role> getAllRole();
}
