# استخدام صورة Ubuntu 22.04 خفيفة ومستقرة
FROM ubuntu:22.04

# معلومات الصورة
LABEL org.opencontainers.image.source="https://github.com/ayoub55555555/-telegram-ai-agent"
LABEL org.opencontainers.image.description="Custom VPS Docker Image with SSH and Persistence"

# منع التفاعل أثناء التثبيت
ENV DEBIAN_FRONTEND=noninteractive

# تثبيت الحزم الأساسية وتنظيف الكاش لتقليل الحجم
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    curl \
    nano \
    wget \
    git \
    net-tools \
    iputils-ping \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# إعداد مجلد تشغيل SSH
RUN mkdir /var/run/sshd

# تعيين كلمة مرور قوية لـ Root (ManusVPS2026!)
RUN echo 'root:ManusVPS2026!' | chpasswd

# تعديل إعدادات SSH للسماح بدخول Root وتفعيل المصادقة بكلمة المرور
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

# فتح المنفذ 22 لـ SSH
EXPOSE 22

# تشغيل SSH في الواجهة الأمامية
CMD ["/usr/sbin/sshd", "-D"]
