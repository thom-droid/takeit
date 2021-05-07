/**
 * 
 */
// interpolation for underscore.js
_.templateSettings = { interpolate: /\<\@\=(.+?)\@\>/gim, evaluate: /\<\@([\s\S]+?)\@\>/gim, escape: /\<\@\-(.+?)\@\>/gim };


// popup for location info

const $location = $(".location");
const $popupLocation = $(".pop_where_wrap");
const $popupCloseBtn = $(".pop_close_button");
const $primaryLocation = $(".pop_primary_location");
const $secondLocation = $(".pop_second_location");
const $primaryItem = $(".primary_location_item");
const $secondItem = $(".second_location_item");
const $locationBtn = $(".location.header_btn");

let itemIdx = 0;


// template
const $resultArea = $(".search_result_list");
const $paginating = $(".pagination");
const $resultUl = $(".search_result_list");
const $subsCard = $(".search_result_item");
const $subsCardTmpl = _.template($("#subsCardTmpl").html());


// filter btn action
const $listBtn = $(".list_btn");

// filter var
const $filterByCategory = $(".by_category");
const $filterByOrder =$(".by_order");

// filter default value when html is rendered
let categoryValue = $filterByCategory.first().data("categoryNo");
let orderValue = "";
let locationVal = "";

// reset btn
const $filterResetBtn = $(".reset_btn");

// check search value
const queryString = window.location.search;
const searchParams = new URLSearchParams(queryString);

const searchType = searchParams.get("searchType");
console.log(searchType);
const searchValue = searchParams.get("searchValue");
console.log(searchValue);
const paramCheck = Boolean(searchParams.get("searchValue")); // false whne there is no query string 

// item list ajax 
function getItemList(categoryValue, orderValue, locationVal, searchType, searchValue, page){
	
	
	if (!categoryValue){
		categoryValue = 0;
	}
	$.ajax({
		url:"/ajax/filter/category/",
		type: "GET",
		data: {"categoryNo": categoryValue, "sort": orderValue, "page": page, "location": locationVal, "searchType": searchType, "searchValue": searchValue},
		dataType: "JSON",
		error: function(){
			alert("failed");
			},
		success: function(json){
			$resultUl.empty();
			$resultUl.append($subsCardTmpl({ subsCardList: json.subList }));
			$paginating.empty();
			$paginating.append(json.paginate);
			console.log(json.subList);
			console.log(json.paginate);
		}
	});
} 

// popup close with a btn
function closePopup(){
	$popupLocation.removeClass("on");
	$("body").css("overflow", "auto");
}

// call list on rendering 
if (paramCheck){
	getItemList(categoryValue, orderValue, locationVal, searchType, searchValue );
	console.log(`paramCheck is ${paramCheck}!`);
} else{
	getItemList(categoryValue, orderValue, locationVal);
	console.log(`paramCheck is ${paramCheck}!`);	
}


// open popup 
$location.click(function(){
	$popupLocation.addClass("on");
	$("body").css("overflow", "hidden");
	
	// default view 
	$secondLocation.eq(itemIdx).addClass("show");
}); 


// close popup
$popupCloseBtn.click(function() {
	closePopup();
});


// location selecting interaction
// primary location tab
$primaryItem.click(function(){
	itemIdx = $(this).index();
	$secondLocation.removeClass("show");
	$secondLocation.eq(itemIdx).addClass("show");
});

// secondary location selection
$secondItem.click(function(){
	locationVal = $(this).children().eq(0).text();
	console.log(locationVal);
	$locationBtn.text(locationVal).css("color","#0057D9");
	closePopup();
	getItemList(categoryValue, orderValue, locationVal);
});


$listBtn.on("click", function(){
	const $nextUl = $(this).next();
	if($nextUl.css("display","none")){
		$nextUl.css("display", "block");
	} 
	
});


// filter by category
$filterByCategory.on("click", function(){
	const $this = $(this);
	const filterSelected = $this.text();
	categoryValue = this.dataset.categoryNo;
	console.log(categoryValue);
	console.log(orderValue);
	
	$this.closest(".btn_box").find(".list_btn").text(filterSelected).css({"color": "#0057D9", "font-weight": "500"});
	$this.closest(".sel_list_ul").css("display", "none");
	
	getItemList(categoryValue, orderValue, locationVal);
});

// filter by order
$filterByOrder.on("click", function(){
	const $this = $(this);
	const filterSelected = $this.text();
	orderValue = this.dataset.order;
	console.log(categoryValue);
	console.log(orderValue);
	
	$this.closest(".btn_box").find(".list_btn").text(filterSelected).css({"color": "#0057D9", "font-weight": "500"});
	$this.closest(".sel_list_ul").css("display", "none");
	
	getItemList(categoryValue, orderValue, locationVal);
});


// getting page data when clicking a (next, prev btn)
$paginating.on("click", "a.paging", function(e){
	e.preventDefault();
	const $this = $(this);
	let page = $this.data("page");
	console.log(page);
	getItemList(categoryValue, orderValue, locationVal, page);
}); // on click

// reset filtered list to default
$filterResetBtn.click(function(){
	
	location.reload();
	
});





