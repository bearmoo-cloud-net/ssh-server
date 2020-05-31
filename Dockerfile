FROM centos

#Install sshd
RUN yum install -y openssh-clients openssh-server 

# Adjust sshd pam file to allow login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

COPY build/run.sh /bin/
RUN chmod a+x /bin/run.sh

CMD sh /bin/run.sh && /usr/sbin/sshd -D
