package com.school.springboot.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.log.Log;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.school.springboot.common.Constants;
import com.school.springboot.controller.dto.UserDTO;
import com.school.springboot.controller.dto.UserPasswordDTO;
import com.school.springboot.entity.User;
import com.school.springboot.exception.ServiceException;
import com.school.springboot.mapper.UserMapper;
import com.school.springboot.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import com.school.springboot.utils.TokenUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;


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

    @Resource
    private UserMapper userMapper;
    @Override
    public UserDTO login(UserDTO userDTO) {
           User one=getUserInfo(userDTO);
            if(one!=null) {
                BeanUtil.copyProperties(one, userDTO, true);
//                设置token
                String token = TokenUtils.genToken(one.getId().toString(),one.getPassword());
                userDTO.setToken(token);
                return userDTO;
            }
            else {
             throw new ServiceException(Constants.code_600,"用户名或密码错误");
            }
        }

    @Override
    public User register(UserDTO userDTO) {
        User one=getUserInfo(userDTO);
        if(one == null){
            one =new User();
            BeanUtil.copyProperties(userDTO,one,true);
            save(one);//存储新用户到数据库
        }else{
            throw new ServiceException(Constants.code_600,"用户已存在");
        }
        return one;
    }

    @Override
    public void updatePassword(UserPasswordDTO userPasswordDTO) {
        int update = userMapper.updatePassword(userPasswordDTO);
        if (update < 1) {
            throw new ServiceException(Constants.code_600, "密码错误");
        }
    }

    private User getUserInfo(UserDTO userDTO) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", userDTO.getUsername());
        queryWrapper.eq("password", userDTO.getPassword());
        User one;
        try {
            one = getOne(queryWrapper); // 从数据库查询用户信息
        } catch (Exception e) {
            LOG.error(e);
            throw new ServiceException(Constants.code_500, "系统错误");
        }
        return one;
    }
}

