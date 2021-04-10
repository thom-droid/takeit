/**
 * 
 */
// 언더스코어는 기본적으로 %을 사용하는데 %는  jsp에서 사용할 수 없기 때문에 % -> @ 로변경하는 코드가 필요함
_.templateSettings = { interpolate: /\<\@\=(.+?)\@\>/gim, evaluate: /\<\@([\s\S]+?)\@\>/gim, escape: /\<\@\-(.+?)\@\>/gim };



//양말 스타킹 탭
const $socksAndStockingTab = $(".socks_and_stocking_tab");
// 양말, 스타킹 박스
const $socksAndStockinngBox = $(".socks_stocking_box");
//패션 스타일링 탭
const $fashionStylingTab = $(".fashion_styling_tab");
//패션,스타일링 박스
const $fashionStylingBox = $(".fashion_styling_box");

//탭 자바스크립트 start
$socksAndStockingTab.click(function() {
	$fashionStylingBox.css("display", "none");
	$socksAndStockinngBox.css("display", "block");
	$fashionStylingTab.removeClass("text_strong");
	$(this).addClass("text_strong");
});//click() end

$fashionStylingTab.click(function() {
	$fashionStylingBox.css("display", "block");
	$socksAndStockinngBox.css("display", "none");
	//패션스타일링탭 클래스에 text_strong를 추가한것
	$(this).addClass("text_strong");
	$socksAndStockingTab.removeClass("text_strong");
});//탭 자바스크립트 end

//-------------------지역 필터 팝업----------------------

//한 지역 누르면 세부 지역 뜨게 하기
$(".korea_states li").click(function(e) {
	e.preventDefault();
	const sequence = $(this).index();
	$(".states_specifics>ul").removeClass("on");
	$(".states_specifics>ul").eq(sequence).addClass("on");

	$.ajax({
		url: "ajax/location.json",
		type: "POST",
		dataType: "json",
		error: function() {
			alert("점검중");
		},
		success: function(json) {
			//지역필터 시 보여줄 부분
			alert("성공");
		}
	});
});//click() end

//어디서 버튼 누르면 팝업창 뜰 수 있도록 함
$(".search_specifics .where").click(function(e) {
	$(".pop_where_wrap").addClass("on");
	$("html").addClass("on");
});//click() end

//엑스버튼 누르면 꺼지도록
$(".pop_close_button").click(function() {
	$(".pop_where_wrap").removeClass("on");
	//다시 눌렀을 때 빈 상태에서 다시 시작하게 하기 위함.
	$(".states_specifics>ul").removeClass("on");
	$("html").removeClass("on");
});//click() end


/*  ========================카테고리에 따라서 구독 상품 카드 목록 나타내기================================ */

//상품카드 템플릿 붙일 ul 요소
const $resultUl = $(".search_result_list");
//상품카드
const $subsCard = $(".search_result_item");
//상품카드템플릿
const $subsCardTmpl = _.template($("#subsCardTmpl").html());

//카테고리 선택시 ajax
$(".select_category").change(function() {
	$.ajax({
		url: "/ajax/category/result",
		type: "POST",
		dataType: "json",
		error: function() {
			alert("점검중");
		},
		success: function(json) {
			//카테고리 선택에 따른 검색결과 list 보여주기
			alert("성공");

			//이전 데이터 지우기
			$resultUl.empty();
			//상품 카드 템플릿
			$resultUl.append(subsCardTmpl({ subsCardList: json }));

		}// success end
	}); // $.ajax()

});

//정렬필터 선택시 ajax
$(".search_order_filter").change(function() {
	$.ajax({
		url: "ajax/location.json",
		type: "POST",
		dataType: "json",
		error: function() {
			alert("점검중");
		},
		success: function(json) {
			//정렬 필터 선택에 따른 검색결과 list 보여주기
			alert("성공");
		}
	});

});//change() end
