<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"
        import="java.sql.*"
%>
<%
Connection conn = null;
PreparedStatement pstm = null;
ResultSet rs = null;

try
{
    String url = "jdbc:mysql://localhost:3306/escteam"
            , id = "escteam"
            , pw = "!chulho00";

    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(url,id,pw);
}
catch( Exception e )
{
    e.printStackTrace();
}
%>