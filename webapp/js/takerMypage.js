/**
 * 
 */

//탭버튼, 구독 리스트 상수 선언
const $mySubscribeList = $(".my_subscribe_list");
const $mySubscribeListText = $(".my_subscribe_list>a")
const $mySubscribeHistory = $(".my_subscribe_history");
const $mySubscribeHistoryText = $(".my_subscribe_history>a");
const $currentSubscribes = $(".current_subscribes");
const $subscribesHistory = $(".subscribes_history");

//탭 버튼 누르면 해당 목록 나오게하기
//  $mySubscribeList.click(function (e) {
//    e.preventDefault();
//  $currentSubscribes.show();
// $subscribesHistory.hide();
// $mySubscribeHistoryText.removeClass("deco");
// $mySubscribeListText.removeClass("nodeco");

//});

// $mySubscribeHistory.click(function (e) {
//   e.preventDefault();
// $currentSubscribes.hide();
// $subscribesHistory.show();
//  $mySubscribeHistoryText.addClass("deco");
//  $mySubscribeListText.addClass("nodeco");

// });

const today = new Date();

const calendarEl = document.getElementById('calendar');

const calendar = new FullCalendar.Calendar(calendarEl, {
	headerToolbar: {
		//툴바 위치 조정 여기서 가능함
		//left, center, right 채워주지 않으면 중복해서 같은 기능이 채워지기도 함
		//필요 없는 기능 지웠더라도, left center right 다 채워져 있어야 함.
		//그 후 필요에 따라 위치조정 하는 것이 더 나을 듯.
		left: 'prev,next',
		center: 'title',
		right: 'today'
	},
	fixedWeekCount: false,//true로 하면 6주 보여줌. false이면 월에 따라서 4,5,6 주 보여 줌
	initialDate: today,
	//navLinks: true, // can click day/week names to navigate views
	//이거 true 아니면 e.stopPropagation(); 안해줘도 됨.
	businessHours: true, // display business hours
	editable: true,
	selectable: true,
	locale: "ko",
	//select: triggered when a date/time selection is made.
	dateClick: function(info) {
		console.log(info);
	}
});

calendar.render();
//리뷰작성버튼
const $writingReviewBtn = $(".write_review_btn");
//리뷰작성 팝업창
const $writeReviewPopUp = $(".write_review_pop_up");
//리뷰작성 팝업창 닫기 버튼
const $reviewCloseBtn = $(".review_close_btn");
const $gradingByStar = $(".grade_star_box>div");

$writingReviewBtn.click(function(e) {
	e.preventDefault();
	$writeReviewPopUp.addClass("write");
});
//닫기 버튼 누르면 리뷰 팝업창 닫히게하기
$reviewCloseBtn.click(function() {
	$writeReviewPopUp.removeClass("write");
	$('.grade_star_box>div').css('color', '#424242');
});

//리뷰 별표 클릭한 만큼 체크가 되도록
$gradingByStar.click(function() {
	const num = $(this).index();
	const index = num + 1;
	for (let i = 1; i < index + 1; i++) {
		$('.grade_star_box>div:nth-child(' + i + ')').css('color', '#b00020');
	}//for end

});



//프로필 사진 인풋요소 상수선언
const $profileInput = $("#takerProfileEdit");
//프로필 사진 업로드 관련 메세지
const $profileMsg = $(".profile_msg");
//테이커 프로파일 담기는 img 요소
const $takerProfileImage = $(".taker_profile>img");

$profileInput.on("change", function() {

	//File API 순수자바스크립트
	//input type=file요소에는
	//files라는 배열이 존재함

	//console.log(this.files);

	const file = this.files[0];

	//1) 파일의 크기가 0이상

	if (file.size == 0) {
		$profileMsg.text("제대로 된 파일을 선택해주세요.");
		return;
	}//if end

	//2) 파일의 종류가 image
	if (!file.type.includes("image/")) {
		//파일이 image가 아닐때
		$profileMsg.text("이미지를 선택해주세요.");
		return;
	}//if end

	$profileMsg.text("파일 업로드중...");

	//3) FormData객체 생성
	const formData = new FormData();

	//4) formdata에 파라미터를 추가

	//?type=P 파라미터
	formData.append("type", "P");

	//파일을 append
	formData.append("profile", file, file.name);

	//$.ajax의 enctype의 기본값은
	//application/x-www-form-urlencoded
	//enctype :
	//multipart/form-data로 넘겨야함
	//1) post방식
	//2) processData : false
	//3) contentType : false
	$.ajax({
		url: "/ajax/profile",
		type: "post",
		processData: false,
		contentType: false,
		data: formData,
		dataType: "json",
		error: function() {
			alert("서버 점검중!")
		},
		success: function(json) {

			//img요소의 src속성을 넘어온 이미지로 변경
			$takerProfileImage.attr("src", "/img/members/" + json.profileName);

			//메세지 제거
			$profileMsg.text("");

			//input hidden에 이름을 value로

			//$profileName.val(json.profileName);

			//서버단에서 vo에 설정된 프로필사진 멤버필드 명과 다른 이름으로
			//인풋타입 히든으로 name 넘겨야 함.


		}
	});//ajax() end

});//change end

//닉네임 수정 팝업창
const $nicknameEditPopUp = $(".nickname_edit_pop_up");
//닉네임 수정 버튼
const $nicknameEditBtn = $(".nickname_edit_btn");
//닉네임 인풋요소
const $nickname = $("#nickname");
//닉네임 메시지 박스
const $nicknameMsg = $(".nickname_msg");
//닉네임 팝업창 닫기 버튼
const $nicknameCloseBtn = $(".nickname_close_btn");
//닉네임 텍스트 부분
const $takerNicknameDd = $(".taker_nickname");
//닉네임 수정 팝업창 수정 버튼
const $appliedNicknameBtn = $(".apply_edited_nickname_btn");


$nicknameEditBtn.click(function() {
	$nicknameEditPopUp.addClass("edit");
});
$nicknameCloseBtn.click(function() {
	$nicknameEditPopUp.removeClass("edit");
	//입력 도중에 닫았을 시 다시 클릭하면 인풋 요소 비워져있게 하기 위함.
	$nickname.val("");
	//유효성 검사 메시지 비워주기
	$nicknameMsg.text("");
});

//nickname의 정규표현식
const nicknameRegExp = /^[가-힣|0-9]{2,8}$/;

//nickname에 글자를 쓸때
$nickname.on("keyup", function() {

	//우선 검사중으로
	$nicknameMsg.text("검사중...");

	//유저가 입력한 id값을 얻어옴
	const nickname = $nickname.val();

	//우선 정규표현식으로 test
	if (nicknameRegExp.test(nickname)) {

		//이때 ajax를 이용하여 데이터베이스에
		//이 아이디가 존재하는 지 확인!!
		$.ajax({
			url: "/ajax/check/nickname",//주소
			type: "get",//방식
			data: { "nickname": nickname },//파라미터
			dataType: "json",//응답의 자료형
			error: function(xhr, error) {
				alert("서버 점검중!");
				console.log(error);
			},
			success: function(json) {

				//alert("성공!!");
				//console.log(json);

				if (json.result) {
					$nicknameMsg.text("이미 사용중인 닉네임입니다.");

				} else {
					$nicknameMsg.text("아주 좋은 닉네임이군요!");

					//유효성 검사 통과하면 수정 버튼 활성화시키기.
					$appliedNicknameBtn.removeAttr("disabled");

				}//if~else end

			}
		});//ajax end

	} else {
		//틀렸을때
		$nicknameMsg.removeClass("ok")
			.text("한글, 숫자로 5글자 이상 입력해주세요. ㅠ-ㅠ");

	}//if~else end

});//keyup() end

$appliedNicknameBtn.click(function() {

	$nicknameEditPopUp.removeClass("edit");
	const nickname = $nickname.val();
	$takerNicknameDd.text(nickname);

});

//캘린더에 구독 정보 넣어 놓기
function getMonthlySubscriptions(info) {
	$.ajax({
		url: "ajax/monthlySubscriptions.json",
		data: {
			date: info
		},
		error: function() {
			alert("에러!");
		},
		success: function(json) {
			console.log(json);
			calendar.addEventSource(json);
		}
	});
}
getMonthlySubscriptions();


// 현재 구독 중인지 히스토리인지 //////////////////////////////////////////////////////////


_.templateSettings = { interpolate: /\<\@\=(.+?)\@\>/gim, evaluate: /\<\@([\s\S]+?)\@\>/gim, escape: /\<\@\-(.+?)\@\>/gim };
let page = 1;
const itemTmpl = _.template($("#itemTmpl").html());
const $itemListBox = $("#subItemList");

// 상품 목록 가져오는 함수 정의 
function getSubList() {
	let status = $("input:radio[name='status']:checked").val();
	$.ajax({
		//url:"/taker/"+${taker.no}+"/items",
		url: "/taker/" + 500 + "/items",
		type: "get",
		data: { status: status, page: page },
		error: function() {
			alert("해당 서비스 점검중 입니다. 나중에 다시 시도해주세요");
		},
		success: function(json) {
			console.log(json);
			$itemListBox.html(itemTmpl(json));
		}
	});
}



getSubList();




// 라디오 누를 때
$("input[type=radio]").on("change", function() {

	getSubList();
});

    //////////////////////////////////////////////////////////////////////////////////////////


