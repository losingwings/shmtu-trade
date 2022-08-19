package com.school.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 
 * </p>
 *
 * @author school
 * @since 2022-08-18
 */
@Getter
@Setter
  @TableName("student_user")
@ApiModel(value = "User对象", description = "")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

      @TableId(value = "id", type = IdType.AUTO)
      private Long id;

      @ApiModelProperty("用户名")
      private String username;

      @ApiModelProperty("密码")
      private String password;

      @ApiModelProperty("昵称")
      private String nickname;

      @ApiModelProperty("专业")
      private String userMajor;

      @ApiModelProperty("班级")
      private String userClass;

      @ApiModelProperty("QQ账号")
      private String qq;

      @ApiModelProperty("邮箱")
      private String email;

      @ApiModelProperty("手机号")
      private String phone;

      @ApiModelProperty("状态  0：禁用   1：正常")
      private Integer status;

      @ApiModelProperty("创建时间")
      private LocalDateTime createTime;

      @ApiModelProperty("头像")
      private String avatarUrl;


}
