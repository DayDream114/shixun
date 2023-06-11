package com.ecjtu.controller;

import com.ecjtu.pojo.User;
import com.ecjtu.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

@Controller
@SessionAttributes(value = "user")//将model中数据同步到session中
public class LoginController {
    @Resource
    private UserService userService;

    @RequestMapping("/login")
    public String login(){
        return "login";
    }
    @RequestMapping("/toLogin")
    public ModelAndView toLogin(User user){
        User u = userService.login(user.getUsername(),user.getPassword());
        ModelAndView modelAndView = new ModelAndView();
        System.out.println(u);
        //是否能得到一个u,决定是否登录成功
        if (u!=null) {
            //将user存进session中
            modelAndView.addObject("user",u);
            modelAndView.setViewName("index");
        }else {
            modelAndView.addObject("error","账号或密码错误!");
            modelAndView.setViewName("login");
        }
        return modelAndView;
    }
    //跳转首页
    @RequestMapping("/main")
    public String main(){
        return "main";
    }
}
