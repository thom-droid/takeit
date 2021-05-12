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

// query string object
const queryString = window.location.search;
const searchParams = new URLSearchParams(queryString);

// filter btn action
const $listBtn = $(".list_btn");
const $orderBtn = $(".order_btn");
const locTagBtnAll = document.querySelectorAll(".loc_tag_btn");

// filter var
const $filterByCategory = $(".by_category");
const $filterByOrder =$(".by_order");

// filter default value when html is rendered
let categoryValue = $filterByCategory.first().data("categoryNo");
let orderValue = searchParams.get("sort");
console.log(orderValue);
let locationVal = "";

// reset btn
const $filterResetBtn = $(".reset_btn");

// check search value from query string
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

const resultText = document.querySelector(".result_text");
const resultNum = document.querySelector(".result_num");
const locationNum = document.getElementsByClassName("location_num");

// check whether or not value is typed from search
if (paramCheck){
	getItemList(categoryValue, orderValue, locationVal, searchType, searchValue );
	
	// search result 
	const resultTxt = `${searchValue} 검색결과`;
	let num = 0;
	
	// numbers of location found
	for (var i =0;i<locationNum.length;i++){
		const val = parseInt(locationNum[i].innerHTML);
		num += val;
	}
		
	resultNum.innerText = num;
	resultText.innerText = resultTxt;
	
	console.log(`paramCheck is ${paramCheck}!`);
	
} else{
	if(orderValue === "lat"){
		$orderBtn.text("최신순").css({"color":"#0057D9", "font-weight": "500"});	
	}
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
	console.log(searchType);
	console.log(searchValue);
	
	$this.closest(".btn_box").find(".list_btn").text(filterSelected).css({"color": "#0057D9", "font-weight": "500"});
	$this.closest(".sel_list_ul").css("display", "none");
	
	getItemList(categoryValue, orderValue, locationVal, searchType, searchValue);
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
	
	getItemList(categoryValue, orderValue, locationVal, searchType, searchValue);
});


// getting page data when clicking a (next, prev btn)
$paginating.on("click", "a.paging", function(e){
	e.preventDefault();
	const $this = $(this);
	let page = $this.data("page");
	console.log(page);
	getItemList(categoryValue, orderValue, locationVal, searchType, searchValue, page);
}); // on click

// reset filtered list to default
$filterResetBtn.click(function(){
	
	location.reload();
	
});

// getting list by location from search result
locTagBtnAll.forEach(item =>{
	item.addEventListener("click", function(){
	
		locationVal = this.dataset.locName;
		getItemList(categoryValue, orderValue, locationVal,searchType, searchValue);
		locTagBtn.style.backgroundColor = "#DBE0DF";	
	});
	
});

/*addEventListener("click", function(){
	console.log(this.dataset.locName);
	locationVal = this.dataset.locName;
	getItemList(categoryValue, orderValue, locationVal,searchType, searchValue);
	locTagBtn.style.backgroundColor = "#DBE0DF";
	
});*/



