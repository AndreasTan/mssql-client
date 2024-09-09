FROM quay.io/centos/centos:stream9
MAINTAINER Andreas Tan
RUN curl https://packages.microsoft.com/config/rhel/9/prod.repo -o /etc/yum.repos.d/msprod.repo 
RUN yum search odbc
RUN yum search msodbcsql18
ENV ACCEPT_EULA=Y
RUN yum install -y unixODBC unixODBC-devel
RUN yum install -y msodbcsql18
RUN yum install -y iputils
RUN yum install -y iproute
RUN yum install -y net-tools
RUN yum install -y bind-utils
RUN yum install -y traceroute
RUN yum install -y libcurl-minimal
RUN yum install -y telnet
RUN yum install -y nfs-utils
RUN yum install -y iperf3
RUN yum install -y fio
RUN yum install -y mssql-tools && yum clean all -y
RUN mkdir -p /mnt/test
ADD ./init.sh ./
ADD ./uid_entrypoint.sh ./
RUN chown 1001:0 *.sh && chmod +wx *.sh

RUN chmod g=u /etc/passwd
ENV PATH $PATH:/opt/mssql-tools/bin

USER 1001
EXPOSE 8080
ENTRYPOINT [ "./uid_entrypoint.sh" ]
CMD ["./init.sh"]
