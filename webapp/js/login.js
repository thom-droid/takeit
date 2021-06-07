/**
 * 
 */

const submitBtn = document.getElementById("submitBtn");
const nameCollection = document.getElementsByName("type");
const typeT = document.getElementById("radioTaker");
const typeG = document.getElementById("radioGvier");
const userid  = document.getElementById("userid");
const userpw  = document.getElementById("userpw");
let loginCheck = Boolean(localStorage.getItem("userinfo"));
let typeVal = '';

// check user type
function getType(){
	
	nameCollection.forEach(item=>{
			
		if(item.checked){
			typeVal = item.value;
		}
	
	});
	return typeVal;
}

// assign user type when loaded
getType();

function populateStorage(){
	
	getType();
	let param = {"userType": typeVal, "userid": userid.value, "userpw": userpw.value};
	sessionStorage.setItem("loginInfo", JSON.stringify(param));
	
}

if(!loginCheck){
	submitBtn.onclick = populateStorage;
}

if(loginCheck){
	let userInfoObj = JSON.parse(localStorage.getItem("userinfo"));
	typeVal = userInfoObj.userType;
	console.log(typeVal);
	userid.value = userInfoObj.userid;
	console.log(userid.value);
	userpw.value = userInfoObj.userpw;
	console.log(userpw.value);
}

// input value validation
submitBtn.addEventListener("click", function(e){
	
	// check empty values in input
	let loginInput = document.querySelectorAll(".login_input");
	
	loginInput.forEach((item)=>{
		
		if(!item.value){
			e.preventDefault();
			alert("아이디 또는 비밀번호를 입력해주세요");
		} 
		
	});
	
});

// no matching result
const loginFailed = document.getElementById("loginFailed");

if(loginFailed){
	alert("아이디 또는 비밀번호가 올바르지 않습니다");
}




