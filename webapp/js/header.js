/**
 * 
 */
const $welcomeMsg = $(".welcome_msg");
    
$welcomeMsg.fadeOut(2000);
$(function() {
	//스크롤을 얼마나 내렸을 때 명령을 실행할 것인지? shrinkHeader
	var shrinkHeader = 100;

	$(window).scroll(function() {
		var scroll = getCurrentScroll();
		if (scroll >= shrinkHeader) {
			$('.hcb_category ul').css("display", "none");
		} else {
			$('.hcb_category ul').css("display", "block");
		}
	});
	//현재 스크롤값 가져오는 함수
	function getCurrentScroll() {
		return window.pageYOffset || document.documentElement.scrollTop;
	}
});

//로그인 했을경우 나오는 아이콘
$hp = $(".hcb_profile");
//아이콘 클릭시 나오는 리스트(마이페이지/로그아웃)
$hmal = $(".hcb_mypage_and_logout");

//리스트 display 체크변수
let displayNum = 0;
//아이콘 클릭시 리스트 display 변경함수
$hp.click(function() {
	if (displayNum == 0) {
		$hmal.css("display", "block")
		displayNum = 1;
	} else {
		$hmal.css("display", "none")
		displayNum = 0;
	}
})//end hp.click