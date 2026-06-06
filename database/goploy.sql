-- Goploy Schema for SQLite
-- Auto-increment primary keys, TEXT for datetime, indexes separated

CREATE TABLE IF NOT EXISTS `project` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `namespace_id` INTEGER NOT NULL DEFAULT 0,
  `name` TEXT NOT NULL DEFAULT '',
  `repo_type` TEXT NOT NULL DEFAULT '',
  `url` TEXT NOT NULL DEFAULT '',
  `path` TEXT NOT NULL DEFAULT '',
  `symlink_path` TEXT NOT NULL DEFAULT '',
  `symlink_backup_number` INTEGER NOT NULL DEFAULT 0,
  `environment` INTEGER NOT NULL DEFAULT 0,
  `branch` TEXT NOT NULL DEFAULT 'master',
  `label` TEXT NOT NULL DEFAULT '',
  `review` INTEGER NOT NULL DEFAULT 0,
  `review_url` TEXT NOT NULL DEFAULT '',
  `script` TEXT NOT NULL,
  `transfer_type` TEXT NOT NULL DEFAULT '',
  `transfer_option` TEXT NOT NULL DEFAULT '',
  `deploy_server_mode` TEXT NOT NULL DEFAULT '',
  `auto_deploy` INTEGER NOT NULL DEFAULT 1,
  `state` INTEGER NOT NULL DEFAULT 1,
  `deploy_state` INTEGER NOT NULL DEFAULT 0,
  `publisher_id` INTEGER NOT NULL DEFAULT 0,
  `publisher_name` TEXT NOT NULL DEFAULT '',
  `last_publish_token` TEXT NOT NULL DEFAULT '',
  `notify_type` INTEGER NOT NULL DEFAULT 0,
  `notify_target` TEXT NOT NULL DEFAULT '',
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `project_file` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `project_id` INTEGER NOT NULL,
  `filename` TEXT NOT NULL DEFAULT '',
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `project_server` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `project_id` INTEGER NOT NULL DEFAULT 0,
  `server_id` INTEGER NOT NULL DEFAULT 0,
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `project_user` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `project_id` INTEGER NOT NULL DEFAULT 0,
  `user_id` INTEGER NOT NULL DEFAULT 0,
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `project_task` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `project_id` INTEGER NOT NULL DEFAULT 0,
  `commit` TEXT NOT NULL DEFAULT '',
  `branch` TEXT NOT NULL DEFAULT '',
  `date` TEXT DEFAULT NULL,
  `state` INTEGER NOT NULL DEFAULT 1,
  `is_run` INTEGER NOT NULL DEFAULT 0,
  `creator_id` INTEGER NOT NULL DEFAULT 0,
  `creator` TEXT NOT NULL DEFAULT '',
  `editor_id` INTEGER NOT NULL DEFAULT 0,
  `editor` TEXT NOT NULL DEFAULT '',
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `project_review` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `project_id` INTEGER NOT NULL DEFAULT 0,
  `commit_id` TEXT NOT NULL DEFAULT '',
  `branch` TEXT NOT NULL DEFAULT '',
  `review_url` TEXT NOT NULL DEFAULT '',
  `state` INTEGER NOT NULL DEFAULT 0,
  `creator_id` INTEGER NOT NULL DEFAULT 0,
  `creator` TEXT NOT NULL DEFAULT '',
  `editor_id` INTEGER NOT NULL DEFAULT 0,
  `editor` TEXT NOT NULL DEFAULT '',
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `project_process` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `project_id` INTEGER NOT NULL DEFAULT 0,
  `name` TEXT NOT NULL DEFAULT '',
  `start` TEXT NOT NULL DEFAULT '',
  `stop` TEXT NOT NULL DEFAULT '',
  `status` TEXT NOT NULL DEFAULT '',
  `restart` TEXT NOT NULL DEFAULT '',
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `publish_trace` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `token` TEXT NOT NULL DEFAULT '',
  `project_id` INTEGER NOT NULL DEFAULT 0,
  `project_name` TEXT NOT NULL DEFAULT '',
  `detail` TEXT NOT NULL,
  `state` INTEGER NOT NULL DEFAULT 1,
  `publisher_id` INTEGER NOT NULL DEFAULT 0,
  `publisher_name` TEXT NOT NULL DEFAULT '',
  `type` INTEGER NOT NULL DEFAULT 0,
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `ext` TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS `monitor` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `namespace_id` INTEGER NOT NULL,
  `name` TEXT NOT NULL,
  `type` INTEGER NOT NULL DEFAULT 0,
  `target` TEXT NOT NULL,
  `second` INTEGER NOT NULL DEFAULT 1,
  `times` INTEGER NOT NULL DEFAULT 1,
  `silent_cycle` INTEGER NOT NULL DEFAULT 0,
  `description` TEXT NOT NULL DEFAULT '',
  `notify_type` INTEGER NOT NULL DEFAULT 0,
  `notify_target` TEXT NOT NULL DEFAULT '',
  `state` INTEGER NOT NULL DEFAULT 1,
  `error_content` TEXT NOT NULL DEFAULT '',
  `success_server_id` INTEGER NOT NULL DEFAULT 0,
  `success_script` TEXT NOT NULL,
  `fail_server_id` INTEGER NOT NULL DEFAULT 0,
  `fail_script` TEXT NOT NULL,
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `server` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `namespace_id` INTEGER NOT NULL DEFAULT 0,
  `name` TEXT NOT NULL DEFAULT '',
  `ip` TEXT NOT NULL DEFAULT '',
  `port` INTEGER NOT NULL DEFAULT 22,
  `owner` TEXT NOT NULL DEFAULT '',
  `path` TEXT NOT NULL DEFAULT '',
  `password` TEXT NOT NULL DEFAULT '',
  `jump_ip` TEXT NOT NULL DEFAULT '',
  `jump_port` INTEGER NOT NULL DEFAULT 0,
  `jump_owner` TEXT NOT NULL DEFAULT '',
  `jump_path` TEXT NOT NULL DEFAULT '',
  `jump_password` TEXT NOT NULL DEFAULT '',
  `os` TEXT NOT NULL DEFAULT '',
  `os_info` TEXT NOT NULL DEFAULT '',
  `description` TEXT NOT NULL DEFAULT '',
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `state` INTEGER NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS `server_agent_log` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `server_id` INTEGER NOT NULL DEFAULT 0,
  `type` INTEGER NOT NULL DEFAULT 0,
  `item` TEXT NOT NULL DEFAULT '',
  `value` TEXT NOT NULL DEFAULT '',
  `report_time` TEXT NOT NULL,
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `server_monitor` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `server_id` INTEGER NOT NULL DEFAULT 0,
  `item` TEXT NOT NULL DEFAULT '',
  `formula` TEXT NOT NULL DEFAULT '',
  `operator` TEXT NOT NULL DEFAULT '',
  `value` TEXT NOT NULL DEFAULT '',
  `group_cycle` INTEGER NOT NULL DEFAULT 0,
  `last_cycle` INTEGER NOT NULL DEFAULT 0,
  `silent_cycle` INTEGER NOT NULL DEFAULT 0,
  `start_time` TEXT NOT NULL DEFAULT '',
  `end_time` TEXT NOT NULL DEFAULT '',
  `notify_type` INTEGER NOT NULL DEFAULT 0,
  `notify_target` TEXT NOT NULL DEFAULT '',
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `cron` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `server_id` INTEGER NOT NULL DEFAULT 0,
  `expression` TEXT NOT NULL DEFAULT '',
  `command` TEXT NOT NULL DEFAULT '',
  `single_mode` INTEGER NOT NULL DEFAULT 0,
  `log_level` INTEGER NOT NULL DEFAULT 0,
  `description` TEXT NOT NULL DEFAULT '',
  `creator` TEXT NOT NULL DEFAULT '',
  `editor` TEXT NOT NULL DEFAULT '',
  `state` INTEGER NOT NULL DEFAULT 1,
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `server_process` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `namespace_id` INTEGER NOT NULL,
  `name` TEXT NOT NULL DEFAULT '',
  `items` TEXT DEFAULT NULL,
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `cron_log` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `cron_id` INTEGER NOT NULL DEFAULT 0,
  `server_id` INTEGER NOT NULL DEFAULT 0,
  `exec_code` INTEGER NOT NULL DEFAULT 0,
  `message` TEXT NOT NULL,
  `report_time` TEXT NOT NULL,
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `user` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `account` TEXT NOT NULL DEFAULT '',
  `password` TEXT NOT NULL DEFAULT '',
  `password_update_time` TEXT DEFAULT NULL,
  `name` TEXT NOT NULL DEFAULT '',
  `contact` TEXT NOT NULL DEFAULT '',
  `state` INTEGER NOT NULL DEFAULT 1,
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `last_login_time` TEXT DEFAULT NULL,
  `super_manager` INTEGER NOT NULL DEFAULT 0,
  `api_key` TEXT NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS `namespace` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `name` TEXT NOT NULL DEFAULT '',
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `namespace_user` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `namespace_id` INTEGER NOT NULL,
  `user_id` INTEGER NOT NULL,
  `role_id` INTEGER NOT NULL DEFAULT 0,
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `role` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `name` TEXT NOT NULL DEFAULT '',
  `description` TEXT NOT NULL DEFAULT '',
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `permission` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `pid` INTEGER NOT NULL DEFAULT 0,
  `name` TEXT NOT NULL DEFAULT '',
  `sort` INTEGER NOT NULL DEFAULT 0,
  `description` TEXT NOT NULL DEFAULT '',
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `role_permission` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `role_id` INTEGER NOT NULL,
  `permission_id` INTEGER NOT NULL,
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `template` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `type` INTEGER NOT NULL DEFAULT 0,
  `name` TEXT NOT NULL DEFAULT '',
  `content` TEXT NOT NULL,
  `description` TEXT NOT NULL DEFAULT '',
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `system_config` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `key` TEXT NOT NULL DEFAULT '',
  `value` TEXT NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS `login_log` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `account` TEXT NOT NULL DEFAULT '',
  `remote_addr` TEXT NOT NULL DEFAULT '',
  `user_agent` TEXT NOT NULL DEFAULT '',
  `referer` TEXT NOT NULL DEFAULT '',
  `reason` TEXT NOT NULL DEFAULT '',
  `login_time` TEXT NOT NULL,
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `operation_log` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `user_id` INTEGER NOT NULL,
  `namespace_id` INTEGER NOT NULL DEFAULT 0,
  `router` TEXT NOT NULL DEFAULT '',
  `api` TEXT NOT NULL DEFAULT '',
  `request_time` TEXT DEFAULT NULL,
  `request_data` TEXT DEFAULT NULL,
  `response_time` TEXT DEFAULT NULL,
  `response_data` TEXT DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS `sftp_log` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `namespace_id` INTEGER NOT NULL DEFAULT 0,
  `user_id` INTEGER NOT NULL DEFAULT 0,
  `server_id` INTEGER NOT NULL DEFAULT 0,
  `remote_addr` TEXT NOT NULL DEFAULT '',
  `user_agent` TEXT NOT NULL DEFAULT '',
  `type` TEXT NOT NULL,
  `path` TEXT NOT NULL DEFAULT '',
  `reason` TEXT NOT NULL DEFAULT '',
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `terminal_log` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `namespace_id` INTEGER NOT NULL DEFAULT 0,
  `user_id` INTEGER NOT NULL DEFAULT 0,
  `server_id` INTEGER NOT NULL DEFAULT 0,
  `remote_addr` TEXT NOT NULL DEFAULT '',
  `user_agent` TEXT NOT NULL DEFAULT '',
  `start_time` TEXT NOT NULL,
  `end_time` TEXT NOT NULL DEFAULT '1970-01-01 00:00:00',
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS `notification_template` (
  `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `type` INTEGER NOT NULL DEFAULT 0,
  `use_by` TEXT NOT NULL DEFAULT '',
  `title` TEXT NOT NULL DEFAULT '',
  `template` TEXT NOT NULL,
  `insert_time` TEXT NOT NULL DEFAULT (datetime('now','localtime')),
  `update_time` TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

-- Indexes

CREATE UNIQUE INDEX IF NOT EXISTS `uk_project_server` ON `project_server`(`project_id`, `server_id`);
CREATE UNIQUE INDEX IF NOT EXISTS `uk_project_user` ON `project_user`(`project_id`, `user_id`);
CREATE INDEX IF NOT EXISTS `idx_project_id` ON `project_file`(`project_id`);
CREATE INDEX IF NOT EXISTS `idx_project_update` ON `project_task`(`project_id`, `update_time`);
CREATE INDEX IF NOT EXISTS `idx_project_id_pub` ON `publish_trace`(`project_id`);
CREATE INDEX IF NOT EXISTS `idx_token` ON `publish_trace`(`token`);
CREATE UNIQUE INDEX IF NOT EXISTS `uk_namespace_ip` ON `server`(`namespace_id`, `ip`);
CREATE INDEX IF NOT EXISTS `idx_server_type_item_time` ON `server_agent_log`(`server_id`, `type`, `item`, `report_time`);
CREATE INDEX IF NOT EXISTS `idx_server_item_time` ON `server_agent_log`(`server_id`, `item`, `report_time`);
CREATE INDEX IF NOT EXISTS `idx_server_item` ON `server_monitor`(`server_id`, `item`);
CREATE INDEX IF NOT EXISTS `idx_namespace` ON `server_process`(`namespace_id`);
CREATE INDEX IF NOT EXISTS `idx_cron` ON `cron_log`(`cron_id`);
CREATE INDEX IF NOT EXISTS `idx_server_cron` ON `cron_log`(`server_id`, `cron_id`);
CREATE UNIQUE INDEX IF NOT EXISTS `uk_name_ns` ON `namespace`(`name`);
CREATE UNIQUE INDEX IF NOT EXISTS `uk_namespace_user` ON `namespace_user`(`namespace_id`, `user_id`);
CREATE UNIQUE INDEX IF NOT EXISTS `uk_name_role` ON `role`(`name`);
CREATE UNIQUE INDEX IF NOT EXISTS `uk_name_perm` ON `permission`(`name`);
CREATE INDEX IF NOT EXISTS `idx_pid` ON `permission`(`pid`);
CREATE UNIQUE INDEX IF NOT EXISTS `uk_role_permission` ON `role_permission`(`role_id`, `permission_id`);
CREATE UNIQUE INDEX IF NOT EXISTS `udx_key` ON `system_config`(`key`);
CREATE INDEX IF NOT EXISTS `idx_user_namespace` ON `operation_log`(`user_id`, `namespace_id`);
CREATE INDEX IF NOT EXISTS `idx_router` ON `operation_log`(`router`);
CREATE INDEX IF NOT EXISTS `idx_api` ON `operation_log`(`api`);
CREATE INDEX IF NOT EXISTS `idx_request_time` ON `operation_log`(`request_time`);

-- Seed data

INSERT OR IGNORE INTO `user`(`id`, `account`, `password`, `name`, `contact`, `state`, `super_manager`) VALUES (1, 'admin', '$2a$10$89ZJ2xeJj35GOw11Qiucr.phaEZP4.kBX6aKTs7oWFp1xcGBBgijm', '超管', '', 1, 1);
INSERT OR IGNORE INTO `namespace`(`id`, `name`) VALUES (1, 'goploy');
INSERT OR IGNORE INTO `namespace_user`(`id`, `namespace_id`, `user_id`, `role_id`) VALUES (1, 1, 1, 0);
INSERT OR IGNORE INTO `system_config` (`id`, `key`, `value`) VALUES (1, 'version', '1.17.5');
INSERT OR IGNORE INTO `role`(`id`, `name`, `description`) VALUES (1, 'manager', '');
INSERT OR IGNORE INTO `role`(`id`, `name`, `description`) VALUES (2, 'member', '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (1, 0, 'Log', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (2, 1, 'ShowLoginLogPage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (3, 1, 'ShowPublishLogPage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (4, 1, 'ShowSFTPLogPage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (5, 1, 'ShowTerminalLogPage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (6, 1, 'ShowTerminalRecord', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (7, 0, 'Setting', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (8, 7, 'ShowMemberPage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (9, 7, 'AddMember', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (10, 7, 'EditMember', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (11, 7, 'DeleteMember', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (13, 7, 'ShowNamespacePage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (14, 7, 'AddNamespace', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (15, 7, 'EditNamespace', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (16, 7, 'AddNamespaceUser', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (17, 7, 'DeleteNamespaceUser', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (18, 7, 'ShowRolePage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (19, 7, 'AddRole', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (20, 7, 'EditRole', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (21, 7, 'DeleteRole', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (22, 7, 'EditPermission', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (23, 0, 'Server', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (24, 23, 'ShowServerPage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (25, 23, 'AddServer', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (26, 23, 'EditServer', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (27, 23, 'SwitchServerState', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (28, 23, 'InstallAgent', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (29, 23, 'ImportCSV', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (30, 23, 'ShowServerMonitorPage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (31, 23, 'AddServerWarningRule', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (32, 23, 'EditServerWarningRule', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (33, 23, 'DeleteServerWarningRule', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (34, 23, 'ShowTerminalPage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (35, 23, 'ShowSftpFilePage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (36, 23, 'SFTPUploadFile', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (37, 23, 'SFTPPreviewFile', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (38, 23, 'SFTPDownloadFile', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (39, 23, 'ShowCronPage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (40, 23, 'AddCron', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (41, 23, 'EditCron', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (42, 23, 'DeleteCron', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (43, 0, 'Project', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (44, 43, 'ShowProjectPage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (45, 43, 'GetAllProjectList', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (46, 43, 'GetBindProjectList', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (47, 43, 'AddProject', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (48, 43, 'EditProject', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (49, 43, 'DeleteProject', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (50, 43, 'SwitchProjectWebhook', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (51, 0, 'Monitor', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (52, 51, 'ShowMonitorPage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (53, 51, 'AddMonitor', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (54, 51, 'EditMonitor', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (55, 51, 'DeleteMonitor', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (56, 0, 'Deploy', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (57, 56, 'ShowDeployPage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (58, 56, 'GetAllDeployList', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (59, 56, 'GetBindDeployList', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (60, 56, 'DeployDetail', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (61, 56, 'DeployProject', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (62, 56, 'DeployResetState', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (64, 56, 'DeployRollback', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (65, 56, 'DeployReview', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (66, 56, 'DeployTask', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (67, 56, 'FileCompare', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (68, 56, 'FileSync', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (69, 56, 'ProcessManager', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (70, 23, 'ShowServerProcessPage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (71, 23, 'AddServerProcess', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (72, 23, 'EditServerProcess', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (73, 23, 'DeleteServerProcess', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (74, 1, 'ShowOperationLogPage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (75, 23, 'SFTPTransferFile', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (76, 23, 'SFTPDeleteFile', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (77, 23, 'ShowServerScriptPage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (78, 23, 'SFTPEditFile', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (79, 23, 'ShowServerNginxPage', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (80, 23, 'ManageServerNginx', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (81, 23, 'AddNginxConfig', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (82, 23, 'EditNginxConfig', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (83, 23, 'DeleteNginxConfig', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (84, 23, 'UnbindServerProject', 0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (85, 43, 'ManageRepository',  0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (86, 7, 'ShowNotificationPage',  0, '');
INSERT OR IGNORE INTO `permission`(`id`, `pid`, `name`, `sort`, `description`) VALUES (87, 7, 'EditNotification',  0, '');

INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 14);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 15);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 16);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 17);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 18);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 19);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 20);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 21);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 22);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 24);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 25);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 26);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 27);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 28);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 29);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 30);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 31);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 32);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 33);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 34);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 35);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 36);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 37);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 38);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 39);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 40);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 41);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 42);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 44);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 45);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 46);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 47);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 48);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 49);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 50);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 52);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 53);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 54);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 55);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 57);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 58);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 59);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 60);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 61);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 62);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 64);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 65);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 66);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 67);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 68);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (1, 69);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (2, 57);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (2, 59);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (2, 60);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (2, 61);
INSERT OR IGNORE INTO `role_permission`(`role_id`, `permission_id`) VALUES (2, 67);

INSERT OR IGNORE INTO `notification_template` (id, type, use_by, title, template) VALUES (1, 1, 'deploy', '{{ .Project.Name }}', 'Deploy: <font color="warning">{{ .Project.Name }}</font>
Publisher: <font color="comment">{{ .Project.PublisherName }}</font>
Author: <font color="comment">{{ .CommitInfo.Author }}</font>
{{ if ne .CommitInfo.Tag ""}}Tag: <font color="comment">{{ .CommitInfo.Tag }}</font>{{ end }}
Branch: <font color="comment">{{ .CommitInfo.Branch }}</font>
CommitSHA: <font color="comment">{{ .CommitInfo.Commit }}</font>
CommitMessage: <font color="comment">{{ .CommitInfo.Message }}</font>
ServerList:<font color="comment">
{{- range .ProjectServers}}
  {{- if ne .Server.Name .Server.IP}}
    {{- .Server.Name}}({{.Server.IP}})
  {{- else}}
    {{- .Server.IP}}
  {{- end}}
{{- end}}
</font>
{{- if eq .DeployState 2 }}
State: <font color="green">success</font>
{{- else }}
State: <font color="red">fail</font>
{{- end }}
{{- if ne .DeployDetail ""}}
Detail: <font color="comment">{{.DeployDetail}}</font>
{{- end }}');
INSERT OR IGNORE INTO `notification_template` (id, type, use_by, title, template) VALUES (2, 2, 'deploy', '{{ .Project.Name }}', '#### Deploy: {{ .Project.Name }}
#### Publisher: {{ .Project.PublisherName }}
#### Author: {{ .CommitInfo.Author }}
#### {{ if ne .CommitInfo.Tag ""}}Tag: {{ .CommitInfo.Tag }}{{ end }}
#### Branch: {{ .CommitInfo.Branch }}
#### CommitSHA: {{ .CommitInfo.Commit }}
#### CommitMessage: {{ .CommitInfo.Message }}
####  ServerList:
{{- range .ProjectServers}}
  {{- if ne .Server.Name .Server.IP}}
    {{- .Server.Name}}({{.Server.IP}})
  {{- else}}
    {{- .Server.IP}}
  {{- end}}
{{- end}}
####
{{- if eq .DeployState 2 }}State: <font color="green">success</font>
{{- else }}State: <font color="red">fail</font>
{{- end }}
{{- if ne .DeployDetail ""}}
> Detail: <font color="comment">{{.DeployDetail}}</font>
{{- end }}
');
INSERT OR IGNORE INTO `notification_template` (id, type, use_by, title, template) VALUES (3, 3, 'deploy', 'Deploy: {{ .Project.Name }}', 'Publisher: {{ .Project.PublisherName }}
Author: {{ .CommitInfo.Author }}
{{ if ne .CommitInfo.Tag "" }}Tag: {{ .CommitInfo.Tag }}{{ end }}
Branch: {{ .CommitInfo.Branch }}
CommitSHA: {{ .CommitInfo.Commit }}
CommitMessage: {{ .CommitInfo.Message }}
ServerList:
{{- range .ProjectServers}}
  {{- if ne .Server.Name .Server.IP}}
    {{- .Server.Name}}({{.Server.IP}}),
  {{- else}}
    {{- .Server.IP}},
  {{- end}}
{{- end}}
{{- if eq .DeployState 2 }}
State: success
{{- else }}
State: fail
{{- end }}
{{- if ne .DeployDetail ""}}
Detail: {{.DeployDetail }}
{{- end }}');
INSERT OR IGNORE INTO `notification_template` (id, type, use_by, title, template) VALUES (4, 1, 'monitor', '{{ .Monitor.Name }}', 'Monitor: <font color="warning">{{ .Monitor.Name }}</font>
> <font color="warning">can not access</font>
> <font color="comment">{{ .ErrorMsg }}</font>');
INSERT OR IGNORE INTO `notification_template` (id, type, use_by, title, template) VALUES (5, 2, 'monitor', '{{ .Monitor.Name }}', '#### Monitor: {{ .Monitor.Name }} can not access
{{ .ErrorMsg }}');
INSERT OR IGNORE INTO `notification_template` (id, type, use_by, title, template) VALUES (6, 3, 'monitor', '{{ .Monitor.Name }}', 'can not access
detail: {{ .ErrorMsg }}');
INSERT OR IGNORE INTO `notification_template` (id, type, use_by, title, template) VALUES (7, 1, 'server_monitor', '{{ .Server.Name }} {{ .ServerMonitor.Item }} Warning', 'Server: {{ .Server.Name }}({{ .Server.Description }})
Item: <font color="warning">{{ .ServerMonitor.Item }} warning</font>
Event: {{ .ServerMonitor.Formula }} value: {{ .CycleValue }}, {{ .ServerMonitor.Operator }} {{ .ServerMonitor.Value }}');
INSERT OR IGNORE INTO `notification_template` (id, type, use_by, title, template) VALUES (8, 2, 'server_monitor', '{{ .Server.Name }} {{ .ServerMonitor.Item }} Warning', 'Server: {{ .Server.Name }}({{ .Server.Description }})
Item: {{ .ServerMonitor.Item }} warning
Event: {{ .ServerMonitor.Formula }} value: {{ .CycleValue }}, {{ .ServerMonitor.Operator }} {{ .ServerMonitor.Value }}');
INSERT OR IGNORE INTO `notification_template` (id, type, use_by, title, template) VALUES (9, 3, 'server_monitor', '{{ .Server.Name }} {{ .ServerMonitor.Item }} Warning', 'Server: {{ .Server.Name }}({{ .Server.Description }})
Item: {{ .ServerMonitor.Item }} warning
Event: {{ .ServerMonitor.Formula }} value: {{ .CycleValue }}, {{ .ServerMonitor.Operator }} {{ .ServerMonitor.Value }}');
