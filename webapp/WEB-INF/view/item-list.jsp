<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구독 상품 목록</title>
<c:import url="/WEB-INF/view/template/link.jsp" />
<link rel="stylesheet" href="/css/item-list.css" />
</head>
<body>

<c:import url="/WEB-INF/view/template/header.jsp" />
	<div id="container">
		<!--container start -->
		<div id="main_menu_content">
			<!--main_menu_content start -->
			<div class="main_category_title">
				<!--main_category_title start -->
				<span>Category</span>
			</div>
			<!--//main_category_title end -->
		</div><!--// main_menu_content end -->
		
		<div class="second_categories_content">	<!-- second_categories_content start-->
			<div class="second_categories_header">	
				<div class="category_box btn_box">
					<button type="button" class="category_btn header_btn list_btn">품목</button>
					<ul class="second_category_list sel_list_ul">
						<li class="category_tab text_strong"><button class="sel_btn"
								data-category-no="${category.no }">전체</button></li>
						<c:forEach items="${categories}" var="category">
							<li class="category_tab text_strong"><button class="sel_btn"
									data-category-no="${category.no }">${category.name }</button></li>
						</c:forEach>
					</ul>
				</div>
				<button type="button" class="location header_btn">지역</button>
				<div class="order_filter_box btn_box">
					<button type="button" class="order_btn header_btn list_btn">정렬</button>
					<ul class="second_category_list sel_list_ul">
						<li class="category_tab"><button class="sel_btn"
								data-order="default">기본</button></li>
						<li class="category_tab"><button class="sel_btn"
								data-order="lat">최신순</button></li>
						<li class="category_tab"><button class="sel_btn"
								data-order="sub">구독순</button></li>
						<li class="category_tab"><button class="sel_btn"
								data-order="lowPrice">낮은가격순</button></li>
						<li class="category_tab"><button class="sel_btn"
								data-order="highPrice">높은가격순</button></li>
						<li class="category_tab"><button class="sel_btn"
								data-order="rate">평점순</button></li>
					</ul>
				</div>
			</div>
		</div><!--// second_categories_content end -->
			
			<div class="category_result_box">
			
				<!-- ----------------------2차 카테고리 박스---------------------- -->
				
				<a class="socks_stocking_box" href="/${category }">
					<ul class="search_result_list">
					
					 
					<c:forEach items="${subsList}" var="subs">
					
						 <a class="search_result_detail_link" href="">
                        <li class="search_result_item">
                            <img src="/img/products/${subs.photo}"/>
                            <div class="subscription_item_info"><!--subscription_item_info start -->
                                <div class="subscription_item_company_and_label"><!--subscription_item_company_and_label start -->
                                    <div class="subscription_item_company">${subs.company}</div>
                                    <div class="subscription_item_label">인기</div>
                                </div><!--//subscription_item_company_and_label end -->
                                <div class="subscription_item_name">${subs.name}</div>
                                <div class="subscription_item_price_and_rate_box"><!--subscription_item_price_and_rate_box start -->
                                    <div class="subscription_item_price">${subs.realPrice}원부터</div>
                                    <div class="subscription_item_rate"><!--subscription_item_rate start -->
                                        <div class="grade_star box">
                                            <div class="inner_star box" style="width:${subs.star*20}%"></div>
                                        </div> 
                                    </div><!--//subscription_item_rate end -->
                                </div><!--//subscription_item_price_and_rate_box end -->
                            </div><!--//subscription_item_info end -->
                        </li>
                    </a>
					</c:forEach> 
        									
					</ul>
				</div>
				${paginate }
				
			</div><!--//category_result_box end -->
		</div><!-- second_categories_content end-->
	</a><!--// container end -->
	
	<!-- ========================지역 팝업 창==============================  -->
	
	<div class="pop_where_wrap">	<!--pop_where_wrap start-->
		<div class="pop_where_box">
			<!--pop_where_box start-->
			<div class="pop_where_header_wrap">
				<!--pop_where_header_wrap start-->
				<div class="pop_where_header_title">
					<span class="filter_where">지역</span>
				</div>
				<button name="close_btn" type="button" class="pop_close_button fas fa-times"></button>
			</div><!--//pop_where_header_wrap end-->
			<div class="pop_where_container">
				<!--pop_where_container start-->
			</div><!--//states_specifics end-->
		</div><!--//pop_where_container end-->
	</div><!--//pop_where_box end-->

<!-- =================================제품 카드 템플릿=================================  -->
<script type="text/template" id="subsCardTmpl">
  					<@ _.each(subsCardList,function(subsCard) { @>
						
						
						<li class="search_result_item">
							<a class="search_result_detail_link" href=""><img src="img/미하이삭스.jpg" />
								<div class="subscription_item_info">
									<!--subscription_item_info start -->
									<div class="subscription_item_company_and_label">
										<!--subscription_item_company_and_label start -->
										<div class="subscription_item_company">미하이삭스</div>
										<div class="subscription_item_label">인기</div>
									</div>
									<!--//subscription_item_company_and_label end -->
									<div class="subscription_item_name">양말정기배송 - 비즈니스 패키지(남성용)</div>
									<div class="subscription_item_price_and_rate_box">
										<!--subscription_item_price_and_rate_box start -->
										<div class="subscription_item_price">6,200원</div>
										<div class="subscription_item_rate">
											<!--subscription_item_rate start -->
											<div class="grade_star box">
												<div class="inner_star box" style="width: 60%"></div>
											</div>
										</div>
										<!--//subscription_item_rate end -->
									</div>
									<!--//subscription_item_price_and_rate_box end -->
								</div><!--//subscription_item_info end -->
						</a>	
					</li>
						
					<@ })@>             
</script>
	<!-- ==========================시도구군 템플릿====================================== -->
<script type="text/template" id="whereTmpl">
    <ul class="korea_states">
    <@ _.each(sidoList,function(sido) {@>
		<li><a href="">전국구</a></li>
        <li><a href=""><@=sido.name@></a></li>
    <@}) @>
    </ul>
    <div class="states_specifics"><!--states_specifics start-->
    <@ _.each(gugunList,function(guguns,idx) { @>
		<ul class="select_all">
			<li><a href="">전체</a></li>
		</ul>
        <ul class="specifics_list <@ if(idx==0){ @> on<@ } @>" >
        <@ _.each(guguns,function(gugun) {@>
            <li><a href=""><@=gugun.name@> <span><@=gugun.size@></span></a></li>
       <@ })@>
        </ul>
    <@ })@>
    </div>
</script>
<c:import url="/WEB-INF/view/template/js-import.jsp" />
<script src="/js/item-list.js"></script>
</body>
</html>