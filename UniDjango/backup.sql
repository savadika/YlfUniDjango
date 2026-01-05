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
