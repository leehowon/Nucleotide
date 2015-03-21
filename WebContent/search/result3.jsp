<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ include file="commonResult.jsp" %>
<%
String query = mRequest.getParameter( "query" ).trim();
File queryFile = mRequest.getFile( "queryFile" );

if( "".equals(query) && queryFile == null )
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
<%@ include file="/search/common/inc/headin.jsp" %>
<body>
<%@ include file="/search/common/inc/header.jsp" %>
<div class="contents_box">
<form id="f" method="post" enctype="multipart/form-data">
  <input type="hidden" id="view" name="view" value="multi" />
  <input type="hidden" id="query0" name="query0" value="<%= query %>" />
  <input type="hidden" id="query" name="query" value="<%= query %>" />
</form>
    <div class="content_box">
        <div class="content_title">| 검색 결과 요약</div>
        <div class="content">
        * CBRUR DB
        <iframe name="result1" style="width:100%; height:500px; border:0;"></iframe>
        * Genbank DB
        <iframe name="result2" style="width:100%; height:500px; border:0;"></iframe>
        </div>
    </div>
<script>
$( document ).ready(function(){
    $( "#f" ).attr( "target", "result1" )
            .attr( "action", "result1_1.jsp" )
            .trigger( "submit" )
            .attr( "target", "result2" )
            .attr( "action", "result2.jsp" )
            .trigger( "submit" );
    
    $( "#summary a" ).click(function( e ){
        window.open( this.href, "detail", "width=800px,height=600px,scrollbars=yes" );
        e.preventDefault();
    });
});
</script>
</div>
<%@ include file="/search/common/inc/footer.jsp" %>
</body>
</html>