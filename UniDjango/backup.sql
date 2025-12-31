/*
 Navicat Premium Dump SQL

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 80041 (8.0.41)
 Source Host           : localhost:3306
 Source Schema         : unidjango

 Target Server Type    : MySQL
 Target Server Version : 80041 (8.0.41)
 File Encoding         : 65001

 Date: 30/12/2025 15:23:42
*/

CREATE DATABASE IF NOT EXISTS unidjango;
USE unidjango;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id` ASC, `codename` ASC) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add permission', 1, 'add_permission');
INSERT INTO `auth_permission` VALUES (2, 'Can change permission', 1, 'change_permission');
INSERT INTO `auth_permission` VALUES (3, 'Can delete permission', 1, 'delete_permission');
INSERT INTO `auth_permission` VALUES (4, 'Can view permission', 1, 'view_permission');
INSERT INTO `auth_permission` VALUES (5, 'Can add group', 2, 'add_group');
INSERT INTO `auth_permission` VALUES (6, 'Can change group', 2, 'change_group');
INSERT INTO `auth_permission` VALUES (7, 'Can delete group', 2, 'delete_group');
INSERT INTO `auth_permission` VALUES (8, 'Can view group', 2, 'view_group');
INSERT INTO `auth_permission` VALUES (9, 'Can add user', 3, 'add_user');
INSERT INTO `auth_permission` VALUES (10, 'Can change user', 3, 'change_user');
INSERT INTO `auth_permission` VALUES (11, 'Can delete user', 3, 'delete_user');
INSERT INTO `auth_permission` VALUES (12, 'Can view user', 3, 'view_user');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add sys user', 6, 'add_sysuser');
INSERT INTO `auth_permission` VALUES (22, 'Can change sys user', 6, 'change_sysuser');
INSERT INTO `auth_permission` VALUES (23, 'Can delete sys user', 6, 'delete_sysuser');
INSERT INTO `auth_permission` VALUES (24, 'Can view sys user', 6, 'view_sysuser');
INSERT INTO `auth_permission` VALUES (25, 'Can add 菜单表', 7, 'add_sysmenu');
INSERT INTO `auth_permission` VALUES (26, 'Can change 菜单表', 7, 'change_sysmenu');
INSERT INTO `auth_permission` VALUES (27, 'Can delete 菜单表', 7, 'delete_sysmenu');
INSERT INTO `auth_permission` VALUES (28, 'Can view 菜单表', 7, 'view_sysmenu');
INSERT INTO `auth_permission` VALUES (29, 'Can add 角色菜单关联表', 8, 'add_sysrolemenu');
INSERT INTO `auth_permission` VALUES (30, 'Can change 角色菜单关联表', 8, 'change_sysrolemenu');
INSERT INTO `auth_permission` VALUES (31, 'Can delete 角色菜单关联表', 8, 'delete_sysrolemenu');
INSERT INTO `auth_permission` VALUES (32, 'Can view 角色菜单关联表', 8, 'view_sysrolemenu');
INSERT INTO `auth_permission` VALUES (33, 'Can add 角色表', 9, 'add_sysrole');
INSERT INTO `auth_permission` VALUES (34, 'Can change 角色表', 9, 'change_sysrole');
INSERT INTO `auth_permission` VALUES (35, 'Can delete 角色表', 9, 'delete_sysrole');
INSERT INTO `auth_permission` VALUES (36, 'Can view 角色表', 9, 'view_sysrole');
INSERT INTO `auth_permission` VALUES (37, 'Can add 用户角色关联表', 10, 'add_sysuserrole');
INSERT INTO `auth_permission` VALUES (38, 'Can change 用户角色关联表', 10, 'change_sysuserrole');
INSERT INTO `auth_permission` VALUES (39, 'Can delete 用户角色关联表', 10, 'delete_sysuserrole');
INSERT INTO `auth_permission` VALUES (40, 'Can view 用户角色关联表', 10, 'view_sysuserrole');
INSERT INTO `auth_permission` VALUES (41, 'Can add 部门', 11, 'add_sysdep');
INSERT INTO `auth_permission` VALUES (42, 'Can change 部门', 11, 'change_sysdep');
INSERT INTO `auth_permission` VALUES (43, 'Can delete 部门', 11, 'delete_sysdep');
INSERT INTO `auth_permission` VALUES (44, 'Can view 部门', 11, 'view_sysdep');
INSERT INTO `auth_permission` VALUES (45, 'Can add 自动代码', 12, 'add_sysauto');
INSERT INTO `auth_permission` VALUES (46, 'Can change 自动代码', 12, 'change_sysauto');
INSERT INTO `auth_permission` VALUES (47, 'Can delete 自动代码', 12, 'delete_sysauto');
INSERT INTO `auth_permission` VALUES (48, 'Can view 自动代码', 12, 'view_sysauto');
INSERT INTO `auth_permission` VALUES (49, 'Can add 系统日志', 13, 'add_syslog');
INSERT INTO `auth_permission` VALUES (50, 'Can change 系统日志', 13, 'change_syslog');
INSERT INTO `auth_permission` VALUES (51, 'Can delete 系统日志', 13, 'delete_syslog');
INSERT INTO `auth_permission` VALUES (52, 'Can view 系统日志', 13, 'view_syslog');
INSERT INTO `auth_permission` VALUES (53, 'Can add 系统日志', 14, 'add_syslog');
INSERT INTO `auth_permission` VALUES (54, 'Can change 系统日志', 14, 'change_syslog');
INSERT INTO `auth_permission` VALUES (55, 'Can delete 系统日志', 14, 'delete_syslog');
INSERT INTO `auth_permission` VALUES (56, 'Can view 系统日志', 14, 'view_syslog');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id` ASC, `group_id` ASC) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id` ASC) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label` ASC, `model` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (2, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (1, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (12, 'auto', 'sysauto');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (11, 'department', 'sysdep');
INSERT INTO `django_content_type` VALUES (14, 'log', 'syslog');
INSERT INTO `django_content_type` VALUES (7, 'menu', 'sysmenu');
INSERT INTO `django_content_type` VALUES (8, 'menu', 'sysrolemenu');
INSERT INTO `django_content_type` VALUES (13, 'monitor', 'syslog');
INSERT INTO `django_content_type` VALUES (9, 'role', 'sysrole');
INSERT INTO `django_content_type` VALUES (10, 'role', 'sysuserrole');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (6, 'user', 'sysuser');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'user', '0001_initial', '2025-07-21 07:45:31.533105');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0001_initial', '2025-08-06 02:19:23.359155');
INSERT INTO `django_migrations` VALUES (3, 'contenttypes', '0002_remove_content_type_name', '2025-08-06 02:19:23.482417');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0001_initial', '2025-08-06 02:19:24.289935');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0002_alter_permission_name_max_length', '2025-08-06 02:19:24.377020');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0003_alter_user_email_max_length', '2025-08-06 02:19:24.396511');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0004_alter_user_username_opts', '2025-08-06 02:19:24.404176');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0005_alter_user_last_login_null', '2025-08-06 02:19:24.465590');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0006_require_contenttypes_0002', '2025-08-06 02:19:24.469789');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0007_alter_validators_add_error_messages', '2025-08-06 02:19:24.477355');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0008_alter_user_username_max_length', '2025-08-06 02:19:24.566925');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0009_alter_user_last_name_max_length', '2025-08-06 02:19:24.659451');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0010_alter_group_name_max_length', '2025-08-06 02:19:24.679357');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0011_update_proxy_permissions', '2025-08-06 02:19:24.689180');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0012_alter_user_first_name_max_length', '2025-08-06 02:19:24.752718');
INSERT INTO `django_migrations` VALUES (16, 'role', '0001_initial', '2025-08-06 02:19:24.928895');
INSERT INTO `django_migrations` VALUES (17, 'menu', '0001_initial', '2025-08-06 02:19:25.041638');
INSERT INTO `django_migrations` VALUES (18, 'menu', '0002_initial', '2025-08-06 02:19:25.115913');
INSERT INTO `django_migrations` VALUES (19, 'sessions', '0001_initial', '2025-08-06 02:19:25.156836');
INSERT INTO `django_migrations` VALUES (20, 'department', '0001_initial', '2025-09-08 07:45:58.953284');
INSERT INTO `django_migrations` VALUES (21, 'auto', '0001_initial', '2025-09-10 12:47:01.142463');
INSERT INTO `django_migrations` VALUES (22, 'auto', '0002_rename_name_sysauto_dep_name', '2025-09-19 08:05:59.448027');
INSERT INTO `django_migrations` VALUES (23, 'user', '0002_sysuser_department', '2025-09-23 06:52:20.761723');
INSERT INTO `django_migrations` VALUES (24, 'user', '0003_sysuser_role', '2025-09-30 06:29:05.262458');
INSERT INTO `django_migrations` VALUES (25, 'user', '0004_remove_sysuser_role', '2025-09-30 06:31:57.438569');
INSERT INTO `django_migrations` VALUES (26, 'monitor', '0001_initial', '2025-12-21 07:34:26.944841');
INSERT INTO `django_migrations` VALUES (27, 'log', '0001_initial', '2025-12-21 07:55:05.781520');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------

-- ----------------------------
-- Table structure for sys_auto
-- ----------------------------
DROP TABLE IF EXISTS `sys_auto`;
CREATE TABLE `sys_auto`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `dep_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` int NULL DEFAULT NULL,
  `create_time` date NULL DEFAULT NULL,
  `update_time` date NULL DEFAULT NULL,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`dep_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_auto
-- ----------------------------
INSERT INTO `sys_auto` VALUES (1, '测试12', 1, '2025-10-02', '2025-09-18', '11112');
INSERT INTO `sys_auto` VALUES (9, '看见撒', 1, '2025-09-23', '2025-09-25', '23');

-- ----------------------------
-- Table structure for sys_department
-- ----------------------------
DROP TABLE IF EXISTS `sys_department`;
CREATE TABLE `sys_department`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `dep_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` int NULL DEFAULT NULL,
  `create_time` date NULL DEFAULT NULL,
  `update_time` date NULL DEFAULT NULL,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `dep_name`(`dep_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_department
-- ----------------------------
INSERT INTO `sys_department` VALUES (1, '技术部', 1, '2025-09-08', '2025-09-08', 'technical1');
INSERT INTO `sys_department` VALUES (2, '网络部', 1, '2025-09-08', '2025-09-08', 'net');
INSERT INTO `sys_department` VALUES (3, '新闻部', 1, '2025-09-08', '2025-09-09', 'news');
INSERT INTO `sys_department` VALUES (17, '采访部', 0, '2025-09-08', '2025-09-16', 'caifang');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `params` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `status` int NOT NULL,
  `cost_time` double NULL DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `log_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `error_msg` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `traceback` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `user_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_log_user_id_4b944456_fk_sys_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `sys_log_user_id_4b944456_fk_sys_user_id` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1373 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (322, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 776.0131359100342, '2025-12-22 06:14:13.401366', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (323, '127.0.0.1', 'GET', '/user/get_user_info', '{}', 200, 36.0867977142334, '2025-12-22 06:14:13.446148', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (324, '127.0.0.1', 'POST', '/menu/', '', 201, 22.40610122680664, '2025-12-22 06:14:13.475702', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (325, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTg4MTk4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2MzgzMzk4fQ.2DC-OfqQux9qItwdGchiB7YiDaUHEimJ1cBrXi6wato\"}', 200, 36.13543510437012, '2025-12-22 06:17:01.685101', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (326, '127.0.0.1', 'GET', '/user', '{}', 200, 15.458822250366211, '2025-12-22 06:17:01.909800', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (327, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 22.452354431152344, '2025-12-22 06:17:01.913628', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (328, '127.0.0.1', 'GET', '/department', '{}', 200, 15.952825546264648, '2025-12-22 06:17:07.431564', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (329, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 18.918514251708984, '2025-12-22 06:17:07.433349', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (330, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 24.727582931518555, '2025-12-22 06:17:07.442203', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (331, '127.0.0.1', 'POST', '/user/logout', '{}', 200, 15.079259872436523, '2025-12-22 06:17:09.911528', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (332, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 769.0978050231934, '2025-12-22 06:17:11.738601', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (333, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 758.3291530609131, '2025-12-22 06:17:15.022908', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (334, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 796.673059463501, '2025-12-22 06:17:41.930229', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (335, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 776.5719890594482, '2025-12-22 06:19:16.259202', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (336, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTg5MTU2LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg0MzU2fQ.sNxtQYMF0dh32xPvQtDla_CIfTSmH5Dmp_3oEYgtjRc\"}', 200, 23.42963218688965, '2025-12-22 06:19:16.299248', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (337, '127.0.0.1', 'GET', '/department', '{}', 200, 12.622833251953125, '2025-12-22 06:19:22.411186', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (338, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 17.736196517944336, '2025-12-22 06:19:22.414117', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (339, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 33.045291900634766, '2025-12-22 06:19:22.435268', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (340, '127.0.0.1', 'POST', '/user/logout', '{}', 200, 5.208730697631836, '2025-12-22 06:20:06.572460', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (341, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 752.9244422912598, '2025-12-22 06:20:59.554176', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (342, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTg5MjU5LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg0NDU5fQ.PTTe-KWdQap-moAIIUYcjJypzw3QsT2HfPW0a7HQF0Q\"}', 200, 31.188249588012695, '2025-12-22 06:20:59.595926', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (343, '127.0.0.1', 'GET', '/user', '{}', 200, 29.059410095214844, '2025-12-22 06:21:10.721698', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (344, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 31.64076805114746, '2025-12-22 06:21:10.723012', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (345, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 12.959718704223633, '2025-12-22 06:21:15.500945', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (346, '127.0.0.1', 'GET', '/department', '{}', 200, 27.351856231689453, '2025-12-22 06:21:15.517131', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (347, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 27.916431427001953, '2025-12-22 06:21:15.518843', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (348, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 32.2575569152832, '2025-12-22 06:21:16.820022', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (349, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 15.512228012084961, '2025-12-22 06:21:17.827920', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (350, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 6.33692741394043, '2025-12-22 06:21:19.079621', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (351, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 16.50094985961914, '2025-12-22 06:21:21.373288', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (352, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 12.935876846313477, '2025-12-22 06:21:23.350881', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (353, '127.0.0.1', 'GET', '/department', '{}', 200, 15.058040618896484, '2025-12-22 06:21:23.351792', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (354, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 17.544984817504883, '2025-12-22 06:21:23.353279', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (355, '127.0.0.1', 'POST', '/user/logout', '{}', 200, 5.343914031982422, '2025-12-22 06:27:27.397164', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (356, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 771.2533473968506, '2025-12-22 06:27:31.109765', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (357, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTg5NjUxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg0ODUxfQ.Y1ZUMeqCi9Vj2PjwbF8aWYPHcphBfDrxs6a-uAP8CyQ\"}', 200, 8.334636688232422, '2025-12-22 06:27:31.130416', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (358, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 17.609834671020508, '2025-12-22 06:27:33.725152', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (359, '127.0.0.1', 'GET', '/department', '{}', 200, 14.912843704223633, '2025-12-22 06:27:33.726459', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (360, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 17.421960830688477, '2025-12-22 06:27:33.729393', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (361, '127.0.0.1', 'GET', '/user', '{}', 200, 24.218320846557617, '2025-12-22 06:27:35.675047', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (362, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 31.33702278137207, '2025-12-22 06:27:35.677192', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (363, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTg5NjUxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg0ODUxfQ.Y1ZUMeqCi9Vj2PjwbF8aWYPHcphBfDrxs6a-uAP8CyQ\"}', 200, 23.21910858154297, '2025-12-22 06:28:33.368990', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (364, '127.0.0.1', 'GET', '/user', '{}', 200, 16.8609619140625, '2025-12-22 06:28:33.558203', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (365, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 19.089698791503906, '2025-12-22 06:28:33.558966', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (366, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTg5NjUxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg0ODUxfQ.Y1ZUMeqCi9Vj2PjwbF8aWYPHcphBfDrxs6a-uAP8CyQ\"}', 200, 65.33670425415039, '2025-12-22 06:34:18.831731', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (367, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTg5NjUxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg0ODUxfQ.Y1ZUMeqCi9Vj2PjwbF8aWYPHcphBfDrxs6a-uAP8CyQ\"}', 200, 32.25207328796387, '2025-12-22 06:34:46.481254', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (368, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 14.904022216796875, '2025-12-22 06:34:49.084621', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (369, '127.0.0.1', 'GET', '/department', '{}', 200, 18.916606903076172, '2025-12-22 06:34:49.086528', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (370, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 26.54242515563965, '2025-12-22 06:34:49.093117', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (371, '127.0.0.1', 'GET', '/user', '{}', 200, 34.89851951599121, '2025-12-22 06:34:51.083377', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (372, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 45.70317268371582, '2025-12-22 06:34:51.093144', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (373, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 30.20954132080078, '2025-12-22 06:34:59.443007', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (374, '127.0.0.1', 'GET', '/department', '{}', 200, 17.55547523498535, '2025-12-22 06:35:04.053771', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (375, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 18.878698348999023, '2025-12-22 06:35:04.057862', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (376, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 23.86188507080078, '2025-12-22 06:35:04.058881', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (377, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 811.8221759796143, '2025-12-22 06:37:55.788732', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (378, '127.0.0.1', 'POST', '/menu/', '{\"name\": \"CSRF Test 2959\", \"path\": \"/csrf-test-2959\", \"component\": \"test/csrf\", \"menu_type\": \"C\", \"order_num\": 100}', 200, 0.3273487091064453, '2025-12-22 06:37:55.815460', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (379, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 762.5002861022949, '2025-12-22 06:38:10.233266', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (380, '127.0.0.1', 'POST', '/menu/', '{\"name\": \"CSRF Test 8086\", \"path\": \"/csrf-test-8086\", \"component\": \"test/csrf\", \"menu_type\": \"C\", \"order_num\": 100}', 200, 0.36072731018066406, '2025-12-22 06:38:10.257830', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (381, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 759.9763870239258, '2025-12-22 06:38:24.248817', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (382, '127.0.0.1', 'POST', '/menu/', '{\"name\": \"CSRF Test 5166\", \"path\": \"/csrf-test-5166\", \"component\": \"test/csrf\", \"menu_type\": \"C\", \"order_num\": 100}', 200, 0.3464221954345703, '2025-12-22 06:38:24.275884', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (383, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 803.1561374664307, '2025-12-22 06:39:09.350261', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (384, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 747.809648513794, '2025-12-22 06:39:24.240904', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (385, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 766.486644744873, '2025-12-22 06:39:49.433193', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (386, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 28.367280960083008, '2025-12-22 06:41:37.363005', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (387, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 32.453298568725586, '2025-12-22 06:41:38.935175', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (388, '127.0.0.1', 'POST', '/user/logout', '{}', 200, 15.66934585571289, '2025-12-22 06:41:40.294559', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (389, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 768.317699432373, '2025-12-22 06:41:42.153638', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (390, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTAyLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzAyfQ.G8OfLHqqiqCnl4AqEwZk7AgOQ2XUAyccgVjsvewKUwI\"}', 200, 21.22044563293457, '2025-12-22 06:41:42.187142', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (391, '127.0.0.1', 'POST', '/user/logout', '{}', 200, 4.917383193969727, '2025-12-22 06:41:45.859251', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (392, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"ylf\", \"password\": \"******\"}', 200, 749.6936321258545, '2025-12-22 06:41:50.646080', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (393, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJ1c2VybmFtZSI6InlsZiIsImV4cCI6MTc2Njk5MDUxMCwiZW1haWwiOiJ5bGY4NzkwOEAxMjYuY29tIiwib3JpZ19pYXQiOjE3NjYzODU3MTB9.tDEEDnhjpmh_E7LqoOIPDf994VZh6JTKfVMQ2OiBf9M\"}', 200, 8.518457412719727, '2025-12-22 06:41:50.664810', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (394, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 12.369155883789062, '2025-12-22 06:41:52.802165', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (395, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 10.652542114257812, '2025-12-22 06:41:52.803639', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (396, '127.0.0.1', 'GET', '/department', '{}', 200, 33.76269340515137, '2025-12-22 06:41:52.825165', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (397, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 18.644332885742188, '2025-12-22 06:41:53.918363', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (398, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 28.36775779724121, '2025-12-22 06:41:55.065732', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (399, '127.0.0.1', 'GET', '/department', '{}', 200, 13.309001922607422, '2025-12-22 06:41:56.887076', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (400, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 14.797687530517578, '2025-12-22 06:41:56.889860', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (401, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 19.77086067199707, '2025-12-22 06:41:56.892654', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (402, '127.0.0.1', 'POST', '/user/logout', '{}', 200, 3.513813018798828, '2025-12-22 06:41:58.979228', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (403, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 776.1034965515137, '2025-12-22 06:42:01.071474', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (404, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 21.137714385986328, '2025-12-22 06:42:01.102763', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (405, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 18.719196319580078, '2025-12-22 06:50:01.378462', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (406, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 13.432741165161133, '2025-12-22 06:50:04.622927', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (407, '127.0.0.1', 'GET', '/department', '{}', 200, 37.73212432861328, '2025-12-22 06:50:04.649355', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (408, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 37.34993934631348, '2025-12-22 06:50:04.651854', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (409, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 9.352445602416992, '2025-12-22 06:50:10.066860', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (410, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 38.88726234436035, '2025-12-22 06:50:12.081709', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (411, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 6.935596466064453, '2025-12-22 06:50:13.196580', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (412, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 20.755529403686523, '2025-12-22 06:50:17.579025', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (413, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 30.086994171142578, '2025-12-22 06:50:18.013441', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (414, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 10.398387908935547, '2025-12-22 06:50:19.471702', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (415, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 19.681930541992188, '2025-12-22 06:50:24.743316', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (416, '127.0.0.1', 'GET', '/department', '{}', 200, 15.04063606262207, '2025-12-22 06:50:27.026989', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (417, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 15.904426574707031, '2025-12-22 06:50:27.029099', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (418, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 19.76156234741211, '2025-12-22 06:50:27.030582', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (419, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 28.72943878173828, '2025-12-22 06:50:37.051172', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (420, '127.0.0.1', 'GET', '/user', '{}', 200, 27.298927307128906, '2025-12-22 06:50:38.220958', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (421, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 35.98499298095703, '2025-12-22 06:50:38.231005', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (422, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 13.56196403503418, '2025-12-22 06:52:09.220709', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (423, '127.0.0.1', 'GET', '/user', '{}', 200, 19.985198974609375, '2025-12-22 06:52:09.440005', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (424, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 28.978347778320312, '2025-12-22 06:52:09.447235', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (425, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 18.694400787353516, '2025-12-22 06:59:11.770396', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (426, '127.0.0.1', 'GET', '/user', '{}', 200, 17.59481430053711, '2025-12-22 06:59:11.993400', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (427, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 21.20494842529297, '2025-12-22 06:59:11.994993', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (428, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 6.937980651855469, '2025-12-22 06:59:13.506589', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (429, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 38.75374794006348, '2025-12-22 06:59:15.436553', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (430, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 39.426326751708984, '2025-12-22 06:59:17.284702', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (431, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 14.740705490112305, '2025-12-22 06:59:17.361780', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (432, '127.0.0.1', 'GET', '/user', '{}', 200, 28.313636779785156, '2025-12-22 06:59:17.377185', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (433, '127.0.0.1', 'GET', '/department', '{}', 200, 10.255813598632812, '2025-12-22 06:59:18.547855', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (434, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 11.080503463745117, '2025-12-22 06:59:18.552961', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (435, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 29.503583908081055, '2025-12-22 06:59:18.566076', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (436, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 25.585651397705078, '2025-12-22 06:59:20.610338', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (437, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 17.515182495117188, '2025-12-22 07:03:53.913640', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (438, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 11.401891708374023, '2025-12-22 07:03:54.071733', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (439, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 13.922691345214844, '2025-12-22 07:05:17.725325', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (440, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 17.435312271118164, '2025-12-22 07:05:17.887474', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (441, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 18.441438674926758, '2025-12-22 07:05:19.743302', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (442, '127.0.0.1', 'GET', '/user', '{}', 200, 21.689653396606445, '2025-12-22 07:05:21.554529', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (443, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 30.890226364135742, '2025-12-22 07:05:21.561017', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (444, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 11.244773864746094, '2025-12-22 07:06:25.202509', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (445, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 21.01588249206543, '2025-12-22 07:07:07.384885', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (446, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 6.740331649780273, '2025-12-22 07:07:07.527670', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (447, '127.0.0.1', 'PUT', '/menu/45/', '', 200, 30.061006546020508, '2025-12-22 07:07:26.971601', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (448, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 16.882658004760742, '2025-12-22 07:07:27.005549', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (449, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 17.455577850341797, '2025-12-22 07:07:31.219115', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (450, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 5.326747894287109, '2025-12-22 07:07:31.351536', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (451, '127.0.0.1', 'PUT', '/menu/45/', '', 200, 32.6235294342041, '2025-12-22 07:08:05.216364', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (452, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 36.96584701538086, '2025-12-22 07:08:05.266594', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (453, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 11.402606964111328, '2025-12-22 07:08:07.521522', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (454, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 6.9179534912109375, '2025-12-22 07:08:07.655745', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (455, '127.0.0.1', 'GET', '/user', '{}', 200, 29.757022857666016, '2025-12-22 07:08:10.383399', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (456, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 30.80129623413086, '2025-12-22 07:08:10.386893', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (457, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 7.613420486450195, '2025-12-22 07:08:15.730634', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (458, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 7.437467575073242, '2025-12-22 07:08:16.131882', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (459, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 14.597415924072266, '2025-12-22 07:08:16.212368', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (460, '127.0.0.1', 'GET', '/department', '{}', 200, 25.789260864257812, '2025-12-22 07:08:16.224772', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (461, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 36.879777908325195, '2025-12-22 07:08:16.237391', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (462, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 15.753984451293945, '2025-12-22 07:08:57.784589', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (463, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 15.166044235229492, '2025-12-22 07:08:57.974921', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (464, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 22.506237030029297, '2025-12-22 07:08:57.979158', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (465, '127.0.0.1', 'GET', '/department', '{}', 200, 24.808883666992188, '2025-12-22 07:08:57.982821', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (466, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 33.13922882080078, '2025-12-22 07:08:59.420745', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (467, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 12.433767318725586, '2025-12-22 07:10:13.278766', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (468, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 16.950607299804688, '2025-12-22 07:10:13.280391', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (469, '127.0.0.1', 'GET', '/department', '{}', 200, 16.477108001708984, '2025-12-22 07:10:13.281382', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (470, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 13.333320617675781, '2025-12-22 07:10:17.973502', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (471, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 37.19377517700195, '2025-12-22 07:10:20.391258', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (472, '127.0.0.1', 'GET', '/role/1/menus/', '{}', 200, 31.310558319091797, '2025-12-22 07:10:20.394054', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (473, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 19.04153823852539, '2025-12-22 07:13:29.789822', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (474, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 8.499383926391602, '2025-12-22 07:13:29.956640', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (475, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 29.881954193115234, '2025-12-22 07:13:31.661250', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (476, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 8.088350296020508, '2025-12-22 07:13:40.891542', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (477, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 15.25259017944336, '2025-12-22 07:13:41.599227', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (478, '127.0.0.1', 'GET', '/user', '{}', 200, 36.37433052062988, '2025-12-22 07:13:41.622307', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (479, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 15.964031219482422, '2025-12-22 07:15:17.746675', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (480, '127.0.0.1', 'GET', '/user', '{}', 200, 15.583992004394531, '2025-12-22 07:15:17.919379', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (481, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 18.962621688842773, '2025-12-22 07:15:17.921325', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (482, '127.0.0.1', 'GET', '/department', '{}', 200, 22.78900146484375, '2025-12-22 07:15:19.851907', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (483, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 26.499509811401367, '2025-12-22 07:15:19.857570', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (484, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 28.383493423461914, '2025-12-22 07:15:19.858400', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (485, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 24.512290954589844, '2025-12-22 07:15:20.565070', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (486, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 11.78741455078125, '2025-12-22 07:15:21.011122', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (487, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 8.079767227172852, '2025-12-22 07:15:21.750172', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (488, '127.0.0.1', 'GET', '/department', '{}', 200, 13.704538345336914, '2025-12-22 07:15:29.756892', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (489, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 16.15428924560547, '2025-12-22 07:15:29.757974', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (490, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 14.711141586303711, '2025-12-22 07:15:29.759295', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (491, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 59.98516082763672, '2025-12-22 07:18:02.051617', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (492, '127.0.0.1', 'GET', '/department', '{}', 200, 28.804540634155273, '2025-12-22 07:18:02.245278', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (493, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 36.16619110107422, '2025-12-22 07:18:02.249968', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (494, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 43.575286865234375, '2025-12-22 07:18:02.262252', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (495, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 30.95722198486328, '2025-12-22 07:18:04.222674', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (496, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 31.30507469177246, '2025-12-22 07:18:22.571011', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (497, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 7.451295852661133, '2025-12-22 07:18:22.721786', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (498, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 19.608497619628906, '2025-12-22 07:18:27.355791', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (499, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 36.019086837768555, '2025-12-22 07:18:28.197654', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (500, '127.0.0.1', 'GET', '/user', '{}', 200, 13.774871826171875, '2025-12-22 07:18:29.008420', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (501, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 44.72708702087402, '2025-12-22 07:18:29.043287', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (502, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 21.37136459350586, '2025-12-22 07:18:29.515381', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (503, '127.0.0.1', 'GET', '/department', '{}', 200, 13.298749923706055, '2025-12-22 07:18:30.569592', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (504, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 16.493558883666992, '2025-12-22 07:18:30.571920', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (505, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 20.99299430847168, '2025-12-22 07:18:30.579410', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (506, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 10.542154312133789, '2025-12-22 07:18:32.033125', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (507, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 20.659923553466797, '2025-12-22 07:18:32.917128', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (508, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 22.088050842285156, '2025-12-22 07:19:10.064544', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (509, '127.0.0.1', 'PUT', '/menu/4/', '', 200, 38.32721710205078, '2025-12-22 07:19:35.424041', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (510, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 25.452375411987305, '2025-12-22 07:19:35.462743', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (511, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 16.119956970214844, '2025-12-22 07:19:37.554851', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (512, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 5.428552627563477, '2025-12-22 07:19:37.706996', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (513, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 32.248497009277344, '2025-12-22 07:19:39.923578', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (514, '127.0.0.1', 'GET', '/department', '{}', 200, 33.67447853088379, '2025-12-22 07:19:39.927418', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (515, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 36.13543510437012, '2025-12-22 07:19:39.932207', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (516, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 27.68254280090332, '2025-12-22 07:19:40.615469', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (517, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 13.44919204711914, '2025-12-22 07:19:56.970436', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (518, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 14.965057373046875, '2025-12-22 07:19:57.123879', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (519, '127.0.0.1', 'GET', '/department', '{}', 200, 13.663291931152344, '2025-12-22 07:19:58.452899', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (520, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 17.704486846923828, '2025-12-22 07:19:58.455215', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (521, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 30.219554901123047, '2025-12-22 07:19:58.474888', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (522, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 7.278203964233398, '2025-12-22 07:19:59.455937', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (523, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 21.456241607666016, '2025-12-22 07:20:01.593400', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (524, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 12.660503387451172, '2025-12-22 07:20:02.539640', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (525, '127.0.0.1', 'GET', '/user', '{}', 200, 30.532121658325195, '2025-12-22 07:20:02.558610', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (526, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 13.194561004638672, '2025-12-22 07:20:06.138983', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (527, '127.0.0.1', 'GET', '/user', '{}', 200, 8.022069931030273, '2025-12-22 07:20:06.282999', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (528, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 46.94724082946777, '2025-12-22 07:20:06.321078', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (529, '127.0.0.1', 'GET', '/log', '{\"page\": \"2\", \"page_size\": \"5\"}', 200, 22.882461547851562, '2025-12-22 07:20:11.543991', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (530, '127.0.0.1', 'GET', '/log', '{\"page\": \"4\", \"page_size\": \"5\"}', 200, 32.83190727233887, '2025-12-22 07:20:12.361276', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (531, '127.0.0.1', 'GET', '/log', '{\"page\": \"6\", \"page_size\": \"5\"}', 200, 12.949228286743164, '2025-12-22 07:20:14.957625', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (532, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 18.918514251708984, '2025-12-22 07:22:07.398135', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (533, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 75.20771026611328, '2025-12-22 07:22:07.637887', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (534, '127.0.0.1', 'GET', '/user', '{}', 200, 78.56607437133789, '2025-12-22 07:22:07.642785', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (535, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 14.259576797485352, '2025-12-22 07:22:13.511495', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (536, '127.0.0.1', 'GET', '/user', '{}', 200, 20.302534103393555, '2025-12-22 07:22:13.756520', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (537, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 23.70142936706543, '2025-12-22 07:22:13.758432', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (538, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 15.681982040405273, '2025-12-22 07:22:21.110050', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (539, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 29.444456100463867, '2025-12-22 07:22:21.262361', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (540, '127.0.0.1', 'GET', '/user', '{}', 200, 29.566287994384766, '2025-12-22 07:22:21.263611', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (541, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 16.858339309692383, '2025-12-22 07:22:28.272350', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (542, '127.0.0.1', 'GET', '/user', '{}', 200, 15.576362609863281, '2025-12-22 07:22:28.597727', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (543, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 17.299652099609375, '2025-12-22 07:22:28.598628', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (544, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 30.979156494140625, '2025-12-22 07:27:16.979021', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (545, '127.0.0.1', 'GET', '/user', '{}', 200, 22.646188735961914, '2025-12-22 07:27:17.453434', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (546, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 25.286197662353516, '2025-12-22 07:27:17.454573', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (547, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 45.80855369567871, '2025-12-22 07:27:28.279664', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (548, '127.0.0.1', 'GET', '/user', '{}', 200, 18.052339553833008, '2025-12-22 07:27:28.748932', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (549, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 20.325899124145508, '2025-12-22 07:27:28.749965', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (550, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 15.437126159667969, '2025-12-22 07:27:38.041956', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (551, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 18.90087127685547, '2025-12-22 07:27:38.104294', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (552, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 20.34783363342285, '2025-12-22 07:27:38.680793', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (553, '127.0.0.1', 'GET', '/user', '{}', 200, 21.781444549560547, '2025-12-22 07:27:38.685682', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (554, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 38.262128829956055, '2025-12-22 07:28:13.001717', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (555, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 21.09360694885254, '2025-12-22 07:28:13.051512', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (556, '127.0.0.1', 'GET', '/user', '{}', 200, 13.791322708129883, '2025-12-22 07:28:13.445366', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (557, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 19.57416534423828, '2025-12-22 07:28:13.449844', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (558, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 9.873390197753906, '2025-12-22 07:28:33.102191', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (559, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 20.981788635253906, '2025-12-22 07:28:33.170502', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (560, '127.0.0.1', 'GET', '/user', '{}', 200, 14.212608337402344, '2025-12-22 07:28:33.549149', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (561, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 17.337560653686523, '2025-12-22 07:28:33.551312', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (562, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkwNTIxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg1NzIxfQ.OjY7X1GbwM9NVHawxqV2TYcq6Sx__s1Z655BThX4Aw8\"}', 200, 35.775184631347656, '2025-12-22 07:28:49.006111', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (563, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 23.702144622802734, '2025-12-22 07:28:49.038269', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (564, '127.0.0.1', 'GET', '/user', '{}', 200, 31.732797622680664, '2025-12-22 07:28:49.260901', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (565, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 36.67616844177246, '2025-12-22 07:28:49.262222', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (566, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 20.15852928161621, '2025-12-22 07:28:51.244955', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (567, '127.0.0.1', 'GET', '/department', '{}', 200, 27.681350708007812, '2025-12-22 07:28:51.250315', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (568, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 30.85613250732422, '2025-12-22 07:28:51.252558', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (569, '127.0.0.1', 'PATCH', '/user/2', '', 200, 788.5911464691162, '2025-12-22 07:29:26.433902', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (570, '127.0.0.1', 'POST', '/user/logout', '{}', 200, 4.912137985229492, '2025-12-22 07:29:31.317749', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (571, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 780.0490856170654, '2025-12-22 07:29:34.070803', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (572, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 810.5185031890869, '2025-12-22 07:29:38.596414', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (573, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 14.340639114379883, '2025-12-22 07:29:38.627327', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (574, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 27.968645095825195, '2025-12-22 07:29:38.664814', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (575, '127.0.0.1', 'PATCH', '/user/2', '', 200, 772.1009254455566, '2025-12-22 07:29:52.396246', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (576, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 13.305187225341797, '2025-12-22 07:29:54.531278', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (577, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 7.487058639526367, '2025-12-22 07:29:54.547445', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (578, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 33.35237503051758, '2025-12-22 07:31:49.904109', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (579, '127.0.0.1', 'GET', '/department', '{}', 200, 36.69595718383789, '2025-12-22 07:31:49.905796', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (580, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 43.256521224975586, '2025-12-22 07:31:49.909811', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (581, '127.0.0.1', 'GET', '/user', '{}', 200, 21.27361297607422, '2025-12-22 07:31:53.403918', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (582, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 38.71941566467285, '2025-12-22 07:31:53.420380', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (583, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 23.928403854370117, '2025-12-22 07:31:56.262800', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (584, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 18.8601016998291, '2025-12-22 07:31:57.545584', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (585, '127.0.0.1', 'GET', '/department', '{}', 200, 23.140430450439453, '2025-12-22 07:31:58.675141', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (586, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 25.736570358276367, '2025-12-22 07:31:58.678672', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (587, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 30.00926971435547, '2025-12-22 07:31:58.681067', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (588, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 18.477201461791992, '2025-12-22 07:31:59.702524', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (589, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 28.99169921875, '2025-12-22 07:32:01.819282', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (590, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 34.026145935058594, '2025-12-22 07:32:03.657251', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (591, '127.0.0.1', 'GET', '/department', '{}', 200, 36.52477264404297, '2025-12-22 07:32:03.658537', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (592, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 47.718048095703125, '2025-12-22 07:32:03.668524', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (593, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 37.84823417663574, '2025-12-22 07:32:55.463194', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (594, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 29.978275299072266, '2025-12-22 07:32:55.501899', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (595, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 16.8607234954834, '2025-12-22 07:32:55.689174', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (596, '127.0.0.1', 'GET', '/department', '{}', 200, 32.12618827819824, '2025-12-22 07:32:55.706132', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (597, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 28.33843231201172, '2025-12-22 07:32:55.708494', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (598, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 25.46834945678711, '2025-12-22 07:33:19.440774', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (599, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 9.257078170776367, '2025-12-22 07:33:19.480129', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (600, '127.0.0.1', 'GET', '/department', '{}', 200, 14.721870422363281, '2025-12-22 07:33:19.644656', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (601, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 19.114971160888672, '2025-12-22 07:33:19.648036', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (602, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 18.584728240966797, '2025-12-22 07:33:19.649744', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (603, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 11.165618896484375, '2025-12-22 07:33:25.933003', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (604, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 42.68908500671387, '2025-12-22 07:33:26.866585', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (605, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 29.539108276367188, '2025-12-22 07:33:27.696105', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (606, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 19.571304321289062, '2025-12-22 07:33:28.032853', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (607, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 29.610157012939453, '2025-12-22 07:33:29.280684', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (608, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 22.940397262573242, '2025-12-22 07:33:30.084393', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (609, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 28.379440307617188, '2025-12-22 07:33:30.596098', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (610, '127.0.0.1', 'GET', '/department', '{}', 200, 29.45709228515625, '2025-12-22 07:33:31.388278', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (611, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 33.67328643798828, '2025-12-22 07:33:31.391192', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (612, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 35.047054290771484, '2025-12-22 07:33:31.394803', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (613, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 12.95161247253418, '2025-12-22 07:34:12.311334', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (614, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 25.49266815185547, '2025-12-22 07:34:12.350854', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (615, '127.0.0.1', 'GET', '/department', '{}', 200, 10.583877563476562, '2025-12-22 07:34:12.514580', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (616, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 10.811328887939453, '2025-12-22 07:34:12.517086', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (617, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 27.602672576904297, '2025-12-22 07:34:12.529001', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (618, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 8.121967315673828, '2025-12-22 07:34:18.322247', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (619, '127.0.0.1', 'GET', '/department', '{}', 200, 23.98228645324707, '2025-12-22 07:34:18.335916', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (620, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 30.17425537109375, '2025-12-22 07:34:18.340998', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (621, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 31.447410583496094, '2025-12-22 07:36:43.624741', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (622, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 21.366119384765625, '2025-12-22 07:36:43.653922', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (623, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 18.265247344970703, '2025-12-22 07:36:43.823040', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (624, '127.0.0.1', 'GET', '/department', '{}', 200, 19.504308700561523, '2025-12-22 07:36:43.825691', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (625, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 17.084360122680664, '2025-12-22 07:36:43.827207', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (626, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 11.142253875732422, '2025-12-22 07:36:49.415847', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (627, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 26.930570602416992, '2025-12-22 07:36:51.249883', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (628, '127.0.0.1', 'GET', '/user', '{}', 200, 41.848182678222656, '2025-12-22 07:36:51.272973', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (629, '127.0.0.1', 'GET', '/department', '{}', 200, 12.312889099121094, '2025-12-22 07:36:52.352913', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (630, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 19.632339477539062, '2025-12-22 07:36:52.359178', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (631, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 124.33171272277832, '2025-12-22 07:36:52.467090', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (632, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 16.283750534057617, '2025-12-22 07:37:33.099171', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (633, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 10.329961776733398, '2025-12-22 07:37:33.121790', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (634, '127.0.0.1', 'GET', '/department', '{}', 200, 13.181924819946289, '2025-12-22 07:37:33.288770', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (635, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 15.801191329956055, '2025-12-22 07:37:33.290445', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (636, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 26.04055404663086, '2025-12-22 07:37:33.302969', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (637, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 21.440744400024414, '2025-12-22 07:45:02.369829', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (638, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 10.680198669433594, '2025-12-22 07:45:02.390882', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (639, '127.0.0.1', 'GET', '/department', '{}', 200, 13.432502746582031, '2025-12-22 07:45:02.610545', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (640, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 17.388105392456055, '2025-12-22 07:45:02.613403', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (641, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 25.12335777282715, '2025-12-22 07:45:02.624418', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (642, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 16.524076461791992, '2025-12-22 07:46:58.615017', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (643, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 13.05842399597168, '2025-12-22 07:46:58.941668', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (644, '127.0.0.1', 'GET', '/department', '{}', 200, 14.338970184326172, '2025-12-22 07:46:59.398837', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (645, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 17.255783081054688, '2025-12-22 07:46:59.400987', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (646, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 16.779184341430664, '2025-12-22 07:46:59.402348', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (647, '127.0.0.1', 'POST', '/upload/', '{}', 404, 61.88344955444336, '2025-12-22 07:49:35.292056', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (648, '127.0.0.1', 'POST', '/upload/', '{}', 200, 18.63718032836914, '2025-12-22 07:55:42.265571', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (649, '127.0.0.1', 'POST', '/upload/', '{}', 200, 1.8222332000732422, '2025-12-22 07:55:59.663671', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (650, '127.0.0.1', 'POST', '/upload/', '{}', 200, 27.203083038330078, '2025-12-22 07:56:12.784042', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (651, '127.0.0.1', 'POST', '/upload/', '{}', 200, 3.6039352416992188, '2025-12-22 07:58:30.293662', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (652, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 57.33895301818848, '2025-12-22 08:00:01.958424', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (653, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 26.816606521606445, '2025-12-22 08:00:02.000333', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (654, '127.0.0.1', 'GET', '/department', '{}', 200, 22.583484649658203, '2025-12-22 08:00:02.330907', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (655, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 23.996829986572266, '2025-12-22 08:00:02.334255', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (656, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 30.037403106689453, '2025-12-22 08:00:02.338605', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (657, '127.0.0.1', 'POST', '/upload/', '{}', 200, 43.58720779418945, '2025-12-22 08:00:58.758198', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (658, '127.0.0.1', 'PATCH', '/user/2', '', 200, 806.37526512146, '2025-12-22 08:01:13.118974', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (659, '127.0.0.1', 'POST', '/upload/', '{}', 200, 19.654035568237305, '2025-12-22 08:02:26.619454', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (660, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 49.143314361572266, '2025-12-22 08:02:40.453015', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (661, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 21.216630935668945, '2025-12-22 08:02:40.496144', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (662, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 17.258882522583008, '2025-12-22 08:02:40.796100', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (663, '127.0.0.1', 'GET', '/department', '{}', 200, 32.469749450683594, '2025-12-22 08:02:40.808930', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (664, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 37.52470016479492, '2025-12-22 08:02:40.810106', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (665, '127.0.0.1', 'POST', '/upload/', '{}', 200, 19.57869529724121, '2025-12-22 08:03:49.412649', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (666, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 25.787353515625, '2025-12-22 08:04:11.895819', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (667, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 27.18043327331543, '2025-12-22 08:04:11.932969', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (668, '127.0.0.1', 'GET', '/department', '{}', 200, 17.33231544494629, '2025-12-22 08:04:12.133724', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (669, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 16.60323143005371, '2025-12-22 08:04:12.140191', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (670, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 35.98499298095703, '2025-12-22 08:04:12.150714', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (671, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 9.510040283203125, '2025-12-22 08:04:48.920731', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (672, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 9.702205657958984, '2025-12-22 08:04:54.438696', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (673, '127.0.0.1', 'POST', '/upload/', '{}', 200, 3.3121109008789062, '2025-12-22 08:06:47.795399', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (674, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 96.0702896118164, '2025-12-22 08:07:29.467346', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (675, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 32.96637535095215, '2025-12-22 08:07:29.509304', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (676, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 12.300968170166016, '2025-12-22 08:07:30.010697', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (677, '127.0.0.1', 'POST', '/upload/', '{}', 200, 21.427631378173828, '2025-12-22 08:07:48.353808', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (678, '127.0.0.1', 'POST', '/upload/', '{}', 200, 4.700183868408203, '2025-12-22 08:08:01.284242', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (679, '127.0.0.1', 'POST', '/upload/', '{}', 200, 4.847288131713867, '2025-12-22 08:09:59.059038', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (680, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 78.78923416137695, '2025-12-22 08:10:10.436622', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (681, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 15.639543533325195, '2025-12-22 08:10:10.478092', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (682, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 73.14562797546387, '2025-12-22 08:10:10.923291', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (683, '127.0.0.1', 'POST', '/upload/', '{}', 200, 10.763883590698242, '2025-12-22 08:10:16.510326', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (684, '127.0.0.1', 'PATCH', '/user/2', '', 200, 775.5370140075684, '2025-12-22 08:10:23.782835', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (685, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 30.33614158630371, '2025-12-22 08:10:28.525393', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (686, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 23.32925796508789, '2025-12-22 08:10:28.557884', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (687, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 32.54199028015137, '2025-12-22 08:10:28.770682', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (688, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 7.582664489746094, '2025-12-22 08:11:23.325364', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (689, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 12.34889030456543, '2025-12-22 08:11:25.412230', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (690, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 7.509469985961914, '2025-12-22 08:11:29.006036', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (691, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 10.580062866210938, '2025-12-22 08:11:29.892335', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (692, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 14.21976089477539, '2025-12-22 08:11:29.893267', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (693, '127.0.0.1', 'GET', '/department', '{}', 200, 21.623849868774414, '2025-12-22 08:11:29.901909', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (694, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 24.904966354370117, '2025-12-22 08:13:03.670462', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (695, '127.0.0.1', 'GET', '/department', '{}', 200, 18.596172332763672, '2025-12-22 08:13:03.681551', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (696, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 71.3658332824707, '2025-12-22 08:13:03.738068', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (697, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 19.308805465698242, '2025-12-22 08:13:05.737600', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (698, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 8.850574493408203, '2025-12-22 08:13:05.755281', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (699, '127.0.0.1', 'GET', '/department', '{}', 200, 21.218538284301758, '2025-12-22 08:13:05.965913', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (700, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 29.939889907836914, '2025-12-22 08:13:05.973002', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (701, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 34.319162368774414, '2025-12-22 08:13:05.980659', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (702, '127.0.0.1', 'POST', '/upload/', '{}', 200, 10.431528091430664, '2025-12-22 08:13:12.020768', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (703, '127.0.0.1', 'POST', '/upload/', '{}', 200, 32.24658966064453, '2025-12-22 08:14:07.427939', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (704, '127.0.0.1', 'PATCH', '/user/2', '', 200, 754.0316581726074, '2025-12-22 08:14:14.999215', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (705, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 34.15322303771973, '2025-12-22 08:14:17.782434', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (706, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 29.5257568359375, '2025-12-22 08:14:17.826771', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (707, '127.0.0.1', 'GET', '/department', '{}', 200, 12.911081314086914, '2025-12-22 08:14:17.996165', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (708, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 15.493154525756836, '2025-12-22 08:14:17.997847', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (709, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 29.92415428161621, '2025-12-22 08:14:18.014915', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (710, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 36.16189956665039, '2025-12-22 08:17:26.516632', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (711, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 8.605003356933594, '2025-12-22 08:17:26.533358', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (712, '127.0.0.1', 'GET', '/department', '{}', 200, 16.71004295349121, '2025-12-22 08:17:26.727503', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (713, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 20.965576171875, '2025-12-22 08:17:26.730462', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (714, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 23.928165435791016, '2025-12-22 08:17:26.737129', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (715, '127.0.0.1', 'POST', '/upload/', '{}', 200, 7.279634475708008, '2025-12-22 08:17:32.776104', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (716, '127.0.0.1', 'PATCH', '/user/2', '', 200, 34.30628776550293, '2025-12-22 08:17:34.304077', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (717, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 13.060569763183594, '2025-12-22 08:17:36.885728', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (718, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 8.969545364379883, '2025-12-22 08:17:36.906384', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (719, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 8.584260940551758, '2025-12-22 08:17:37.069211', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (720, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 24.734973907470703, '2025-12-22 08:17:37.082737', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (721, '127.0.0.1', 'GET', '/department', '{}', 200, 29.4191837310791, '2025-12-22 08:17:37.088948', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (722, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 20.44820785522461, '2025-12-22 08:20:58.200778', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (723, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 7.442235946655273, '2025-12-22 08:20:58.216781', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (724, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 23.628711700439453, '2025-12-22 08:20:58.423366', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (725, '127.0.0.1', 'GET', '/department', '{}', 200, 33.15258026123047, '2025-12-22 08:20:58.428993', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (726, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 38.22469711303711, '2025-12-22 08:20:58.430904', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (727, '127.0.0.1', 'POST', '/upload/', '{}', 200, 3.398418426513672, '2025-12-22 08:22:37.708267', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (728, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 35.2935791015625, '2025-12-22 08:23:03.237175', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (729, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 7.56382942199707, '2025-12-22 08:23:03.253076', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (730, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 18.327713012695312, '2025-12-22 08:23:03.426194', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (731, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 22.57084846496582, '2025-12-22 08:23:03.424703', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (732, '127.0.0.1', 'GET', '/department', '{}', 200, 25.64096450805664, '2025-12-22 08:23:03.438924', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (733, '127.0.0.1', 'POST', '/upload/', '{}', 200, 9.118318557739258, '2025-12-22 08:23:21.306818', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (734, '127.0.0.1', 'PATCH', '/user/2', '', 200, 758.7077617645264, '2025-12-22 08:23:27.709044', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (735, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 16.60752296447754, '2025-12-22 08:24:03.370726', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (736, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 30.579805374145508, '2025-12-22 08:24:03.408961', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (737, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 15.248298645019531, '2025-12-22 08:24:03.582219', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (738, '127.0.0.1', 'GET', '/department', '{}', 200, 14.188766479492188, '2025-12-22 08:24:03.592726', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (739, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 26.491641998291016, '2025-12-22 08:24:03.622033', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (740, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 12.160778045654297, '2025-12-22 08:24:32.370503', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (741, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 15.961885452270508, '2025-12-22 08:24:32.444394', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (742, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 20.223140716552734, '2025-12-22 08:24:32.757999', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (743, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 18.57161521911621, '2025-12-22 08:24:32.759111', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (744, '127.0.0.1', 'GET', '/department', '{}', 200, 21.55447006225586, '2025-12-22 08:24:32.760593', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (745, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 13.71908187866211, '2025-12-22 08:24:41.092375', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (746, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 30.199289321899414, '2025-12-22 08:24:42.249500', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (747, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 11.963844299316406, '2025-12-22 08:24:43.268285', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (748, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 24.431467056274414, '2025-12-22 08:24:46.078739', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (749, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 14.652490615844727, '2025-12-22 08:24:54.963589', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (750, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 11.704444885253906, '2025-12-22 08:24:54.965219', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (751, '127.0.0.1', 'GET', '/department', '{}', 200, 34.813880920410156, '2025-12-22 08:24:54.985464', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (752, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 32.7603816986084, '2025-12-22 08:25:39.438711', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (753, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 27.118444442749023, '2025-12-22 08:25:39.473691', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (754, '127.0.0.1', 'GET', '/department', '{}', 200, 15.896320343017578, '2025-12-22 08:25:39.665303', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (755, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 18.929243087768555, '2025-12-22 08:25:39.666146', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (756, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 38.863182067871094, '2025-12-22 08:25:39.691975', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (757, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 70.14870643615723, '2025-12-22 08:30:53.584153', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (758, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 49.12924766540527, '2025-12-22 08:30:53.644514', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (759, '127.0.0.1', 'GET', '/department', '{}', 200, 18.215417861938477, '2025-12-22 08:30:53.855106', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (760, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 20.824193954467773, '2025-12-22 08:30:53.864014', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (761, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 42.565345764160156, '2025-12-22 08:30:53.889010', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (762, '127.0.0.1', 'POST', '/upload/', '{}', 200, 33.5993766784668, '2025-12-22 08:30:59.229112', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (763, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 29.338359832763672, '2025-12-22 08:55:13.200531', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (764, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 60.5926513671875, '2025-12-22 08:55:13.270729', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (765, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 12.775659561157227, '2025-12-22 08:55:13.471776', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (766, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 20.122766494750977, '2025-12-22 08:55:13.473954', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (767, '127.0.0.1', 'GET', '/department', '{}', 200, 34.271955490112305, '2025-12-22 08:55:13.490335', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (768, '127.0.0.1', 'POST', '/upload/', '{}', 200, 39.87836837768555, '2025-12-22 08:55:25.021093', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (769, '127.0.0.1', 'PATCH', '/user/2', '', 200, 818.4397220611572, '2025-12-22 08:55:29.729582', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (770, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 25.913000106811523, '2025-12-22 08:55:32.233273', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (771, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 10.712862014770508, '2025-12-22 08:55:32.251660', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (772, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 13.353109359741211, '2025-12-22 08:55:32.416621', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (773, '127.0.0.1', 'GET', '/department', '{}', 200, 16.04008674621582, '2025-12-22 08:55:32.418192', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (774, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 18.44024658203125, '2025-12-22 08:55:32.419674', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (775, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 53.72929573059082, '2025-12-22 09:22:54.727838', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (776, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 43.0445671081543, '2025-12-22 09:22:54.783997', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (777, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 23.826122283935547, '2025-12-22 09:22:54.998396', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (778, '127.0.0.1', 'GET', '/department', '{}', 200, 23.785114288330078, '2025-12-22 09:22:55.001243', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (779, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 49.82328414916992, '2025-12-22 09:22:55.030755', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (780, '127.0.0.1', 'GET', '/log/', '{\"log_type\": \"ERROR\"}', 200, 17.133235931396484, '2025-12-22 09:23:06.470460', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (781, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 102.39219665527344, '2025-12-24 07:38:06.635358', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (782, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 22.99642562866211, '2025-12-24 07:38:06.685494', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (783, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 14.395475387573242, '2025-12-24 07:38:13.950779', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (784, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 22.4764347076416, '2025-12-24 07:38:13.963640', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (785, '127.0.0.1', 'GET', '/department', '{}', 200, 28.28812599182129, '2025-12-24 07:38:13.968487', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (786, '127.0.0.1', 'PUT', '/user/2', '', 400, 75.18839836120605, '2025-12-24 07:38:31.097940', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (787, '127.0.0.1', 'POST', '/upload/', '{}', 200, 47.689199447631836, '2025-12-24 07:38:53.325895', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (788, '127.0.0.1', 'PUT', '/user/2', '', 400, 35.78042984008789, '2025-12-24 07:39:00.498139', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (789, '127.0.0.1', 'POST', '/upload/', '{}', 200, 11.90638542175293, '2025-12-24 07:42:18.612576', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (790, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY2OTkzMzc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2Mzg4NTc4fQ.2O4J2PhWIG1p79bK_cQiUOPb3LbJVJyVvm4tRwxu7SE\"}', 200, 9.588479995727539, '2025-12-24 07:42:25.873515', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (791, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 15.628576278686523, '2025-12-24 07:42:25.950579', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (792, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 26.25727653503418, '2025-12-24 07:42:26.248836', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (793, '127.0.0.1', 'GET', '/department', '{}', 200, 25.469303131103516, '2025-12-24 07:42:26.251881', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (794, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 55.94801902770996, '2025-12-24 07:42:26.283972', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (795, '127.0.0.1', 'POST', '/upload/', '{}', 200, 30.747652053833008, '2025-12-24 07:42:33.237158', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (796, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 846.2502956390381, '2025-12-24 08:52:48.020012', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (797, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 772.2766399383545, '2025-12-24 08:52:57.616538', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (798, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 756.4547061920166, '2025-12-24 08:53:12.491105', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (799, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 759.9079608917236, '2025-12-24 08:53:14.739549', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (800, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 785.3281497955322, '2025-12-24 08:53:37.230111', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (801, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 788.2425785064697, '2025-12-24 08:54:47.689734', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (802, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 25.853395462036133, '2025-12-24 08:54:47.742185', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (803, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 10.158300399780273, '2025-12-24 08:54:47.761401', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (804, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 15.23280143737793, '2025-12-24 08:54:53.152621', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (805, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 29.919862747192383, '2025-12-24 08:54:53.191345', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (806, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 15.423774719238281, '2025-12-24 08:54:56.034912', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (807, '127.0.0.1', 'GET', '/department', '{}', 200, 15.424966812133789, '2025-12-24 08:54:56.036465', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (808, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 24.026870727539062, '2025-12-24 08:54:56.046697', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (809, '127.0.0.1', 'POST', '/upload/', '{}', 200, 36.99374198913574, '2025-12-24 08:55:00.700881', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (810, '127.0.0.1', 'POST', '/upload/', '{}', 200, 10.636091232299805, '2025-12-24 08:55:09.996161', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (811, '127.0.0.1', 'POST', '/upload/', '{}', 200, 6.525278091430664, '2025-12-24 08:58:10.147541', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (812, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 14.217853546142578, '2025-12-24 08:58:30.387235', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (813, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 26.685237884521484, '2025-12-24 08:58:30.461670', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (814, '127.0.0.1', 'GET', '/department', '{}', 200, 23.717164993286133, '2025-12-24 08:58:30.754220', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (815, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 30.755996704101562, '2025-12-24 08:58:30.758353', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (816, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 38.22779655456543, '2025-12-24 08:58:30.770906', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (817, '127.0.0.1', 'POST', '/upload/', '{}', 200, 33.59532356262207, '2025-12-24 08:58:35.197487', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (818, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 58.3803653717041, '2025-12-24 08:59:23.411897', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (819, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 9.671211242675781, '2025-12-24 08:59:23.446714', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (820, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 24.774551391601562, '2025-12-24 08:59:23.771385', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (821, '127.0.0.1', 'GET', '/department', '{}', 200, 26.319265365600586, '2025-12-24 08:59:23.774238', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (822, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 98.43707084655762, '2025-12-24 08:59:23.851249', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (823, '127.0.0.1', 'POST', '/upload/', '{}', 200, 12.820005416870117, '2025-12-24 08:59:28.423645', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (824, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 48.59495162963867, '2025-12-24 09:03:12.967740', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (825, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 10.319232940673828, '2025-12-24 09:03:13.038816', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (826, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 23.167133331298828, '2025-12-24 09:03:13.330983', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (827, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 28.410673141479492, '2025-12-24 09:03:13.333364', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (828, '127.0.0.1', 'GET', '/department', '{}', 200, 23.680925369262695, '2025-12-24 09:03:13.335355', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (829, '127.0.0.1', 'POST', '/upload/', '{}', 200, 5.799531936645508, '2025-12-24 09:03:19.332521', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (830, '127.0.0.1', 'POST', '/upload/', '{}', 200, 70.28722763061523, '2025-12-24 09:13:52.297954', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (831, '127.0.0.1', 'POST', '/upload/', '{}', 200, 5.860805511474609, '2025-12-24 09:15:56.519645', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (832, '127.0.0.1', 'PUT', '/user/3', '', 400, 73.12917709350586, '2025-12-24 09:16:07.818204', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (833, '127.0.0.1', 'PUT', '/user/3', '', 400, 33.02764892578125, '2025-12-24 09:17:45.489335', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (834, '127.0.0.1', 'PUT', '/user/3', '', 400, 25.893449783325195, '2025-12-24 09:17:56.578663', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (835, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 17.46058464050293, '2025-12-24 09:18:43.715346', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (836, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 25.995254516601562, '2025-12-24 09:18:43.811699', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (837, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 12.58540153503418, '2025-12-24 09:18:44.004826', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (838, '127.0.0.1', 'GET', '/department', '{}', 200, 16.261816024780273, '2025-12-24 09:18:44.006889', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (839, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 17.873048782348633, '2025-12-24 09:18:44.007399', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (840, '127.0.0.1', 'POST', '/upload/', '{}', 200, 8.181333541870117, '2025-12-24 09:22:59.223124', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (841, '127.0.0.1', 'PUT', '/user/3', '', 200, 787.6408100128174, '2025-12-24 09:23:17.724186', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (842, '127.0.0.1', 'PATCH', '/user/3', '', 200, 40.79484939575195, '2025-12-24 09:23:17.773551', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (843, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 32.289981842041016, '2025-12-24 09:23:17.841649', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (844, '127.0.0.1', 'POST', '/upload/', '{}', 200, 6.848573684692383, '2025-12-24 09:23:55.442819', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (845, '127.0.0.1', 'PUT', '/user/3', '', 200, 791.1419868469238, '2025-12-24 09:24:01.207478', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (846, '127.0.0.1', 'PATCH', '/user/3', '', 200, 15.941381454467773, '2025-12-24 09:24:01.231772', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (847, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 40.490150451660156, '2025-12-24 09:24:01.312479', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (848, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 60.706377029418945, '2025-12-25 00:56:06.884558', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (849, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 15.016555786132812, '2025-12-25 00:56:06.925274', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (850, '127.0.0.1', 'GET', '/department', '{}', 200, 18.81241798400879, '2025-12-25 00:56:11.175276', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (851, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 25.544404983520508, '2025-12-25 00:56:11.180278', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (852, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 20.646333694458008, '2025-12-25 00:56:11.181505', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (853, '127.0.0.1', 'POST', '/upload/', '{}', 200, 21.75283432006836, '2025-12-25 00:56:27.227500', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (854, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 14.751434326171875, '2025-12-25 00:59:55.929333', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (855, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 20.24364471435547, '2025-12-25 00:59:55.991332', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (856, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 18.518924713134766, '2025-12-25 00:59:56.307901', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (857, '127.0.0.1', 'GET', '/department', '{}', 200, 28.921127319335938, '2025-12-25 00:59:56.316373', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (858, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 36.84878349304199, '2025-12-25 00:59:56.320499', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (859, '127.0.0.1', 'POST', '/upload/', '{}', 200, 30.15732765197754, '2025-12-25 01:00:17.492160', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (860, '127.0.0.1', 'POST', '/upload/', '{}', 200, 8.57234001159668, '2025-12-25 01:07:52.429814', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (861, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 48.697710037231445, '2025-12-25 01:08:15.464822', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (862, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 23.606300354003906, '2025-12-25 01:08:15.498224', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (863, '127.0.0.1', 'GET', '/department', '{}', 200, 13.828754425048828, '2025-12-25 01:08:15.697482', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (864, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 18.477916717529297, '2025-12-25 01:08:15.700372', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (865, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 30.176639556884766, '2025-12-25 01:08:15.715708', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (866, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 10.715961456298828, '2025-12-25 01:08:52.367823', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (867, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 9.747505187988281, '2025-12-25 01:08:52.482122', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (868, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 15.38228988647461, '2025-12-25 01:08:52.787144', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (869, '127.0.0.1', 'GET', '/department', '{}', 200, 17.972230911254883, '2025-12-25 01:08:52.793248', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (870, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 14.925718307495117, '2025-12-25 01:08:52.794786', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (871, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 14.441490173339844, '2025-12-25 01:10:06.745512', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (872, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 7.643699645996094, '2025-12-25 01:10:06.761793', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (873, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 9.229660034179688, '2025-12-25 01:10:06.919092', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (874, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 14.605998992919922, '2025-12-25 01:10:06.922963', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (875, '127.0.0.1', 'GET', '/department', '{}', 200, 29.38556671142578, '2025-12-25 01:10:06.938531', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (876, '127.0.0.1', 'POST', '/upload/', '{}', 200, 8.303403854370117, '2025-12-25 01:10:11.029918', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (877, '127.0.0.1', 'POST', '/upload/', '{}', 200, 8.898019790649414, '2025-12-25 01:10:18.002602', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (878, '127.0.0.1', 'PUT', '/user/2', '', 400, 54.26287651062012, '2025-12-25 01:10:38.053505', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (879, '127.0.0.1', 'PUT', '/user/2', '', 200, 781.9473743438721, '2025-12-25 01:10:56.021911', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (880, '127.0.0.1', 'PATCH', '/user/2', '', 200, 35.10260581970215, '2025-12-25 01:10:56.063675', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (881, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 11.222124099731445, '2025-12-25 01:10:56.115525', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (882, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 48.2332706451416, '2025-12-25 01:24:11.343352', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (883, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 13.399124145507812, '2025-12-25 01:24:11.369047', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (884, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 29.096603393554688, '2025-12-25 01:24:11.735490', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (885, '127.0.0.1', 'GET', '/department', '{}', 200, 31.98409080505371, '2025-12-25 01:24:11.744303', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (886, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 60.11843681335449, '2025-12-25 01:24:11.787600', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (887, '127.0.0.1', 'POST', '/upload/', '{}', 200, 18.77117156982422, '2025-12-25 01:24:34.387471', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (888, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 43.78485679626465, '2025-12-25 01:27:58.889410', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (889, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 11.176586151123047, '2025-12-25 01:27:58.944783', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (890, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 19.685745239257812, '2025-12-25 01:27:59.230654', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (891, '127.0.0.1', 'GET', '/department', '{}', 200, 19.896984100341797, '2025-12-25 01:27:59.232261', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (892, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 19.419431686401367, '2025-12-25 01:27:59.234261', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (893, '127.0.0.1', 'POST', '/upload/', '{}', 200, 37.05191612243652, '2025-12-25 01:28:18.299271', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (894, '127.0.0.1', 'POST', '/upload/', '{}', 200, 5.09953498840332, '2025-12-25 01:29:56.772791', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (895, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 11.970758438110352, '2025-12-25 01:33:06.375473', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (896, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 33.70308876037598, '2025-12-25 01:33:06.458250', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (897, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 14.243125915527344, '2025-12-25 01:33:06.804575', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (898, '127.0.0.1', 'GET', '/department', '{}', 200, 14.481544494628906, '2025-12-25 01:33:06.923483', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (899, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 14.73546028137207, '2025-12-25 01:33:06.925526', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (900, '127.0.0.1', 'POST', '/upload/', '{}', 200, 14.974355697631836, '2025-12-25 01:33:10.959074', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (901, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 27.510881423950195, '2025-12-25 01:35:18.795863', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (902, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 19.702434539794922, '2025-12-25 01:35:18.862109', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (903, '127.0.0.1', 'GET', '/department', '{}', 200, 27.022600173950195, '2025-12-25 01:35:19.144990', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (904, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 27.217626571655273, '2025-12-25 01:35:19.147266', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (905, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 39.070844650268555, '2025-12-25 01:35:19.154410', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (906, '127.0.0.1', 'POST', '/upload/', '{}', 200, 7.724523544311523, '2025-12-25 01:35:29.069941', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (907, '127.0.0.1', 'POST', '/upload/', '{}', 200, 9.747982025146484, '2025-12-25 01:35:35.147604', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (908, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 43.22481155395508, '2025-12-25 01:35:40.478989', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (909, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 20.247220993041992, '2025-12-25 01:35:40.530887', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (910, '127.0.0.1', 'GET', '/department', '{}', 200, 17.107009887695312, '2025-12-25 01:35:40.845835', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (911, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 31.7690372467041, '2025-12-25 01:35:40.858206', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (912, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 127.58779525756836, '2025-12-25 01:35:40.955297', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (913, '127.0.0.1', 'POST', '/upload/', '{}', 200, 66.74551963806152, '2025-12-25 01:35:55.836389', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (914, '127.0.0.1', 'GET', '/department', '{}', 200, 13.52834701538086, '2025-12-25 01:43:27.185373', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (915, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 12.877702713012695, '2025-12-25 01:43:27.187268', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (916, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 24.235248565673828, '2025-12-25 01:43:27.195075', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (917, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 13.75126838684082, '2025-12-25 01:43:31.427648', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (918, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 18.738746643066406, '2025-12-25 01:43:31.455692', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (919, '127.0.0.1', 'GET', '/department', '{}', 200, 11.954307556152344, '2025-12-25 01:43:31.647607', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (920, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 17.178773880004883, '2025-12-25 01:43:31.651562', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (921, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 22.489547729492188, '2025-12-25 01:43:31.659438', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (922, '127.0.0.1', 'POST', '/upload/', '{}', 200, 28.558731079101562, '2025-12-25 01:43:46.740644', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (923, '127.0.0.1', 'POST', '/upload/', '{}', 200, 10.526657104492188, '2025-12-25 01:44:11.553027', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (924, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 12.547492980957031, '2025-12-25 01:44:26.834660', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (925, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 8.536577224731445, '2025-12-25 01:44:26.856181', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (926, '127.0.0.1', 'GET', '/department', '{}', 200, 13.043403625488281, '2025-12-25 01:44:27.047652', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (927, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 13.813972473144531, '2025-12-25 01:44:27.049529', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (928, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 18.493175506591797, '2025-12-25 01:44:27.051697', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (929, '127.0.0.1', 'POST', '/upload/', '{}', 200, 6.677150726318359, '2025-12-25 01:44:50.895448', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (930, '127.0.0.1', 'GET', '/uploads/2025/12/25/9c897a40b55046dbb9ff2fb0ca82799b.png', '{}', 200, 0.6597042083740234, '2025-12-25 01:44:50.927865', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (931, '127.0.0.1', 'GET', '/department', '{}', 200, 16.85166358947754, '2025-12-25 01:57:11.926523', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (932, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 22.115230560302734, '2025-12-25 01:57:11.929941', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (933, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 37.65106201171875, '2025-12-25 01:57:11.948775', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (934, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 30.55095672607422, '2025-12-25 01:57:13.017940', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (935, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 18.440961837768555, '2025-12-25 01:57:13.044706', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (936, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 15.92111587524414, '2025-12-25 01:57:13.245554', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (937, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 19.220829010009766, '2025-12-25 01:57:13.246159', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (938, '127.0.0.1', 'GET', '/department', '{}', 200, 19.306421279907227, '2025-12-25 01:57:13.247333', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (939, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 17.30823516845703, '2025-12-25 01:57:39.735357', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (940, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 8.39686393737793, '2025-12-25 01:57:39.753199', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (941, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 25.733232498168945, '2025-12-25 01:57:39.993846', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (942, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 28.031587600708008, '2025-12-25 01:57:40.000635', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (943, '127.0.0.1', 'GET', '/department', '{}', 200, 33.93840789794922, '2025-12-25 01:57:40.004449', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (944, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 75.21581649780273, '2025-12-25 08:11:54.047430', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (945, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 22.711992263793945, '2025-12-25 08:11:54.090154', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (946, '127.0.0.1', 'GET', '/department', '{}', 200, 25.78568458557129, '2025-12-25 08:12:02.086649', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (947, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 64.5291805267334, '2025-12-25 08:12:02.111787', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (948, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 70.85680961608887, '2025-12-25 08:12:02.114861', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (949, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MTcxMjg3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NTY2NDg3fQ.7nLUVjeZCbwkYA4evPGoSjPRbyYcLd6_mlxDXGPDhzU\"}', 200, 38.77854347229004, '2025-12-25 08:24:02.612958', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (950, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 813.2874965667725, '2025-12-25 08:24:10.605361', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (951, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 756.8690776824951, '2025-12-25 08:24:14.619433', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (952, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MjU1ODU0LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NjUxMDU0fQ.GP9BL8VbUdzJq_kjEED5SVCwx1Y_pmNVYR-K0A1VYzM\"}', 200, 28.218507766723633, '2025-12-25 08:24:14.661909', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (953, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 13.753175735473633, '2025-12-25 08:24:14.686498', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (954, '127.0.0.1', 'GET', '/department', '{}', 200, 19.303321838378906, '2025-12-25 08:24:21.255854', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (955, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 20.0960636138916, '2025-12-25 08:24:21.258262', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (956, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 23.468494415283203, '2025-12-25 08:24:21.258881', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (957, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MjU1ODU0LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NjUxMDU0fQ.GP9BL8VbUdzJq_kjEED5SVCwx1Y_pmNVYR-K0A1VYzM\"}', 200, 34.249067306518555, '2025-12-25 08:33:34.819371', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (958, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 15.491485595703125, '2025-12-25 08:33:34.860891', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (959, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 17.251014709472656, '2025-12-25 08:33:35.146414', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (960, '127.0.0.1', 'GET', '/department', '{}', 200, 14.930486679077148, '2025-12-25 08:33:35.148285', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (961, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 19.17576789855957, '2025-12-25 08:33:35.153351', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (962, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MjU1ODU0LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NjUxMDU0fQ.GP9BL8VbUdzJq_kjEED5SVCwx1Y_pmNVYR-K0A1VYzM\"}', 200, 19.299030303955078, '2025-12-25 08:34:18.187713', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (963, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 9.096145629882812, '2025-12-25 08:34:18.217911', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (964, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 11.663436889648438, '2025-12-25 08:34:18.399788', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (965, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 39.037466049194336, '2025-12-25 08:34:18.429592', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (966, '127.0.0.1', 'GET', '/department', '{}', 200, 42.32025146484375, '2025-12-25 08:34:18.431489', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (967, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 14.310121536254883, '2025-12-25 08:39:00.177899', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (968, '127.0.0.1', 'GET', '/department', '{}', 200, 17.089366912841797, '2025-12-25 08:39:00.179458', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (969, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 20.292282104492188, '2025-12-25 08:39:00.180616', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (970, '127.0.0.1', 'POST', '/upload/', '{}', 200, 37.564992904663086, '2025-12-25 08:39:04.925960', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (971, '127.0.0.1', 'PATCH', '/user/2', '', 200, 776.6115665435791, '2025-12-25 08:39:21.719377', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (972, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MjU1ODU0LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NjUxMDU0fQ.GP9BL8VbUdzJq_kjEED5SVCwx1Y_pmNVYR-K0A1VYzM\"}', 200, 16.02911949157715, '2025-12-25 08:39:24.702432', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (973, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 10.79559326171875, '2025-12-25 08:39:24.721251', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (974, '127.0.0.1', 'GET', '/department', '{}', 200, 14.043807983398438, '2025-12-25 08:39:24.904115', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (975, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 15.062808990478516, '2025-12-25 08:39:24.906511', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (976, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 25.109052658081055, '2025-12-25 08:39:24.913831', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (977, '127.0.0.1', 'GET', '/uploads/2025/12/25/8ae1f6d706a746858b2e873180bc4b86.png', '{}', 200, 0.1823902130126953, '2025-12-25 08:39:24.977028', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (978, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MjU1ODU0LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NjUxMDU0fQ.GP9BL8VbUdzJq_kjEED5SVCwx1Y_pmNVYR-K0A1VYzM\"}', 200, 12.745857238769531, '2025-12-25 08:39:28.555703', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (979, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 26.56245231628418, '2025-12-25 08:39:28.598057', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (980, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 12.401580810546875, '2025-12-25 08:39:28.768083', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (981, '127.0.0.1', 'GET', '/department', '{}', 200, 11.42430305480957, '2025-12-25 08:39:28.766500', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (982, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 18.657207489013672, '2025-12-25 08:39:28.772915', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (983, '127.0.0.1', 'GET', '/uploads/2025/12/25/8ae1f6d706a746858b2e873180bc4b86.png', '{}', 200, 0.17333030700683594, '2025-12-25 08:39:28.847815', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (984, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MjU1ODU0LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NjUxMDU0fQ.GP9BL8VbUdzJq_kjEED5SVCwx1Y_pmNVYR-K0A1VYzM\"}', 200, 15.409231185913086, '2025-12-25 08:50:39.805758', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (985, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 15.047550201416016, '2025-12-25 08:50:39.868032', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (986, '127.0.0.1', 'GET', '/department', '{}', 200, 18.735885620117188, '2025-12-25 08:50:40.191051', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (987, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 20.92766761779785, '2025-12-25 08:50:40.191669', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (988, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 18.069982528686523, '2025-12-25 08:50:40.194000', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (989, '127.0.0.1', 'GET', '/uploads/2025/12/25/8ae1f6d706a746858b2e873180bc4b86.png', '{}', 200, 0.20456314086914062, '2025-12-25 08:50:40.280447', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (990, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MjU1ODU0LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NjUxMDU0fQ.GP9BL8VbUdzJq_kjEED5SVCwx1Y_pmNVYR-K0A1VYzM\"}', 200, 30.21693229675293, '2025-12-25 09:03:40.328293', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (991, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 30.0295352935791, '2025-12-25 09:03:40.383444', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (992, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MjU1ODU0LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NjUxMDU0fQ.GP9BL8VbUdzJq_kjEED5SVCwx1Y_pmNVYR-K0A1VYzM\"}', 200, 43.32685470581055, '2025-12-25 09:09:09.872703', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (993, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 15.14434814453125, '2025-12-25 09:09:09.914574', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (994, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MjU1ODU0LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NjUxMDU0fQ.GP9BL8VbUdzJq_kjEED5SVCwx1Y_pmNVYR-K0A1VYzM\"}', 200, 32.82427787780762, '2025-12-25 09:09:40.107860', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (995, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 20.26081085205078, '2025-12-25 09:09:40.136959', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (996, '127.0.0.1', 'POST', '/user/logout', '{}', 200, 21.64459228515625, '2025-12-25 09:13:01.149650', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (997, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 775.8502960205078, '2025-12-25 09:13:08.143428', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (998, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MjU4Nzg4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NjUzOTg4fQ.U6KURAQ1hVfZMx5FRWQwF420fv2-BTSxM8INqGhOaWM\"}', 200, 15.73491096496582, '2025-12-25 09:13:08.175132', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (999, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 29.72579002380371, '2025-12-25 09:13:08.213529', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1000, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 765.4049396514893, '2025-12-25 09:16:18.354163', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1001, '127.0.0.1', 'GET', '/user/get_user_info', '{}', 200, 0.18095970153808594, '2025-12-25 09:16:18.387914', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1002, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 766.6158676147461, '2025-12-25 09:16:33.295464', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1003, '127.0.0.1', 'GET', '/user/get_user_info', '{}', 200, 0.20265579223632812, '2025-12-25 09:16:33.327716', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1004, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 46.855926513671875, '2025-12-25 09:21:30.970576', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1005, '127.0.0.1', 'GET', '/department', '{}', 200, 63.66872787475586, '2025-12-25 09:21:30.988233', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1006, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 64.5143985748291, '2025-12-25 09:21:30.990016', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1007, '127.0.0.1', 'GET', '/uploads/2025/12/25/8ae1f6d706a746858b2e873180bc4b86.png', '{}', 200, 0.22745132446289062, '2025-12-25 09:21:31.043917', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1008, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MjU4Nzg4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NjUzOTg4fQ.U6KURAQ1hVfZMx5FRWQwF420fv2-BTSxM8INqGhOaWM\"}', 200, 70.31965255737305, '2025-12-26 02:57:11.018769', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1009, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 43.404340744018555, '2025-12-26 02:57:11.076047', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1010, '127.0.0.1', 'POST', '/upload/', '{}', 200, 30.17449378967285, '2025-12-26 02:58:04.313337', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1011, '127.0.0.1', 'PATCH', '/user/2', '', 200, 799.7593879699707, '2025-12-26 02:58:13.371156', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1012, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MjU4Nzg4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NjUzOTg4fQ.U6KURAQ1hVfZMx5FRWQwF420fv2-BTSxM8INqGhOaWM\"}', 200, 36.206960678100586, '2025-12-26 02:58:15.929372', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1013, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 10.151863098144531, '2025-12-26 02:58:15.947971', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1014, '127.0.0.1', 'POST', '/upload/', '{}', 200, 25.609731674194336, '2025-12-26 02:59:50.199100', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1015, '127.0.0.1', 'PATCH', '/user/2', '', 200, 775.8772373199463, '2025-12-26 02:59:57.360904', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1016, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MjU4Nzg4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NjUzOTg4fQ.U6KURAQ1hVfZMx5FRWQwF420fv2-BTSxM8INqGhOaWM\"}', 200, 20.62845230102539, '2025-12-26 03:00:16.459947', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1017, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 26.970624923706055, '2025-12-26 03:00:16.516324', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1018, '127.0.0.1', 'POST', '/upload/', '{}', 200, 8.209228515625, '2025-12-26 03:03:14.127114', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1019, '127.0.0.1', 'PATCH', '/user/2', '', 200, 787.0345115661621, '2025-12-26 03:03:23.726997', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1020, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MjU4Nzg4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NjUzOTg4fQ.U6KURAQ1hVfZMx5FRWQwF420fv2-BTSxM8INqGhOaWM\"}', 200, 35.89606285095215, '2025-12-26 03:03:28.183306', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1021, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 17.266511917114258, '2025-12-26 03:03:28.223932', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1022, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MjU4Nzg4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NjUzOTg4fQ.U6KURAQ1hVfZMx5FRWQwF420fv2-BTSxM8INqGhOaWM\"}', 200, 32.29403495788574, '2025-12-26 03:05:11.103851', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1023, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 34.08002853393555, '2025-12-26 03:05:11.161191', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1024, '127.0.0.1', 'POST', '/upload/', '{}', 200, 28.10978889465332, '2025-12-26 03:05:17.767405', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1025, '127.0.0.1', 'PATCH', '/user/2', '', 200, 789.2682552337646, '2025-12-26 03:05:26.615206', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1026, '127.0.0.1', 'GET', '/user', '{}', 200, 22.438764572143555, '2025-12-26 03:06:28.631286', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1027, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 90.07477760314941, '2025-12-26 03:06:28.697329', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1028, '127.0.0.1', 'GET', '/log', '{\"page\": \"2\", \"page_size\": \"5\"}', 200, 22.58753776550293, '2025-12-26 03:06:37.916197', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1029, '127.0.0.1', 'GET', '/log', '{\"page\": \"3\", \"page_size\": \"5\"}', 200, 28.9766788482666, '2025-12-26 03:06:38.781038', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1030, '127.0.0.1', 'GET', '/log', '{\"page\": \"4\", \"page_size\": \"5\"}', 200, 23.810386657714844, '2025-12-26 03:06:39.347843', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1031, '127.0.0.1', 'GET', '/log', '{\"page\": \"5\", \"page_size\": \"5\"}', 200, 29.99114990234375, '2025-12-26 03:06:39.850234', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1032, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 37.036895751953125, '2025-12-26 03:06:44.445705', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1033, '127.0.0.1', 'GET', '/log', '{\"page\": \"2\", \"page_size\": \"5\"}', 200, 16.72053337097168, '2025-12-26 03:06:47.914746', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1034, '127.0.0.1', 'GET', '/log', '{\"page\": \"3\", \"page_size\": \"5\"}', 200, 15.465974807739258, '2025-12-26 03:06:49.459366', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1035, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MjU4Nzg4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NjUzOTg4fQ.U6KURAQ1hVfZMx5FRWQwF420fv2-BTSxM8INqGhOaWM\"}', 200, 84.63931083679199, '2025-12-26 07:26:34.425593', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1036, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 48.80642890930176, '2025-12-26 07:26:34.505060', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1037, '127.0.0.1', 'PATCH', '/user/2', '', 200, 796.3979244232178, '2025-12-26 07:27:09.294423', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1038, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MjU4Nzg4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NjUzOTg4fQ.U6KURAQ1hVfZMx5FRWQwF420fv2-BTSxM8INqGhOaWM\"}', 200, 36.79776191711426, '2025-12-26 07:27:11.513792', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1039, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 29.98805046081543, '2025-12-26 07:27:11.552759', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1040, '127.0.0.1', 'POST', '/user/logout', '{}', 200, 7.9193115234375, '2025-12-26 07:27:14.185993', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1041, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 781.2709808349609, '2025-12-26 07:27:16.272202', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1042, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzM4ODM2LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM0MDM2fQ.-LCIGQvSiQ2bHFN2Gtvza_pXNbugz3t_O6-YLjrnzec\"}', 200, 33.19406509399414, '2025-12-26 07:27:16.317059', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1043, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 13.54837417602539, '2025-12-26 07:27:16.337656', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1044, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 18.866777420043945, '2025-12-26 07:27:21.980459', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1045, '127.0.0.1', 'GET', '/department', '{}', 200, 18.36872100830078, '2025-12-26 07:27:21.982033', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1046, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 29.674530029296875, '2025-12-26 07:27:21.998142', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1047, '127.0.0.1', 'POST', '/upload/', '{}', 200, 18.17178726196289, '2025-12-26 07:29:05.543276', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1048, '127.0.0.1', 'GET', '/uploads/2025/12/26/790db87a3008476da27ff69839692361.jpg', '{}', 200, 0.385284423828125, '2025-12-26 07:29:05.582976', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1049, '127.0.0.1', 'POST', '/upload/', '{}', 200, 23.231029510498047, '2025-12-26 07:29:31.931073', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1050, '127.0.0.1', 'GET', '/uploads/2025/12/26/13ddba9109bf42ea955eff4e325ac888.png', '{}', 200, 0.19502639770507812, '2025-12-26 07:29:31.986950', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1051, '127.0.0.1', 'POST', '/upload/', '{}', 200, 12.961149215698242, '2025-12-26 07:30:42.322668', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1052, '127.0.0.1', 'GET', '/uploads/2025/12/26/7b71cac1d15c4b9c85c20cc26984dc2f.jpg', '{}', 200, 1.0633468627929688, '2025-12-26 07:30:42.358397', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1053, '127.0.0.1', 'POST', '/upload/', '{}', 200, 3.9305686950683594, '2025-12-26 07:33:48.586564', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1054, '127.0.0.1', 'GET', '/uploads/2025/12/26/91f5461b9f874656ba18dd04b2aea721.jpg', '{}', 200, 0.9789466857910156, '2025-12-26 07:33:48.619499', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1055, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzM4ODM2LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM0MDM2fQ.-LCIGQvSiQ2bHFN2Gtvza_pXNbugz3t_O6-YLjrnzec\"}', 200, 22.130966186523438, '2025-12-26 07:33:55.897452', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1056, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 10.165214538574219, '2025-12-26 07:33:55.915544', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1057, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 16.411542892456055, '2025-12-26 07:33:56.131567', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1058, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 19.515514373779297, '2025-12-26 07:33:56.133199', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1059, '127.0.0.1', 'GET', '/department', '{}', 200, 30.982494354248047, '2025-12-26 07:33:56.149668', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1060, '127.0.0.1', 'POST', '/upload/', '{}', 200, 4.665851593017578, '2025-12-26 07:34:30.348771', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1061, '127.0.0.1', 'GET', '/uploads/2025/12/26/862ca55cc6294e58af421cc259de9444.jpg', '{}', 200, 0.23293495178222656, '2025-12-26 07:34:30.408452', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1062, '127.0.0.1', 'POST', '/upload/', '{}', 200, 9.886741638183594, '2025-12-26 07:34:36.986262', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1063, '127.0.0.1', 'GET', '/uploads/2025/12/26/1072ec60d9e84536be897748d8f075d0.jpg', '{}', 200, 0.27179718017578125, '2025-12-26 07:34:37.016190', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1064, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 25.000333786010742, '2025-12-26 07:36:42.835049', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1065, '127.0.0.1', 'GET', '/department', '{}', 200, 27.979373931884766, '2025-12-26 07:36:42.839008', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1066, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 40.80343246459961, '2025-12-26 07:36:42.853281', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1067, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 0.5133152008056641, '2025-12-26 07:36:42.995505', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1068, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzM4ODM2LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM0MDM2fQ.-LCIGQvSiQ2bHFN2Gtvza_pXNbugz3t_O6-YLjrnzec\"}', 200, 40.1151180267334, '2025-12-26 07:36:44.547321', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1069, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 13.807296752929688, '2025-12-26 07:36:44.579696', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1070, '127.0.0.1', 'GET', '/department', '{}', 200, 15.74254035949707, '2025-12-26 07:36:44.875738', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1071, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 33.47897529602051, '2025-12-26 07:36:44.892239', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1072, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 34.012794494628906, '2025-12-26 07:36:44.895077', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1073, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 0.5443096160888672, '2025-12-26 07:36:44.964824', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1074, '127.0.0.1', 'POST', '/upload/', '{}', 200, 5.60450553894043, '2025-12-26 07:36:50.905125', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1075, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzM4ODM2LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM0MDM2fQ.-LCIGQvSiQ2bHFN2Gtvza_pXNbugz3t_O6-YLjrnzec\"}', 200, 14.1448974609375, '2025-12-26 07:37:42.980480', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1076, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 27.180194854736328, '2025-12-26 07:37:43.018942', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1077, '127.0.0.1', 'GET', '/department', '{}', 200, 6.405353546142578, '2025-12-26 07:37:43.186974', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1078, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 14.723062515258789, '2025-12-26 07:37:43.196032', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1079, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 29.579877853393555, '2025-12-26 07:37:43.209463', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1080, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 0.4947185516357422, '2025-12-26 07:37:43.293192', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1081, '127.0.0.1', 'GET', '/department', '{}', 200, 10.876655578613281, '2025-12-26 07:38:52.380462', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1082, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 14.402151107788086, '2025-12-26 07:38:52.383027', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1083, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 24.416446685791016, '2025-12-26 07:38:52.394598', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1084, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 0.6191730499267578, '2025-12-26 07:38:52.427823', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1085, '127.0.0.1', 'POST', '/upload/', '{}', 200, 7.805585861206055, '2025-12-26 07:40:49.554738', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1086, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzM4ODM2LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM0MDM2fQ.-LCIGQvSiQ2bHFN2Gtvza_pXNbugz3t_O6-YLjrnzec\"}', 200, 19.718408584594727, '2025-12-26 07:42:36.907952', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1087, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 19.651174545288086, '2025-12-26 07:42:36.935580', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1088, '127.0.0.1', 'GET', '/department', '{}', 200, 12.128829956054688, '2025-12-26 07:42:37.127348', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1089, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 22.516250610351562, '2025-12-26 07:42:37.138517', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1090, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 25.28238296508789, '2025-12-26 07:42:37.139652', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1091, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 0.5190372467041016, '2025-12-26 07:42:37.226035', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1092, '127.0.0.1', 'GET', '/department', '{}', 200, 8.56471061706543, '2025-12-26 07:47:11.848191', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1093, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 20.905017852783203, '2025-12-26 07:47:11.861809', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1094, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 40.88234901428223, '2025-12-26 07:47:11.878821', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1095, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 0.7002353668212891, '2025-12-26 07:47:11.934883', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1096, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzM4ODM2LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM0MDM2fQ.-LCIGQvSiQ2bHFN2Gtvza_pXNbugz3t_O6-YLjrnzec\"}', 200, 31.64386749267578, '2025-12-26 07:50:52.054408', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1097, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 8.936643600463867, '2025-12-26 07:50:52.070915', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1098, '127.0.0.1', 'GET', '/department', '{}', 200, 16.31951332092285, '2025-12-26 07:50:52.277901', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1099, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 21.141767501831055, '2025-12-26 07:50:52.282865', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1100, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 24.415254592895508, '2025-12-26 07:50:52.283719', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1101, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 1.3043880462646484, '2025-12-26 07:50:52.358066', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1102, '127.0.0.1', 'POST', '/user/logout', '{}', 200, 26.762723922729492, '2025-12-26 07:51:25.228651', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1103, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"ylf\", \"password\": \"******\"}', 200, 782.8118801116943, '2025-12-26 07:51:30.978053', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1104, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"ylf\", \"password\": \"******\"}', 200, 768.0590152740479, '2025-12-26 07:51:37.170693', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1105, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJ1c2VybmFtZSI6InlsZiIsImV4cCI6MTc2NzM0MDI5NywiZW1haWwiOiJ5bGY4NzkwOEAxMjYuY29tIiwib3JpZ19pYXQiOjE3NjY3MzU0OTd9.e0fBuScAk2RHNJAz3rveHQTHddab5EmIOVupCLRPTGc\"}', 200, 13.409137725830078, '2025-12-26 07:51:37.196393', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1106, '127.0.0.1', 'GET', '/user', '{\"username\": \"ylf\"}', 200, 26.806354522705078, '2025-12-26 07:51:37.232837', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1107, '127.0.0.1', 'GET', '/department', '{}', 200, 15.02537727355957, '2025-12-26 07:51:41.740758', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1108, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 20.25628089904785, '2025-12-26 07:51:41.747308', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1109, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 23.748159408569336, '2025-12-26 07:51:41.748540', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1110, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 0.5023479461669922, '2025-12-26 07:51:41.799970', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1111, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 21.74544334411621, '2025-12-26 07:56:50.538008', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1112, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 34.66343879699707, '2025-12-26 07:56:50.554285', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1113, '127.0.0.1', 'GET', '/department', '{}', 200, 44.99459266662598, '2025-12-26 07:56:50.563071', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1114, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 0.522613525390625, '2025-12-26 07:56:50.608080', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1115, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJ1c2VybmFtZSI6InlsZiIsImV4cCI6MTc2NzM0MDI5NywiZW1haWwiOiJ5bGY4NzkwOEAxMjYuY29tIiwib3JpZ19pYXQiOjE3NjY3MzU0OTd9.e0fBuScAk2RHNJAz3rveHQTHddab5EmIOVupCLRPTGc\"}', 200, 12.796163558959961, '2025-12-26 07:56:51.301818', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1116, '127.0.0.1', 'GET', '/user', '{\"username\": \"ylf\"}', 200, 9.151935577392578, '2025-12-26 07:56:51.321019', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1117, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 8.59379768371582, '2025-12-26 07:56:51.509583', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1118, '127.0.0.1', 'GET', '/department', '{}', 200, 20.648956298828125, '2025-12-26 07:56:51.520458', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1119, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 22.405147552490234, '2025-12-26 07:56:51.520949', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1120, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 1.0950565338134766, '2025-12-26 07:56:51.590406', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1121, '127.0.0.1', 'POST', '/upload/', '{}', 200, 5.652904510498047, '2025-12-26 07:56:59.293970', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1122, '127.0.0.1', 'PUT', '/user/2', '', 400, 88.61207962036133, '2025-12-26 07:57:01.914124', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1123, '127.0.0.1', 'PUT', '/user/2', '', 400, 28.9151668548584, '2025-12-26 07:57:24.223783', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1124, '127.0.0.1', 'GET', '/department', '{}', 200, 17.6999568939209, '2025-12-26 07:59:00.818908', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1125, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 18.03135871887207, '2025-12-26 07:59:00.820611', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1126, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 23.808002471923828, '2025-12-26 07:59:00.824030', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1127, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 0.6206035614013672, '2025-12-26 07:59:00.936262', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1128, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJ1c2VybmFtZSI6InlsZiIsImV4cCI6MTc2NzM0MDI5NywiZW1haWwiOiJ5bGY4NzkwOEAxMjYuY29tIiwib3JpZ19pYXQiOjE3NjY3MzU0OTd9.e0fBuScAk2RHNJAz3rveHQTHddab5EmIOVupCLRPTGc\"}', 200, 47.93190956115723, '2025-12-26 07:59:02.411706', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1129, '127.0.0.1', 'GET', '/user', '{\"username\": \"ylf\"}', 200, 8.627653121948242, '2025-12-26 07:59:02.432721', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1130, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 24.793386459350586, '2025-12-26 07:59:02.745897', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1131, '127.0.0.1', 'GET', '/department', '{}', 200, 27.85325050354004, '2025-12-26 07:59:02.747816', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1132, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 31.122922897338867, '2025-12-26 07:59:02.749879', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1133, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 0.7700920104980469, '2025-12-26 07:59:02.836053', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1134, '127.0.0.1', 'POST', '/upload/', '{}', 200, 5.673885345458984, '2025-12-26 07:59:09.335513', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1135, '127.0.0.1', 'PUT', '/user/2', '', 200, 30.158281326293945, '2025-12-26 07:59:10.941798', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1136, '127.0.0.1', 'PATCH', '/user/2', '', 200, 28.542757034301758, '2025-12-26 07:59:10.977721', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1137, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 16.352415084838867, '2025-12-26 07:59:11.023411', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1138, '127.0.0.1', 'GET', '/user/2', '{}', 200, 19.973039627075195, '2025-12-26 07:59:11.095732', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1139, '127.0.0.1', 'POST', '/upload/', '{}', 200, 75.1657485961914, '2025-12-26 07:59:31.910840', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1140, '127.0.0.1', 'PUT', '/user/3', '', 200, 43.60508918762207, '2025-12-26 07:59:35.184882', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1141, '127.0.0.1', 'PATCH', '/user/3', '', 200, 24.807214736938477, '2025-12-26 07:59:35.219497', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1142, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 16.35456085205078, '2025-12-26 07:59:35.267518', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1143, '127.0.0.1', 'GET', '/user/3', '{}', 200, 11.035442352294922, '2025-12-26 07:59:35.357027', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1144, '127.0.0.1', 'GET', '/user/2', '{}', 200, 24.807214736938477, '2025-12-26 07:59:35.372011', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1145, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJ1c2VybmFtZSI6InlsZiIsImV4cCI6MTc2NzM0MDI5NywiZW1haWwiOiJ5bGY4NzkwOEAxMjYuY29tIiwib3JpZ19pYXQiOjE3NjY3MzU0OTd9.e0fBuScAk2RHNJAz3rveHQTHddab5EmIOVupCLRPTGc\"}', 200, 39.11113739013672, '2025-12-26 07:59:37.998091', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1146, '127.0.0.1', 'GET', '/user', '{\"username\": \"ylf\"}', 200, 14.602422714233398, '2025-12-26 07:59:38.034258', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1147, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJ1c2VybmFtZSI6InlsZiIsImV4cCI6MTc2NzM0MDI5NywiZW1haWwiOiJ5bGY4NzkwOEAxMjYuY29tIiwib3JpZ19pYXQiOjE3NjY3MzU0OTd9.e0fBuScAk2RHNJAz3rveHQTHddab5EmIOVupCLRPTGc\"}', 200, 9.11092758178711, '2025-12-26 07:59:42.807735', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1148, '127.0.0.1', 'GET', '/user', '{\"username\": \"ylf\"}', 200, 18.71800422668457, '2025-12-26 07:59:42.875195', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1149, '127.0.0.1', 'POST', '/user/logout', '{}', 200, 8.58449935913086, '2025-12-26 07:59:47.764070', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1150, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 807.4941635131836, '2025-12-26 07:59:49.988922', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1151, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQwNzg5LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM1OTg5fQ.cTutBmTmvbF3dwAmr1tO5x86yne0Yuz_DsVS3nQ02BE\"}', 200, 23.78225326538086, '2025-12-26 07:59:50.032478', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1152, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 14.478683471679688, '2025-12-26 07:59:50.062462', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1153, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQwNzg5LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM1OTg5fQ.cTutBmTmvbF3dwAmr1tO5x86yne0Yuz_DsVS3nQ02BE\"}', 200, 14.401435852050781, '2025-12-26 07:59:54.517959', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1154, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 7.140398025512695, '2025-12-26 07:59:54.532478', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1155, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQwNzg5LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM1OTg5fQ.cTutBmTmvbF3dwAmr1tO5x86yne0Yuz_DsVS3nQ02BE\"}', 200, 21.2709903717041, '2025-12-26 08:00:18.357668', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1156, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 6.639719009399414, '2025-12-26 08:00:18.371297', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1157, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQwNzg5LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM1OTg5fQ.cTutBmTmvbF3dwAmr1tO5x86yne0Yuz_DsVS3nQ02BE\"}', 200, 9.822845458984375, '2025-12-26 08:00:20.621970', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1158, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 26.52430534362793, '2025-12-26 08:00:20.656457', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1159, '127.0.0.1', 'POST', '/user/logout', '{}', 200, 29.43253517150879, '2025-12-26 08:00:23.325759', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1160, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 773.8301753997803, '2025-12-26 08:00:25.730127', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1161, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQwODI1LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2MDI1fQ.OIR1FuSLVrtizYwl24LBYgd7tl_nFCXLwI4BoVXKfQc\"}', 200, 18.38088035583496, '2025-12-26 08:00:25.761793', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1162, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 9.617090225219727, '2025-12-26 08:00:25.781577', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1163, '127.0.0.1', 'POST', '/user/logout', '{}', 200, 4.4612884521484375, '2025-12-26 08:00:59.510044', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1164, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 829.7057151794434, '2025-12-26 08:03:37.864525', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1165, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxMDE3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2MjE3fQ.Ze31x8wu15WUZrkXU9tBOlF8pj3bV68bsp7tInzJN0U\"}', 200, 27.29964256286621, '2025-12-26 08:03:37.913086', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1166, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 43.60198974609375, '2025-12-26 08:03:37.964853', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1167, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 16.530513763427734, '2025-12-26 08:03:40.627704', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1168, '127.0.0.1', 'GET', '/department', '{}', 200, 18.96953582763672, '2025-12-26 08:03:40.631535', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1169, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 26.52883529663086, '2025-12-26 08:03:40.642917', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1170, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 1.173257827758789, '2025-12-26 08:03:40.678857', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1171, '127.0.0.1', 'POST', '/upload/', '{}', 200, 12.919902801513672, '2025-12-26 08:03:49.273775', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1172, '127.0.0.1', 'PUT', '/user/2', '', 200, 35.16697883605957, '2025-12-26 08:03:51.337127', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1173, '127.0.0.1', 'PATCH', '/user/2', '', 200, 27.768373489379883, '2025-12-26 08:03:51.372802', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1174, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 20.041942596435547, '2025-12-26 08:03:51.419836', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1175, '127.0.0.1', 'GET', '/user/2', '{}', 200, 19.729137420654297, '2025-12-26 08:03:51.464498', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1176, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxMDE3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2MjE3fQ.Ze31x8wu15WUZrkXU9tBOlF8pj3bV68bsp7tInzJN0U\"}', 200, 24.97076988220215, '2025-12-26 08:03:53.350168', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1177, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 8.278846740722656, '2025-12-26 08:03:53.365508', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1178, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxMDE3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2MjE3fQ.Ze31x8wu15WUZrkXU9tBOlF8pj3bV68bsp7tInzJN0U\"}', 200, 8.933067321777344, '2025-12-26 08:03:56.525197', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1179, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 6.431341171264648, '2025-12-26 08:03:56.538595', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1180, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxMDE3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2MjE3fQ.Ze31x8wu15WUZrkXU9tBOlF8pj3bV68bsp7tInzJN0U\"}', 200, 11.227607727050781, '2025-12-26 08:07:13.353380', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1181, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 7.372617721557617, '2025-12-26 08:07:13.371278', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1182, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxMDE3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2MjE3fQ.Ze31x8wu15WUZrkXU9tBOlF8pj3bV68bsp7tInzJN0U\"}', 200, 12.982368469238281, '2025-12-26 08:07:34.195704', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1183, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 10.257482528686523, '2025-12-26 08:07:34.218061', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1184, '127.0.0.1', 'GET', '/department', '{}', 200, 14.645099639892578, '2025-12-26 08:07:36.822252', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1185, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 17.7004337310791, '2025-12-26 08:07:36.823620', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1186, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 16.260862350463867, '2025-12-26 08:07:36.827575', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1187, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 0.8399486541748047, '2025-12-26 08:07:36.878030', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1188, '127.0.0.1', 'PUT', '/user/2', '', 200, 28.943538665771484, '2025-12-26 08:08:08.560218', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1189, '127.0.0.1', 'PATCH', '/user/2', '', 200, 38.67650032043457, '2025-12-26 08:08:08.608054', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1190, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 20.397663116455078, '2025-12-26 08:08:08.659557', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1191, '127.0.0.1', 'GET', '/department', '{}', 200, 14.396190643310547, '2025-12-26 08:10:50.645232', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1192, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 20.67089080810547, '2025-12-26 08:10:50.649234', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1193, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 35.17746925354004, '2025-12-26 08:10:50.667197', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1194, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 1.2297630310058594, '2025-12-26 08:10:50.746644', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1195, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxMDE3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2MjE3fQ.Ze31x8wu15WUZrkXU9tBOlF8pj3bV68bsp7tInzJN0U\"}', 200, 48.485755920410156, '2025-12-26 08:10:51.824746', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1196, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 10.304689407348633, '2025-12-26 08:10:51.853043', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1197, '127.0.0.1', 'GET', '/department', '{}', 200, 13.043880462646484, '2025-12-26 08:10:52.139785', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1198, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 26.17669105529785, '2025-12-26 08:10:52.151342', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1199, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 35.10451316833496, '2025-12-26 08:10:52.163122', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1200, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 1.001119613647461, '2025-12-26 08:10:52.250797', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1201, '127.0.0.1', 'PUT', '/user/3', '', 200, 49.3013858795166, '2025-12-26 08:11:10.764238', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1202, '127.0.0.1', 'PATCH', '/user/3', '', 200, 40.08889198303223, '2025-12-26 08:11:10.813061', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1203, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 14.324426651000977, '2025-12-26 08:11:10.858131', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1204, '127.0.0.1', 'PUT', '/user/3', '', 200, 33.53309631347656, '2025-12-26 08:11:41.130848', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1205, '127.0.0.1', 'PATCH', '/user/3', '', 200, 36.943912506103516, '2025-12-26 08:11:41.174905', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1206, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 13.25535774230957, '2025-12-26 08:11:41.216010', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1207, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxMDE3LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2MjE3fQ.Ze31x8wu15WUZrkXU9tBOlF8pj3bV68bsp7tInzJN0U\"}', 200, 32.47570991516113, '2025-12-26 08:11:43.920894', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1208, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 35.40492057800293, '2025-12-26 08:11:43.975179', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1209, '127.0.0.1', 'GET', '/department', '{}', 200, 13.699054718017578, '2025-12-26 08:11:44.281968', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1210, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 17.086029052734375, '2025-12-26 08:11:44.286509', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1211, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 22.44877815246582, '2025-12-26 08:11:44.289984', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1212, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 0.774383544921875, '2025-12-26 08:11:44.410974', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1213, '127.0.0.1', 'POST', '/user/logout', '{}', 200, 20.295381546020508, '2025-12-26 08:11:47.687096', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1214, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"ylf\", \"password\": \"******\"}', 200, 788.4790897369385, '2025-12-26 08:11:52.273390', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1215, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"ylf\", \"password\": \"******\"}', 200, 792.8800582885742, '2025-12-26 08:11:55.858551', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1216, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJ1c2VybmFtZSI6InlsZiIsImV4cCI6MTc2NzM0MTUxNSwiZW1haWwiOiJ5bGY4NzkwOEAxMjYuY29tIiwib3JpZ19pYXQiOjE3NjY3MzY3MTV9.fypwZByP26FA5J1S5VO9nN7XYQrTlOHR3Dxx_JPl4iM\"}', 200, 34.43431854248047, '2025-12-26 08:11:55.906807', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1217, '127.0.0.1', 'GET', '/user', '{\"username\": \"ylf\"}', 200, 33.667802810668945, '2025-12-26 08:11:55.948801', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1218, '127.0.0.1', 'POST', '/user/logout', '{}', 200, 16.381502151489258, '2025-12-26 08:12:03.305923', 'INFO', NULL, NULL, 3);
INSERT INTO `sys_log` VALUES (1219, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 787.355899810791, '2025-12-26 08:12:21.568858', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1220, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxNTQxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2NzQxfQ.c0FrleCtA-dEVc40EvMjnpNCU0qCBl2-RomLR4SFEY0\"}', 200, 32.72819519042969, '2025-12-26 08:12:21.616809', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1221, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 33.930301666259766, '2025-12-26 08:12:21.691393', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1222, '127.0.0.1', 'GET', '/department', '{}', 200, 13.829469680786133, '2025-12-26 08:12:23.410346', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1223, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 18.30887794494629, '2025-12-26 08:12:23.413445', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1224, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 23.416996002197266, '2025-12-26 08:12:23.424078', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1225, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 48.1569766998291, '2025-12-26 08:12:23.589587', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1226, '127.0.0.1', 'PUT', '/user/2', '', 200, 26.324748992919922, '2025-12-26 08:12:31.897899', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1227, '127.0.0.1', 'PATCH', '/user/2', '', 200, 37.69803047180176, '2025-12-26 08:12:31.947510', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1228, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 58.7010383605957, '2025-12-26 08:12:32.041101', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1229, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxNTQxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2NzQxfQ.c0FrleCtA-dEVc40EvMjnpNCU0qCBl2-RomLR4SFEY0\"}', 200, 7.744550704956055, '2025-12-26 08:12:34.635322', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1230, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 16.687631607055664, '2025-12-26 08:12:34.702890', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1231, '127.0.0.1', 'GET', '/department', '{}', 200, 21.596193313598633, '2025-12-26 08:12:35.042518', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1232, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 24.417877197265625, '2025-12-26 08:12:35.044367', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1233, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 41.632890701293945, '2025-12-26 08:12:35.066717', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1234, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 1.0805130004882812, '2025-12-26 08:12:35.123100', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1235, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxNTQxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2NzQxfQ.c0FrleCtA-dEVc40EvMjnpNCU0qCBl2-RomLR4SFEY0\"}', 200, 31.908512115478516, '2025-12-26 08:12:53.715211', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1236, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 18.746614456176758, '2025-12-26 08:12:53.767070', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1237, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 23.68474006652832, '2025-12-26 08:12:54.051793', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1238, '127.0.0.1', 'GET', '/department', '{}', 200, 22.112131118774414, '2025-12-26 08:12:54.053851', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1239, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 30.88855743408203, '2025-12-26 08:12:54.064901', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1240, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 0.9305477142333984, '2025-12-26 08:12:54.166007', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1241, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxNTQxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2NzQxfQ.c0FrleCtA-dEVc40EvMjnpNCU0qCBl2-RomLR4SFEY0\"}', 200, 27.47941017150879, '2025-12-26 08:12:56.740774', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1242, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 21.221160888671875, '2025-12-26 08:12:56.771380', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1243, '127.0.0.1', 'GET', '/department', '{}', 200, 16.928434371948242, '2025-12-26 08:12:57.202255', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1244, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 17.368078231811523, '2025-12-26 08:12:57.204128', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1245, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 20.265579223632812, '2025-12-26 08:12:57.204618', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1246, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 0.5419254302978516, '2025-12-26 08:12:57.292575', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1247, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 0.8304119110107422, '2025-12-26 08:13:11.979525', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1248, '127.0.0.1', 'POST', '/upload/', '{}', 200, 22.90034294128418, '2025-12-26 08:13:15.337834', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1249, '127.0.0.1', 'PUT', '/user/17', '', 200, 29.995441436767578, '2025-12-26 08:13:19.309878', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1250, '127.0.0.1', 'PATCH', '/user/17', '', 200, 34.00540351867676, '2025-12-26 08:13:19.349740', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1251, '127.0.0.1', 'GET', '/media/media/avatars/ylf.png', '', 500, 0.6661415100097656, '2025-12-26 08:13:19.396027', 'ERROR', '“D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\static.py\", line 51, in serve\n    raise Http404(_(\"“%(path)s” does not exist\") % {\"path\": fullpath})\ndjango.http.response.Http404: “D:\\PythonProjects\\UniDjango\\UniDjango\\media\\media\\avatars\\ylf.png” does not exist\n', NULL);
INSERT INTO `sys_log` VALUES (1252, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 20.287752151489258, '2025-12-26 08:13:19.398778', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1253, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxNTQxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2NzQxfQ.c0FrleCtA-dEVc40EvMjnpNCU0qCBl2-RomLR4SFEY0\"}', 200, 17.527341842651367, '2025-12-26 08:13:21.395377', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1254, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 6.560087203979492, '2025-12-26 08:13:21.409608', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1255, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 13.332843780517578, '2025-12-26 08:13:21.516042', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1256, '127.0.0.1', 'GET', '/department', '{}', 200, 26.863574981689453, '2025-12-26 08:13:21.531811', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1257, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 31.156539916992188, '2025-12-26 08:13:21.537986', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1258, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxNTQxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2NzQxfQ.c0FrleCtA-dEVc40EvMjnpNCU0qCBl2-RomLR4SFEY0\"}', 200, 14.776229858398438, '2025-12-26 08:16:09.139621', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1259, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 32.92655944824219, '2025-12-26 08:16:09.181922', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1260, '127.0.0.1', 'GET', '/department', '{}', 200, 15.614748001098633, '2025-12-26 08:16:09.374532', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1261, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 19.3936824798584, '2025-12-26 08:16:09.376984', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1262, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 20.99466323852539, '2025-12-26 08:16:09.382093', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1263, '127.0.0.1', 'POST', '/upload/', '{}', 200, 9.861230850219727, '2025-12-26 08:16:16.804560', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1264, '127.0.0.1', 'PUT', '/user/3', '', 200, 31.82697296142578, '2025-12-26 08:16:19.294445', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1265, '127.0.0.1', 'PATCH', '/user/3', '', 200, 41.21279716491699, '2025-12-26 08:16:19.341930', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1266, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 29.5717716217041, '2025-12-26 08:16:19.400952', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1267, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxNTQxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2NzQxfQ.c0FrleCtA-dEVc40EvMjnpNCU0qCBl2-RomLR4SFEY0\"}', 200, 14.390945434570312, '2025-12-26 08:16:21.370737', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1268, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 15.204668045043945, '2025-12-26 08:16:21.411973', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1269, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 17.270565032958984, '2025-12-26 08:16:21.636965', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1270, '127.0.0.1', 'GET', '/department', '{}', 200, 19.810914993286133, '2025-12-26 08:16:21.638758', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1271, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 23.05459976196289, '2025-12-26 08:16:21.640921', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1272, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxNTQxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2NzQxfQ.c0FrleCtA-dEVc40EvMjnpNCU0qCBl2-RomLR4SFEY0\"}', 200, 51.11050605773926, '2025-12-26 08:20:10.366871', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1273, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 20.610332489013672, '2025-12-26 08:20:10.396909', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1274, '127.0.0.1', 'GET', '/department', '{}', 200, 11.266946792602539, '2025-12-26 08:20:24.624561', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1275, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 15.293121337890625, '2025-12-26 08:20:24.630634', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1276, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 23.379087448120117, '2025-12-26 08:20:24.635094', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1277, '127.0.0.1', 'POST', '/upload/', '{}', 200, 24.443864822387695, '2025-12-26 08:20:48.365199', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1278, '127.0.0.1', 'PATCH', '/user/2', '', 200, 12.753963470458984, '2025-12-26 08:20:49.734298', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1279, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxNTQxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2NzQxfQ.c0FrleCtA-dEVc40EvMjnpNCU0qCBl2-RomLR4SFEY0\"}', 200, 23.433685302734375, '2025-12-26 08:20:53.344301', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1280, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 37.12582588195801, '2025-12-26 08:20:53.389153', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1281, '127.0.0.1', 'GET', '/department', '{}', 200, 15.468835830688477, '2025-12-26 08:20:53.573629', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1282, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 15.614986419677734, '2025-12-26 08:20:53.575570', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1283, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 19.791603088378906, '2025-12-26 08:20:53.576766', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1284, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxNTQxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2NzQxfQ.c0FrleCtA-dEVc40EvMjnpNCU0qCBl2-RomLR4SFEY0\"}', 200, 31.81171417236328, '2025-12-26 08:21:02.387079', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1285, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 33.38956832885742, '2025-12-26 08:21:02.429298', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1286, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 15.135049819946289, '2025-12-26 08:21:02.609954', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1287, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 14.469146728515625, '2025-12-26 08:21:02.612290', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1288, '127.0.0.1', 'GET', '/department', '{}', 200, 31.425952911376953, '2025-12-26 08:21:02.627748', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1289, '127.0.0.1', 'PUT', '/user/2', '', 200, 60.990333557128906, '2025-12-26 08:29:01.051751', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1290, '127.0.0.1', 'PATCH', '/user/2', '', 200, 34.99412536621094, '2025-12-26 08:29:01.094182', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1291, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 23.900270462036133, '2025-12-26 08:29:01.146349', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1292, '127.0.0.1', 'PUT', '/user/2', '', 200, 36.60297393798828, '2025-12-26 08:29:21.222960', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1293, '127.0.0.1', 'PATCH', '/user/2', '', 200, 34.62624549865723, '2025-12-26 08:29:21.265091', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1294, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 28.149127960205078, '2025-12-26 08:29:21.324225', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1295, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxNTQxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2NzQxfQ.c0FrleCtA-dEVc40EvMjnpNCU0qCBl2-RomLR4SFEY0\"}', 200, 15.221834182739258, '2025-12-26 08:29:47.115460', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1296, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 9.044885635375977, '2025-12-26 08:29:47.133933', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1297, '127.0.0.1', 'GET', '/department', '{}', 200, 13.553619384765625, '2025-12-26 08:29:47.330176', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1298, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 15.604734420776367, '2025-12-26 08:29:47.331206', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1299, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 32.32407569885254, '2025-12-26 08:29:47.351872', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1300, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxNTQxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2NzQxfQ.c0FrleCtA-dEVc40EvMjnpNCU0qCBl2-RomLR4SFEY0\"}', 200, 15.390396118164062, '2025-12-26 08:42:35.505512', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1301, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 8.30984115600586, '2025-12-26 08:42:35.522743', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1302, '127.0.0.1', 'GET', '/department', '{}', 200, 14.241695404052734, '2025-12-26 08:42:35.725832', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1303, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 16.743898391723633, '2025-12-26 08:42:35.729585', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1304, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 40.25626182556152, '2025-12-26 08:42:35.741225', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1305, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxNTQxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2NzQxfQ.c0FrleCtA-dEVc40EvMjnpNCU0qCBl2-RomLR4SFEY0\"}', 200, 16.258716583251953, '2025-12-26 09:14:12.577494', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1306, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 24.803638458251953, '2025-12-26 09:14:12.609317', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1307, '127.0.0.1', 'GET', '/department', '{}', 200, 19.633769989013672, '2025-12-26 09:14:12.810832', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1308, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 23.45561981201172, '2025-12-26 09:14:12.811679', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1309, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 19.389867782592773, '2025-12-26 09:14:12.813262', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1310, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 6.871223449707031, '2025-12-26 09:14:15.920433', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1311, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 24.896860122680664, '2025-12-26 09:14:17.103627', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1312, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 22.042274475097656, '2025-12-26 09:14:18.234565', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1313, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 67.71993637084961, '2025-12-26 09:14:19.691089', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1314, '127.0.0.1', 'GET', '/user', '{}', 200, 8.783578872680664, '2025-12-26 09:14:20.710407', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1315, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 58.82120132446289, '2025-12-26 09:14:20.759362', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1316, '127.0.0.1', 'GET', '/department', '{}', 200, 12.605905532836914, '2025-12-26 09:14:23.449907', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1317, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 19.4549560546875, '2025-12-26 09:14:23.455753', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1318, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 22.25518226623535, '2025-12-26 09:14:23.461922', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1319, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 14.42575454711914, '2025-12-26 09:14:24.846083', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1320, '127.0.0.1', 'GET', '/user', '{}', 200, 23.221731185913086, '2025-12-26 09:14:24.855830', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1321, '127.0.0.1', 'GET', '/log', '{\"page\": \"3\", \"page_size\": \"5\"}', 200, 26.044845581054688, '2025-12-26 09:14:30.486517', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1322, '127.0.0.1', 'GET', '/log', '{\"page\": \"4\", \"page_size\": \"5\"}', 200, 14.03188705444336, '2025-12-26 09:14:31.985767', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1323, '127.0.0.1', 'GET', '/log', '{\"page\": \"5\", \"page_size\": \"5\"}', 200, 13.242006301879883, '2025-12-26 09:14:33.242842', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1324, '127.0.0.1', 'GET', '/log', '{\"page\": \"6\", \"page_size\": \"5\"}', 200, 33.495187759399414, '2025-12-26 09:14:33.879503', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1325, '127.0.0.1', 'GET', '/log', '{\"page\": \"7\", \"page_size\": \"5\"}', 200, 37.3692512512207, '2025-12-26 09:14:34.264879', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1326, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3MzQxNTQxLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2NzM2NzQxfQ.c0FrleCtA-dEVc40EvMjnpNCU0qCBl2-RomLR4SFEY0\"}', 200, 57.743072509765625, '2025-12-26 10:06:22.595166', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1327, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 34.749507904052734, '2025-12-26 10:06:22.654424', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1328, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 873.8620281219482, '2025-12-29 01:31:18.610805', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1329, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3NTc2Njc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2OTcxODc4fQ.uMDu04Brf5yFUQKpqxkVH66MbZTgJdXWno5-TheUnKI\"}', 200, 48.31647872924805, '2025-12-29 01:31:18.692120', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1330, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 46.51355743408203, '2025-12-29 01:31:18.749169', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1331, '127.0.0.1', 'GET', '/department', '{}', 200, 15.523433685302734, '2025-12-29 01:31:23.008128', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1332, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 17.073631286621094, '2025-12-29 01:31:23.008592', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1333, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 16.382694244384766, '2025-12-29 01:31:23.010043', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1334, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 8.604049682617188, '2025-12-29 01:31:28.252123', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1335, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 9.22250747680664, '2025-12-29 01:31:29.748691', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1336, '127.0.0.1', 'GET', '/menu/get_all_menus/', '{}', 200, 28.783559799194336, '2025-12-29 01:31:31.161870', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1337, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 32.958030700683594, '2025-12-29 01:31:34.244183', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1338, '127.0.0.1', 'GET', '/user', '{}', 200, 10.69021224975586, '2025-12-29 01:31:35.655008', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1339, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 48.441410064697266, '2025-12-29 01:31:35.691739', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1340, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3NTc2Njc4LCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY2OTcxODc4fQ.uMDu04Brf5yFUQKpqxkVH66MbZTgJdXWno5-TheUnKI\"}', 200, 22.539854049682617, '2025-12-29 01:33:26.164795', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1341, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 12.162208557128906, '2025-12-29 01:33:26.185314', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1342, '127.0.0.1', 'GET', '/user', '{}', 200, 29.799938201904297, '2025-12-29 01:33:26.387943', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1343, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 41.64886474609375, '2025-12-29 01:33:26.398846', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1344, '127.0.0.1', 'GET', '/department', '{}', 200, 21.443843841552734, '2025-12-29 01:33:28.036515', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1345, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 22.66669273376465, '2025-12-29 01:33:28.039680', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1346, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 26.656627655029297, '2025-12-29 01:33:28.040514', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1347, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 20.40576934814453, '2025-12-29 01:33:45.191119', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1348, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 7.686138153076172, '2025-12-29 01:33:46.261687', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1349, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 27.37879753112793, '2025-12-29 01:35:38.414672', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1350, '127.0.0.1', 'GET', '/user', '{}', 200, 27.029037475585938, '2025-12-29 01:35:40.864675', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1351, '127.0.0.1', 'GET', '/log', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 31.675100326538086, '2025-12-29 01:35:40.867268', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1352, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 14.031648635864258, '2025-12-29 01:35:54.344116', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1353, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 18.73779296875, '2025-12-29 01:35:54.351738', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1354, '127.0.0.1', 'GET', '/department', '{}', 200, 42.96445846557617, '2025-12-29 01:35:54.374699', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1355, '127.0.0.1', 'GET', '/department', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 12.474536895751953, '2025-12-29 01:35:58.381492', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1356, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 13.927936553955078, '2025-12-29 01:36:49.213883', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1357, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 24.860143661499023, '2025-12-29 01:36:49.229967', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1358, '127.0.0.1', 'GET', '/department', '{}', 200, 30.354022979736328, '2025-12-29 01:36:49.231874', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1359, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 847.3465442657471, '2025-12-30 00:57:30.853939', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1360, '127.0.0.1', 'GET', '/user/get_user_info', '{\"token\": \"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNzY3NjYxMDUwLCJlbWFpbCI6InlsZjg3MDhAMTI2LmNvbSIsIm9yaWdfaWF0IjoxNzY3MDU2MjUwfQ.X8iekRgRbiGBFeexwUete6I9VkBukMifgVSj-dqnrjo\"}', 200, 20.71976661682129, '2025-12-30 00:57:30.913181', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1361, '127.0.0.1', 'GET', '/user', '{\"username\": \"admin\"}', 200, 34.366607666015625, '2025-12-30 00:57:30.958576', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1362, '127.0.0.1', 'GET', '/auto/', '{\"status\": \"1\", \"page\": \"1\", \"page_size\": \"5\"}', 200, 26.65543556213379, '2025-12-30 00:57:44.669889', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1363, '127.0.0.1', 'GET', '/department', '{}', 200, 19.005537033081055, '2025-12-30 00:57:49.740996', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1364, '127.0.0.1', 'GET', '/user', '{\"page\": \"1\", \"page_size\": \"5\"}', 200, 24.48725700378418, '2025-12-30 00:57:49.744948', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1365, '127.0.0.1', 'GET', '/role', '{\"page\": \"1\", \"size\": \"1000\"}', 200, 44.99626159667969, '2025-12-30 00:57:49.767531', 'INFO', NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (1366, '127.0.0.1', 'GET', '/user', '{}', 200, 0.39505958557128906, '2025-12-30 00:59:14.698605', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1367, '127.0.0.1', 'GET', '/user', '{}', 200, 0.21648406982421875, '2025-12-30 00:59:17.955426', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1368, '127.0.0.1', 'GET', '/user/gen_token', '{}', 405, 3.438234329223633, '2025-12-30 01:00:00.630302', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1369, '127.0.0.1', 'GET', '/user/gen_token', '{}', 405, 2.3987293243408203, '2025-12-30 01:00:10.587744', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1370, '127.0.0.1', 'GET', '/user/gen_token', '{}', 405, 2.183675765991211, '2025-12-30 01:01:34.039403', 'INFO', NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (1371, '127.0.0.1', 'POST', '/user/gen_token', '', 500, 0.7660388946533203, '2025-12-30 01:01:45.235737', 'ERROR', 'Expecting value: line 1 column 1 (char 0)', 'Traceback (most recent call last):\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\core\\handlers\\base.py\", line 197, in _get_response\n    response = wrapped_callback(request, *callback_args, **callback_kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\generic\\base.py\", line 105, in view\n    return self.dispatch(request, *args, **kwargs)\n           ~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^\n  File \"D:\\PythonProjects\\UniDjango\\.venv\\Lib\\site-packages\\django\\views\\generic\\base.py\", line 144, in dispatch\n    return handler(request, *args, **kwargs)\n  File \"D:\\PythonProjects\\UniDjango\\UniDjango\\user\\views.py\", line 44, in post\n    data = json.loads(request.body)\n  File \"C:\\Users\\ylf\\AppData\\Local\\Programs\\Python\\Python313\\Lib\\json\\__init__.py\", line 346, in loads\n    return _default_decoder.decode(s)\n           ~~~~~~~~~~~~~~~~~~~~~~~^^^\n  File \"C:\\Users\\ylf\\AppData\\Local\\Programs\\Python\\Python313\\Lib\\json\\decoder.py\", line 345, in decode\n    obj, end = self.raw_decode(s, idx=_w(s, 0).end())\n               ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^\n  File \"C:\\Users\\ylf\\AppData\\Local\\Programs\\Python\\Python313\\Lib\\json\\decoder.py\", line 363, in raw_decode\n    raise JSONDecodeError(\"Expecting value\", s, err.value) from None\njson.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)\n', NULL);
INSERT INTO `sys_log` VALUES (1372, '127.0.0.1', 'POST', '/user/gen_token', '{\"username\": \"admin\", \"password\": \"******\"}', 200, 764.2767429351807, '2025-12-30 01:04:44.232901', 'INFO', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `parent_id` int NULL DEFAULT NULL,
  `order_num` int NULL DEFAULT NULL,
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `component` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `menu_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_time` date NULL DEFAULT NULL,
  `update_time` date NULL DEFAULT NULL,
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 'el-icon-setting', 0, 0, '/system', '/system/index.vue', 'M', 'system:*:*', '2023-10-01', '2023-10-01', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '业务管理', 'el-icon-phone', 0, 1, '/bu', '/bu/index.vue', 'M', 'bu:*:*', '2023-10-01', '2023-10-01', '业务管理目录');
INSERT INTO `sys_menu` VALUES (3, '用户管理', 'el-icon-user', 1, 1, '/system/user', '/user/index.vue', 'C', 'system:user:manage', '2023-10-01', '2023-10-01', '系统管理-用户管理');
INSERT INTO `sys_menu` VALUES (4, '角色管理', 'el-icon-s-custom', 1, 3, '/system/role', '/role/index.vue', 'C', 'system:role:manage', '2023-10-01', '2023-10-01', '系统管理-角色管理');
INSERT INTO `sys_menu` VALUES (5, '菜单管理', 'el-icon-menu', 1, 4, '/system/menu', '/menu/index.vue', 'C', 'system:menu:manage', '2023-10-01', '2023-10-01', '系统管理-菜单管理');
INSERT INTO `sys_menu` VALUES (6, '部门管理', 'el-icon-s-grid', 1, 2, '/system/department', '/department/index.vue', 'C', 'monitor:department:manage', '2023-10-01', '2023-10-01', '业务管理-部门管理');
INSERT INTO `sys_menu` VALUES (7, '岗位管理哈哈1', 'el-icon-s-platform', 2, 1, '/bu/position', '/bu/position/index.vue', 'C', 'monitor:position:manage', '2023-10-01', '2023-10-01', '业务管理-岗位管理');
INSERT INTO `sys_menu` VALUES (8, '代码生成', 'el-icon-s-platform', 1, 5, '/system/generator', '/generator/index.vue', 'C', 'system:generator:manage', '2025-09-09', '2025-09-10', '系统管理-代码生成');
INSERT INTO `sys_menu` VALUES (9, '测试管理', 'el-icon-s-grid', 1, 6, '/system/auto', '/auto/index.vue', 'C', 'system:auto:manage', '2025-09-10', '2025-09-09', '系统管理-测试');
INSERT INTO `sys_menu` VALUES (25, '用户新增', 'el-icon-mouse', 3, 0, NULL, NULL, 'F', 'system:user:add', NULL, NULL, '用户新增');
INSERT INTO `sys_menu` VALUES (26, '用户删除', 'el-icon-mouse', 3, 1, NULL, NULL, 'F', 'system:user:delete', NULL, NULL, '用户删除');
INSERT INTO `sys_menu` VALUES (27, '用户更新', 'el-icon-mouse', 3, 2, NULL, NULL, 'F', 'system:user:update', NULL, NULL, '用户更新');
INSERT INTO `sys_menu` VALUES (28, '用户批量删除', 'el-icon-mouse', 3, 3, NULL, NULL, 'F', 'system:user:deleteall', NULL, NULL, '批量删除');
INSERT INTO `sys_menu` VALUES (29, '测试新增', 'el-icon-mouse', 9, 0, NULL, NULL, 'F', 'system:test:add', NULL, NULL, '测试新增');
INSERT INTO `sys_menu` VALUES (30, '测试全删', 'el-icon-mouse', 9, 1, NULL, NULL, 'F', 'system:test:deleteall', NULL, NULL, '测试全删');
INSERT INTO `sys_menu` VALUES (31, '部门新增', 'el-icon-mouse', 6, 0, NULL, NULL, 'F', 'system:department:add', NULL, NULL, '部门新增');
INSERT INTO `sys_menu` VALUES (32, '部门删除', 'el-icon-mouse', 6, 1, NULL, NULL, 'F', 'system:department:delete', NULL, NULL, '部门删除');
INSERT INTO `sys_menu` VALUES (33, '部门更新', 'el-icon-mouse', 6, 2, NULL, NULL, 'F', 'system:department:update', NULL, NULL, '部门更新');
INSERT INTO `sys_menu` VALUES (34, '部门批量删除', 'el-icon-mouse', 6, 3, NULL, NULL, 'F', 'system:department:deleteall', NULL, NULL, '部门批量删除');
INSERT INTO `sys_menu` VALUES (35, '部门导出', 'el-icon-mouse', 6, 4, NULL, NULL, 'F', 'system:department:export', NULL, NULL, '部门导出');
INSERT INTO `sys_menu` VALUES (36, '角色新增', 'el-icon-mouse', 4, 0, NULL, NULL, 'F', 'system:role:add', NULL, NULL, '角色新增');
INSERT INTO `sys_menu` VALUES (37, '角色删除', 'el-icon-mouse', 4, 1, NULL, NULL, 'F', 'system:role:delete', NULL, NULL, '角色删除');
INSERT INTO `sys_menu` VALUES (38, '角色编辑', 'el-icon-mouse', 4, 2, NULL, NULL, 'F', 'system:role:edit', NULL, NULL, '角色编辑');
INSERT INTO `sys_menu` VALUES (39, '角色批量删除', 'el-icon-mouse', 4, 3, NULL, NULL, 'F', 'system:role:deleteall', NULL, NULL, '角色批量删除');
INSERT INTO `sys_menu` VALUES (40, '角色导出', 'el-icon-mouse', 4, 4, NULL, NULL, 'F', 'system:role:export', NULL, NULL, '角色导出');
INSERT INTO `sys_menu` VALUES (41, '权限分配', 'el-icon-mouse', 4, 5, NULL, NULL, 'F', 'system:role:permission', NULL, NULL, '权限分配');
INSERT INTO `sys_menu` VALUES (42, '新增菜单', 'el-icon-mouse', 5, 0, NULL, NULL, 'F', 'system:menu:add', NULL, NULL, '新增菜单');
INSERT INTO `sys_menu` VALUES (43, '菜单编辑', 'el-icon-mouse', 5, 1, NULL, NULL, 'F', 'system:menu:edit', NULL, NULL, '菜单编辑');
INSERT INTO `sys_menu` VALUES (44, '菜单删除', 'el-icon-mouse', 5, 2, NULL, NULL, 'F', 'system:menu:delete', NULL, NULL, '菜单删除');
INSERT INTO `sys_menu` VALUES (45, '日志管理', 'el-icon-document', 1, 7, '/system/log', '/log/index.vue', 'C', 'system:log:manage', NULL, NULL, '系统管理-日志管理');
INSERT INTO `sys_menu` VALUES (47, '日志导出', 'el-icon-mouse', 45, 0, NULL, NULL, 'F', 'system:log:export', NULL, NULL, '日志导出');
INSERT INTO `sys_menu` VALUES (48, '查看详情', 'el-icon-mouse', 45, 1, NULL, NULL, 'F', 'system:log:detail', NULL, NULL, '查看详情');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_time` date NULL DEFAULT NULL,
  `update_time` date NULL DEFAULT NULL,
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, 'super_admin', '10000', '2023-10-01', '2023-10-01', '系统管理员');
INSERT INTO `sys_role` VALUES (2, 'admin', '10001', '2023-10-01', '2023-10-01', '普通管理员');
INSERT INTO `sys_role` VALUES (3, 'user', '10002', '2023-10-01', '2023-10-01', '普通用户');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `menu_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_role_menu_menu_id_5c7ca896_fk_sys_menu_id`(`menu_id` ASC) USING BTREE,
  INDEX `sys_role_menu_role_id_e0dcb43b_fk_sys_role_id`(`role_id` ASC) USING BTREE,
  CONSTRAINT `sys_role_menu_menu_id_5c7ca896_fk_sys_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sys_role_menu_role_id_e0dcb43b_fk_sys_role_id` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 527 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (265, 9, 3);
INSERT INTO `sys_role_menu` VALUES (266, 29, 3);
INSERT INTO `sys_role_menu` VALUES (267, 30, 3);
INSERT INTO `sys_role_menu` VALUES (268, 2, 3);
INSERT INTO `sys_role_menu` VALUES (269, 7, 3);
INSERT INTO `sys_role_menu` VALUES (270, 1, 3);
INSERT INTO `sys_role_menu` VALUES (452, 3, 2);
INSERT INTO `sys_role_menu` VALUES (453, 25, 2);
INSERT INTO `sys_role_menu` VALUES (454, 26, 2);
INSERT INTO `sys_role_menu` VALUES (455, 27, 2);
INSERT INTO `sys_role_menu` VALUES (456, 28, 2);
INSERT INTO `sys_role_menu` VALUES (457, 35, 2);
INSERT INTO `sys_role_menu` VALUES (458, 9, 2);
INSERT INTO `sys_role_menu` VALUES (459, 29, 2);
INSERT INTO `sys_role_menu` VALUES (460, 30, 2);
INSERT INTO `sys_role_menu` VALUES (461, 2, 2);
INSERT INTO `sys_role_menu` VALUES (462, 7, 2);
INSERT INTO `sys_role_menu` VALUES (463, 1, 2);
INSERT INTO `sys_role_menu` VALUES (464, 6, 2);
INSERT INTO `sys_role_menu` VALUES (495, 1, 1);
INSERT INTO `sys_role_menu` VALUES (496, 3, 1);
INSERT INTO `sys_role_menu` VALUES (497, 25, 1);
INSERT INTO `sys_role_menu` VALUES (498, 26, 1);
INSERT INTO `sys_role_menu` VALUES (499, 27, 1);
INSERT INTO `sys_role_menu` VALUES (500, 28, 1);
INSERT INTO `sys_role_menu` VALUES (501, 6, 1);
INSERT INTO `sys_role_menu` VALUES (502, 31, 1);
INSERT INTO `sys_role_menu` VALUES (503, 32, 1);
INSERT INTO `sys_role_menu` VALUES (504, 33, 1);
INSERT INTO `sys_role_menu` VALUES (505, 34, 1);
INSERT INTO `sys_role_menu` VALUES (506, 35, 1);
INSERT INTO `sys_role_menu` VALUES (507, 4, 1);
INSERT INTO `sys_role_menu` VALUES (508, 36, 1);
INSERT INTO `sys_role_menu` VALUES (509, 37, 1);
INSERT INTO `sys_role_menu` VALUES (510, 38, 1);
INSERT INTO `sys_role_menu` VALUES (511, 39, 1);
INSERT INTO `sys_role_menu` VALUES (512, 40, 1);
INSERT INTO `sys_role_menu` VALUES (513, 41, 1);
INSERT INTO `sys_role_menu` VALUES (514, 5, 1);
INSERT INTO `sys_role_menu` VALUES (515, 42, 1);
INSERT INTO `sys_role_menu` VALUES (516, 43, 1);
INSERT INTO `sys_role_menu` VALUES (517, 44, 1);
INSERT INTO `sys_role_menu` VALUES (518, 8, 1);
INSERT INTO `sys_role_menu` VALUES (519, 9, 1);
INSERT INTO `sys_role_menu` VALUES (520, 29, 1);
INSERT INTO `sys_role_menu` VALUES (521, 30, 1);
INSERT INTO `sys_role_menu` VALUES (522, 45, 1);
INSERT INTO `sys_role_menu` VALUES (523, 47, 1);
INSERT INTO `sys_role_menu` VALUES (524, 48, 1);
INSERT INTO `sys_role_menu` VALUES (525, 2, 1);
INSERT INTO `sys_role_menu` VALUES (526, 7, 1);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `login_date` date NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL,
  `create_time` date NULL DEFAULT NULL,
  `update_time` date NULL DEFAULT NULL,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `department_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE,
  INDEX `sys_user_department_id_32761663_fk_sys_department_id`(`department_id` ASC) USING BTREE,
  CONSTRAINT `sys_user_department_id_32761663_fk_sys_department_id` FOREIGN KEY (`department_id`) REFERENCES `sys_department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (2, 'admin', 'pbkdf2_sha256$1000000$61Lsiivf3W0wPudXHcJBAs$tYsvXp+TJEQM8o1WG+1LXS5gfxvjhGxSNqzdd9AthkE=', 'uploads/2025/12/26/28f3ccceb78e423a808a9f4dbe613e6b.png', 'ylf8708@126.com', '18806537016', '2015-08-11', 1, '2025-08-14', '2025-08-05', '超级管理员', 3);
INSERT INTO `sys_user` VALUES (3, 'ylf', 'pbkdf2_sha256$1000000$n60o4LPA3xxpZalmXoVdjU$hWICGowczkmwveE4MnM5vbK6jF+D1eiQaWGYAIYiNM0=', 'uploads/2025/12/26/74edcf4a3c224c21ad4419ee45082b89.jpg', 'ylf87908@126.com', '18803885922', '2025-08-05', 1, '2025-08-14', '2025-08-19', '一级管理', 2);
INSERT INTO `sys_user` VALUES (17, 'hxf', 'pbkdf2_sha256$1000000$k2Cas4LgX6nSGMpXb9BE3Z$xTKgo7qeiyTYZi42L0tAEshe7foVOYuzXpRQcV2Acy0=', 'uploads/2025/12/26/f7f60847d4ee4108a7e096929a139cde.png', 'hxf@126.com', '823940897', '2025-12-17', 1, '2025-12-17', '2025-12-15', '普通用户', 3);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_user_role_role_id_63624973_fk_sys_role_id`(`role_id` ASC) USING BTREE,
  INDEX `sys_user_role_user_id_5f2fb964_fk_sys_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `sys_user_role_role_id_63624973_fk_sys_role_id` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sys_user_role_user_id_5f2fb964_fk_sys_user_id` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (34, 3, 17);
INSERT INTO `sys_user_role` VALUES (36, 3, 3);
INSERT INTO `sys_user_role` VALUES (40, 1, 2);

SET FOREIGN_KEY_CHECKS = 1;
