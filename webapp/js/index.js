
let left = 0;
let kategorieLeft = 0;
const $kategorieList = $(".kategorie_list");
const $next = $(".next");
const $prev = $(".prev");
const $slide_list = $(".slide_list");

//다음버튼눌렀을때
$next.on("click", function () {
	$prev.css("visibility", "visible");
	left -= 990;
	kategorieLeft -=1100;
	$kategorieList.css("left", kategorieLeft);
	console.log(left);


	$slide_list.css("left", left);

	if (left == -2970) {
		$next.css("visibility", "hidden");
		console.log(left);
	}
});

//이전버튼눌렀을때
$prev.on("click", function() {
	$next.css("visibility", "visible");
	left += 990;
	kategorieLeft += 1100;
	$kategorieList.css("left", kategorieLeft);
	console.log(left);

	$slide_list.css("left", left);
	if (left == 0) {
		$prev.css("visibility", "hidden");
	}
});