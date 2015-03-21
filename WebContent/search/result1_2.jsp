<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"
        import="java.util.*" %>
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
List< String > params = new ArrayList< String >();
String sql = "select * from orchid where 1 = 1"
        , organism = mRequest.getParameter( "organism" ).trim()
        , familyNameKR = mRequest.getParameter( "familyNameKR" ).trim()
        , familyNameUS = mRequest.getParameter( "familyNameUS" ).trim()
        , genusNameKR = mRequest.getParameter( "genusNameKR" ).trim()
        , genusNameUS = mRequest.getParameter( "genusNameUS" ).trim()
        , koreaName = mRequest.getParameter( "koreaName" ).trim()
        , specificEpithet = mRequest.getParameter( "specificEpithet" ).trim();

//과명, family
if( !"".equals(familyNameKR) || !"".equals(familyNameUS) )
{
    sql += " AND ( family_nm = ? OR family_nm = ? ) ";
 
    params.add( familyNameKR );
    params.add( familyNameUS );
}
//속명, Genus
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

 // 염기서열
if( !"".equals(organism) )
{
    sql += " AND ( organism like ? OR organism_acronyms like ? )";
    params.add( organism + "%" );
    params.add( organism + "%" );
}

try
{
    //out.println( sql );
    pstm = conn.prepareStatement( sql );

    int li = 1;
    
    for( String param : params )
        pstm.setString( li++, param );

    rs = pstm.executeQuery();

    if( rs.next() )
    {
        int rowNum = 1;
        
        do
        {
            String accessionNumber = rs.getString( "accession_num" );
%>
                    <tr>
                        <td class="tl"><%= rs.getString( "specific_nm" ) %></td>
                        <td><%= rs.getString( "organism" ) %></td>
                        <td><%= accessionNumber %></td>
                        <td>CBRUR</td>
                        <td><a href="detail1.jsp?accessionNumber=<%= accessionNumber %>" class="btn_s btn_pe01">View</a></td>
                        <td><a href="download.jsp?accessionNumber=<%= accessionNumber %>" class="btn_s btn_pe01">Save</a></td>
                    </tr>
<%
            ++rowNum;
        }
        while( rs.next() );
    }
    else
    {
%>
                    <tr>
                        <td colspan="6">검색 결과가 없습니다.</td>
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
        window.open( this.href, "detail", "width=1100px,height=600px,scrollbars=yes" );
        e.preventDefault();
    });
});
</script>
</div>
<%@ include file="/search/common/inc/footer.jsp" %>
</body>
</html>