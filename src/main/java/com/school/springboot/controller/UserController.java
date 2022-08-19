package com.school.springboot.controller;


import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.poi.excel.ExcelReader;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.school.springboot.controller.dto.UserDTO;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;

import com.school.springboot.service.IUserService;
import com.school.springboot.entity.User;

import org.springframework.stereotype.Controller;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author school
 * @since 2022-08-18
 */
@RestController
@RequestMapping("/user")
public class UserController {

        //动态生成
        @Resource
          private IUserService userService;

        @PostMapping("/login")
        public boolean login(@RequestBody UserDTO userDTO) {
            String username=userDTO.getUsername();
            String password=userDTO.getPassword();
            if(StrUtil.isBlank(username)|| StringUtils.isBlank(password)){
                return false;
            }
            return userService.login(userDTO);
        }

          //新增或者更新
        @PostMapping
          public Boolean save(@RequestBody User user) {
                return userService.saveOrUpdate(user);
                }
        //删除
        @DeleteMapping("/{id}")
          public Boolean delete(@PathVariable Integer id) {
                return userService.removeById(id);
                }
        //查询所有
        @GetMapping
          public List<User> findAll() {
                return userService.list();
                }
        //根据id查询
        @GetMapping("/{id}")
          public User findOne(@PathVariable Integer id) {
                return userService.getById(id);
                }
        //分页查询
        @GetMapping("/page")
          public Page<User> findPage(@RequestParam Integer pageNum,
                                @RequestParam Integer pageSize,
                                     @RequestParam(defaultValue = "")  String uername) {
            QueryWrapper<User> queryWrapper=new QueryWrapper<>();
            if (!"".equals(uername)){
                queryWrapper.like("username",uername);
            }
            queryWrapper.orderByDesc("id");
                return userService.page(new Page<>(pageNum, pageSize),queryWrapper);
                }

}

