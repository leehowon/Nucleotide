<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ include file="/search/openDB.jsp" %>
<%@ include file="/search/commonResult.jsp" %>
<%@ include file="/search/common/inc/headin.jsp" %>
<body>
<%@ include file="/search/common/inc/header.jsp" %>
<div class="contents_box">
    <div class="content_box">
        <div class="content_title">| 검색 결과</div>
        <div class="content">
            <table id="summary">
                <col width="200px">
                <col width="">
                <col width="100px">
                <col width="50px">
                <col width="70px">
                <col width="90px">
                <thead>
                    <tr>
                        <th>학명</th>
                        <th>유전자 / 구간명</th>
                        <th>Accenssion</th>
                        <th>DB</th>
                        <th>Detail</th>
                        <th>Download</th>
                    </tr>
                </thead>
                <tbody>
<%
String sql = "select * from orchid where 1 = 1";
//String sql = "select * from orchid limit 0, 15";
String geneOrSection = request.getParameter( "geneOrSection" )
        , familyNameKR = request.getParameter( "familyNameKR" )
        , familyNameUS = request.getParameter( "familyNameUS" )
        , genusNameKR = request.getParameter( "genusNameKR" )
        , genusNameUS = request.getParameter( "genusNameUS" )
        , koreaName = request.getParameter( "koreaName" )
        , specificName = request.getParameter( "specificName" );

//유전자 / 구간명
if( geneOrSection != null && !"".equals(geneOrSection) )
{
    geneOrSection = geneOrSection.trim();
    sql += " AND ( 유전자명 = ? or 구간명 = ? )";
}
else
{
    // 과명, family
    if( familyNameKR != null || familyNameUS != null )
    {
        sql += " AND (";
        
        if( familyNameKR != null && !"".equals(familyNameKR) )
        {
            familyNameKR = familyNameKR.trim();
            sql += " family_nm = ? ";
        }
        
        if( familyNameUS != null && !"".equals(familyNameUS) )
        {
            familyNameUS = familyNameUS.trim();
            sql += " OR family_nm = ? ";
        }
        
        sql += " )";
    }
    // 속명, Genus
    if( genusNameKR != null || genusNameUS != null )
    {
        sql += " AND (";
        
        if( genusNameKR != null && !"".equals(genusNameKR) )
        {
            genusNameKR = genusNameKR.trim();
            sql += " genus_nm = ? ";
        }
        
        if( genusNameUS != null && !"".equals(genusNameUS) )
        {
            genusNameUS = genusNameUS.trim();
            sql += " OR genus_nm = ? ";
        }
        
        sql += " )";
    }
}
try
{
    pstm = conn.prepareStatement( sql );
    //pstm.setString( 1, "%" + query + "%" );
    rs = pstm.executeQuery();

    if( rs != null )
    {
        int rowNum = 1;
        
        while( rs.next() )
        { 
            int seq = rs.getInt( "seq" );
%>
                    <tr>
                        <td class="tl"><%= rs.getString( "specific_nm" ) %></td>
                        <td><%= rs.getString( "organism" ) %></td>
                        <td><%= rs.getString( "accession_num" ) %></td>
                        <td>CBRUR DB</td>
                        <td><a href="detail1.jsp?seq=<%= seq %>" class="btn_s btn_pe01">View</a></td>
                        <td><a href="detail1.jsp?seq=<%= seq %>" class="btn_s btn_pe01">Save</a></td>
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