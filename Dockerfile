FROM quay.io/centos/centos:stream9
MAINTAINER Andreas Tan
RUN curl https://packages.microsoft.com/config/rhel/9/prod.repo -o /etc/yum.repos.d/msprod.repo 
RUN yum search odbc
RUN yum search msodbcsql17
ENV ACCEPT_EULA=Y
RUN yum install -y unixODBC unixODBC-devel
RUN yum install -y msodbcsql17
RUN yum install -y iputils
RUN yum install -y bind-utils
RUN yum install -y traceroute
RUN yum install -y curl
RUN yum install -y mssql-tools && yum clean all -y
ADD ./init.sh ./
ADD ./uid_entrypoint.sh ./
RUN chown 1001:0 *.sh && chmod +wx *.sh

RUN chmod g=u /etc/passwd
ENV PATH $PATH:/opt/mssql-tools/bin

USER 1001
EXPOSE 8080
ENTRYPOINT [ "./uid_entrypoint.sh" ]
CMD ["./init.sh"]
