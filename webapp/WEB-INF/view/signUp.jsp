<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>테이커 회원가입</title>
    <link rel="stylesheet" href="/css/signUp.css"/>
	<c:import url="/WEB-INF/view/template/link.jsp"/>
  
</head>
<body>
<div id="container"><!--container start-->
<form action="/signUp" method="post"><!--//form start-->
    <div id="signUpTitleContent"><!--signUpTitleBox start-->
        <div class="sign_up_title"><span>Take It</span></div>
        <c:choose>
			<c:when test="${type =='G' }">
				<div class="sign_up_sub_title"><span>기버 회원가입</span></div>
				<input type="hidden" name="type" value="G" />
			</c:when>
			<c:otherwise>
				<div class="sign_up_sub_title"><span>테이커 회원가입</span></div>
				<input type="hidden" name="type" value="T" />
			</c:otherwise>
		</c:choose>
    </div><!--//signUpTitleBox end-->

	<div id="signUpInputContent">
		<!--sign_up_input_container start-->
		<c:if test="${type =='G' }">
			<div class="business_name_input_box">
				<!--business_name_input_box start-->
				<div class="business_name_input_title">
					<span>상호명</span>
				</div>
				<input class="business_name_input" placeholder="2~10글자"
					name="company" />
				<div class="business_name_notice">
					<span></span>
				</div>
			</div>
			<!--//business_name_input_box end-->
			<div class="business_number_input_box">
				<!--business_name_input_box start-->
				<div class="business_number_input_title">
					<span>사업자등록번호</span>
				</div>
				<div class="business_number">${giver.businessNum}</div>
				<input type="hidden" value="${giver.businessNum}"
					name="businessNum" />
			</div>
			<!--//business_name_input_box end-->
		</c:if>

		<div class="id_input_box">
			<!--idInputBox start-->
			<div class="id_input_title">
				<span>아이디</span>
			</div>
			<input class="id_input" name="id"
				placeholder="이메일형식으로 입력 예)xxxx@gmail.com" />
			<div class="id_notice">
				<span></span>
			</div>
		</div>
		<!--//idInputBox end-->
		<div class="password_input_box">
			<!--passwordInputBox start-->
			<div class="password_input_title">
				<span>비밀번호</span>
			</div>
			<input class="password_input" name="password" type="password"
				placeholder="영문 및 숫자, 특수문자 8~12자를 입력하세요" />
			<div class="password_notice">
				<span></span>
			</div>
		</div>
		<!--//passwordInputBox end-->
		<div class="password_confirm_input_box">
			<!--passwordConfirmInputBox start-->
			<div class="password_confirm_input_title">
				<span>비밀번호 확인</span>
			</div>
			<input class="password_confirm_input" type="password"
				name="passwordConfirm" />
			<div class="password_confirm_notice">
				<span></span>
			</div>
		</div>
		<!--//passwordConfirmInputBox end-->
		<c:choose >
			<c:when test="${type == 'G'}">
				<div class="phone_input_box">
					<!--passwordConfirmInputBox start-->
					<div class="phone_input_title">
						<span>연락처</span>
					</div>
					<input class="phone_input" maxlength="12" name="phone"
						oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
						placeholder="'-'를 빼고 입력해주세요" />
					<div class="phone_notice">
						<span></span>
					</div>
				</div>
			</c:when>
			<c:otherwise>
			<div class="name_input_box">
				<!--nameInputBox start-->
				<div class="name_input_title">
					<span>이름</span>
				</div>
				<input class="name_input" name="name" />
			</div>
			<!--//nameInputBox end-->
			<div class="nickname_input_box">
				<!--nicknameInputBox start-->
				<label class="nickname_input_title" for="nickname"><span>닉네임</span></label>
				<input class="nickname_input" name="nickname"
					placeholder="한/영 10자까지 가능합니다." maxlength=10 />
				<div class="nickname_notice">
					<span>닉네임은 한/영 10자까지 가능합니다.</span>
				</div>
				<div class="nickname_notice">
					<span>중복되는 닉네임입니다.</span>
				</div>
			</div>
			<!--//nicknameInputBox end-->
			<div class="birthday_input_box">
				<!--birthdayInputBox start-->
				<div class="birthday_input_title">
					<span>생년월일</span>
				</div>
				<select class="birth_year_input" name="birthYear">
				</select> <select class="birth_month_input" name="birthMonth">
				</select> <select class="birth_date_input" name="birthDay">
				</select>
			</div>
			<!--//birthdayInputBox end-->
			<div class="gender_input_box">
				<!--genderInputBox start-->
				<div class="gender_input_title">
					<span>성별</span>
				</div>
				<input id="genderMaleBtn" name="gender" type="radio" value="M" /><label
					for="genderMaleBtn">남</label> <input id="genderFemaleBtn"
					name="gender" type="radio" value="F" /><label
					for="genderFemaleBtn">여</label>
			</div>
			<!--//genderInputBox end-->
			</c:otherwise>
		</c:choose>
		<div class="profile_img_input_box">
			<!--profileImg_input_box start-->
			<i class="far fa-times-circle"></i>
			<div class="profile_img_input_title">
				<span>프로필</span>
			</div>
			<label class="profile_img_input" for="profileImgInput"><i
				class="far fa-plus-square"></i> </label>
			<!--input value를 기본프로필로 넘길 사진으로 해두면 된다.-->
			<input id="profileImgInput" type="file" accept="image/*" /> <input
				id="profileImgVal" type="hidden" name="profileImg" />
		</div>
		<!--//profileImg_input_box end-->
	</div>
	<!--//sign_up_input_container end-->
	<button class="sign_up_btn" type="submit">회원가입 하기</button>
</form><!--//form end-->
</div><!---container end-->
<script src="/js/signUpTaker.js"></script>
</body>
</html>