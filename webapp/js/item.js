
// delivery option
const $optArea = $(".opt_area");

// tab contents 
const $tab = $(".product_detail_tab_box");
const $content = $(".content");

// datepicker
let minDateInput = document.getElementById("dateVal");
let dateVal = minDateInput.value;


// rating 
let allRatings = document.querySelectorAll(".rating");
let ratingSum = 0;
let rating = ratingSum/allRatings.length;


// delivery option 
$optArea.on("click", ".delivery_opt_label", function() {
	
	$(".product_price").text(this.dataset.price);
	$(".opt_price_input").val(this.dataset.optPrice);
	$(".opt_region1_input").val(this.dataset.sido);
	$(".opt_region2_input").val(this.dataset.sigungu);
	$(".opt_no").val(this.dataset.optNo);
	$(".opt_area_no").val(this.dataset.optAreaNo);

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


// tab display action
$tab.on("click", function() {
	$tab.removeClass("on");
	$(this).addClass("on");

	const onTab = $(this).attr("data-tab");

	$content.removeClass("on");
	$(this).addClass("on");
	$("#" + onTab).addClass("on");

}); //$tab click() end



// datepicker setup
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


$(function() {

	//오늘 날짜를 출력
	$("#today").text(new Date().toLocaleDateString());

	$("#datepicker").datepicker({
		
		// date range available. 2 weeks from today
		minDate: dateVal,
		maxDate: 14
	});

}); //function() end


// count the numbers of reviews
allRatings.forEach(item =>{
	
	ratingSum += parseInt(item.textContent);
	
});

document.querySelector(".star_review").textContent = rating;
document.querySelector(".rating_num").innerHTML = allRatings.length; 

// validation test
const submitBtn = document.querySelector(".subscribeBtn");

submitBtn.addEventListener("click", (e)=>{
	
	let dateVal = document.getElementById("datepicker").value;
	let regionVal = document.getElementById("primaryRegion").value;
	let optPriceVal = document.getElementById("optPrice").value;
	
	if(!dateVal){
		alert("choose the date!");
		e.preventDefault();
	} else{
		alert(`${dateVal} is chosen`);
	}
	
	if(!regionVal || !optPriceVal){
		alert("choose the region!");
		e.preventDefault();
		
	} else if(regionVal && optPriceVal){
		
		alert(`지역 :  ${regionVal}, 추가가격 : ${optPriceVal}`);
	}
	
	
});



