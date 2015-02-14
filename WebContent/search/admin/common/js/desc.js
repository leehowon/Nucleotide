$("#cdName")
.mouseover(function() {
	view(this,"칼라코드 관리를 위한 이름을 입력하세요. 코드 스캔앱 히스토리에도 코드명이 제공됩니다.")
})
.focusin(function() {
	view(this,"칼라코드 관리를 위한 이름을 입력하세요. 코드 스캔앱 히스토리에도 코드명이 제공됩니다.")
})
.mouseout(function() {
	$(".pop_desc").remove()
})
.focusout(function() {
	$(".pop_desc").remove()
});

$("#mName")
.mouseover(function() {
	view(this,"회원명을 입력하세요.")
})
.focusin(function() {
	view(this,"회원명을 입력하세요.")
})
.mouseout(function() {
	$(".pop_desc").remove()
})
.focusout(function() {
	$(".pop_desc").remove()
});


$("#colorURL, #cardUrl1, #cardUrl2")
.mouseover(function() {
	view(this,"'http.' 또는 'https.'형태만 서비스 가능합니다.")
})
.focusin(function() {
	view(this,"'http.' 또는 'https.'형태만 서비스 가능합니다.")
})
.mouseout(function() {
	$(".pop_desc").remove()
})
.focusout(function() {
	$(".pop_desc").remove()
});


$("#tel")
.mouseover(function() {
	view(this,"'-' 없이 번호만입력 해외인 경우 '+'와 국가번호를 입력합니다. (ex. +82234567890)")
})
.focusin(function() {
	view(this,"'-' 없이 번호만입력 해외인 경우 '+'와 국가번호를 입력합니다. (ex. +82234567890)")
})
.mouseout(function() {
	$(".pop_desc").remove()
})
.focusout(function() {
	$(".pop_desc").remove()
});

$("#cardTel, #cardCellphone")
.mouseover(function() {
	view(this,"'-' 없이 번호만 입력")
})
.focusin(function() {
	view(this,"'-' 없이 번호만 입력")
})
.mouseout(function() {
	$(".pop_desc").remove()
})
.focusout(function() {
	$(".pop_desc").remove()
});

$("#colorApp")
.mouseover(function() {
	view(this,"칼라코드 전용 스캔앱에서 스캔시 연결되는 URL입니다. ")
})
.focusin(function() {
	view(this,"칼라코드 전용 스캔앱에서 스캔시 연결되는 URL입니다. ")
})
.mouseout(function() {
	$(".pop_desc").remove()
})
.focusout(function() {
	$(".pop_desc").remove()
});

$("#app_an, #app_ios")
.mouseover(function() {
	view(this,"해당앱에서 스캔시 연결되는 URL을 입력하세요.<br>'http.' 또는 'https.'형태만 서비스 가능합니다.")
})
.focusin(function() {
	view(this,"해당앱에서 스캔시 연결되는 URL을 입력하세요.<br>'http.' 또는 'https.'형태만 서비스 가능합니다.")
})
.mouseout(function() {
	$(".pop_desc").remove()
})
.focusout(function() {
	$(".pop_desc").remove()
});


$("#pwd, #pwd2, #copw, #copw2")
.mouseover(function() {
	view(this,"한/영/숫자 15글자 이내. 특수문자 불가")
})
.focusin(function() {
	view(this,"한/영/숫자 15글자 이내. 특수문자 불가")
})
.mouseout(function() {
	$(".pop_desc").remove()
})
.focusout(function() {
	$(".pop_desc").remove()
});



function view(id,text){
	var desc_width =$(id).css("width")
	var desc_w = Number(desc_width.substring(3,-1)) + 120
	var desc_w = desc_w + "px"
	var desc_height = $(id).css("height")
	$(id).parent("dd").append("<div class='pop_desc'><span></span>"+text+"</div>")
	$(".pop_desc").css("left",desc_w)
}