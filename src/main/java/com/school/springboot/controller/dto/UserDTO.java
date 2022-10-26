package com.school.springboot.controller.dto;

import lombok.Data;
/*接受前端参数的的*/

@Data
public class UserDTO {
    private String username;
    private String password;
    private String nickname;
    private  String avatarUrl;
    private String token;
}
