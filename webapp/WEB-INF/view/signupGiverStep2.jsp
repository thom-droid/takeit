<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:import url="/WEB-INF/view/template/link.jsp" />
<link rel="stylesheet" href="/css/signupGiverStep2.css"/>
</head>
<body>
<c:if test="${msg!=null }">
alert("${msg }");
</c:if>
<div id="container"><!--container start-->
    <div id="signUpReadyTitleContent"><!--signUpTitleContent start-->
        <img src="/img/로고.png" width="240"><span>Take It</span>
    </div><!--//signUpTitleContent end-->
    <div id="singUpReadyContent"><!--singUpReadyContent start-->
        <div class="head_sentence"><span>사업자 등록번호를 입력하세요.</span><span>사업자 번호로 등록여부를 확인합니다.</span></div>
        <form action="/signUp" method="GET">
        	<input id="businessNumInput" name="businessNum" maxlength="10" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
        	<input type="hidden" name="type" value="G" />
       		<button class="nextBtn">다음</button>
        </form>
    </div><!--//singUpReadyContent end-->
</div><!--//container end-->
<c:import url="/WEB-INF/view/template/js-import.jsp" />
<script src="/js/signupGiverStep2.js"/></script>
</body>
</html>