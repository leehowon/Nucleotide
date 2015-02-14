<%@ page language="java" contentType="application/octet-stream; charset=utf-8" pageEncoding="UTF-8" %><%
String fileName = "sequence.txt";

response.setHeader( "Content-Disposition", "attatchment; filename = " + fileName );


out.println( "석류\t맛있어" );
%>