/**
 * 
 */
const $html = $("html");
const $taker = $("#taker");
const $giver = $("#giver");
const $takerIntroduce = $(".takerIntroduce");
const $giverIntroduce = $(".giverIntroduce");

$taker.on("click", function() {
	$takerIntroduce.css("display", "block");
	$giverIntroduce.css("display", "none");
	$html.css("padding-right", "17px");
});
$giver.on("click", function() {
	$takerIntroduce.css("display", "none");
	$giverIntroduce.css("display", "block");
	$html.css("padding-right", "0");
});