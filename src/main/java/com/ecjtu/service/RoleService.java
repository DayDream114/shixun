package com.ecjtu.service;

import com.ecjtu.pojo.Role;

import java.util.List;

public interface RoleService {
    public List<Role> getAllRole();
    public int addRole(Role role);
    public int update(Role role);
}
