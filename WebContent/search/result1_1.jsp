<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"
        import="java.io.IOException
                , java.util.*
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
<%@ include file="/search/openDB.jsp" %>
<%@ include file="commonResult.jsp" %>
<%
List< String > params = new ArrayList< String >();
String url = "http://115.68.22.110/blast/blast.cgi"
        , sql = "select * from orchid where 1 = 1"
        , querySql = ""
        , familyNameKR = mRequest.getParameter( "familyNameKR" ) == null ? "" : mRequest.getParameter( "familyNameKR" ).trim()
        , familyNameUS = mRequest.getParameter( "familyNameUS" ) == null ? "" : mRequest.getParameter( "familyNameUS" ).trim()
        , genusNameKR = mRequest.getParameter( "genusNameKR" ) == null ? "" : mRequest.getParameter( "genusNameKR" ).trim()
        , genusNameUS = mRequest.getParameter( "genusNameUS" ) == null ? "" : mRequest.getParameter( "genusNameUS" ).trim()
        , koreaName = mRequest.getParameter( "koreaName" ) == null ? "" : mRequest.getParameter( "koreaName" ).trim()
        , specificEpithet = mRequest.getParameter( "specificEpithet" ) == null ? "" : mRequest.getParameter( "specificEpithet" ).trim();

// 과명, family
if( !"".equals(familyNameKR) || !"".equals(familyNameUS) )
{
    sql += " AND ( family_nm = ? OR family_nm = ? ) ";
    
    params.add( familyNameKR );
    params.add( familyNameUS );
}
// 속명, Genus
if( !"".equals(genusNameKR) || !"".equals(genusNameUS) )
{
    sql += " AND ( genus_nm = ? OR genus_nm = ? )";
    
    params.add( genusNameKR );
    params.add( genusNameUS );
}
// 국명
if( !"".equals(koreaName) )
{
    sql += " AND korea_nm = ? ";
    params.add( koreaName );
}
// 종소명
if( specificEpithet != null && !"".equals(specificEpithet) )
{
    sql += " AND specific_epithet = ? ";
    params.add( specificEpithet );
}

boolean isQuerySql = false;
//종정보 and ( (유전자명 and 염기서열) or (유전자명 and 염기서열) or (유전자명 and 염기서열) ... )
for( int li = 0, limit = 10; li < limit; ++li )
{
    String organism = mRequest.getParameter( "organism" + li ) == null ? "" : mRequest.getParameter( "organism" + li ).trim()
            , query = mRequest.getParameter( "query" + li ) == null ? "" : mRequest.getParameter( "query" + li ).trim();
    File queryFile = mRequest.getFile( "queryFile" + li );
    
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
    
    if( organism != null && !"".equals(organism.trim()) && query != null && !"".equals(query.trim()) )
    {
        if( !isQuerySql ) // 처음이면
        {
            querySql += "( (organism LIKE ? OR organism_acronyms like ? ) AND origin like ? )";
            isQuerySql = true;
        }
        else
            querySql += " AND ( (organism LIKE ? OR organism_acronyms like ? ) AND origin like ? )";
        
        params.add( organism.trim() + "%" );
        params.add( organism.trim() + "%" );
        params.add( query.trim() + "%" );
    }
    else if( organism != null && !"".equals(organism.trim()) )
    {
        if( !isQuerySql ) // 처음이면
        {
            querySql += "( organism LIKE ? OR organism_acronyms like ? )";
            isQuerySql = true;
        }
        else
            querySql += " AND ( organism LIKE ? OR organism_acronyms like ? )";
        
        params.add( organism.trim() + "%" );
        params.add( organism.trim() + "%" );
    }
    else if( query != null && !"".equals(query.trim()) )
    {
        if( !isQuerySql ) // 처음이면
        {
            querySql += "( origin LIKE ? )";
            isQuerySql = true;
        }
        else
            querySql += " AND ( origin LIKE ? )";

        params.add( query.trim() + "%" );
    }
}

if( isQuerySql ) sql +=  " AND ( " + querySql + " )";

try
{
    List< Map<String, Object> > list100 = new ArrayList< Map<String, Object> >()
                                 , list = new ArrayList< Map<String, Object> >();
    Map< String, Integer > assessionNumbers = new HashMap< String, Integer >(); // 중복제거를 위한 맵
    int maxIdentity = 0, li = 1;
    
    pstm = conn.prepareStatement( sql );
    //out.println( sql + "<br/>" );
    for( String param : params )
    {
        //out.println( param );
        pstm.setString( li++, param );
    }
    
    rs = pstm.executeQuery();
    
    if( rs.next() )
    {
        do
        {
            HttpClient httpClient = HttpClientBuilder.create().build();
            List< NameValuePair > postParams = new ArrayList< NameValuePair >();
            /**
            ALIGNMENT_VIEW
            0 - Pairwise
            1 - master-slave with identities
            2 - master-slave without identities
            3 - flat master-slave with identities
            4 - flat master-slave without identities
            7 - BLAST XML
            9 - Hit Table
            /**/
            postParams.add( new BasicNameValuePair("ALIGNMENT_VIEW", "7") );
            postParams.add( new BasicNameValuePair("PROGRAM", "blastn") );
            postParams.add( new BasicNameValuePair("DATALIB", "cbrur_db") );
            postParams.add( new BasicNameValuePair("DESCRIPTIONS", "100") );
            postParams.add( new BasicNameValuePair("ALIGNMENTS", "100") );
            //postParams.add( new BasicNameValuePair("SEQUENCE", "AACTAAAGCAAGTGTTGGATTCAAAGCTGGGGTTAAAGATTACAAATTGACTTATTATACTCCTGACTATGAAACCAAAGATACTGATATCTTGGCAGCATTCCGAGTAACTCCTCAACCTGGAGTTCCACCTGAAGAAGCGGGAGCCGCGGTAGCTGCCGAATCTTCTACTGGTACATGGACCACTGTGTGGACCGATGGACTTACCAGCCTTGATCGTTACAAAGGGCGCTGCTACGGAATCGAGCCCGTTGCTGGAGAAGAAAATCAATTTATCGCTTATGTAGCTTACCCATTAGACCTTTTTGAAGAAGGTTCTGTTACTAACATGTTTACTTCTATTGTAGGTAATGTATTTGGGTTCAAAGCCCTGCGCGCTCTACGTCTGGAAGATCTGCGAATCCCCGTTGCTTATGTTAAAACTTTCCAAGGACCGCCTCATGGCATCCAAGTTGAGAGAGATAAATTGAACAAGTATGGTCGTCCCCTGTTGGGATGTACTATTAAACCTAAATTGGGATTATCCGCTAAAAAC") );
            postParams.add( new BasicNameValuePair("SEQUENCE", rs.getString("origin")) );

            HttpPost post = new HttpPost( url );

            post.setHeader( "Cache-Control", "no-cache, no-store, must-revalidate" );
            post.setHeader( "Pragma", "no-cache" );
            post.setHeader( "Expires", "0" );
            post.setEntity( new UrlEncodedFormEntity(postParams) );
            
            String data = "";
            
            try
            {
                data = httpClient.execute(post, new BasicResponseHandler()
                {
                    @Override
                    public String handleResponse( HttpResponse response ) throws HttpResponseException, IOException
                    {
                        return super.handleResponse( response );
                    }
                });
                //System.out.println( data );
            }
            catch ( IOException e )
            {
                e.printStackTrace();
            }
            
            Document doc = Jsoup.parse( data );
            Elements hitElements = doc.getElementsByTag("Hit");
            
            for( Element hit : hitElements )
            {
                Map< String, Object > m = new HashMap< String, Object >();
                String[] vals = hit.getElementsByTag( "Hit_def" ).get( 0 ).text().split( "\\|" );// accession number|속명|종소명|구간명
                String accessionNumber = vals[ 0 ].trim()
                        , genusName = vals[ 1 ].trim()
                        , specificEpithetName = vals[ 2 ].trim()
                        , organismAcronyms = vals[ 3 ].trim()
                        , hspIdentity = hit.getElementsByTag( "Hsp_identity" ).get( 0 ).text()
                        , hspAlignLen = hit.getElementsByTag( "Hsp_align-len" ).get( 0 ).text();
                int identity = Integer.parseInt(hspIdentity) * 100 / Integer.parseInt(hspAlignLen);
                
                if( assessionNumbers.containsKey(accessionNumber) ) continue; // 중복 제거
                
                assessionNumbers.put( accessionNumber, identity );
                
                PreparedStatement pstm2 = null;
                ResultSet rs2 = null;
                
                try
                {
                    pstm2 = conn.prepareStatement( "select * from orchid where accession_num = ?" );
                    pstm2.setString( 1, accessionNumber );
                    rs2 = pstm2.executeQuery();
                    
                    if( rs2.next() )
                    {
                        m.put( "specificName", rs2.getString("specific_nm") );
                        m.put( "koreaName", rs2.getString("korea_nm") );
                    }
                }
                catch( Exception e2 )
                {
                    e2.printStackTrace();
                }
                finally
                {
                    if(rs2 != null) try{ rs2.close(); }catch( SQLException se ){}
                    if(pstm2 != null) try{ pstm2.close(); }catch( SQLException se ){}
                }
                
                m.put( "accessionNumber", accessionNumber );
                m.put( "genusName", genusName );
                m.put( "specificEpithet", specificEpithetName );
                m.put( "organismAcronyms", organismAcronyms );
                m.put( "identity", identity );
                
                if( identity > 99 ) list100.add( m );
                else if( identity > maxIdentity )
                {
                    maxIdentity = identity;
                    list.add( m );
                }
            }
        }
        while( rs.next() ); // end while rs.next()
        
        if( list100.size() == 0 ) list100.add( 0, list.get(list.size() - 1) ); // 100% 가 없는 경우는 최대값만 가져온다.
        
        list = list100;
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
        <div class="content_title">| 검색 결과</div>
<%
}
%>
        <div class="content">
            <table id="summary">
<!--                 <col width="100px"> -->
<!--                 <col width="150px"> -->
                <col width="">
                <col width="150px">
                <col width="140px">
                <col width="100px">
                <col width="100px">
                <col width="60px">
                <col width="70px">
                <col width="90px">
                <thead>
                    <tr>
                        <th>학명</th>
                        <th>국명</th>
                        <th>유전자/구간명</th>
                        <th>identity</th>
                        <th>Accession</th>
                        <th>DB</th>
                        <th>Detail</th>
                        <th>Download</th>
                    </tr>
                </thead>
                <tbody>
<%
if( list.size() > 0 )
{
    for( Map< String, Object > m : list )
    {
%>
                    <tr>
                        <td><%= m.get( "specificName" )  %></td>
                        <td><%= m.get( "koreaName" ) %></td>
<%--                         <td><%= m.get( "genusName" )  %></td> --%>
<%--                         <td><%= m.get( "specificEpithet" ) %></td> --%>
                        <td><%= m.get( "organismAcronyms" ) %></td>
                        <td><%= m.get( "identity" ) %></td>
                        <td><%= m.get( "accessionNumber" ) %></td>
                        <td>CBRUR</td>
                        <td><a href="detail1.jsp?accessionNumber=<%= m.get( "accessionNumber" ) %>" class="btn_s btn_pe01">View</a></td>
                        <td><a href="download.jsp?accessionNumber=<%= m.get( "accessionNumber" ) %>" class="btn_s btn_pe01">Save</a></td>
                    </tr>
<%
    }
}
else
{
%>
                    <tr>
                        <td colspan="8">검색 결과가 없습니다.</td>
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
<%
}
catch( Exception e )
{
    e.printStackTrace();
}
finally
{
    if(rs != null) try{ rs.close(); }catch( SQLException se ){}
    if(pstm != null) try{ pstm.close(); }catch( SQLException se ){}
    if(conn != null) try{ conn.close(); }catch( SQLException se ){}
}
%>