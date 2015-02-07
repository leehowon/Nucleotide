<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<div class="popup" id="name_search_pop">
	<div class="popup_box">
			<div class="btn_close" onClick="$('#name_search_pop').toggle()">X</div>
			<div class="tc">	<strong>회원명</strong>&nbsp; &nbsp;<input type="text" class="input w300"  onClick=""> &nbsp;<img src="../common/ui/img/search.png"> </div>
<div class="table_box">	
			<table class="table">
				<thead>
				<tr><th>회원명</th><th>회원유형</th><th>고객명</th><th>담당자</th><th>전화번호</th></tr>
				</thead>
				<tbody>
				<tr>
					<td>기아자동차</td><td>기업</td><td>-</td><Td>고우리</Td><td>01012341234</td>
				</tr>
				<tr>
					<td>기아자동차</td><td>기업</td><td>모비잼</td><Td>고우리</Td><td>01012341234</td>
				</tr>
				</tbody>
			</table>	
		</div>
			
			<%@ include file="/colorzip/common/inc/page.jsp" %>
			
			<div class="empty tc">
				검색 결과가 없습니다.
			</div>			
	</div>
</div>

<div class="popup" id="code_pe_pop">
	<div class="popup_box">
			<div class="btn_close" onClick="$('#code_pe_pop').toggle()">X</div>
			<div class="title">코드명 : <strong>숙이</strong></div>
<div class="table_box">	
			<table class="table">
			<col width="40">
			<col width="">
			<col width="110">
			<col width="80">
			<col width="80">												
				<thead>
				<tr><th>No.</th><th>발급일시</th><th>코드값</th><th>칼라코드</th><th>코드디자인</th></tr>
				</thead>
				<tbody>
				<tr>
					<td>1</td><td>2014.04.05 13:09:07</td><td>1223445566</td><Td><img src="/colorzip/common/ui/img/sample_code.png" width="40"></Td><td><a href="code_down.jsp?type=<%=mainFlag%>"><img src="/colorzip/common/ui/img/sub_ico_7.png"</a></td>
				</tr>
				<tr>
					<td>2</td><td>2014.04.05 13:09:07</td><td>1223445566</td><Td><img src="/colorzip/common/ui/img/sample_code.png" width="40"></Td><td><a href="code_down.jsp?type=<%=mainFlag%>"><img src="/colorzip/common/ui/img/sub_ico_7.png"</a></td>
				</tr>
				<tr>
					<td>2</td><td>2014.04.05 13:09:07</td><td>1223445566</td><Td><img src="/colorzip/common/ui/img/sample_code.png" width="40"></Td><td><a href="code_down.jsp?type=<%=mainFlag%>"><img src="/colorzip/common/ui/img/sub_ico_7.png"</a></td>
				</tr>
				<tr>
					<td>2</td><td>2014.04.05 13:09:07</td><td>1223445566</td><Td><img src="/colorzip/common/ui/img/sample_code.png" width="40"></Td><td><a href="code_down.jsp?type=<%=mainFlag%>"><img src="/colorzip/common/ui/img/sub_ico_7.png"</a></td>
				</tr>
				<tr>
					<td>2</td><td>2014.04.05 13:09:07</td><td>1223445566</td><Td><img src="/colorzip/common/ui/img/sample_code.png" width="40"></Td><td><a href="code_down.jsp?type=<%=mainFlag%>"><img src="/colorzip/common/ui/img/sub_ico_7.png"</a></td>
				</tr>
				</tbody>
		</table>
		</div>
		<%@ include file="/colorzip/common/inc/page.jsp" %>
				
	</div>
</div>

<div class="popup" id="member_client_pop">
	<div class="popup_box">
			<div class="btn_close" onClick="$('#member_client_pop').toggle()">X</div>
			<div class="title">모비쟆미디어(대행사) 고객사 리스트</div>
<div class="table_box">	
			<table class="table">
			<col width="100">
			<col width="100">
			<col width="70">
			<col width="70">
			<col width="100">												
			<col width="65">												
				<thead>
				<tr><th>고객명</th><th>등록일</th><th>사업부서</th><th>담당자명</th><th>전화번호</th><th>등록코드</th></tr>
				</thead>
				<tbody>
				<tr>
					<th>고객명</th><td>2014.04.05</td><td>마케팅</td><Td>홍길동</Td><td>01012341234</td><td>0</td>
				</tr>
				<tr>
					<th>고객명</th><td>2014.04.05</td><td>마케팅</td><Td>홍길동</Td><td>01012341234</td><td>0</td>
				</tr>
				<tr>
					<th>고객명</th><td>2014.04.05</td><td>마케팅</td><Td>홍길동</Td><td>01012341234</td><td>0</td>
				</tr>
				<tr>
					<th>고객명</th><td>2014.04.05</td><td>마케팅</td><Td>홍길동</Td><td>01012341234</td><td>0</td>
				</tr>
				<tr>
					<th>고객명</th><td>2014.04.05</td><td>마케팅</td><Td>홍길동</Td><td>01012341234</td><td>0</td>
				</tr>
				</tbody>
		</table>
		</div>
		
		<%@ include file="/colorzip/common/inc/page.jsp" %>
				
	</div>
</div>


<div class="popup" id="code_down_pop">
	<div class="popup_box">
			<div class="btn_close" onClick="$('#code_down_pop').toggle()">X</div>
			<div class="title">
코드명: <strong>000</strong> <br>
이미지: <strong>가이드형, JPEG</strong>
			<hr style="margin:20px 0">
			</div>
		<div class="icon_to">
		<a href="#"><img src="../common/ui/img/icon_email.png"></a>&nbsp;		
		<a href="#"><img src="../common/ui/img/icon_print.png"></a>		
		
		</div>	
			
		<div class="colorcode">		
		<img src="../common/ui/img/sample_code1.png">
		</div>	
	</div>
</div>

