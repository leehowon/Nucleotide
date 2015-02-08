<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ include file="/search/openDB.jsp" %>
<%
String seq = request.getParameter( "seq" );

//if( seq == null || "".equals(seq) || rid == null || "".equals(rid) )
    if( seq == null || "".equals(seq) )
{
%>
<html>
<head><script>alert( "필수 파라미터가 없습니다." );window.close();</script></head>
<body></body>
</html>
<%
    return;
}
%>
<%@ include file="/search/common/inc/headin.jsp" %>
<body>
<%@ include file="/search/common/inc/header.jsp" %>
<div class="popup" id="popup" style="display:block;">
    <div class="popup_box">
<%
String sql = "select * from orchid where seq = ?";

try
{
    pstm = conn.prepareStatement( sql );
    pstm.setInt( 1, Integer.parseInt(seq) );
    rs = pstm.executeQuery();
    rs.next();
%>
        <div class="title"><%= rs.getString( "organism" ) %></div>
        <div class="content">
            <table>
                <col width="80px">
                <col width="600px">
                    <tr>
                        <th>국명</th>
                        <td><%= rs.getString( "korea_nm" ) %></td>
                    </tr>
                    <tr>
                        <th>학명</th>
                        <td><%= rs.getString( "scientific_nm" ) %></td>
                    </tr>
                    <tr>
                        <th>채집장소</th>
                        <td><%= rs.getString( "locus" ) %></td>
                    </tr>
                    <tr>
                        <th>채집일</th>
                        <td><%= rs.getString( "collection" ) %></td>
                    </tr>
                    <tr>
                        <th>채집자</th>
                        <td><%= rs.getString( "authors" ) %></td>
                    </tr>
                    <tr>
                        <th>채집번호</th>
                        <td><%= rs.getString( "accession" ) %></td>
                    </tr>
                    <tr>
                        <th>유전자</th>
                        <td><%= rs.getString( "organism" ) %></td>
                    </tr>
                    <tr>
                        <th>염기서열</th>
                        <td>
                        <pre>
                        <%
                        %>
                        </pre>
                        </td>
                    </tr>
                </table>
        </div>
<%
}
catch( Exception e )
{
    e.printStackTrace();
    return;
}
finally
{
    if(rs != null) try{ rs.close(); }catch( SQLException se ){}
    if(pstm != null) try{ pstm.close(); }catch( SQLException se ){}
    if(conn != null) try{ conn.close(); }catch( SQLException se ){}
}
%>
    </div>
</div>
</body>
</html>