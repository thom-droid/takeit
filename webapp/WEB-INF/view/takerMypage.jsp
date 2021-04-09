<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Taker MyPage</title>
 	<c:import url="/WEB-INF/view/template/link.jsp" />
 	<link rel="stylesheet" href="/css/takerMypage.css" />
    <link rel="stylesheet" href="/css/calendar.css" />
</head>
<body>
<c:import url="/WEB-INF/view/template/header.jsp"></c:import>
<div id="container"><!--container start-->
    <div id="content"><!--content start-->
        <div class="taker_my_page_header">
        <h1>테이커 마이페이지</h1>
        </div>
        <div class="taker_profile_payment_info"><!--taker_profile_payment_info-->
            <div class="taker_profile_box"><!--taker_profile_box-->
                <div class="taker_profile">
                    <img src="/img/upload/profile/${loginMember['member'].profileImg}"/>
                </div>
                <label for="takerProfileEdit" class="profile_edit_label fas fa-plus-circle"></label>
                <input type="file" name="takerProfile" id="takerProfileEdit" class="profile_input screen_out"/>
                <div class="profile_msg"></div>
            </div><!--//taker_profile_box end-->
            <dl class="monthly_payment_info">
                <dt>이번달 총 예상 결제 금액</dt>
                <dd>10,000원</dd>
             </dl>
        </div><!--//taker_profile_payment_info end-->
        <div class="full_calendar_wrap"><!--full_calendar_wrap-->
            <div id="calendar"></div><!--full calendar 담을 박스-->
        </div><!--//full_calendar_wrap-->
        <div class="taker_basic_info"><!--taker_basic_info-->
            <div class="taker_basic_info_header">
                <h2>테이커 정보</h2>
            </div>
            <dl class="taker_basic_info_list"><!--taker_basic_info_list-->
                <dt>이름</dt>
                <dd>정진하</dd>
                <dt>별명</dt>
                <dd class="taker_nickname">찐니</dd>
                <button class="nickname_edit_btn fas fa-edit"></button>

                <dt>이메일</dt>
                <dd>jinha4ever@gmail.com</dd>
            </dl><!--//taker_basic_info_list-->
        </div><!--//taker_basic_info-->
        
        
        <div class="subscribes"><!--subscribes-->
            <div class="subscribes_tab">
                <input id="current" type="radio" name="status" value="current" checked/>
                	<label for="current" class="my_subscribe_list">내 구독 리스트</label>
                <input id="history" type="radio" name="status" value="history" />
                	<label for="history" class="my_subscribe_history">구독 히스토리</label>
        	 </div>
            
            <div id="subItemList">
            </div>
            
        </div><!--//subscribes end-->
    </div><!--//content end-->
</div><!--//container end-->

<!--리뷰작성 팝업창 -->
<div class="write_review_pop_up"><!--write_review_pop_up-->
    <div class="write_review_box"><!--write_review_box start-->
        <div class="pop_review_header_wrap">
            <div class="pop_review_header_title">
                <span class="writing_review">리뷰 작성</span>
            </div>
            <button class="review_close_btn fas fa-times"></button>
        </div>
        <div class="pop_review_content"><!--pop_review_content start-->
            <div class="subscription_product_name">구독 상품 명: <span>마스크 네고</span></div>
            <div class="rating_box">
             <div class="grade_star_box">
                 <div class="fas fa-star"></div>
                 <div class="fas fa-star"></div>
                 <div class="fas fa-star"></div>
                 <div class="fas fa-star"></div>
                 <div class="fas fa-star"></div>
             </div>
            </div>
            <div class="subscriber_review_box">
                <label for="subscriberReview">구독자 리뷰작성</label>
                <textarea id="subscriberReview" name="review" rows="8" cols="70"
                placeholder="구독 후기를 작성해주세요."></textarea>
            </div>
        </div><!--//pop_review_content end -->
        <button type="submit" class="review_submit_btn">작성</button>
    </div><!--//write_review_box end -->
</div><!--//write_review_pop_up end-->

<!--닉네임 팝업창 -->
<div class="nickname_edit_pop_up"><!--nickname_edit_pop_up start-->
    <div class="nickname_edit_wrap"><!--nickname_edit_box start-->
        <div class="nickname_edit_header_box">
            <div class="pop_nickname_edit_header_title">
                <span class="nickname_change">닉네임 변경</span>
            </div>
            <button class="nickname_close_btn fas fa-times"></button>
        </div>
        <div class="pop_nickname_edit_content"><!--pop_nickname_edit_content start-->
                <label class="label" for="nickname">새로운 별명을 입력해주세요.</label>
                <input id="nickname"
                       autocomplete="off"
                       placeholder="5자 내로 한글,숫자 입력"
                       title="5자 내로 한글,숫자 입력"
                       name="nickname"/>
                <div class="nickname_msg"></div>
            <button disabled="disabled" class="apply_edited_nickname_btn">수정</button>
        </div><!--//pop_nickname_edit_content end -->
    </div><!--//nickname_edit_box end -->
</div><!--//nickname_edit_pop_up end-->

<script id="itemTmpl" type="text/template">
<ul class="current_subscribes">
	<@ _.each(itemList,function(item) { @>
	  <li class="one_subscribe">
                    <dl class="my_subscribe_essentials">
                        <dt class="screen_out">대표사진</dt>
                        <dd class="representative_image"><img src="img/<@=item.photo@>" width="100" height="100">
                        <span class="subscription_title"><@=item.productName@></span></dd>
                      
                    </dl>
                    <dl class="my_subscribe_specifics">
                        <dt>가격</dt>
                        <dd class="subscription_price"><@=item.price@></dd>
                        <dt>배송 요일</dt>
                        <dd class="delivery_day"><@=item.deliveryDaysStr@></dd>
                        <dt>배송지 주소</dt>
                        <dd class="delivery_address"><@=item.addr@> <@=item.addrDetail@></dd>
                        <dt>구독 시작일</dt>
                        <dd class="subscription_start_date"><@=item.startDate@></dd>
                        <dt>다음 결제일</dt>
                        <dd class="next_payment_date">2020월 2월 11일</dd>
                    </dl>
                    <a class="write_review_btn" href="">리뷰 작성</a>
                    <a class="cancel_subscription_btn" href="">구독 취소</a>

                </li><!--//one_subscribe-->
<@})@>
</ul>
  <div class="paging"><@=paginate@></div>
</script>

<c:import url="/WEB-INF/view/template/footer.jsp" />
<c:import url="/WEB-INF/view/template/js-import.jsp" />
<script src="/js/header.js"></script>

<script src="/js/main.js"></script>
<script src="/js/takerMypage.js"></script>

</body>
</html>