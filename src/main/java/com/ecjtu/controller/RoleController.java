package com.ecjtu.controller;

import com.ecjtu.pojo.DataVo;
import com.ecjtu.pojo.Role;
import com.ecjtu.service.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
@Controller
public class RoleController {
    @Resource
    RoleService roleService;
    //跳转至role.jsp
    @RequestMapping("/role")
    public String user(HttpServletRequest res){
        return "role";
    }

    @RequestMapping("/getAllRole")
    @ResponseBody //不返回视图，直接写入页面
    //返回给layui使用，返回值必须包含某些字段
    public DataVo getAllUsers(@RequestParam(defaultValue = "1") int page,
                              @RequestParam(defaultValue = "10") int limit){
        //设置分页的参数
        PageHelper.startPage(page,limit);//设置当前页和每页的数量
        //获取数据
        List<Role> list = roleService.getAllRole();
        //获取分页的信息,将要分页的数据给分页工具
        PageInfo<Object> pageInfo = new PageInfo(list);
        //封装的layui数据根据分页对象来获取
        DataVo roleVo = new DataVo(pageInfo.getList(),(int)pageInfo.getTotal());
        return roleVo;
    }
    //添加用户的请求
    @RequestMapping("/addRole")
    @ResponseBody
    public String addUser(Role role){
        int a = roleService.addRole(role);
        if(a>0){
            return "添加成功!";
        }else{
            return "添加失败!";
        }
    }
    //添加用户的请求
    @RequestMapping("/updateRole")
    @ResponseBody
    public String updateUser(Role role){
        int a = roleService.update(role);
        if(a>0){
            return "修改成功!";
        }else{
            return "修改失败!";
        }
    }
}
