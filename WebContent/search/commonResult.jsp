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
<%
String url = "http://www.ncbi.nlm.nih.gov/blast/Blast.cgi"
       , query = "AGACGCCGCCGCCACCACCGCCACCGCCGC";

HttpClient httpClient = HttpClientBuilder.create().build();
List<NameValuePair> params = new ArrayList<NameValuePair>();

params.add( new BasicNameValuePair("CMD", "Put") );
params.add( new BasicNameValuePair("DATABASE", "nr") );
params.add( new BasicNameValuePair("PROGRAM", "blastn") );
params.add( new BasicNameValuePair("QUERY", query) );

HttpPost post = new HttpPost( url );
String rid = "";

try
{
    post.setHeader( "Cache-Control", "no-cache, no-store, must-revalidate" );
    post.setHeader( "Pragma", "no-cache" );
    post.setHeader( "Expires", "0" );
    post.setEntity( new UrlEncodedFormEntity(params) );

    rid = httpClient.execute(post, new BasicResponseHandler() 
    {
        @Override
        public String handleResponse(HttpResponse response)
                throws HttpResponseException, IOException
        {
            Document doc = Jsoup.parse( super.handleResponse(response) );
            Element element = doc.getElementById( "rid" );
            
            return element != null ? element.val() : "";
        }
    });
}
catch ( IOException e )
{
    System.out.println("search URL connect failed: "
            + e.getMessage());

    e.printStackTrace();

}

if( !"".equals(rid) )
{
%>
<%--@ include file="result2.jsp" --%>
<%
}
%>