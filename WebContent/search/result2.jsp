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
                , org.apache.http.client.methods.HttpPost
                , org.apache.http.impl.client.BasicResponseHandler
                , org.apache.http.impl.client.HttpClientBuilder
                , org.apache.http.message.BasicNameValuePair
                , org.jsoup.Jsoup
                , org.jsoup.nodes.Document
                , org.jsoup.nodes.Element
                , org.jsoup.select.Elements" %>
<%@ include file="commonResult.jsp" %>
<%
String url = "http://www.ncbi.nlm.nih.gov/blast/Blast.cgi"
        , query = mRequest.getParameter( "query" ).trim();
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

HttpClient httpClient = HttpClientBuilder.create().build();
List< NameValuePair > params = new ArrayList< NameValuePair >();

params.add( new BasicNameValuePair("CMD", "Put") );
params.add( new BasicNameValuePair("DATABASE", "nr") );
params.add( new BasicNameValuePair("PROGRAM", "blastn") );
params.add( new BasicNameValuePair("QUERY", query) ); //"AGACGCCGCCGCCACCACCGCCACCGCCGC"

HttpPost post = new HttpPost( url );
String rid = "", data = "", status = "";

post.setHeader( "Cache-Control", "no-cache, no-store, must-revalidate" );
post.setHeader( "Pragma", "no-cache" );
post.setHeader( "Expires", "0" );
post.setEntity( new UrlEncodedFormEntity(params) );

try
{
    data = httpClient.execute(post, new BasicResponseHandler() 
    {
        @Override
        public String handleResponse(HttpResponse response)
                throws HttpResponseException, IOException
        {
            return super.handleResponse( response );
        }
    });
    Document doc = Jsoup.parse( data );
    Element element = doc.getElementById( "rid" );
    
    rid = element != null ? element.val() : "";
}
catch ( IOException e )
{
    e.printStackTrace();
}

if( !"".equals(rid) )
{
    System.out.println( rid );
    
    params = new ArrayList< NameValuePair >();
    params.add( new BasicNameValuePair("CMD", "Get") );
    params.add( new BasicNameValuePair("db", "nucleotide") );
    params.add( new BasicNameValuePair("DATABASE", "nr") );
    params.add( new BasicNameValuePair("PROGRAM", "blastn") );
    params.add( new BasicNameValuePair("RID", rid) );
    params.add( new BasicNameValuePair("SHOW_OVERVIEW", "no") );
    params.add( new BasicNameValuePair("DESCRIPTIONS", "100") );
    
    post = new HttpPost( url );
    post.setHeader( "Cache-Control", "no-cache, no-store, must-revalidate" );
    post.setHeader( "Pragma", "no-cache" );
    post.setHeader( "Expires", "0" );
    post.setEntity( new UrlEncodedFormEntity(params) );
    
    try
    {
        do
        {
            data = httpClient.execute(post, new BasicResponseHandler() 
            {
                @Override
                public String handleResponse(HttpResponse response)
                        throws HttpResponseException, IOException
                {
                    return super.handleResponse( response );
                }
            });
            Element element = Jsoup.parse( data ).getElementById( "statInfo" );
    
            status = element != null ? element.attr( "class" ) : "";
            Thread.sleep( 3000 );
        }
        while( "WAITING".equals(status) );
        
        System.out.println( data );
    }
    catch ( IOException e )
    {
        e.printStackTrace();
    }
}

String viewType = mRequest.getParameter( "view" ) == null ? "" : mRequest.getParameter( "view" ).trim();
%>
<%@ include file="/search/common/inc/headin.jsp" %>
<body<%= "multi".equals(viewType) ? " style=\"min-width: 953px !important;\"" : "" %>>
<%
if( !"multi".equals(viewType) )
{
%>
<%@ include file="/search/common/inc/header.jsp" %>
<div class="contents_box">
    <div class="content_box">
        <div class="content_title">| 검색 결과 요약</div>
<%
}
%>
        <div class="content">
            <table id="summary">
                <col width="">
                <col width="45px">
                <col width="45px">
                <col width="50px">
                <col width="50px">
                <col width="50px">
                <col width="100px">
                <col width="50px">
                <col width="70px">
                <thead>
                    <tr>
                        <th>Description</th>
                        <th>Max<br/>score</th>
                        <th>Total<br/>score</th>
                        <th>Query<br/>cover</th>
                        <th>E<br/>value</th>
                        <th>Ident</th>
                        <th>Accenssion</th>
                        <th>DB</th>
                        <th>Detail</th>
                    </tr>
                </thead>
                <tbody>
<%
Document doc = Jsoup.parse( data );
Elements rows = doc.select( "#dscTable tbody tr" );

if( rows != null && rows.size() > 0 )
{
    int rowNum = 1;
    
    for( Element row : rows )
    {
        Elements elements = row.getElementsByTag( "td" ); 
        String seq = row.getElementById( "chk_" + rowNum ).val();
%>
                    <tr>
<!--                         <td><input type="checkbox"></td> -->
                        <td class="tl"><a href="order.jsp?rid=<%= rid %>&seq=<%= seq %>"><%= elements.get(1).text() %></a></td>
                        <td><%= elements.get(2).text() %></td>
                        <td><%= elements.get(3).text() %></td>
                        <td><%= elements.get(4).text() %></td>
                        <td><%= elements.get(5).text() %></td>
                        <td><%= elements.get(6).text() %></td>
                        <td><%= elements.get(7).text() %></td>
                        <td>GenBank</td>
                        <td><a href="detail2.jsp?rid=<%= rid %>&seq=<%= seq %>" class="btn_s btn_pe01">View</a></td>
                    </tr>
<%
        ++rowNum;
    }
}
else
{
%>
                    <tr>
                        <td colspan="9">검색 결과가 없습니다.</td>
                    </tr>
<%
}
%>
                </tbody>
            </table>
        </div>
<%
if( !"multi".equals(viewType) )
{
%>
    </div>
</div>
<%@ include file="/search/common/inc/footer.jsp" %>
<%
}
%>
<script>
$( document ).ready(function(){
    $( "#summary a" ).click(function( e ){
        window.open( this.href, "detail", "width=1100px,height=600px,scrollbars=yes" );
        e.preventDefault();
    });
});
</script>
</body>
</html>
