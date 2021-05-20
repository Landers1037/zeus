#!/usr/bin/env bash
echo '
zeus使用帮助
(zeus是一个服务注册监听管理程序 帮助你管理服务注册模板)
使用方式：zeus [cmd] [app]
支持命令:
help     显示帮助信息
config   显示配置环境变量
register 注册程序为服务
delete   卸载服务
manage   管理注册在zeus的服务
show     显示注册在zeus的服务
template 显示注册服务模板
edit     编辑模板和环境变量

快捷命令：
run      监听服务
config   查看配置
start    启动服务
stop     停止服务
status   查看状态
show     查看服务
log      查看日志
update   更新服务
rm       删除服务
rmlog    清除日志
backup   备份服务
export   导出服务配置
'