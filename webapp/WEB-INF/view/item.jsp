<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${product.name}</title>
	<c:import url="/WEB-INF/view/template/link.jsp" />
  	<link rel="stylesheet" href="/css/item.css"/>
  	<link rel="stylesheet" href="/css/datepicker.css" />
</head>
<body>
<c:import url="/WEB-INF/view/template/header.jsp" />
    <div class="product_detail_page_container">
        <div class="product_detail_page_head_contents">
            <div class="product_detail_page_content_head">
                <div class="item_category_box">
                    <div class="category_box">
                        <p><span class="category"><a href="">의</a></span> > <span><a href=""> 양말/스타킹</a></span></p>
                    </div>
                    <div class="subs_info_box">
                        <!--구독자 수-->
                        <div class="subs_num">100 &nbsp;</div>
                        <!-- 평점 & 리뷰 수 -->
                        <div class="star_review_num">
                            <img class="star" src="/img/green_star.png"><div class="star_review">${product.star} (36)</div>
                        </div>
                    </div>
                </div>

                <!-- 상단부의 기버 정보-->
                <div class="giver_information_box">
                    <div class="giver_information">
                        <!-- taker 가 보는 giver 상세 페이지로 이동 -->
                        <a href=""><img class="giver_profile_img" src="/img/walle.png"></a>
                        <a href=""><span>${giver.company }</span></a>
                    </div>
                </div>
            </div>

            <div class="product_detail_page_content_left">
                <!-- 구독 제품 대표 이미지-->
                <img class="product_thumbnail_img" src="/img/products/${product.photo }">
            </div>
            <div class="product_detail_page_content_right">
                <h2 class="subs_title">${product.name }</h2>
                <div class="item_info_box">
                    <dl>
                        <dt>배송 시작일</dt>
                        <dd>
                        	<div role="button"> 
                        		<input name="deliveryStart" id="datepicker" >
                        		<label for="datepicker" class="datepicker_label">희망배송시작일자</label>
                        	</div>
                        </dd>
                    </dl>
                    <dl>
                        <dt>배송일</dt>
                        <dd><!--월화수목금 표기.-->
                            <div class="deliver_date_box">
                        
                            	<div class="delivery_date  <c:forEach var="deliveryDay" items="${deliveryDays}"> 
                                    <c:choose>
                            		<c:when test="${deliveryDay.day==0}">selected</c:when>
                            		<c:otherwise></c:otherwise>
	                            	</c:choose>
                            	</c:forEach>">일</div>
                                <div class="delivery_date  <c:forEach var="deliveryDay" items="${deliveryDays}"> 
                                    <c:choose>
                            		<c:when test="${deliveryDay.day==1}">selected</c:when>
                            		<c:otherwise></c:otherwise>
	                            	</c:choose>
                            	</c:forEach>">월</div>
                                <div class="delivery_date  <c:forEach var="deliveryDay" items="${deliveryDays}"> 
                                    <c:choose>
                            		<c:when test="${deliveryDay.day==2}">selected</c:when>
                            		<c:otherwise></c:otherwise>
	                            	</c:choose>
                            	</c:forEach>">화</div>
                                <div class="delivery_date  <c:forEach var="deliveryDay" items="${deliveryDays}"> 
                                    <c:choose>
                            		<c:when test="${deliveryDay.day==3}">selected</c:when>
                            		<c:otherwise></c:otherwise>
	                            	</c:choose>
                            	</c:forEach>">수</div>
                                <div class="delivery_date  <c:forEach var="deliveryDay" items="${deliveryDays}"> 
                                    <c:choose>
                            		<c:when test="${deliveryDay.day==4}">selected</c:when>
                            		<c:otherwise></c:otherwise>
	                            	</c:choose>
                            	</c:forEach>">목</div>
                                <div class="delivery_date  <c:forEach var="deliveryDay" items="${deliveryDays}"> 
                                    <c:choose>
                            		<c:when test="${deliveryDay.day==5}">selected</c:when>
                            		<c:otherwise></c:otherwise>
	                            	</c:choose>
                            	</c:forEach>">금</div>
                                <div class="delivery_date  <c:forEach var="deliveryDay" items="${deliveryDays}"> 
                                    <c:choose>
                            		<c:when test="${deliveryDay.day==6}">selected</c:when>
                            		<c:otherwise></c:otherwise>
	                            	</c:choose>
                            	</c:forEach>">토</div>
                               
                            </div>
                        </dd>
                    </dl>
                    <!--기본가격에 옵션, 배송추가 가격 표시되면 좋을 것 같음-->
                    <dl>
                        <dt class="delivery_addr_option">배송지역 선택</dt>
                        <dd class="opt_area">
                        	<c:forEach items="${deliveryOpt}" var="opt">
                         		
                            <input id="deliveryAddrOption${opt.areaNo}" name="addrOpt" value="${opt.primaryRegionName}${opt.regionName}+${opt.price}" class="addr_option_input" type="radio" <c:if test="${opt.areaNo eq param.regionNo}"> checked</c:if>>
                            <label class="delivery_opt_label" for="deliveryAddrOption${opt.areaNo }" data-price="${opt.price+product.price}" data-sido="${opt.primaryRegionName}" data-sigungu="${opt.regionName}">${opt.primaryRegionName}${opt.regionName}/+<span class="opt_price">${opt.price}</span></label>
                            <input type="hidden" class="opt_price_input" name="optPrice" value="${opt.price}" />
                            </c:forEach>
                        </dd>
                    </dl>
                    <!-- 남은 수량이 9개 이하가 되면, 나타남 -->
                    <dl class="sold_out">
                        <dt>남은 수량</dt>
                        <dd class="last_qnt">9 개</dd>
                    </dl>
                    <dl class="price_tag">
                        <dt>총 가격</dt>
                        <dd><span class="product_price">${product.price}</span>원</dd>
                            <input class="total_price_input" type="hidden" name="price" value="${product.price}" />
                    </dl>
                    <!-- 일반 유저들이 보는 페이지에서는 구독 하기 버튼이 보임-->
                    <button class="subscribeBtn" onclick = "location.href = '' ">구독하기</button>
                    <!-- 이 구독 상품의 기버가 제품 상세 페이지에 들어왔을 때 보이는 버튼 -->
                    <div class="giver_view_btn_box">
                        <button class="subscribe_pause">구독 일시정지</button>
                        <button class="subscribe_delete">구독 삭제</button>
                    </div>

                </div><!--item_info_box-->
            </div>
        </div>
        <div class="product_detail_page_body_contents">
            <ul class="product_detail_tab_wrap">
                <li class="product_detail_tab_box on" data-tab="tab1">상품 상세</li>
                <li class="product_detail_tab_box" data-tab="tab2">구매 안내</li>
                <li class="product_detail_tab_box" data-tab="tab3">리뷰</li>
            </ul>
            <!--  ------------------------상품 상세 정보----------------------- -->
            <div class="tab_product_detail content on" id="tab1">
                <!--제품 등록에서 퀼 에디터로 저장하는 것 보여주는 div (현재는 사진하나로 퉁쳐놨다)-->
                <img class="tab_product_detail_img" src="/img/pp.jpg">
            </div>
            <!-- -------------------------구매 안내 정보-------------------------  -->
            <div class="tab_purchase_detail content" id="tab2">
                <img class="tab_purchase_detail_img" src="/img/${product.instruction }"/>
            </div>
            <!-- -------------------------------리뷰------------------------- -->
            <div class="tab_review content" id="tab3">
                <ul class="review_list">
                    <li class="review_item">
                        <div class="review_wrap">
                            <div class="review_profile_box">
                                <img class="review_profile_img" src="/img/walle.png" width="50" height="50"/>
                                <span class="review_user_nickname">가나다라마바사</span>
                                <span class="review_star_rating"><span style ="width:80%"></span></span>
                                <span class="review_regdate">(2020.02.10. 03:20)</span>
                                <p class="review_detail">
                              
                                </p>
                                <!--//review_detail-->
                            </div>
                            <!--//review_profile_box-->
                            <div class="reply_detail_box">
                                <img class="reply_giver_profile_img" src="img/profile_img_default.jpg" width="50px" height="50px"/>
                                <div class="reply_detail">
                                <span class="reply">이용해주셔서 감사감사이용해주셔서이용해주셔서이용해주셔서이용해
                                    주셔서이용해주셔서이용해주셔서이용해주셔서이용해주셔서이용해주셔서이용해주셔서이
                                    용해주셔서이용해주셔서이용해주셔서이용해주셔서이용해주셔서이용해주셔서</span>
                                    <p class="reply_regdate">(2020. 02. 10. 03:20)</p>
                                </div>
                            </div>
                            <!--//reply_detail_box-->
                        </div>
                        <!--//review_wrap-->
                    </li>
                </ul>
            </div>

        </div>
    </div>
<c:import url="/WEB-INF/view/template/footer.jsp"/>
<input id="dateVal" type="hidden" name="dateVal" value="${product.dateAvail}" />
</body>

<c:import url="/WEB-INF/view/template/js-import.jsp"/>
<script src="/js/tui-date-picker.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/js/item.js"></script>


</html>