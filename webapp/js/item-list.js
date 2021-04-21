/**
 * 
 */
// 언더스코어는 기본적으로 %을 사용하는데 %는  jsp에서 사용할 수 없기 때문에 % -> @ 로변경하는 코드가 필요함
_.templateSettings = { interpolate: /\<\@\=(.+?)\@\>/gim, evaluate: /\<\@([\s\S]+?)\@\>/gim, escape: /\<\@\-(.+?)\@\>/gim };


// popup for location info

const $location = $(".location");
const $popupLocation = $(".pop_where_wrap");
const $popupCloseBtn = $(".pop_close_button");

$location.click(function(){
	$popupLocation.addClass("on");
	
}); // popup showup 

// popup close with a btn
$popupCloseBtn.click(function() {
	$popupLocation.removeClass("on");
	
	//다시 눌렀을 때 빈 상태에서 다시 시작하게 하기 위함.
	
	$(".states_specifics>ul").removeClass("on");
	$("html").removeClass("on");
});// popup close


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




/*  ========================카테고리에 따라서 구독 상품 카드 목록 나타내기================================ */

//상품카드 템플릿 붙일 ul 요소
const $resultUl = $(".search_result_list");
//상품카드
const $subsCard = $(".search_result_item");
//상품카드템플릿
const $subsCardTmpl = _.template($("#subsCardTmpl").html());

// filter btn action
const $listBtn = $(".list_btn");

$listBtn.on("click", function(){
	const $nextUl = $(this).next();
	if($nextUl.css("display","none")){
		$nextUl.css("display", "block");
	} 
	
});


const url = window.location.href;


// template
const $resultArea = $(".search_result_list");
const $paginating = $(".pagination");

// filter var
const $filterByCategory = $(".by_category");
const $filterByOrder =$(".by_order");


// filter default value when html is rendered
let categoryValue = $filterByCategory.first().data("categoryNo");
let orderValue = "";


// filter by category
$filterByCategory.on("click", function(){
	const $this = $(this);
	const filterSelected = $this.text();
	categoryValue = this.dataset.categoryNo;
	console.log(categoryValue);
	console.log(orderValue);
	
	$this.closest(".btn_box").find(".list_btn").text(filterSelected);
	$this.closest(".btn_box").find(".list_btn").css({"color": "#0057D9", "font-weight": "500"});
	$this.closest(".sel_list_ul").css("display", "none");
	
	getItemList(categoryValue, orderValue);
});

// filtered by order
$filterByOrder.on("click", function(){
	const $this = $(this);
	const filterSelected = $this.text();
	orderValue = this.dataset.order;
	console.log(categoryValue);
	console.log(orderValue);
	
	$this.closest(".btn_box").find(".list_btn").text(filterSelected);
	$this.closest(".btn_box").find(".list_btn").css({"color": "#0057D9", "font-weight": "500"});
	$this.closest(".sel_list_ul").css("display", "none");
	
	getItemList(categoryValue, orderValue);
});


// getting page data when clicking a (next, prev btn)
$paginating.on("click", "a.paging", function(e){
	e.preventDefault();
	const $this = $(this);
	page = $this.data("page");
	console.log(page);
	getItemList(categoryValue, orderValue, page);
}); // on click

function getItemList(categoryValue, orderValue, page){
	
	$.ajax({
		url:"/ajax/filter/category/",
		type: "GET",
		data: {"categoryNo": categoryValue, "sort": orderValue, "page": page},
		dataType: "JSON",
		error: function(){
			alert("failed");
			},
		success: function(json){
			$resultUl.empty();
			$resultUl.append($subsCardTmpl({ subsCardList: json.subList }));
			$paginating.empty();
			$paginating.append(json.paginate);
		}
	});
} 

// call list on rendering
getItemList(categoryValue, orderValue);





