FROM centos

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum install -y wget 
RUN mkdir /opt/tomcat
WORKDIR /opt/tomcat 
ENV PATH /opt/tomcat/bin:$PATH
ENV JAVA_OPTS "-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -Xmx24g -Xms24g -Xverify:none -Djava.awt.headless=true -Dfile.encoding=UTF-8 -XX:+UseCompressedOops -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSClassUnloadingEnabled -XX:+CMSParallelRemarkEnabled -XX:+CMSCompactWhenClearAllSoftRefs -XX:CMSInitiatingOccupancyFraction=85 -XX:+CMSScavengeBeforeRemark -XX:+CMSConcurrentMTEnabled -XX:ParallelCMSThreads=28 -XX:+DisableExplicitGC -XX:MaxHeapFreeRatio=70 -XX:MinHeapFreeRatio=40 -XX:MaxTenuringThreshold=2 -XX:NewSize=12g -XX:MaxNewSize=12g -XX:SurvivorRatio=4 -XX:TargetSurvivorRatio=85 -XX:InitialCodeCacheSize=1g -XX:ReservedCodeCacheSize=2g -XX:ParallelGCThreads=28 -XX:ConcGCThreads=7"
RUN wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.85/bin/apache-tomcat-8.5.85.tar.gz 
RUN tar xvzf apache-tomcat-8.5.85.tar.gz
RUN mv apache-tomcat-8.5.85/* /opt/tomcat
RUN yum install -y java
EXPOSE 8080
RUN echo "Hello from Volume" > test
COPY simple-war /opt/tomcat/webapps
VOLUME /var/lib/docker/volumes/vol1/_data /opt/
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
