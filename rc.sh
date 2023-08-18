#!/bin/bash

cat <<EOF >/etc/systemd/system/rc-local.service
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target
EOF

cat <<EOF >/etc/rc.local
#!/bin/sh -e
exit 0
EOF

# 添加权限
chmod +x /etc/rc.local
# 设置到系统启动
systemctl enable rc-local
#启动脚本
systemctl start rc-local.service
#检查服务状态
systemctl status rc-local.service
