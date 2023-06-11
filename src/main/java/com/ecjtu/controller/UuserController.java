package com.ecjtu.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ecjtu.pojo.Role;
import com.ecjtu.pojo.User;
import com.ecjtu.pojo.DataVo;
import com.ecjtu.service.RoleService;
import com.ecjtu.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class UuserController {
    @Resource
    UserService userService;
    @Resource
    RoleService roleService;
    //跳转至user.jsp
    @RequestMapping("/user")
    public String user(HttpServletRequest res){
        //获取角色权限的所有值传递到user.jsp页面
        List<Role> roleList = roleService.getAllRole();
        res.setAttribute("roleList",roleList);
        return "user";
    }
    //获取所有用户信息的请求路径
//    @RequestMapping("/getAllUsers")
//    @ResponseBody //不返回视图，直接写入页面
//    public List<User> getAllUsers(){
//        List<User> list = userService.getUsers(new User());
//        return list;
//    }
    @RequestMapping("/getAllUsers")
    @ResponseBody //不返回视图，直接写入页面
    //返回给layui使用，返回值必须包含某些字段
    public DataVo getAllUsers(@RequestParam(defaultValue = "1") int page,
                              @RequestParam(defaultValue = "8") int limit,
                              @RequestParam(required = false,value = "username")String username,
                              @RequestParam(required = false,value = "tel")String tel,
                              @RequestParam(required = false,value = "role")String role){
        //初始化查询的User对象
        User user = new User(username,tel,role);
        //设置分页的参数
        PageHelper.startPage(page,limit);//设置当前页和每页的数量
        //获取数据
        List<User> list = userService.getUsers(user);
        //获取分页的信息,将要分页的数据给分页工具
        PageInfo<Object> pageInfo = new PageInfo(list);
        //封装的layui数据根据分页对象来获取
        DataVo userVo = new DataVo(pageInfo.getList(),(int)pageInfo.getTotal());
        return userVo;
    }
    //添加用户的请求
    @RequestMapping("/addUser")
    @ResponseBody
    public String addUser(User user){
        int a = userService.register(user);
        if(a>0){
            return "添加成功!";
        }else{
            return "添加失败!";
        }
    }
    //添加用户的请求
    @RequestMapping("/updateUser")
    @ResponseBody
    public String updateUser(User user){
        int a = userService.update(user);
        if(a>0){
            return "修改成功!";
        }else{
            return "修改失败!";
        }
    }
    //批量删除的方法
    @RequestMapping("/deleteUser")
    @ResponseBody
    public String deleteUser(int[] ids){
        int a = userService.deleteBatch(ids);
        if(a>0){
            return "删除"+a+"个用户成功!";
        }else{
            return "删除失败!";
        }
    }
}
