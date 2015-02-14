<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ include file="/search/openDB.jsp" %>
<%
String seq = request.getParameter( "seq" );

if( seq == null && "".equals(seq) )
{
%>
<html>
<head><script>alert( "필수 파라미터가 없습니다." );history.back( -1 );</script></head>
<body></body>
</html>
<%
    return;
}

String sql = "delete from orchid where seq = ?"
        , message = "삭제 되었습니다.";

try
{
    pstm = conn.prepareStatement( sql );
    pstm.setString( 1, seq );
    pstm.executeUpdate();
}
catch( Exception e )
{
    message = "처리 실패했습니다.";
    e.printStackTrace();
}
finally
{
    if(rs != null) try{ rs.close(); }catch( SQLException se ){}
    if(pstm != null) try{ pstm.close(); }catch( SQLException se ){}
    if(conn != null) try{ conn.close(); }catch( SQLException se ){}
}
%>
<html>
<head><script>alert( "<%= message %>" );location.replace( "admin.jsp" );</script></head>
<body></body>
</html>