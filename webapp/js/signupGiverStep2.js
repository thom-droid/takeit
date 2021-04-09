/**
 * 
 */

$businessNumInput = $('#businessNumInput'); //사업자번호 입력공간
$nextBtn = $('.nextBtn'); //다음 버튼
myStorage = window.localStorage;

$businessNumInput.on('keyup', (function() { //사업자 번호 input의 키보드 이벤트

	let nu = $businessNumInput.val(); //input의 값

	if (nu.length == 10) { //input의 입력값이 10개일 때
		$nextBtn.css({
			"background-color": "#0B4D40",
			"pointer-events": "auto",
			"box-shadow": "0 8px 17px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)"
		})
	} else {
		$nextBtn.css({
			"background-color": "#424242",
			"pointer-events": "none",
			"box-shadow": "none"
		})
	}//end else
}))//end $businessNumInput.on()