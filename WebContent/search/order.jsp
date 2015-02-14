<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"
        import="java.io.IOException
                , java.util.ArrayList
                , java.util.Iterator
                , java.util.List
                , org.apache.http.HttpResponse
                , org.apache.http.NameValuePair
                , org.apache.http.client.ClientProtocolException
                , org.apache.http.client.HttpClient
                , org.apache.http.client.HttpResponseException
                , org.apache.http.client.entity.UrlEncodedFormEntity
                , org.apache.http.client.methods.HttpGet
                , org.apache.http.client.methods.HttpPost
                , org.apache.http.impl.client.BasicResponseHandler
                , org.apache.http.impl.client.HttpClientBuilder
                , org.apache.http.message.BasicNameValuePair
                , org.jsoup.Jsoup
                , org.jsoup.nodes.Document
                , org.jsoup.nodes.Element
                , org.jsoup.select.Elements" %>
<%
String seq = request.getParameter( "seq" )
        , rid = request.getParameter( "rid" );

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
String url = "http://blast.ncbi.nlm.nih.gov/t2g.cgi?CMD=Get&OLD_BLAST=false&DYNAMIC_FORMAT=on&RID=" + rid + "&ALIGN_SEQ_LIST=gi%7C" + seq;
HttpClient httpClient = HttpClientBuilder.create().build();
HttpGet get = new HttpGet( url );

get.setHeader( "Cache-Control", "no-cache, no-store, must-revalidate" );
get.setHeader( "Pragma", "no-cache" );
get.setHeader( "Expires", "0" );

Document doc = null;

try
{
    String data = httpClient.execute(get, new BasicResponseHandler() 
    {
        @Override
        public String handleResponse(HttpResponse response)
                throws HttpResponseException, IOException
        {
            return super.handleResponse( response );
        }
    });
    
    doc = Jsoup.parse( data );
}
catch (Exception e)
{
    e.printStackTrace();
    return;
}
%>
<%@ include file="/search/common/inc/headin.jsp" %>
<body>
<%@ include file="/search/common/inc/header.jsp" %>
<div class="popup" id="popup" style="display:block;">
    <div class="popup_box">
<!--         <div class="btn_close" onClick="$('#popup').toggle()">X</div> -->
        <div class="content"><%= doc.select( "div.oneSeqAln" ).html() %></div>
    </div>
</div>
</body>
</html>