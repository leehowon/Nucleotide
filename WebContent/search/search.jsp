<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ include file="/search/common/inc/headin.jsp" %>
<body>
<%@ include file="/search/common/inc/header.jsp" %>
<div class="contents_box">
    <div class="content_box">
        <div class="content_title">| 검색 DataBase 선택</div>
        <div class="check_box">
            <ul>
                <li>
                    <label>
                        <input type="radio" name="db_choice">
                        CBRUR </label>
                </li>
                <li>
                    <label>
                        <input type="radio" name="db_choice">
                        DBenBank DB</label>
                </li>
                <li>
                    <label>
                        <input type="radio" name="db_choice">
                        CBRUR+DBenBank DB</label>
                </li>
            </ul>
        </div>
    </div>
    <div class="content_box mt20">
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
                <input type="text" class="input " id="specific" >
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
    <div class="content_box mt20">
        <div class="content_title">| 염기서열 검색</div>
        <div class="content">
            <div class="btn_box"><a href="#" class="btn_s btn_pe01">초기화</a></div>
            <textarea id="textarea" class="textarea"></textarea>
        </div>
        <dl>
            <dt>
                <label for="upload"> 업로드 파일선택 </label   >
            </dt>
            <dd>
                <input type="file" class="input w640" id="upload" >
            </dd>   
        </dl>
    </div>

    <div class="btn_box"> <a href="result.jsp" class="btn_m btn_pe01">BLAST</a> </div>

</div>
<%@ include file="/search/common/inc/footer.jsp" %>
</body>
</html>
