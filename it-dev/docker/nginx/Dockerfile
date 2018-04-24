FROM daocloud.io/library/nginx:latest

MAINTAINER Zachary Wang <291768903@qq.com>

# 设置阿里云镜像加速
RUN sed -i "s/archive.ubuntu./mirrors.aliyun./g" /etc/apt/sources.list 
RUN sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list 

# 更改时区到中国
RUN echo 'Asia/Shanghai' > /etc/timezone

# 更新系统依赖
RUN apt-get update