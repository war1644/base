# 基础镜像（alpine linux)
FROM alpine:3.10
LABEL author=ahmerry@qq.com

ENV OS_VER 3.10
ENV TIMEZONE Asia/Shanghai

# 一些工作目录准备
RUN mkdir -p /my/project && \
    # 修改镜像源为国内 ustc.edu.cn(中科大)/aliyun.com(阿里云)
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    # 更新索引，系统和修改时区以及一些扩展
    apk update && apk upgrade && apk add --no-cache tzdata bash && \
    # -X获取指定仓库的包
    #apk add --no-cache -X http://mirrors.aliyun.com/alpine/edge/community neofetch && \
    #apk add --no-cache -X http://mirrors.aliyun.com/alpine/edge/testing filebeat && \
    # 配置ll alias 命令
    echo "alias ll='ls -l --color=tty'" >> /etc/profile && \
    echo "source /etc/profile " >> ~/.bashrc && \
    # 配置时区
    cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    # 创建www用户组 alpine中 -D:不创建密码
    adduser -D www www

CMD ["bash"]
