<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"
        import="com.oreilly.servlet.*
                , com.oreilly.servlet.multipart.DefaultFileRenamePolicy
                , java.io.*
                , java.net.InetAddress" %>
<%
String uploadPath = "211.115.111.229".equals( InetAddress.getLocalHost().getHostAddress() ) ? "/home/user/escteam/webapps/ROOT/upload" : "c:\\upload";
MultipartRequest mRequest = new MultipartRequest( request, uploadPath
        , 1024 * 1024 * 10, "UTF-8", new DefaultFileRenamePolicy() );
%>