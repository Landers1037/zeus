# 注册原理
使用linux服务注册的方式 注册服务到linux
根据服务中定义的功能脚本 进行管理

**但是此功能一般不会生效 除非指定变量ZEUS_USE_SYSTEMD**
在一般情况下zeus还是会使用自带的服务管理工具函数

即根据regsiter下注册的服务遍历
取出app_path 即真实的应用路径一般为${ZEUS_APP_ROOT}

## 脚本维护
zeus会自主的维护一个shell脚本库用于存储app的管理脚本
包含了启动 停止 重启 状态 日志 日志分割 备份

## 通用的app信息将保存到app_info中
按行分割 读取应用的信息

## 无法找到应用
在无法找到输入的应用时 会返回错误

## server轮询
register下的每个目录即为一个微服务
注意： 前端和后端分别属于一个服务

服务命名规范：小写字母+下划线的方式
前端应用统一为xx_frontend

因为前端服务无法被单独管理 因为统一属于nginx服务
所以停止前端服务就代表关闭nginx服务