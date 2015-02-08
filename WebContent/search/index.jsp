<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ include file="/search/common/inc/headin.jsp" %>
<body>
<%@ include file="/search/common/inc/header.jsp" %>
<%@ include file="/search/openDB.jsp" %>
<%
String sql = "select * from orchid where seq = ?";

try
{
    pstm = conn.prepareStatement( sql );
    pstm.setInt( 1, 1 );
    rs = pstm.executeQuery();
    
    while( rs.next() )
    {
        out.println( rs.getString("family_nm") );
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
<div class="contents_box">
    <form id="f" method="post" enctype="multipart/form-data">
    <div class="content_box">
        <div class="content_title">| 검색 DataBase 선택</div>
        <div class="check_box">
            <ul>
                <li>
                    <input type="radio" name="db_choice" id="db_choice1" value="result1">
                    <label for="db_choice1">CBRUR </label>
                </li>
                <li>
                        <input type="radio" name="db_choice" id="db_choice2" value="result2">
                        <label for="db_choice2">DBenBank DB</label>
                </li>
                <li>
                        <input type="radio" name="db_choice" id="db_choice3" value="result3">
                        <label for="db_choice3">CBRUR+DBenBank DB</label>
                </li>
            </ul>
        </div>
    </div>
    <div id="cbrurSection" class="content_box mt20">
        <div class="content_title">| 분류군 검색</div>
        <dl>
            <dt>
                <label for="familyname"> 과명 </label>
            </dt>
            <dd>
                <input type="text" class="input w640" id="familyname" >
            </dd>
            <dt>
                <label for="genericname"> 속명 </label>
            </dt>
            <dd class="fl w270">
                <input type="text" class="input" id="genericname" >
            </dd>
            <dt class="fl clno">
                <label for="specific"> 종소명</label>
            </dt>
            <dd>
                <input type="text" class="input" id="specific" >
            </dd>
            <dt>
                <label for="specificname"> 종명(한글)</label>
            </dt>
            <dd class="fl w270">
                <input type="text" class="input" id="specificname" >
            </dd>
            <dt class="fl clno">
                <label for="gene"> 유전자명 </label>
            </dt>
            <dd>
                <input type="text" class="input" id="gene" >
            </dd>
        </dl>
    </div>
    <div id="genbankSection" class="content_box mt20">
        <div class="content_title">| 염기서열 검색</div>
        <div class="content">
            <div class="btn_box"><button type="reset" id="resetBtn" class="btn_s btn_pe01">초기화</button></div>
            <textarea id="query" name="query" class="textarea"></textarea>
        </div>
        <dl>
            <dt>
                <label for="upload">업로드 파일선택 </label>
            </dt>
            <dd>
                <input type="file" id="queryFile" name="queryFile" class="input w640" />
            </dd>   
        </dl>
    </div>
    <div class="btn_box"><button type="submit" class="btn_m btn_pe01">BLAST</button></div>
    </form>
</div>
<script>
$( document ).ready(function(){
    var $db = $( "input[name='db_choice']" )
        , db1 = "result1"
        , db2 = "result2"
        , db3 = "result3";
    
    $( "#f" ).submit(function(){
        var $selectDB = $db.filter( ":checked" )
            , db = $selectDB.val()
            , $query = $( "#query" )
            , $queryFile = $( "#queryFile" );
        
        if( !db ){
            $db.focus();
            return alert( "Database를 선택하세요" ), false;
        }
        
        if( db == db1 ){
            
        }else if( db == db2 ){
            if( !$query.val() && !$queryFile.val() ){
                $query.focus();
                return alert( "염기서열을 입력하시거나 파일을 선택하세요" ), false;
            }
        }else if( db == db3 ){
            if( !$query.val() && !$queryFile.val() ){
                $query.focus();
                return alert( "염기서열을 입력하시거나 파일을 선택하세요" ), false;
            }
        }
        
        this.action = db + ".jsp";
    });
    
    $db.click(function(){
        var val = this.value
            , $cbrurSection = $( "#cbrurSection" )
            , $genbankSection = $( "#genbankSection" )
            , on = { "display" : "block" }
            , off = { "display" : "none" };
        
        if( val == db1 ){
            $cbrurSection.css( on );
            $genbankSection.css( on );
        }else if( val == db2 ){
            $cbrurSection.css( off );
            $genbankSection.css( on );
        }else if( val == db3 ){
            $cbrurSection.css( off );
            $genbankSection.css( on );
        }
    })
    .focus(function(){
        $( this ).trigger( "click" );
    });
});
</script>
<%@ include file="/search/common/inc/footer.jsp" %>
</body>
</html>
<%@ include file="closeDB.jsp" %>