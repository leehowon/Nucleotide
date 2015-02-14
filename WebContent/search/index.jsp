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
//        out.println( rs.getString("family_nm") );
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
        <div class="content_title">검색 DataBase 선택</div>
        <div class="check_box">
            <ul>
                <li>
                    <input type="radio" name="db_choice" id="db_choice1" value="result1">
                    <label for="db_choice1">CBRUR</label>
                </li>
                <li>
                        <input type="radio" name="db_choice" id="db_choice2" value="result2">
                        <label for="db_choice2">GenBank DB</label>
                </li>
                <li>
                        <input type="radio" name="db_choice" id="db_choice3" value="result3">
                        <label for="db_choice3">CBRUR + GenBank DB</label>
                </li>
            </ul>
        </div>
    </div>
    <div id="cbrurSection">
        <div class="content_box">
            <div class="content_title">검색 모드</div>
            <div class="check_box">
                <ul>
                    <li>
                        <input type="radio" name="searchMode" id="searchMode1" value="searchMode1">
                        <label for="searchMode1">종 검색</label>
                    </li>
                    <li>
                        <input type="radio" name="searchMode" id="searchMode2" value="searchMode2">
                        <label for="searchMode2">염기서열 검색</label>
                    </li>
                </ul>
            </div>
        </div>
        <div id="mode1Section" class="content_box mt20">
            <!-- 종 검색 선택시 노출 -->
            <div class="content_title">검색 염기서열</div>
            <div class="btn_box_add" style="position:absolute; left:139px; top:-11px"><button type="reset" id="resetBtn" class="btn_s btn_pe01">+ 추가</button></div>
            <dl>
                <dt>
                    <label for="upload">유전자명/구간명</label>
                </dt>
                <dd class="fl w270">
                    <input type="text" class="input" id="" >
                </dd>  
                <dt class="fl clno">
                    <label for="upload">업로드 파일선택 </label>
                </dt>
                <dd>
                    <input type="file" id="queryFile" name="queryFile" class="input" />
                    <button type="reset" id="resetBtn" class="btn_s btn_pe01">초기화</button>
                 </dd>                  
                 
            </dl>
            <textarea id="query" name="query" class="textarea"></textarea>
        </div>
        <div id="mode2Section">
            <div class="content_box mt20">
                <div class="content_title">검색 종/분류군 정보</div>
                <div class="content tr">
                    <span class="mr30">입력 가능한 정보만 입력하십시오.</span>
                </div>
                <dl>
                    <dt>
                        <label for="familyname"> 과명 </label>
                    </dt>
                    <dd class="fl w270">
                        <input type="text" class="input" id="familyNameKR" name="familyNameKR">
                    </dd>
                    <dt class="fl clno">
                        <label for="Family"> Family </label>
                    </dt>
                    <dd class="fl w270">
                        <input type="text" class="input" id="familyNameUS" name="familyNameUS">
                    </dd>
                    <dt class="fl clno">
                        <label for="genericname"> 속명 </label>
                    </dt>
                    <dd class="fl w270">
                        <input type="text" class="input" id="genusNameKR" name="genusNameKR">
                    </dd>
                    <dt class="fl clno">
                        <label for="genes"> Genus </label>
                    </dt>
                    <dd>
                        <input type="text" class="input" id="genusNameUS" name="genusNameUS">
                    </dd>
                    <dt class="fl clno">
                        <label for=""> 국명</label>
                    </dt>
                    <dd class="fl w270">
                        <input type="text" class="input" id="koreaName" name="koreaName">
                    </dd>
                    <dt class="fl clno">
                        <label for="specific"> Specific epithet</label>
                    </dt>
                    <dd>
                        <input type="text" class="input" id="specificName" name="specificName">
                    </dd>
                </dl>
            </div>
            <div class="content_box mt20">
                <!-- 염기 서열  검색 선택시 노출 -->
                <div class="content_title">검색 염기서열</div>
                <dl>
                    <dt>
                        <label for="upload">유전자명/구간명 </label>
                    </dt>
                    <dd>
                        <input type="text" class="input" id="geneOrSection" name="geneOrSection">
                    </dd>   
                </dl>
            </div>
        </div>
    </div>
    <div id="genbankSection" class="content_box mt20">
        <div class="content_title">검색 염기서열</div>
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
    <div class="btn_box"><button type="submit" class="btn_m btn_pe01">검색시작</button></div>
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
            db += $( "#searchMode1" )[0].checked ? "_1" : "_2";
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
            $genbankSection.css( off );
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
    })
        .eq( 0 )
        .trigger( "click" );
    
    $( "input[name='searchMode']" ).click(function(){
        var val = this.value
        , $mode1Section = $( "#mode1Section" )
        , $mode2Section = $( "#mode2Section" )
        , on = { "display" : "block" }
        , off = { "display" : "none" };
    
        if( val == "searchMode1" ){
            $mode1Section.css( on );
            $mode2Section.css( off );
        }else{
            $mode1Section.css( off );
            $mode2Section.css( on );
        }
    })
        .eq( 0 )
        .trigger( "click" );
});
</script>
<%@ include file="/search/common/inc/footer.jsp" %>
</body>
</html>