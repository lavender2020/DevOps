FROM ubuntu:latest

# 创建者信息
MAINTAINER lavender "gengxd@foxmail.com"

# 设置环境变量，所有操作都是非交互式的
ENV DEBIAN_FRONTEND noninteractive

# 更改系统的时区设置
RUN echo "Asia/Shanghai" > /etc/timezone && \
    apt-get update -y && apt-get upgrade -y && \
    apt-get install -y supervisor ssh openjdk-8-jdk wget && \
    mkdir -p /var/log/supervisor /var/log/tomcat /tomcat /run/sshd && \
    wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.16/bin/apache-tomcat-8.5.16.tar.gz && \
    tar -zxvf apache-tomcat-8.5.16.tar.gz && mv apache-tomcat-8.5.16/* /tomcat/ && rm -rf apache-tomcat-8.5.16.tar.gz
RUN mkdir -p /root/.ssh/ && chmod 700 /root/.ssh && echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDATHJ3xOYEge9Iuka+npVJ7zfx/CqGh2bEMGIene0C6s21Wao6G4voyYoOP/qgh4+cyMgG54uYC6hxCKcIjNzagAMmFcQ7kG8Se/2+4PaD/aiNKPWxBzwAfNdzkyzHw7evlFaSIu0CxwGNm3AJ1iHDGjGCqTqW+CxqsnrpMjkjq6e6rmRaxFgvkTA/FvsmC+UuY+YqjWfmv1//4MV0VZoBS+2pBaVV/RWQTj8KRd9AiMHrF3o7RylCwX+rcZL0QIJ4S+f7UsJ8zyK5KQnt6RGXsUlDUqq3uDP5fCLIGoNH15+Hy1J4Q6KQbi9ZgJlHmKpO/mkqFVFG5sfCA79xmi6f lavender.geng@lavenders-MacBook-Pro.local" > /root/.ssh/authorized_keys && \
chmod 600 /root/.ssh/authorized_keys

# 添加supervisor管理进程
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY ssh.conf /etc/supervisor/conf.d/
COPY tomcat.conf /etc/supervisor/conf.d/

# 设置tomcat的环境变量
ENV CATALINA_HOME /tomcat

# 定义容器卷信息
VOLUME ["/tomcat/logs", "/tomcat/webapps", "/var/log/tomcat"]

# 暴露tomcat接口，默认为8080
EXPOSE 8080 22 9001

# 设置自启动命令
CMD ["/usr/bin/supervisord"]
