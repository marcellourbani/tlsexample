FROM rockylinux:9

ARG SAPCC_VERSION=2.19.0.2
ARG SAPJVM_VERSION=8.1.109
ARG SAPCC_VERSION_F=2.19.0

RUN dnf -y install which unzip wget net-tools less sysstat procps-ng; dnf clean all

WORKDIR /tmp/sapdownloads

# Automated download auto-accepts SAP's EULA via the eula_3_2_agreed cookie.
# Using this Dockerfile as-is accepts that EULA on your behalf.
RUN <<EOF
wget --no-check-certificate --no-cookies --header "Cookie: eula_3_2_agreed=tools.hana.ondemand.com/developer-license-3_2.txt; path=/;" -S https://tools.hana.ondemand.com/additional/sapcc-$SAPCC_VERSION-linux-x64.zip
wget --no-check-certificate --no-cookies --header "Cookie: eula_3_2_agreed=tools.hana.ondemand.com/developer-license-3_2.txt; path=/;" -S https://tools.hana.ondemand.com/additional/sapjvm-$SAPJVM_VERSION-linux-x64.rpm
unzip sapcc-$SAPCC_VERSION-linux-x64.zip
rpm -i sapjvm-$SAPJVM_VERSION-linux-x64.rpm 
rpm -i com.sap.scc-ui-${SAPCC_VERSION_F}*.x86_64.rpm
EOF
ENV JAVA_HOME=/opt/sapjvm_8/

EXPOSE 8443
USER sccadmin
WORKDIR /opt/sap/scc

VOLUME /opt/sap/scc/config
VOLUME /opt/sap/scc/scc_config
VOLUME /opt/sap/scc/log

ENTRYPOINT [ "./go.sh" ]
