package com.school.springboot.controller;


import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.school.springboot.common.Constants;
import com.school.springboot.common.Result;
import com.school.springboot.controller.dto.UserDTO;
import com.school.springboot.controller.dto.UserPasswordDTO;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;

import com.school.springboot.service.IUserService;
import com.school.springboot.entity.User;

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
        public Result login(@RequestBody UserDTO userDTO) {
            String username=userDTO.getUsername();
            String password=userDTO.getPassword();
            if(StrUtil.isBlank(username)||StrUtil.isBlank(password)){
                return Result.error(Constants.code_400,"参数错误");
            }
            UserDTO dto=userService.login(userDTO);
            return Result.success(dto);
        }

        @PostMapping("/register")
        public Result register(@RequestBody UserDTO userDTO) {
            String username=userDTO.getUsername();
            String password=userDTO.getPassword();
            if(StrUtil.isBlank(username)|| StrUtil.isBlank(password)){
                return Result.error(Constants.code_400,"参数错误");
            }
            return Result.success(userService.register(userDTO));
    }

          //新增或者更新
        @PostMapping
          public Result save(@RequestBody User user) {
              String username=user.getUsername();
              if(StrUtil.isBlank(username)){
                return Result.error(Constants.code_400,"参数错误");
                }
              if(user.getId()!=null)
              {
                  user.setPassword(null);
              }else {
                  user.setNickname(user.getUsername());
                  if(user.getPassword()==null)
                  {
                      user.setPassword("123");
                  }
              }
              return Result.success(userService.saveOrUpdate(user));
        }

    /**
     * 修改密码
     * @param userPasswordDTO
     * @return
     */
    @PostMapping("/password")
    public Result password(@RequestBody UserPasswordDTO userPasswordDTO) {
        userService.updatePassword(userPasswordDTO);
        return Result.success();
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



        /*
        根据用户的用户名获取数据库的用户属性
        * */
        @GetMapping("/username/{username}")
        public Result findByUsername(@PathVariable String username) {
            QueryWrapper<User> queryWrapper=new QueryWrapper<>();
            queryWrapper.eq("username",username);
            User one=userService.getOne(queryWrapper);
            return Result.success(one);
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

