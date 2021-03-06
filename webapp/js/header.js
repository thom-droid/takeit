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
		//when scrolled down
		if (scroll >= shrinkHeader) {
			
			
		} else {
			
			
		}
	});
	
});

//아이콘 클릭시 리스트 display 변경함수
$hp.click(function() {
	if (displayNum == 0) {
		$hmal.css("display", "flex");
		displayNum = 1;
	} else {
		$hmal.css("display", "none");
		displayNum = 0;
	}
})//end hp.click

const $searchBar = $(".search_bar");
const $searchBy = $(".search_by");
const $searchInput = $(".search_input");
const $searchResetBtn = $(".fas.fa-times.bar_component");
const type = document.getElementById("searchType");

// selection to bar
$searchBtn.click(function(){
	
	// get type value 
	const typeVal = this.dataset.type;
	type.value = typeVal;
	$searchInput.attr("placeholder", typeVal=="item"?"무엇을 찾으시나요?":"배송지역(예. 송파구)");
	
	// btn disappear
	$searchBy.fadeOut(100, function(){
		$searchInput.focus();
		$searchBar.css("display", "flex");
				
	});
	
});

// bar to selection
$searchResetBtn.click(function(){
	
	// reset type value  
	type.value="";
	searchInput.value="";
	
	// bar disappear, btn appear back 
	$searchBar.fadeOut(100, function(){
		$searchBy.fadeIn();
	});
	
});

// search input validation check

let searchInput = document.querySelector(".search_input");
let queryValue = "";
	
let validationCheck = true;

searchInput.addEventListener("keydown", (event) =>{
	const keyName = event.key;
	
	if(keyName ==="Enter"){
		queryValue = searchInput.value; 
		console.log(queryValue);
		if(!queryValue){
			alert("검색어를 입력해주세요");
			validationCheck = false;
			console.log(validationCheck);
			event.preventDefault();
			searchInput.focus();
			return false;
		}
		console.log(validationCheck);
		return validationCheck;
	}
});

console.log(validationCheck);
