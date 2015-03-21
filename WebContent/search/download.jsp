<%@ page language="java" pageEncoding="UTF-8" %><%@ include file="/search/openDB.jsp" %><%
try
{
    String accessionNumber = request.getParameter( "accessionNumber" );

    if( accessionNumber == null || "".equals(accessionNumber) )
        throw new Exception( "필수 파라미터가 없습니다." );
    
    pstm = conn.prepareStatement( "select * from orchid where accession_num = ?" );
    pstm.setString( 1, accessionNumber );
    rs = pstm.executeQuery();
    
    if( !rs.next() )
        throw new Exception( "상세내역이 없습니다." );
    
    String fileName = rs.getString( "accession_num" ) + "_fasta.txt";
    StringBuffer sb = new StringBuffer( ">" )
                                        .append( rs.getString("accession_num") )
                                        .append( "|" )
                                        .append( rs.getString("genus_nm") )
                                        .append( "|" )
                                        .append( rs.getString("specific_epithet") )
                                        .append( "|" )
                                        .append( rs.getString("organism_acronyms") )
                                        .append( "\r\n" )
                                        .append( rs.getString("origin") );

    response.setContentType( "application/octet-stream; charset=utf-8" );
    response.setHeader( "Content-Disposition", "attatchment; filename = " + fileName );

    out.print( sb.toString() );
}
catch( Exception e )
{
    response.setContentType( "text/html; charset=utf-8" );
    e.printStackTrace();
%>
<html>
<head><script>alert( "<%= e.getMessage()%>" );window.close();</script></head>
<body></body>
</html>
<%
}
finally
{
    if(rs != null) try{ rs.close(); }catch( SQLException se ){}
    if(pstm != null) try{ pstm.close(); }catch( SQLException se ){}
    if(conn != null) try{ conn.close(); }catch( SQLException se ){}
}
%>