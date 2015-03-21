<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ include file="/search/openDB.jsp" %>
<%
String accessionNumber = request.getParameter( "accessionNumber" );

if( accessionNumber == null || "".equals(accessionNumber) )
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
<div class="popup" id="popup" style="display:block;">
    <div class="popup_box">
<%
String sql = "select * from orchid where accession_num = ?";

try
{
    pstm = conn.prepareStatement( sql );
    pstm.setString( 1, accessionNumber );
    rs = pstm.executeQuery();
    
    if( !rs.next() )
    {
%>
<html>
<head><script>alert( "상세 내역이 없습니다." );window.close();</script></head>
<body></body>
</html>
<%
        return;
    }

    String orgin = rs.getString( "origin" );
    StringBuffer sb = new StringBuffer();
    
    if( orgin != null && !"".equals(orgin) )
    {
        int li = 0, wordLen = 10, seqLen = orgin.length(), limit = ( int ) Math.ceil( seqLen / ( float ) wordLen )
            , startIndex = 0, endIndex = 0
            , digit = String.valueOf( seqLen ).length();
        
        for( ; li < limit; ++li )
        {
            endIndex = startIndex + 10;
            
            if( endIndex > seqLen ) endIndex = seqLen;
            
            if( li % 6 == 0 )
            {
                if( li != 0 ) sb.append( "\n" );
                sb.append( String.format("%" + digit + "s", startIndex + 1) ).append( " " );
            }
            
            sb.append( orgin.substring(startIndex, endIndex) );
            startIndex = endIndex;
            
            if( (li + 1) < limit ) sb.append( " " );
        }
    }
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
                        <td><%= rs.getString( "specific_nm" ) %></td>
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
                        <td><%= rs.getString( "accession_num" ) %></td>
                    </tr>
                    <tr>
                        <th>유전자</th>
                        <td><%= rs.getString( "organism" ) %></td>
                    </tr>
                    <tr>
                        <th>염기서열</th>
                        <td>
                        <pre><%= sb.toString() %></pre>
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
<script>
$( document ).ready(function(){
    $( "#summary a" ).click(function( e ){
        window.open( this.href, "detail", "width=800px,height=600px,scrollbars=yes" );
        e.preventDefault();
    });
});
</script>
</body>
</html>