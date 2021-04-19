<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="header">
<c:if test="${msg!=null }">
	<div class="welcome_msg">
		<p>${msg }</p>
	</div>
</c:if>
    <!-- 헤더 내용들 -->
    <div class="header_contents_box">
    	
        <!-- hcb == header_contents_box를 줄인 단어 -->
        <!-- 로고 -->
        <div class="hcb_logo">
            <a href="/">
                <img src="/img/resource/logo.png" class="header_logo_img">
                <span class="header_logo_font">TAKE IT</span>
            </a>
        </div>
        <!-- end hcb_logo -->

        <!-- 카테고리 -->
        <div class="hcb_category">
            <ul>
                <li <c:if test="${category.no==1}">class="on"</c:if>><a href="/clothes">의류</a></li>
                <li <c:if test="${category.no==2}">class="on"</c:if>><a href="/food">식품</a></li>
                <li <c:if test="${category.no==3}">class="on"</c:if>><a href="/living">주거</a></li>
                <li <c:if test="${category.no==4}">class="on"</c:if>><a href="/etc">기타</a></li>
            </ul>
        </div>
        <!-- end hcb_category -->

        <!-- 검색 -->
        <div class="hcb_search">
            <form>
                <div>
                    <input type="text">
                    <button><i class="fas fa-search"></i></button>
                </div>
            </form>
        </div>
        <!-- end hcb_search -->

        <!-- 로그인 -->
        <div class="hcb_login">
        <c:choose>
        	<c:when test="${loginMember==null }">
            <div class="hcb_login_btn">
               <a href="/log">로그인</a>
            </div>
         	</c:when>
         	<c:otherwise>
	            <div class="hcb_profile">
	               <p>
	                  <i class="fas fa-bars"></i> <i class="far fa-user-circle"></i>
	               </p>
	            </div>
	            <div class="hcb_mypage_and_logout">
	               <ul>
	                  <li><a href="/taker/${loginMember['taker'].no}">마이페이지</a></li>
	                  <li>
		                  <form id="logOutForm" action="/log" method="post">
		                  <input type="hidden" name="_method" value="delete"/>
		                  <button form="logOutForm" class="logout btn">로그아웃</button>
	                  </form>
	                  </li>
	               </ul>
	            </div>
         	</c:otherwise>
     	</c:choose>
     	</div>
        <!-- end hcb_login-->
    </div>
    <!-- end header_contents_box -->
</div>
<!--end herder-->

