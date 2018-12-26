# 基础镜像（alpine linux)
FROM alpine:edge
LABEL author=ahmerry@qq.com

ENV TIMEZONE Asia/Shanghai

# 一些工作目录准备
RUN mkdir -p /var/www/html && \
    mkdir -p /var/lib/nginx && \
    mkdir -p /my/web && \
    # 修改镜像源为国内ustc.edu.cn(中科大)/aliyun.com(阿里云)
    # main官方仓库，community社区仓库
    echo http://mirrors.aliyun.com/alpine/edge/main > /etc/apk/repositories && \
    echo http://mirrors.aliyun.com/alpine/edge/community >> /etc/apk/repositories && \
    # 更新系统和修改时区以及一些扩展 busybox-extras libc6-compat openssh git shadow
    apk update && apk upgrade -a && apk add --no-cache tzdata curl wget bash vim && \
    # -X获取指定仓库的包
    #apk add --no-cache -X http://mirrors.aliyun.com/alpine/edge/community neofetch && \
    #apk add --no-cache -X http://mirrors.aliyun.com/alpine/edge/testing filebeat && \
    # 配置ll alias 命令
    echo "alias ll='ls -l --color=tty'" >> /etc/profile && \
    echo "source /etc/profile " >> ~/.bashrc && \
    # 配置时区
    cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone
    # 创建www用户组 alpine中 -D:不创建密码
    #adduser -D www www && \

CMD ["bash"]
