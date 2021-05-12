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
        <div class="hcb_category">
            <ul class="hcb_category_list">
                <li <c:if test="${category.no==1}">class="on"</c:if>><a href="/item/clothes">CLOTHING</a></li>
                <li <c:if test="${category.no==2}">class="on"</c:if>><a href="/item/food">FOOD</a></li>
                <li <c:if test="${category.no==3}">class="on"</c:if>><a href="/item/living">LIVING</a></li>
                <li <c:if test="${category.no==4}">class="on"</c:if>><a href="/item/etc">ETC.</a></li>
            </ul>
        </div>
        
        <div class="hcb_logo">
        	<div class="logo_box">
	            <a href="/">
	                <img src="/img/resource/logo.png" class="header_logo_img">
	                <span class="header_logo_font">TAKE IT</span>
	            </a>
            </div>
        </div>

        <!-- 검색 -->
        <div class="hcb_search">
            <form id="form" method="GET" action="/item/search">
                <div class="search_area">
				    <div class="search_by">
				        <div class="search_btn_item search_by_btn" data-type="item">상품검색</div>
				    </div>
				    <div class="search_by">
				        <div class="search_btn_locaction search_by_btn" data-type="location">지역검색</div>
				    </div>
				    <div class="search_bar">
					    <input id="searchInput" class="search_input" name="searchValue" placeholder="무엇을 찾으시나요?">
					    <button class="search_input_btn fas fa-search bar_component" type="button"></button>
					    <button class="reset_search_btn fas fa-times bar_component" type="button"></button>
				    </div>
                </div>
                <input id="searchType" type="hidden" name="searchType" value="">                
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
                  	<i class="far fa-user-circle"></i>
	            </div>
	            <div class="hcb_mypage_and_logout">
	               <ul>
	                  <li><a href="/taker/${loginMember['taker'].no}">MYPAGE</a></li>
	                  <li>
                		<div>
		                  <form id="logOutForm" action="/log" method="post">
		                  <input type="hidden" name="_method" value="delete"/>
		                  <button form="logOutForm" class="logout btn">로그아웃</button>
	                  	  </form>
	                    </div>
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

