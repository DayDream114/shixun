package com.ecjtu.service.impl;

import com.ecjtu.dao.RoleMapper;
import com.ecjtu.pojo.Role;
import com.ecjtu.service.RoleService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {
    @Resource
    RoleMapper roleMapper;

    @Override
    public List<Role> getAllRole() {
        return roleMapper.getAllRole();
    }
    @Override
    public int addRole(Role role) {
        return roleMapper.addRole(role);
    }

    @Override
    public int update(Role role) {
        return roleMapper.updateRole(role);
    }

}
