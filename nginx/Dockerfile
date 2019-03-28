FROM ubuntu:latest

RUN apt-get update && apt-get install -y supervisor nginx ssh
RUN mkdir -p /var/log/supervisor /var/log/nginx /run/sshd
RUN mkdir -p /root/.ssh/ && chmod 700 /root/.ssh && echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDATHJ3xOYEge9Iuka+npVJ7zfx/CqGh2bEMGIene0C6s21Wao6G4voyYoOP/qgh4+cyMgG54uYC6hxCKcIjNzagAMmFcQ7kG8Se/2+4PaD/aiNKPWxBzwAfNdzkyzHw7evlFaSIu0CxwGNm3AJ1iHDGjGCqTqW+CxqsnrpMjkjq6e6rmRaxFgvkTA/FvsmC+UuY+YqjWfmv1//4MV0VZoBS+2pBaVV/RWQTj8KRd9AiMHrF3o7RylCwX+rcZL0QIJ4S+f7UsJ8zyK5KQnt6RGXsUlDUqq3uDP5fCLIGoNH15+Hy1J4Q6KQbi9ZgJlHmKpO/mkqFVFG5sfCA79xmi6f lavender.geng@lavenders-MacBook-Pro.local" > /root/.ssh/authorized_keys && \
chmod 600 /root/.ssh/authorized_keys && mkdir /usr/share/nginx/html/static && echo "Hello" > /usr/share/nginx/html/static/index.html

COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY nginx.conf /etc/supervisor/conf.d/
COPY ssh.conf /etc/supervisor/conf.d/
COPY nginx-default.conf /etc/nginx/sites-enabled/default

VOLUME [ "/usr/share/nginx/html", "/var/log/nginx" ]

EXPOSE 80 22 9001

CMD ["/usr/bin/supervisord"]
