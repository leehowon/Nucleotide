<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ include file="/search/openDB.jsp" %>
<%@ include file="/search/common/inc/headin.jsp" %>
<body>
<%@ include file="/search/common/inc/header.jsp" %>
<div class="contents_box">
    <div class="content_box">
        <div class="content_title">| 검색 결과 요약</div>
        <div class="content">
            <table id="summary">
<!--                 <col width="20px"> -->
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
<!--                         <th><input type="checkbox"></th> -->
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
String sql = "select * from orchid where seq = ?";

try
{
    pstm = conn.prepareStatement( sql );
    pstm.setInt( 1, 1 );
    rs = pstm.executeQuery();

    if( rs != null )
    {
        int rowNum = 1;
        
        while( rs.next() )
        { 
            int seq = rs.getInt( "seq" );
%>
                    <tr>
<!--                         <td><input type="checkbox"></td> -->
                        <td class="tl"><%= rs.getString( "organism" ) %></td>
                        <td><%= "" %></td>
                        <td><%= "" %></td>
                        <td><%= "" %></td>
                        <td><%= "" %></td>
                        <td><%= "" %></td>
                        <td><%= "" %></td>
                        <td>CBRUR DB</td>
                        <td><a href="detail2.jsp?seq=<%= seq %>" class="btn_s btn_pe01">View</a></td>
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
                </tbody>
            </table>
        </div>
    </div>
<!--     <div class="content_box mt20 mb20"> -->
<!--         <div class="content_title">| 염기서열 정렬</div> -->
<!--         <div class="content"> -->
<!--             <div class="item_box"> -->
<!--                 <div class="btn_box"><a href="#" class="btn_s btn_pe01">Download</a></div> -->
                
<!--                 api 에서 제공 받아서 표시 해주어야 함 참고 : http://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastx&PAGE_TYPE=BlastSearch&LINK_LOC=blasthome -->
<!--                 위에 노출된 모든 결과값에 대한 내용이 노출 되어야 함 -->
                
<!--                 <div class="oneSeqAln" id="aln_443761306"> -->
<!--                     <div id="dln_443761306">  테이블 에서 클릭시 이동 aln_443761306 -->
<!--                         <div class="dlfRow"> Sequence 13603 from patent US 8343764 -->
<!--                             <div> -->
<!--                                 <label>Sequence ID: </label> -->
<!--                                 <a href="http://www.ncbi.nlm.nih.gov/protein/443761306?report=genbank&amp;log$=protalign&amp;blast_rank=1&amp;RID=DB53815G014" target="lnkDB53815G014" title="Show report for gb|AGD16147.1|">gb|AGD16147.1|</a><span class=" r"> -->
<!--                                 <label>Length: </label> -->
<!--                                 469 -->
<!--                                 <label>Number of Matches: </label> -->
<!--                                 1</span></div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                     <div class="relInf" id="relInf_443761306"> -->
<!--                         <label>Related Information</label> -->
<!--                     </div> -->
<!--                     <div class="alnAll" id="alnAll_443761306"> -->
<!--                         <div id="hd_443761306_1"> -->
<!--                             <div class="dflLnk hsp"><span class="alnRn"> -->
<!--                                 <label>Range 1: 1 to 186</label> -->
<!--                                 <span class="" id="rng_443761306"><a href="http://www.ncbi.nlm.nih.gov/protein/443761306?report=genbank&amp;log$=protalign&amp;blast_rank=1&amp;RID=DB53815G014&amp;from=1&amp;to=186" class="" target="lnkDB53815G014" title="Aligned region spanning positions 1 to 186 on AGD16147">GenPept</a><a href="http://www.ncbi.nlm.nih.gov/protein/443761306?report=graph&amp;rid=DB53815G014[443761306]&amp;tracks=[key:sequence_track,name:Sequence,display_name:Sequence,id:STD1,category:Sequence,annots:Sequence,ShowLabel:true][key:gene_model_track,CDSProductFeats:false][key:alignment_track,name:other alignments,annots:NG Alignments|Refseq Alignments|Gnomon Alignments|Unnamed,shown:false]&amp;v=0:195&amp;appname=ncbiblast&amp;link_loc=fromHSP" class="spr" target="lnkDB53815G014" title="Show alignment to AGD16147 in Protein Graphics for 1 to 186 range">Graphics</a></span></span> <span id="hsp443761306_1" class="alnParLinks"> <a class="gbd toolsCtr navNext" disabled="disabled" title="Go to next match #2 for gb|AGD16147.1|" onmouseover="scan(this)" ref="ordinalpos=1&amp;currseq=443761306" onclick="goToNextHSP(this,true)" init="on"><span>Next Match</span></a> <a class="gbd toolsCtr navPrev" disabled="disabled" title="Go to previous match #0 for gb|AGD16147.1|" onmouseover="scan(this)" ref="ordinalpos=1&amp;currseq=443761306" onclick="goToNextHSP(this,false)" init="on"><span>Previous Match</span></a> <a class="gbd toolsCtr navBack hidden" href="#hsp443761306_1" title="Go to first match for gb|AGD16147.1|"><span>First Match</span></a> </span> </div> -->
<!--                             <table class="alnParams"> -->
<!--                                 <caption class="hdnHeader"> -->
<!--                                 Alignment statistics for match #1 -->
<!--                                 </caption> -->
<!--                                 <tbody> -->
<!--                                     <tr> -->
<!--                                         <th>Score</th> -->
<!--                                         <th>Expect</th> -->
<!--                                         <th class="cbs_md ">Method</th> -->
<!--                                         <th>Identities</th> -->
<!--                                         <th>Positives</th> -->
<!--                                         <th>Gaps</th> -->
<!--                                         <th class="aln_frame shown">Frame</th> -->
<!--                                     </tr> -->
<!--                                     <tr> -->
<!--                                         <td> 348 bits(894)</td> -->
<!--                                         <td>2e-117<span class="sumN ">()</span></td> -->
<!--                                         <td class="">Compositional matrix adjust.</td> -->
<!--                                         <td>184/186(99%)</td> -->
<!--                                         <td>185/186(99%)</td> -->
<!--                                         <td>0/186(0%)</td> -->
<!--                                         <td class="aln_frame shown">+3</td> -->
<!--                                     </tr> -->
<!--                                 </tbody> -->
<!--                             </table> -->
<!--                             <div class="dflLnk aln_feat hidden"> -->
<!--                                 <label>Features:</label> -->
<!--                                 <div></div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         <div id="ar_443761306_1"> -->
<!--                             <pre>Query  6    KASVGFKAGVKDYKLTYYTPDYETKDTDILAAFRVTPQ<font color="#808080">pgvppeeagaavaae</font>SSTGTWT  185 -->
<!--             KASVGFKAGVKDY+LTYYTPDYETKDTDILAAFRVTPQPGVP EEAGAAVAAESSTGTWT -->
<!-- Sbjct  1    KASVGFKAGVKDYRLTYYTPDYETKDTDILAAFRVTPQPGVPAEEAGAAVAAESSTGTWT  60 -->

<!-- Query  186  TVWTDGLTSLDRYKGRCYHIEAVVGEENQYIAYVAYPLDLFEEGSVTNMFTSIVGNVFGF  365 -->
<!--             TVWTDGLTSLDRYKGRCYHIEAVVGEENQYIAYVAYPLDLFEEGSVTNMFTSIVGNVFGF -->
<!-- Sbjct  61   TVWTDGLTSLDRYKGRCYHIEAVVGEENQYIAYVAYPLDLFEEGSVTNMFTSIVGNVFGF  120 -->

<!-- Query  366  KALRALRLEDLRIPPAYSKTFQGPPHGIQVERDKLNKYGRPLLGCTIKPKLGLSAKNYGR  545 -->
<!--             KALRALRLEDLRIPPAYSKTFQGPPHGIQVERDKLNKYGRPLLGCTIKPKLGLSAKNYGR -->
<!-- Sbjct  121  KALRALRLEDLRIPPAYSKTFQGPPHGIQVERDKLNKYGRPLLGCTIKPKLGLSAKNYGR  180 -->

<!-- Query  546  AVYECL  563 -->
<!--             AVYECL -->
<!-- Sbjct  181  AVYECL  186 -->


<!-- </pre> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                     alnAll_443761306  -->
<!--                 </div> -->
<!--             </div> -->
<!--             // item_box  -->
            
<!--         </div> -->
<!--     </div> -->
<script>
$( document ).ready(function(){
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