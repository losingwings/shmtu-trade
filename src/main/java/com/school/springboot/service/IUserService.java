package com.school.springboot.service;

import com.school.springboot.controller.dto.UserDTO;
import com.school.springboot.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author school
 * @since 2022-08-18
 */
public interface IUserService extends IService<User> {

    boolean login(UserDTO userDTO);
}
