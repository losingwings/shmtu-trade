package com.school.springboot.mapper;

import com.school.springboot.entity.User;
import com.school.springboot.controller.dto.UserPasswordDTO;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Update;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author school
 * @since 2022-08-18
 */

public interface UserMapper extends BaseMapper<User> {
    @Update("update student_user set password = #{newPassword} where username = #{username} and password = #{password}")
    int updatePassword(UserPasswordDTO userPasswordDTO);
}
