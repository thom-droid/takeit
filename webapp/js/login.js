/**
 * 
 */

const submitBtn = document.getElementById("submitBtn");
const nameCollection = document.getElementsByName("type");
const userid  = document.getElementById("userid");
const userpw  = document.getElementById("userpw");
let loginCheck = Boolean(localStorage.getItem("userinfo"));
let typeVal = '';

nameCollection.forEach(item=>{
	
	item.addEventListener("", ()=>{
		typeVal = this.value;
	});
});


function populateStorage(){
	let param = {"userType": typeVal, "userid": userid.value, "userpw": userpw.value};
	localStorage.setItem("userinfo", JSON.stringify(param));
	console.log(localStorage);			
}

submitBtn.addEventListener("click", (e)=>{
	e.preventDefault();
});


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