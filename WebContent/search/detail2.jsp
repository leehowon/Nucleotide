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

if( seq == null || "".equals(seq) || rid == null || "".equals(rid) )
{
%>
<html>
<head><script>alert( "필수 파라미터가 없습니다." );window.close();</script></head>
<body></body>
</html>
<%
    return;
}
//String url = "http://www.ncbi.nlm.nih.gov/nucleotide/" + seq + "?report=genbank&RID=" + rid;
String url = "http://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?val=" + seq;
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
        <div class="title"><%= doc.select( "p.title > a" ).get( 0 ).text() %></div>
        <div class="content"><pre><%= doc.select( "pre" ).get( 0 ).text() %></pre>
            <!-- genbank detail -->
<!--             <table> -->
<!--                 <col width="80px"> -->
<!--                 <col width="600px"> -->
<!--                     <tr> -->
<!--                         <th>ORGANISM</th> -->
<!--                         <td>Platanthera japonica<br> -->
<!--                             Eukaryota; Viridiplantae; Stre... -->
<!--                         </td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<!--                         <th>DEFINITION</th> -->
<!--                         <td>Platan... chloroplast</td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<!--                         <th>AUTHORS</th> -->
<!--                         <td>Kim,h,m,, oh,S,H., Bhandari,G.S., </td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<!--                         <th>TITLE</th> -->
<!--                         <td>DNA barcoding of Orchidaceae in Korea</td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<!--                         <th>JOURNAL</th> -->
<!--                         <td>Moi Ecol Resour 41(3), 499-507 (2014)</td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<!--                         <th>ORIGN</th> -->
<!--                         <td> -->
<!--                         <pre> -->
<!--   1 AAACTAAAGCAA GTGTTGGATTTA AAGCTGGTGTTA AAGATTACAAAT TGACTTATTATA CTCCTGACTACG  -->
<!--  61 AAACCAAAGATA CTGATATCTTGG CAGCATTCCGAG TAACTCCTCAAC CGGGAGTTCCGC CTGAAGAAGCGG  -->
<!-- 121 GCGCTGCGGTAG CAGCCGAATCTT CTACTGGTACAT GGACAACTGTGT GGACTGATGGAC TTACTAGTCTTG  -->
<!-- 181 ATCGTTACAAAG GACGATGCTACC ACATTGAGGCCG TTGTTGGGGAGG AAAATCAATATA TTGCTTATGTAG  -->
<!-- 241 CTTATCCTTTAG ACCTTTTTGAAG AAGGTTCTGTTA CTAACATGTTTA CTTCCATTGTGG GTAATGTTTTTG  -->
<!-- 301 GTTTCAAAGCTC TGCGAGCTCTAC GTCTGGAAGATC TGCGAATTCCCC CTGCTTATTCCA AAACTTTCCAAG  -->
<!-- 361 GTCCACCTCATG GCATCCAAGTTG AAAGAGATAAAT TGAACAAGTACG GTCGTCCCCTAT TGGGATGTACTA  -->
<!-- 421 TTAAACCAAAAT TGGGATTATCCG CAAAAAACTACG GTAGAGCGGTTT ATGAATGTCTAC G -->
<!--                         </pre> -->
<!--                         </td> -->
<!--                     </tr> -->
<!--                 </table> -->
        </div>
    </div>
</div>
</body>
</html>