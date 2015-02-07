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

try
{
    post.setHeader( "Cache-Control", "no-cache, no-store, must-revalidate" );
    post.setHeader( "Pragma", "no-cache" );
    post.setHeader( "Expires", "0" );
    post.setEntity( new UrlEncodedFormEntity(params) );

    String rid = httpClient.execute(post, new BasicResponseHandler() 
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
    
    params = new ArrayList<NameValuePair>();
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
    
    String status = "", data = "";
    do
    {
        data = httpClient.execute(post, new BasicResponseHandler() 
        {
            @Override
            public String handleResponse(HttpResponse response)
                    throws HttpResponseException, IOException
            {
                return super.handleResponse(response);
            }
        });
        System.out.println( data );
        
        Element element = Jsoup.parse( data ).getElementById( "statInfo" );

        status = element != null ? element.attr( "class" ) : "";
        Thread.sleep( 3000 );
    }
    while( "WAITING".equals(status) );
    
    out.println( data );
}
catch ( IOException e )
{
    System.out.println("search URL connect failed: "
            + e.getMessage());

    e.printStackTrace();

}
if( true ) return;
/**
try
{
    if( connection.getResponseCode() == 200 )
    {
        InputStreamReader in = new InputStreamReader( connection.getInputStream(), "utf-8" );
        BufferedReader br = new BufferedReader( in );
        String data = "", strLine = "", rid = "";

        while ( (strLine = br.readLine()) != null ) 
            data = data.concat( strLine );
        
        Matcher m = Pattern.compile( "RID%3D[A-Z,0-9]+[^%]*[$]?" ).matcher( data );
        rid = m.find() ? m.group( 0 ).replaceAll( "RID%3D", "" ).trim() : "";
        getIFParam += rid;
        
        out.println( rid );

        br.close();
        in.close();
        connection.disconnect();

        String repeatParam = "";
        int count = 0;
        do
        {
            data = "";

            connection = ( HttpURLConnection ) new URL( url ).openConnection();
            connection.setDoOutput( true );
            connection.setRequestMethod( "POST" );
            connection.setUseCaches( false );
            connection.setRequestProperty( "Content-Length", Integer.toString(repeatParam != "" ? repeatParam.length() : getIFParam.length()) );

            os = connection.getOutputStream();
            os.write( repeatParam != "" ? repeatParam.getBytes() : getIFParam.getBytes() );
            os.flush();
            os.close();
            
            in = new InputStreamReader( connection.getInputStream(), "utf-8" );
            br = new BufferedReader( in );
            
            while ( (strLine = br.readLine()) != null ) 
                data = data.concat( strLine );

            br.close();
            in.close();
            connection.disconnect();
            repeatParam = getIFParam + "&OLD_BLAST=false&_PGR=" + count++;
            
            System.out.println( data );
            Thread.sleep( 2000 );
        }
        while( data.indexOf("Status=WAITING") > -1 );

        out.println( data );
        return;
    }
    else
    {
        System.out.println("http response code error: " + rc + "\n");

        return;
    }
}
catch ( IOException e )
{
    System.out.println("search URL connect failed: "
            + e.getMessage());

    e.printStackTrace();

}
finally
{
    if (os != null)
        os.close();

    connection.disconnect();

}
/**/
%>
<%@ include file="/search/common/inc/headin.jsp" %>
<body>
<%@ include file="/search/common/inc/header.jsp" %>
<div class="popup" id="popup">
    <div class="popup_box">
        <div class="btn_close" onClick="$('#popup').toggle()">X</div>
        <div class="title">
ribulose-1,5-bisphosphate carboxylase/oxygenase large subunit (rbcL) gene, partial cds; chloroplast
        </div>
        <div class="content">
                <!-- cbrur detail -->
            <table>
                <col width="80px">
                <col width="600px">
                    <tr>
                        <th>국명</th>
                        <td>갈매기란</td>
                    </tr>
                    <tr>
                        <th>학명</th>
                        <td>Platanthera japonica(Thunb. ex Murray) Lindl.</td>
                    </tr>
                    <tr>
                        <th>채집장소</th>
                        <td>제주도 서귀포시 표선면</td>
                    </tr>
                    <tr>
                        <th>채집일</th>
                        <td>2011-7-15</td>
                    </tr>
                    <tr>
                        <th>채집자</th>
                        <td>김찬수</td>
                    </tr>
                    <tr>
                        <th>채집번호</th>
                        <td>38183</td>
                    </tr>
                    <tr>
                        <th>유전자</th>
                        <td>
                        ribulose-1,5-bisphosphate carboxylase/oxygenase large subunit (rbcL) gene, partial cds; chloroplast
                        </td>
                    </tr>
                    <tr>
                        <th>염기서열</th>
                        <td>
                        <pre>
  1 AAACTAAAGCAA GTGTTGGATTTA AAGCTGGTGTTA AAGATTACAAAT TGACTTATTATA CTCCTGACTACG 
 61 AAACCAAAGATA CTGATATCTTGG CAGCATTCCGAG TAACTCCTCAAC CGGGAGTTCCGC CTGAAGAAGCGG 
121 GCGCTGCGGTAG CAGCCGAATCTT CTACTGGTACAT GGACAACTGTGT GGACTGATGGAC TTACTAGTCTTG 
181 ATCGTTACAAAG GACGATGCTACC ACATTGAGGCCG TTGTTGGGGAGG AAAATCAATATA TTGCTTATGTAG 
241 CTTATCCTTTAG ACCTTTTTGAAG AAGGTTCTGTTA CTAACATGTTTA CTTCCATTGTGG GTAATGTTTTTG 
301 GTTTCAAAGCTC TGCGAGCTCTAC GTCTGGAAGATC TGCGAATTCCCC CTGCTTATTCCA AAACTTTCCAAG 
361 GTCCACCTCATG GCATCCAAGTTG AAAGAGATAAAT TGAACAAGTACG GTCGTCCCCTAT TGGGATGTACTA 
421 TTAAACCAAAAT TGGGATTATCCG CAAAAAACTACG GTAGAGCGGTTT ATGAATGTCTAC G
                        </pre>
                        </td>
                    </tr>
                </table>
                <!-- // -->     
                
                <!-- genbank detail -->
            <table>
                <col width="80px">
                <col width="600px">
                    <tr>
                        <th>ORGANISM</th>
                        <td>Platanthera japonica<br>
                            Eukaryota; Viridiplantae; Stre...
                        </td>
                    </tr>
                    <tr>
                        <th>DEFINITION</th>
                        <td>Platan... chloroplast</td>
                    </tr>
                    <tr>
                        <th>AUTHORS</th>
                        <td>Kim,h,m,, oh,S,H., Bhandari,G.S., </td>
                    </tr>
                    <tr>
                        <th>TITLE</th>
                        <td>DNA barcoding of Orchidaceae in Korea</td>
                    </tr>
                    <tr>
                        <th>JOURNAL</th>
                        <td>Moi Ecol Resour 41(3), 499-507 (2014)</td>
                    </tr>
                    <tr>
                        <th>ORIGN</th>
                        <td>
                        <pre>
  1 AAACTAAAGCAA GTGTTGGATTTA AAGCTGGTGTTA AAGATTACAAAT TGACTTATTATA CTCCTGACTACG 
 61 AAACCAAAGATA CTGATATCTTGG CAGCATTCCGAG TAACTCCTCAAC CGGGAGTTCCGC CTGAAGAAGCGG 
121 GCGCTGCGGTAG CAGCCGAATCTT CTACTGGTACAT GGACAACTGTGT GGACTGATGGAC TTACTAGTCTTG 
181 ATCGTTACAAAG GACGATGCTACC ACATTGAGGCCG TTGTTGGGGAGG AAAATCAATATA TTGCTTATGTAG 
241 CTTATCCTTTAG ACCTTTTTGAAG AAGGTTCTGTTA CTAACATGTTTA CTTCCATTGTGG GTAATGTTTTTG 
301 GTTTCAAAGCTC TGCGAGCTCTAC GTCTGGAAGATC TGCGAATTCCCC CTGCTTATTCCA AAACTTTCCAAG 
361 GTCCACCTCATG GCATCCAAGTTG AAAGAGATAAAT TGAACAAGTACG GTCGTCCCCTAT TGGGATGTACTA 
421 TTAAACCAAAAT TGGGATTATCCG CAAAAAACTACG GTAGAGCGGTTT ATGAATGTCTAC G
                        </pre>
                        </td>
                    </tr>
                </table>                        
                
        </div>      
    </div>
</div>
<div class="contents_box">

    <div class="content_box">
        <div class="content_title">| 검색 결과 요약</div>
        <div class="content">
            <table>
                <col width="20px">
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
                        <th><input type="checkbox"></th>
                        <th>Description</th>
                        <th>Max<br>
                            score</th>
                        <th>Total<br>
                            score</th>
                        <th>Query<br>
                            cover</th>
                        <th>E<br>
                            value</th>
                        <th>Ident</th>
                        <th>Accenssion</th>
                        <th>DB</th>
                        <th>Detail</th>
                    </tr>
                </thead>
                <tbody>
                <!-- 결과는 페이징 없이 Max 100 표시 -->
                    <tr>
                        <td><input type="checkbox"></td>
                        <td class="tl"><a href="#aln_443761306">Amitostigma gracile (Blume) Schltr.</a></td>
                        <td>1037</td>
                        <td>1037</td>
                        <td>100</td>
                        <td>0.0</td>
                        <td>100</td>
                        <td>d</td>
                        <td>DBenBank DB</td>
                        <td><a href="#" onClick="$('#popup').toggle()" class="btn_s btn_pe01">View</a></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td class="tl"><a href="#aln_443761306">Amitostigma gracile (Blume) Schltr.</a></td>
                        <td>1037</td>
                        <td>1037</td>
                        <td>100</td>
                        <td>0.0</td>
                        <td>100</td>
                        <td>d</td>
                        <td>CBRUR</td>
                        <td><a href="#" onClick="$('#popup').toggle()" class="btn_s btn_pe01">View</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="content_box mt20 mb20">
        <div class="content_title">| 염기서열 정렬</div>
        <div class="content">
            <div class="item_box">
                <div class="btn_box"><a href="#" class="btn_s btn_pe01">Download</a></div>
                
                <!-- api 에서 제공 받아서 표시 해주어야 함 참고 : http://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastx&PAGE_TYPE=BlastSearch&LINK_LOC=blasthome -->
                <!-- 위에 노출된 모든 결과값에 대한 내용이 노출 되어야 함 -->
                
                <div class="oneSeqAln" id="aln_443761306">
                    <div id="dln_443761306"> <!--  테이블 에서 클릭시 이동 aln_443761306 -->
                        <div class="dlfRow"> Sequence 13603 from patent US 8343764
                            <div>
                                <label>Sequence ID: </label>
                                <a href="http://www.ncbi.nlm.nih.gov/protein/443761306?report=genbank&amp;log$=protalign&amp;blast_rank=1&amp;RID=DB53815G014" target="lnkDB53815G014" title="Show report for gb|AGD16147.1|">gb|AGD16147.1|</a><span class=" r">
                                <label>Length: </label>
                                469
                                <label>Number of Matches: </label>
                                1</span></div>
                        </div>
                    </div>
                    <div class="relInf" id="relInf_443761306">
                        <label>Related Information</label>
                    </div>
                    <!--
<pre>
<@aln_gene_info@>
</pre>
-->
                    <div class="alnAll" id="alnAll_443761306">
                        <div id="hd_443761306_1">
                            <div class="dflLnk hsp"><span class="alnRn">
                                <label>Range 1: 1 to 186</label>
                                <span class="" id="rng_443761306"><a href="http://www.ncbi.nlm.nih.gov/protein/443761306?report=genbank&amp;log$=protalign&amp;blast_rank=1&amp;RID=DB53815G014&amp;from=1&amp;to=186" class="" target="lnkDB53815G014" title="Aligned region spanning positions 1 to 186 on AGD16147">GenPept</a><a href="http://www.ncbi.nlm.nih.gov/protein/443761306?report=graph&amp;rid=DB53815G014[443761306]&amp;tracks=[key:sequence_track,name:Sequence,display_name:Sequence,id:STD1,category:Sequence,annots:Sequence,ShowLabel:true][key:gene_model_track,CDSProductFeats:false][key:alignment_track,name:other alignments,annots:NG Alignments|Refseq Alignments|Gnomon Alignments|Unnamed,shown:false]&amp;v=0:195&amp;appname=ncbiblast&amp;link_loc=fromHSP" class="spr" target="lnkDB53815G014" title="Show alignment to AGD16147 in Protein Graphics for 1 to 186 range">Graphics</a></span></span> <span id="hsp443761306_1" class="alnParLinks"> <a class="gbd toolsCtr navNext" disabled="disabled" title="Go to next match #2 for gb|AGD16147.1|" onmouseover="scan(this)" ref="ordinalpos=1&amp;currseq=443761306" onclick="goToNextHSP(this,true)" init="on"><span>Next Match</span></a> <a class="gbd toolsCtr navPrev" disabled="disabled" title="Go to previous match #0 for gb|AGD16147.1|" onmouseover="scan(this)" ref="ordinalpos=1&amp;currseq=443761306" onclick="goToNextHSP(this,false)" init="on"><span>Previous Match</span></a> <a class="gbd toolsCtr navBack hidden" href="#hsp443761306_1" title="Go to first match for gb|AGD16147.1|"><span>First Match</span></a> </span> </div>
                            <table class="alnParams">
                                <caption class="hdnHeader">
                                Alignment statistics for match #1
                                </caption>
                                <tbody>
                                    <tr>
                                        <th>Score</th>
                                        <th>Expect</th>
                                        <th class="cbs_md ">Method</th>
                                        <th>Identities</th>
                                        <th>Positives</th>
                                        <th>Gaps</th>
                                        <th class="aln_frame shown">Frame</th>
                                    </tr>
                                    <tr>
                                        <td> 348 bits(894)</td>
                                        <td>2e-117<span class="sumN ">()</span></td>
                                        <td class="">Compositional matrix adjust.</td>
                                        <td>184/186(99%)</td>
                                        <td>185/186(99%)</td>
                                        <td>0/186(0%)</td>
                                        <td class="aln_frame shown">+3</td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="dflLnk aln_feat hidden">
                                <label>Features:</label>
                                <div></div>
                            </div>
                        </div>
                        <div id="ar_443761306_1">
                            <pre>Query  6    KASVGFKAGVKDYKLTYYTPDYETKDTDILAAFRVTPQ<font color="#808080">pgvppeeagaavaae</font>SSTGTWT  185
            KASVGFKAGVKDY+LTYYTPDYETKDTDILAAFRVTPQPGVP EEAGAAVAAESSTGTWT
Sbjct  1    KASVGFKAGVKDYRLTYYTPDYETKDTDILAAFRVTPQPGVPAEEAGAAVAAESSTGTWT  60

Query  186  TVWTDGLTSLDRYKGRCYHIEAVVGEENQYIAYVAYPLDLFEEGSVTNMFTSIVGNVFGF  365
            TVWTDGLTSLDRYKGRCYHIEAVVGEENQYIAYVAYPLDLFEEGSVTNMFTSIVGNVFGF
Sbjct  61   TVWTDGLTSLDRYKGRCYHIEAVVGEENQYIAYVAYPLDLFEEGSVTNMFTSIVGNVFGF  120

Query  366  KALRALRLEDLRIPPAYSKTFQGPPHGIQVERDKLNKYGRPLLGCTIKPKLGLSAKNYGR  545
            KALRALRLEDLRIPPAYSKTFQGPPHGIQVERDKLNKYGRPLLGCTIKPKLGLSAKNYGR
Sbjct  121  KALRALRLEDLRIPPAYSKTFQGPPHGIQVERDKLNKYGRPLLGCTIKPKLGLSAKNYGR  180

Query  546  AVYECL  563
            AVYECL
Sbjct  181  AVYECL  186


</pre>
                        </div>
                    </div>
                    <!-- alnAll_443761306 --> 
                </div>
            </div>
            <!--// item_box --> 
            
        </div>
    </div>
</div>
<%@ include file="/search/common/inc/footer.jsp" %>

</body>
</html>
