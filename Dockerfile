# استخدام صورة Ubuntu 22.04 خفيفة
FROM ubuntu:22.04

# منع التفاعل أثناء التثبيت
ENV DEBIAN_FRONTEND=noninteractive

# تثبيت الحزم الأساسية وتنظيف الكاش لتقليل الحجم
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    curl \
    nano \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# إعداد مجلد تشغيل SSH
RUN mkdir /var/run/sshd

# تعيين كلمة مرور قوية لـ Root (سيتمكن المستخدم من تغييرها لاحقاً)
RUN echo 'root:ManusVPS2026!' | chpasswd

# تعديل إعدادات SSH للسماح بدخول Root
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

# فتح المنفذ 22
EXPOSE 22

# تشغيل SSH في الواجهة الأمامية لضمان استمرار الحاوية
CMD ["/usr/sbin/sshd", "-D"]
