# Sử dụng Tomcat image chính thức
FROM tomcat:9.0-jdk17

# Xóa ứng dụng mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy file WAR của bạn vào thư mục webapps (giả sử file .war là classroommanagement.war)
COPY target/classroommanagement-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Tomcat tự động deploy ROOT.war thành webapp
EXPOSE 8080

CMD ["catalina.sh", "run"]
