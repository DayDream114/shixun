/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80028
 Source Host           : localhost:3306
 Source Schema         : ssmdb

 Target Server Type    : MySQL
 Target Server Version : 80028
 File Encoding         : 65001

 Date: 07/06/2023 08:55:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hotel_recard
-- ----------------------------
DROP TABLE IF EXISTS `hotel_recard`;
CREATE TABLE `hotel_recard`  (
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `idcard` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `roomid` int NOT NULL,
  `roomtype` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Stime` datetime NULL DEFAULT NULL,
  `Etime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`idcard`, `roomid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hotel_recard
-- ----------------------------
INSERT INTO `hotel_recard` VALUES ('1231', '123', 203, '标准间', '2023-05-09 00:00:00', NULL);
INSERT INTO `hotel_recard` VALUES ('123', '123', 205, '标准间', '2023-05-13 00:00:00', NULL);
INSERT INTO `hotel_recard` VALUES ('123', '123', 403, '豪华间', '2023-05-09 16:00:00', NULL);
INSERT INTO `hotel_recard` VALUES ('哈哈哈', '1234', 202, '单人间', '2023-05-09 00:00:00', NULL);

-- ----------------------------
-- Table structure for hotel_role
-- ----------------------------
DROP TABLE IF EXISTS `hotel_role`;
CREATE TABLE `hotel_role`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hotel_role
-- ----------------------------
INSERT INTO `hotel_role` VALUES (1, '大堂职员');
INSERT INTO `hotel_role` VALUES (2, '酒店经理');
INSERT INTO `hotel_role` VALUES (3, '酒店后勤');

-- ----------------------------
-- Table structure for hotel_room
-- ----------------------------
DROP TABLE IF EXISTS `hotel_room`;
CREATE TABLE `hotel_room`  (
  `roomid` int NOT NULL,
  `roomtype` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`roomid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hotel_room
-- ----------------------------
INSERT INTO `hotel_room` VALUES (202, '单人间', 299.00, '居住');
INSERT INTO `hotel_room` VALUES (203, '标准间', 299.00, '居住');
INSERT INTO `hotel_room` VALUES (205, '标准间', 299.00, '居住');
INSERT INTO `hotel_room` VALUES (302, '标准间', 299.00, '空闲');
INSERT INTO `hotel_room` VALUES (403, '豪华间', 699.00, '居住');

-- ----------------------------
-- Table structure for hotel_user
-- ----------------------------
DROP TABLE IF EXISTS `hotel_user`;
CREATE TABLE `hotel_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hotel_user
-- ----------------------------
INSERT INTO `hotel_user` VALUES (1, 'xiaoming', '123', '123', '1');
INSERT INTO `hotel_user` VALUES (2, 'xiaowang', '123', '123', '2');
INSERT INTO `hotel_user` VALUES (3, 'xiaohong', '123', '123', '3');
INSERT INTO `hotel_user` VALUES (5, 'xiaotian', '123', '123', '3');
INSERT INTO `hotel_user` VALUES (8, '123', '123', '123', '2');

SET FOREIGN_KEY_CHECKS = 1;
