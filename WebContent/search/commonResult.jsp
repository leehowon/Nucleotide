<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"
        import="com.oreilly.servlet.*
                , com.oreilly.servlet.multipart.DefaultFileRenamePolicy
                , java.io.*
                , java.net.InetAddress" %>
<%
String uploadPath = "211.115.111.229".equals( InetAddress.getLocalHost().getHostAddress() ) ? "/home/user/escteam/webapps/ROOT/upload" : "c:\\upload";
MultipartRequest mRequest = new MultipartRequest( request, uploadPath
        , 1024 * 1024 * 10, "UTF-8", new DefaultFileRenamePolicy() );
String url = "http://www.ncbi.nlm.nih.gov/blast/Blast.cgi"
       , query = mRequest.getParameter( "query" );
File queryFile = mRequest.getFile( "queryFile" );

if( query == null && "".equals(query) && queryFile == null )
{
%>
<html>
<head><script>alert( "필수 파라미터가 없습니다." );history.back(-1);</script></head>
<body></body>
</html>
<%
    return;
}

if( queryFile != null )
{
    StringBuffer sb = new StringBuffer();
    String tempStr = "";
    BufferedReader br = new BufferedReader( new InputStreamReader(new FileInputStream(queryFile), "utf-8") );
    
    while( (tempStr = br.readLine()) != null )
        sb.append( tempStr );
    
    query = sb.toString(); //업로드에 있는거 먼저..
    br.close();
}
%>