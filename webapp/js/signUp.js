const $month = $(".birth_month_input");

function yearSelect (){
	let nowDate = new Date();
	let nowYear = nowDate.getFullYear()
	let yearText = "";
	let i;
	for(i = nowYear; i>1900;i--){
		yearText += "<option value="+i+">"+i+"</option>";
		
	}
	$(".birth_year_input").html(yearText);
}

yearSelect();

function monthSelect(){
	let monthText ="";
	let i;
	for(i = 1;i<13;i++){
		monthText += "<option value="+i+">"+i+"</option>";
	}
	
	$(".birth_month_input").html(monthText);
}

monthSelect();

$month.on("change", function(){

	let monthVal = $month.val();
	
	let dateText = "";
	let i;
	
	if(monthVal === 2){
		for(i=1;i<29;i++){
			dateText += "<option value="+i+">"+i+"</option>";
		}
		
	} 
	
	if(monthVal%2 ===0){
		for(i=1;i<31;i++){
			dateText += "<option value="+i+">"+i+"</option>";
		}
	} else {
		for(i=1;i<32;i++){
			dateText += "<option value="+i+">"+i+"</option>";
		}
		
	}
	
	$(".birth_date_input").html(dateText);
});// on change

function dateSelect(){
	
	
}

/*======아이디========= */
//id 입력필드
const $id = $(".id_input");
//id에 대한 메세지
const $idMsg = $(".id_notice");

const idRegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;

$id.on("keyup",function() {
	
	//우선 검사중으로
	$idMsg.text("검사중..");	
	
	//유저가 입력한 id값을 얻어옴
	const id = $id.val();
	
	//우선 정규표현식으로 test
	if(idRegExp.test(id)) {
				//이때 ajax를 이용하여 데이터베이스에
				//이 아이디가 존재하는 지 확인!!
				$.ajax({
					url:"/ajax/check/id",//주소
					type:"get",//방식
					data:{"id":id},//파라미터
					dataType:"json",//응답의 자료형
					error:function(xhr,error){
						alert("서버 점검중!");
						console.log(error);
					},
					success:function(json){
						
						//alert("성공!!");
						//console.log(json);
						
						if(json.result) {
							$idMsg.text("이미 사용중이거나 탈퇴한 아이디입니다.");
							$idMsg.css("color", "red");
							
						}else {
							$idMsg.text("사용하실 수 있는 이메일입니다!");
							$idMsg.css("color", "blue");
							
						}//if~else end
						
					}
				});//ajax end
				
			}else {
				//틀렸을때
				$idMsg.text("올바른 형식으로 입력해주세요.");
				$idMsg.css("color", "red");
				
			}//if~else end
	
});//keyup() end

/*==========비밀번호============= */
//비밀번호 유효성검사
const $passwordInput = $(".password_input");
const $passwordNotice = $(".password_notice");
const $passwordConfirmInput = $(".password_confirm_input");
const $passwordConfirmNotice = $(".password_confirm_notice");

function checkPassword(password){
    let passwordNum = password.search(/[0-9]/g);
    let passwordEng = password.search(/[a-z]/ig);
    let passwordSpe = password.search(/[~!@#$%^&*()_+|<>?:{}]/g);

    if((password.length < 8 || password.length > 12) || (passwordNum<0 || passwordEng<0 || passwordSpe<0)){
        $passwordNotice.show();
        $passwordNotice.css("color","crimson");
        $passwordNotice.children("span").text("영문 및 숫자, 특수문자 포함 8~12자입니다.");
    }else if(password.search(/\s/) != -1){
        $passwordNotice.show();
        $passwordNotice.css("color","crimson");
        $passwordNotice.children("span").text("공백은 허용되지 않습니다.");
    }else {
        $passwordNotice.show();
        $passwordNotice.css("color","blue");
        $passwordNotice.children("span").text("사용가능한 비밀번호입니다.");
    }
}

function checkPasswordConfirm(password, passwordConfirm){
	
    if(!password){
        $passwordConfirmNotice.show();
        $passwordConfirmNotice.css("color", "crimson");
        $passwordConfirmNotice.children("span").text("비밀번호를 입력하여주세요.");
    }else if(password==passwordConfirm){
        $passwordConfirmNotice.show();
        $passwordConfirmNotice.css("color", "blue");
        $passwordConfirmNotice.children("span").text("비밀번호가 일치합니다.");
    }else{
        $passwordConfirmNotice.show();
        $passwordConfirmNotice.css("color", "crimson");
        $passwordConfirmNotice.children("span").text("비밀번호가 일치하지 않습니다.");
    }
}

$passwordInput.blur(function(){
    checkPassword($passwordInput.val());
});
$passwordConfirmInput.blur(function(){
    checkPasswordConfirm($passwordInput.val(), $passwordConfirmInput.val());
});
//2021/02/25 박형우 작성---------------------------------------------------------------

//닉네임 유효성 검사
const $nicknameInput = $(".nickname_input");
const $nicknameNotice = $(".nickname_notice");


//nickname 정규표현식
const nicknameRegExp = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|a-zA-Z]{1,10}$/;

//nickname에 글자를 쓸때	
	$nicknameInput.on("keyup",function() {
	
	//우선 검사중으로
	$nicknameNotice.children("span").text("검사중..");	
	
	//유저가 입력한 id값을 얻어옴
	const nickname = $nicknameInput.val();
	
	//우선 정규표현식으로 test
	if(nicknameRegExp.test(nickname)) {
		
		//이때 ajax를 이용하여 데이터베이스에
		//이 아이디가 존재하는 지 확인!!
		$.ajax({
			url:"/ajax/check/nickname",//주소
			type:"get",//방식
			data:{"nickname":nickname},//파라미터
			dataType:"json",//응답의 자료형
			error:function(xhr,error){
				alert("서버 점검중!");
				console.log(error);
			},
			success:function(json){
				
				if(json.result) {
					$nicknameNotice.show();
                    $nicknameNotice.css("color", "crimson");
                    $nicknameNotice.children("span").text("중복되는 닉네임입니다.");
					
				}else {
					 $nicknameNotice.show();
                     $nicknameNotice.css("color", "blue");
                     $nicknameNotice.children("span").text("사용가능한 닉네임입니다.");
					
				}//if~else end
				
			}
		});//ajax end
		
	}else {
			$nicknameNotice.show();
	        $nicknameNotice.css("color", "crimson");
	        $nicknameNotice.children("span").text("올바른 형식으로 입력해주세요.");
		
	}//if~else end
	
});//keyup() end


$nicknameInput.blur(function(){
    checkNickname($nicknameInput.val());
});

//2021/02/25 박형우 작성---------------------------------------------------------------

//프로필 이미지 처리
const $profileImgInput = $("#profileImgInput");
const $profileImg = $(".profile_img_input");
const $profileImgVal = $("#profileImgVal");
const $plusSquare = $(".far.fa-plus-square");
const $profileDelBtn = $(".far.fa-times-circle");

$profileImgInput.on("change", function(){
   		const file = this.files[0];
   		
    
    	if (/^image\//.test(file.type)) {
        const formData = new FormData();

		formData.append("type", "P");
        formData.append("uploadImg", file, file.name);

        $.ajax({
        url:"/ajax/profile",
        type : 'POST',//multipart/form-data
        processData : false,//multipart/form-data
        contentType : false,//multipart/form-data
        data : formData,//multipart/form-data
        dataType : "json",
        error : function(xhr, error, code) {
            alert("에러:" + code);
        },
        success:function(json) {
            $profileImg.css("background-image","url(/img/upload/resized/"+json.profileName+")");
            $profileImgVal.val(json.profileName);
            $plusSquare.css("display", "none");
            $profileDelBtn.css("display","block");
            
        }
    });
    } else {
        alert("이미지를 선택해주세요!");
    }
});


$profileDelBtn.on("click", function(){
	const profileImage = $profileImgVal.val(); 
	console.log(profileImage);
	
	$.ajax({
		url: "/ajax/profile/"+profileImage,
		method: "DELETE",
		dataType: "json",
		error: function(){console.log("failed");},
		success: function(json){
			// 파일 이름을 넘겨서 처리
			console.log(json.msg);
			
			// 값을 ""로 세팅하고 아이콘들도 원상복구
			$profileImgVal.val("");
			$plusSquare.css("display", "block");
            $profileDelBtn.css("display","none");
            $profileImg.css("background-image", "none");
            
		}
	}); // ajax
	
}); // on click


//상호명 유효성 검사
let $businessName = $(".business_name_input");
let $businessNameNotice = $(".business_name_notice");
let $businessNameNoticeSpan = $(".business_name_notice span");

$businessName.on("keyup",function () {
    if ($businessName.val().length <= 1) {
    	 $businessNameNotice.css("display","block");
		 $businessNameNoticeSpan.text("2글자 이상으로 해주세요!");
    }else{
    	$.ajax({
			url:"/ajax/check/businessName",//주소
			type:"get",//방식
			data:{"businessName":$businessName.val()},//파라미터
			dataType:"json",//응답의 자료형
			error:function(xhr,error){
				alert("서버 점검중!");
				console.log(error);
			},
			success:function(json){
			if(json.result) {
				$businessNameNoticeSpan.text("이미 등록된 상호명입니다.");
			}//end success
			else{
				$businessNameNoticeSpan.text("좋은 상호명입니다.");
				}
			}
		});//end ajax 
    }//end else
})//end $businessName.on()
