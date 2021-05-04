/**
 * last update : 2021 May 4
 */
// msg showing up when sign in or up
const $welcomeMsg = $(".welcome_msg");

// block when signed in
const $hp = $(".hcb_profile");

// block for log out
const $hmal = $(".hcb_mypage_and_logout");

//리스트 display 체크변수
let displayNum = 0;

//search bar
const $searchBarArea = $(".search_area");
const $searchBtn = $(".search_by_btn");

$welcomeMsg.fadeOut(2000);

// header button display/none on scroll
$(function() {
	
	//현재 스크롤값 가져오는 함수	
	function getCurrentScroll() {
		return window.pageYOffset || document.documentElement.scrollTop;
	}
	
	//스크롤을 얼마나 내렸을 때 명령을 실행할 것인지? shrinkHeader
	var shrinkHeader = 100;

	$(window).scroll(function() {
		var scroll = getCurrentScroll();
		if (scroll >= shrinkHeader) {
			$('.hcb_category ul').css("display", "none");
			$searchBarArea.css("transform", "translate(-215px, 0)")
		} else {
			$('.hcb_category ul').css("display", "block");
			$searchBarArea.css("transform", "translate(0, 0)")
		}
	});
	
});

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

const $searchBar = $(".search_bar");
const $searchBy = $(".search_by");
const $searchInput = $(".search_input");
const $searchResetBtn = $(".fas.fa-times.bar_component");
const searchType = $("input[name=searchType]");

// selection to bar
$searchBtn.click(function(){
	
	// get type value 
	const type = $(this).data("type");
	searchType.val(type);
	$searchInput.attr("placeholder", type=="item"?"무엇을 찾으시나요?":"배송지역(예. 송파구)");
	
	// btn disappear
	$searchBy.fadeOut(100, function(){
		$searchBar.fadeIn();	
	});
	
});

// bar to selection
$searchResetBtn.click(function(){
	
	// reset type value  
	searchType.val('');
	
	// bar disappear, btn appear back 
	$searchBar.fadeOut(100, function(){
		$searchBy.fadeIn();
	});
	
});

