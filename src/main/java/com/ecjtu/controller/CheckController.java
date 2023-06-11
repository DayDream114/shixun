package com.ecjtu.controller;

import com.ecjtu.pojo.DataVo;
import com.ecjtu.pojo.Recard;
import com.ecjtu.pojo.Role;
import com.ecjtu.pojo.Room;
import com.ecjtu.service.RecardService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Controller
public class CheckController {
    @Resource
    RecardService recardService;
    @RequestMapping("/checkout")
    public String checkout(HttpServletRequest res){
        //获取角色权限的所有值传递到user.jsp页面
        List<Recard> checkList = recardService.getRecard();
        res.setAttribute("recardList",checkList);
        return "checkout";
    }
    @RequestMapping("/getRecard")
    @ResponseBody //不返回视图，直接写入页面
    //返回给layui使用，返回值必须包含某些字段
    public DataVo getAllUsers(@RequestParam(defaultValue = "1") int page,
                              @RequestParam(defaultValue = "10") int limit,
                              @RequestParam(required = false,value = "name")String name,
                              @RequestParam(required = false,value = "roomid")Integer roomid,
                              @RequestParam(required = false,value = "roomtype")String roomtype,
                              @RequestParam(required = false,value = "stime")Date stime
                              ){

        Recard recard = new Recard();
        if (name != null){
            recard.setName(name);
        }
        if (roomid != null){
            recard.setRoomid(roomid);
        }
        if (roomtype != null){
            recard.setRoomtype(roomtype);
        }
        if (stime != null){
            recard.setStime(stime);
        }
        //        //设置分页的参数
        PageHelper.startPage(page,limit);//设置当前页和每页的数量
        //获取数据
        List<Recard> list = recardService.getRecard();
        for (Recard r:list) {
            System.out.println(r.getStime());
        }
        //获取分页的信息,将要分页的数据给分页工具
        PageInfo<Object> pageInfo = new PageInfo(list);
        //封装的layui数据根据分页对象来获取
        DataVo userVo = new DataVo(pageInfo.getList(),(int)pageInfo.getTotal());
        return userVo;
    }
    //退房请求
    @RequestMapping("/checkOut")
    @ResponseBody
    public String CheckOut(Recard recard,Room room){
        int a = recardService.checkOut(recard,room);
        if(a>0){
            return "退房成功!";
        }else{
            return "退房失败!";
        }
    }
}
