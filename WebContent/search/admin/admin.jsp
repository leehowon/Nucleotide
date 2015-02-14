<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ include file="/search/openDB.jsp" %>
<%@ include file="/search/admin/common/inc/headin.jsp" %>
<body>
<%@ include file="/search/admin/common/inc/header.jsp" %>

<div class="contents_box">
        <div class="content">
            <div class="table_box">
            <table id="summary">
<!--                 <col width="20px"> -->
                <col width="">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Family</th>
                        <th>GName</th>
                        <th>Genus</th>
                        <th>Specificepithet</th>
                        <th>Author</th>
                        <th>Infraspecifictaxa</th>
                        <th>Author2</th>
                    </tr>
                </thead>
                <tbody>
<%
String seq = request.getParameter( "seq" );
String sql = "select * from orchid";
//String sql = "select * from orchid limit 0, 15";

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
            String className = rs.getString( "seq" ).equals( seq ) ? "active" : "";
%>
                    <tr class="<%= className %>" onclick="location.href='admin.jsp?seq=<%= rs.getString( "seq" ) %>'">
                        <td><%= rs.getString( "korea_nm" ) %></td>
                        <td><%= rs.getString( "family_nm" ) %></td>
                        <td><%= rs.getString( "genus_nm" ) %></td>
                        <td><%= rs.getString( "genus_nm" ) %></td>
                        <td><%= rs.getString( "species_nm" ) %></td>
                        <td><%= rs.getString( "authors" ) %></td>
                        <td></td>
                        <td></td>
                    </tr>
<%
        }
    }
    else
    {
%>
                    <tr class="active">
                        <td colspan="8">결과가 없습니다.</td>
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
            <div class="edit_box mt10">
                <dl>
                    <dt>Name</dt>
                    <dd><input type="text" class="input"></dd>
                    <dt>Family</dt>
                    <dd><input type="text" class="input"></dd>
                    <dt>GName</dt>
                    <dd><input type="text" class="input"></dd>
                    <dt>Genus</dt>
                    <dd><input type="text" class="input"></dd>
                    <dt>Specificepithet</dt>
                    <dd><input type="text" class="input"></dd>
                    <dt>Author</dt>
                    <dd><input type="text" class="input"></dd>
                    <dt>Infraspecifictaxa</dt>
                    <dd><input type="text" class="input"></dd>
                    <dt>Author2</dt>
                    <dd><input type="text" class="input"></dd>
                </dl>
                <div class="btn_box tc mt10">
<!--                 <a href="#" class="btn_s btn_pe02"><span>확인</span></a> -->
                </div>
            </div>
        <div class="btn_box" style="text-align:center; position:absolute; bottom:0; width:100%;  padding-bottom:10px">
                <a href="#" class="btn_m btn_pe02"><span><i class="fa fa-plus"></i> &nbsp; Add</span></a>&nbsp;&nbsp;
                <a href="#" class="btn_m btn_pe02"><span><i class="fa fa-trash-o"></i> &nbsp; Delete</span></a>
        </div>          
        </div>


</div>
<%@ include file="/search/admin/common/inc/footer.jsp" %>
</body>
</html>
