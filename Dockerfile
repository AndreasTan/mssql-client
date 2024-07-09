FROM quay.io/centos/centos:stream9
MAINTAINER Andreas Tan

RUN  rpm --import https://packages.microsoft.com/keys/microsoft.asc && curl -o /etc/yum.repos.d/mssql-release.repo https://packages.microsoft.com/config/rhel/7/prod.repo && ACCEPT_EULA=Y yum install -y msodbcsql mssql-tools unixODBC-devel && yum clean all -y

ADD ./init.sh ./
ADD ./uid_entrypoint.sh ./
RUN chown 1001:0 *.sh && chmod +wx *.sh

RUN chmod g=u /etc/passwd
ENV PATH $PATH:/opt/mssql-tools/bin

USER 1001
EXPOSE 8080
ENTRYPOINT [ "./uid_entrypoint.sh" ]
CMD ["./init.sh"]
