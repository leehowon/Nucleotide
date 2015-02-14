<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"
        import="com.oreilly.servlet.*
                , com.oreilly.servlet.multipart.DefaultFileRenamePolicy
                , java.io.*
                , java.net.InetAddress" %>
<%@ include file="/search/openDB.jsp" %>
<%
String uploadPath = "211.115.111.229".equals( InetAddress.getLocalHost().getHostAddress() ) ? "/home/user/escteam/webapps/ROOT/upload" : "c:\\upload";
MultipartRequest mRequest = new MultipartRequest( request, uploadPath
        , 1024 * 1024 * 10, "UTF-8", new DefaultFileRenamePolicy() );
File orginFile = mRequest.getFile( "orginFile" );
String seq = mRequest.getParameter( "seq" )
        , familyNm = mRequest.getParameter( "familyNm" )
        , genusNm = mRequest.getParameter( "genusNm" )
        , speciesNm = mRequest.getParameter( "speciesNm" )
        , scientificNm = mRequest.getParameter( "scientificNm" )
        , koreaNm = mRequest.getParameter( "koreaNm" )
        , organism = mRequest.getParameter( "organism" )
        , orgin = mRequest.getParameter( "orgin" )
        , locus = mRequest.getParameter( "locus" )
        , collection = mRequest.getParameter( "collection" )
        , authors = mRequest.getParameter( "authors" )
        , accession = mRequest.getParameter( "accession" )
        , message = "추가 되었습니다."
        , sql = "insert into orchid ( family_nm, genus_nm, species_nm, scientific_nm, korea_nm, organism, orgin, locus, collection, authors, accession )";

sql += "values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )";

Object[] args = { familyNm, genusNm, speciesNm, scientificNm, koreaNm, organism
                  , orgin, locus, collection, authors, accession };
boolean isComplete = false;

if( orginFile != null )
{
    StringBuffer sb = new StringBuffer();
    String tempStr = "";
    BufferedReader br = new BufferedReader( new InputStreamReader(new FileInputStream(orginFile), "utf-8") );
    
    while( (tempStr = br.readLine()) != null )
        sb.append( tempStr );
    
    orgin = sb.toString(); //업로드에 있는거 먼저..
    br.close();
}

if( seq != null && !"".equals(seq) )
{
    message = "수정 되었습니다.";
    
    sql = "update orchid set";
    sql += "family_nm = ?, genus_nm = ?, species_nm = ?, scientific_nm = ?, korea_nm = ?, organism = ?";
    sql += ", orgin = ?, locus = ?, collection = ?, authors = ?, accession = ?";
    sql += "where seq = ?";
    
    args = new Object[]{ familyNm, genusNm, speciesNm, scientificNm, koreaNm
                         , organism, orgin, locus, collection, authors, accession, seq };
}

try
{
    int li = 1;
    
    pstm = conn.prepareStatement( sql );
    
    for( Object arg : args )
        pstm.setString( li++, (String) arg );
    
    pstm.executeUpdate();
    isComplete = true;
}
catch( Exception e )
{
    message = "처리 실패했습니다.";
    e.printStackTrace();
}
finally
{
    if(rs != null) try{ rs.close(); }catch( SQLException se ){}
    if(pstm != null) try{ pstm.close(); }catch( SQLException se ){}
    if(conn != null) try{ conn.close(); }catch( SQLException se ){}
}
%>
<html>
<head><script>alert( "<%= message %>" );location.replace( "admin.jsp" );</script></head>
<body></body>
</html>