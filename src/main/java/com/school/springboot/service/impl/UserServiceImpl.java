package com.school.springboot.service.impl;

import cn.hutool.log.Log;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.school.springboot.controller.dto.UserDTO;
import com.school.springboot.entity.User;
import com.school.springboot.mapper.UserMapper;
import com.school.springboot.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import org.springframework.stereotype.Service;


/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author school
 * @since 2022-08-18
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {
    private static final Log LOG = Log.get();
    @Override
    public boolean login(UserDTO userDTO) {
        QueryWrapper<User> queryWrapper=new QueryWrapper<>();
        queryWrapper.eq("username",userDTO.getUsername());
        queryWrapper.eq("password",userDTO.getPassword());
        try {
            User one= getOne(queryWrapper);
            return one != null;
        }catch (Exception e){
            LOG.error(e);
            return false;
        }
    }
}
