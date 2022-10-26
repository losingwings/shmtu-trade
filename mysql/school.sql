/*
 Navicat Premium Data Transfer

 Source Server         : root
 Source Server Type    : MySQL
 Source Server Version : 80011
 Source Host           : localhost:3306
 Source Schema         : school

 Target Server Type    : MySQL
 Target Server Version : 80011
 File Encoding         : 65001

 Date: 26/10/2022 19:37:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_allusers
-- ----------------------------
DROP TABLE IF EXISTS `admin_allusers`;
CREATE TABLE `admin_allusers`  (
  `admin_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `admin_pwd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_allusers
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `goods_category_id` bigint(20) NOT NULL COMMENT '分类id',
  `goods_category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类别',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`goods_category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------

-- ----------------------------
-- Table structure for student_user
-- ----------------------------
DROP TABLE IF EXISTS `student_user`;
CREATE TABLE `student_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `user_major` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专业',
  `user_class` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '班级',
  `qq` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'QQ账号',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '状态  0：禁用   1：正常',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `avatar_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student_user
-- ----------------------------
INSERT INTO `student_user` VALUES (1, '123', '123', '小小小', '信息', '193', '123123123', '123123123@123', '1472286', 1, '2022-08-03 13:50:34', 'http://localhost:9090/file/d1c1ac423550413d9c9792734ad69cd5.jpg');
INSERT INTO `student_user` VALUES (2, 'nikou', '123', '霓口', '计算机', '201', NULL, '321@123', NULL, NULL, '2022-08-03 14:58:02', NULL);
INSERT INTO `student_user` VALUES (9, '2123', '0000', '什么', '网络', '202', '222', NULL, NULL, NULL, '2022-08-03 19:39:51', '');
INSERT INTO `student_user` VALUES (13, '111', '111', '小路', NULL, NULL, NULL, '1231231237@qq.com', '123123123', NULL, '2022-10-10 12:43:50', NULL);
INSERT INTO `student_user` VALUES (14, '333', '333', '小米', NULL, NULL, NULL, '789987@qq.com', '222222222', NULL, '2022-10-10 12:44:28', NULL);

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件名称',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件类型',
  `size` bigint(20) NULL DEFAULT NULL COMMENT '文件大小',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '下载链接',
  `md5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件md5',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  `enable` tinyint(1) NULL DEFAULT 1 COMMENT '是否禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES (29, '0169ca5b062596a801209a859064f9.jpg@1280w_1l_2o_100sh.jpg', 'jpg', 780, 'http://localhost:9090/file/37fb24db50e54458862659c635f3966c.jpg', '3fee9a3791cb68451b2def775eded8a9', 0, 1);
INSERT INTO `sys_file` VALUES (30, 'preview.jpg', 'jpg', 57, 'http://localhost:9090/file/d1c1ac423550413d9c9792734ad69cd5.jpg', 'de70fbc2fde86769c2b557b890c173b1', 0, 1);
INSERT INTO `sys_file` VALUES (31, '01134756d3ed8b6ac7252ce6d00009.jpg@1280w_1l_2o_100sh.jpg', 'jpg', 389, 'http://localhost:9090/file/25d68d5f8da247f2bf18bd9116feae4a.jpg', 'b0339c656cd44229e55ebdf6cef2162b', 0, 1);
INSERT INTO `sys_file` VALUES (32, '01134756d3ed8b6ac7252ce6d00009.jpg@1280w_1l_2o_100sh.jpg', 'jpg', 389, 'http://localhost:9090/file/25d68d5f8da247f2bf18bd9116feae4a.jpg', 'b0339c656cd44229e55ebdf6cef2162b', 0, 1);
INSERT INTO `sys_file` VALUES (33, '0169ca5b062596a801209a859064f9.jpg@1280w_1l_2o_100sh.jpg', 'jpg', 780, 'http://localhost:9090/file/37fb24db50e54458862659c635f3966c.jpg', '3fee9a3791cb68451b2def775eded8a9', 0, 1);
INSERT INTO `sys_file` VALUES (34, '01134756d3ed8b6ac7252ce6d00009.jpg@1280w_1l_2o_100sh.jpg', 'jpg', 389, 'http://localhost:9090/file/25d68d5f8da247f2bf18bd9116feae4a.jpg', 'b0339c656cd44229e55ebdf6cef2162b', 0, 1);
INSERT INTO `sys_file` VALUES (35, '01134756d3ed8b6ac7252ce6d00009.jpg@1280w_1l_2o_100sh.jpg', 'jpg', 389, 'http://localhost:9090/file/25d68d5f8da247f2bf18bd9116feae4a.jpg', 'b0339c656cd44229e55ebdf6cef2162b', 0, 1);
INSERT INTO `sys_file` VALUES (36, '0169ca5b062596a801209a859064f9.jpg@1280w_1l_2o_100sh.jpg', 'jpg', 780, 'http://localhost:9090/file/37fb24db50e54458862659c635f3966c.jpg', '3fee9a3791cb68451b2def775eded8a9', 0, 1);
INSERT INTO `sys_file` VALUES (37, '0169ca5b062596a801209a859064f9.jpg@1280w_1l_2o_100sh.jpg', 'jpg', 780, 'http://localhost:9090/file/37fb24db50e54458862659c635f3966c.jpg', '3fee9a3791cb68451b2def775eded8a9', 0, 1);
INSERT INTO `sys_file` VALUES (38, '01134756d3ed8b6ac7252ce6d00009.jpg@1280w_1l_2o_100sh.jpg', 'jpg', 389, 'http://localhost:9090/file/25d68d5f8da247f2bf18bd9116feae4a.jpg', 'b0339c656cd44229e55ebdf6cef2162b', 0, 1);
INSERT INTO `sys_file` VALUES (39, '01b8f15a2a9554a80120ba380380c1.jpg@1280w_1l_2o_100sh.jpg', 'jpg', 815, 'http://localhost:9090/file/349ffa05e100484e9164918cac6f5589.jpg', '9dea2dcd02d5b9f1a940ff47fe5bb1e2', 0, 1);
INSERT INTO `sys_file` VALUES (40, '01134756d3ed8b6ac7252ce6d00009.jpg@1280w_1l_2o_100sh.jpg', 'jpg', 389, 'http://localhost:9090/file/25d68d5f8da247f2bf18bd9116feae4a.jpg', 'b0339c656cd44229e55ebdf6cef2162b', 0, 1);
INSERT INTO `sys_file` VALUES (41, '01134756d3ed8b6ac7252ce6d00009.jpg@1280w_1l_2o_100sh.jpg', 'jpg', 389, 'http://localhost:9090/file/25d68d5f8da247f2bf18bd9116feae4a.jpg', 'b0339c656cd44229e55ebdf6cef2162b', 0, 1);
INSERT INTO `sys_file` VALUES (42, '01134756d3ed8b6ac7252ce6d00009.jpg@1280w_1l_2o_100sh.jpg', 'jpg', 389, 'http://localhost:9090/file/25d68d5f8da247f2bf18bd9116feae4a.jpg', 'b0339c656cd44229e55ebdf6cef2162b', 0, 1);
INSERT INTO `sys_file` VALUES (43, '0169ca5b062596a801209a859064f9.jpg@1280w_1l_2o_100sh.jpg', 'jpg', 780, 'http://localhost:9090/file/37fb24db50e54458862659c635f3966c.jpg', '3fee9a3791cb68451b2def775eded8a9', 0, 1);

-- ----------------------------
-- Table structure for system_about_us
-- ----------------------------
DROP TABLE IF EXISTS `system_about_us`;
CREATE TABLE `system_about_us`  (
  `ID` int(11) NOT NULL,
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_about_us
-- ----------------------------

-- ----------------------------
-- Table structure for system_goods
-- ----------------------------
DROP TABLE IF EXISTS `system_goods`;
CREATE TABLE `system_goods`  (
  `goods_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品表主键id',
  `goods_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商品名',
  `goods_intro` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商品简介',
  `goods_category_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '关联分类id',
  `goods_cover_img` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '/admin/dist/img/no-img.png' COMMENT '商品主图',
  `goods_detail_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品详情',
  `original_price` int(11) NOT NULL DEFAULT 1 COMMENT '商品价格',
  `selling_price` int(11) NOT NULL DEFAULT 1 COMMENT '商品实际售价',
  `tag` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商品标签',
  `goods_sell_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '商品上架状态 0-下架 1-上架',
  `create_user` bigint(20) NOT NULL DEFAULT 0 COMMENT '添加者主键id',
  PRIMARY KEY (`goods_id`) USING BTREE,
  INDEX `create_user_idx`(`create_user` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_goods
-- ----------------------------

-- ----------------------------
-- Table structure for system_notice
-- ----------------------------
DROP TABLE IF EXISTS `system_notice`;
CREATE TABLE `system_notice`  (
  `ID` int(11) NOT NULL,
  `tittle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_notice
-- ----------------------------

-- ----------------------------
-- Table structure for uer_wish_list
-- ----------------------------
DROP TABLE IF EXISTS `uer_wish_list`;
CREATE TABLE `uer_wish_list`  (
  `goods_category_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '心愿单类型',
  `goods_details` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '描述',
  PRIMARY KEY (`goods_category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of uer_wish_list
-- ----------------------------

-- ----------------------------
-- Table structure for user_add_goods
-- ----------------------------
DROP TABLE IF EXISTS `user_add_goods`;
CREATE TABLE `user_add_goods`  (
  `goods_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `goods_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商品名',
  `goods_intro` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商品简介',
  `goods_category_id` bigint(20) NULL DEFAULT 0 COMMENT '分类id',
  `goods_cover_img` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `original_price` int(11) NOT NULL COMMENT '商品价格',
  `tag` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '标签',
  `goods_sell_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '商品上架状态 0-下架 1-上架',
  `addtime` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`goods_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_add_goods
-- ----------------------------

-- ----------------------------
-- Table structure for user_order
-- ----------------------------
DROP TABLE IF EXISTS `user_order`;
CREATE TABLE `user_order`  (
  `order_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单表主键id',
  `order_no` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '订单号',
  `user_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '用户主键id',
  `total_price` int(11) NOT NULL DEFAULT 1 COMMENT '订单总价',
  `pay_status` bigint(20) NOT NULL DEFAULT 0 COMMENT '支付状态:0.未支付,1.支付成功,-1:支付失败',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `order_status` bigint(20) NOT NULL DEFAULT 0 COMMENT '订单状态:0.待支付 1.已支付 2.配货完成 3:出库成功 4.交易成功 -1.手动关闭 -2.超时关闭 -3.商家关闭',
  `extra_info` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '订单body',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `user_phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '收货人手机号',
  `user_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '收货人收货地址',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `user_id_idx`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_order
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
