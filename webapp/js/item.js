/**
 * 
 */
/* ======================탭 내용 & css 변경========================= */

// 배송 옵션에 따른 가격 변동
const $optArea = $(".opt_area");

// 배송지 옵션 선택 + 가격 변동

$optArea.on("click", ".delivery_opt_label", function() {
	$(".total_price_input").val(this.dataset.price);
	$(".product_price").text(this.dataset.price);

	// 시도 / 시군구
	curAddrOptSido = this.dataset.sido;
	curAddrOptSigungu = this.dataset.sigungu;

	console.log(this.dataset.sido);
	console.log(this.dataset.sigungu);
	// 배송지 입력 후에 위에 배송지 옵션 바꿨을 경우 대비 기존 배송지 값을 지워줌

	if ($(".delivery_detail_box input").val()) {
		$(".delivery_detail_box input").val("");
	}


});// on click

/* 탭 */
const $tab = $(".product_detail_tab_box");
/* 탭 안의 컨텐츠 */
const $content = $(".content");

/* 탭 클릭 시 css 변경 & 변경된 탭 내용 보여주기 */
$tab.on("click", function() {
	$tab.removeClass("on");
	$(this).addClass("on");

	const onTab = $(this).attr("data-tab");

	$content.removeClass("on");
	$(this).addClass("on");
	$("#" + onTab).addClass("on");

}); //$tab click() end


/* ==========================datepicker 이용================================= */

/* datepicker 한글로 변경 */

$.datepicker.setDefaults({
	dateFormat: 'yy-mm-dd',
	prevText: '이전 달',
	nextText: '다음 달',
	monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	showMonthAfterYear: true,
	yearSuffix: '년'
});

let minDateInput = document.getElementById("dateVal");
let dateVal = minDateInput.value;
console.log(dateVal);
$(function() {

	//오늘 날짜를 출력
	$("#today").text(new Date().toLocaleDateString());

	$("#datepicker").datepicker({
		/*
			선택할 수 있는 최소 날짜 (3이면 현재 날짜로부터 3일 이후부터 가능)
			=> 나중에 서버에서 기버가 배송 가능한 날짜 선택하면
			그 값 받아서 나타내면 될 듯!
		 */
		minDate: dateVal,
		/* 뭔가 이거는 다같이 얘기 해봐야 하지 않을까? 최대 기간 정해두는 게 나을 것 같다. */
		maxDate: 14
	});

}); //function() end
