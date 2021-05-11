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
			<div class="result_text_area">
				<span class="result_text"></span>
				<span class="result_num"></span>
			</div>
			<!--//main_category_title end -->
		</div><!--// main_menu_content end -->
		
		<div class="second_categories_content">	<!-- second_categories_content start-->
			<div class="second_categories_header">	
				<div class="category_box btn_box">
					<button type="button" class="category_btn header_btn list_btn">품목</button>
					<ul class="second_category_list sel_list_ul">
						<li class="category_tab text_strong"><button class="by_category sel_btn"
								data-category-no="${category.no }" data-category-name="${category.name}">전체</button></li>
						<c:forEach items="${categories}" var="category">
							<li class="category_tab text_strong"><button class="by_category sel_btn"
									data-category-no="${category.no }" data-category-name="${category.name}">${category.name }</button></li>
						</c:forEach>
					</ul>
				</div>
				<c:if test="${locations ==null }">
				<button type="button" class="location header_btn">지역</button>
				</c:if>
				<div class="order_filter_box btn_box">
					<button type="button" class="order_btn header_btn list_btn">정렬</button>
					<ul class="second_category_list sel_list_ul">
						<li class="category_tab"><button class="by_order sel_btn"
								data-order="default">기본</button></li>
						<li class="category_tab"><button class="by_order sel_btn"
								data-order="lat">최신순</button></li>
						<li class="category_tab"><button class="by_order sel_btn"
								data-order="sub">구독순</button></li>
						<li class="category_tab"><button class="by_order sel_btn"
								data-order="lowPrice">낮은가격순</button></li>
						<li class="category_tab"><button class="by_order sel_btn"
								data-order="highPrice">높은가격순</button></li>
						<li class="category_tab"><button class="by_order sel_btn"
								data-order="rate">평점순</button></li>
					</ul>
				</div>
				<button type="button" class="reset_btn header_btn">초기화</button>
			</div><!-- categories_header_end -->
			<div class="loc_tag_box">
				<ul class="loc_tag_list">
				<c:forEach items="${locations }" var="location">
					<li class="loc_item_tag"><button type="button" class="loc_tag_btn">${location.name } <span class="loc_num_deco"><span class="location_num">${location.num}</span></span></button></li>
				</c:forEach>
				</ul>
			</div>
			<div class="category_result_box">
				<ul class="search_result_list">
				</ul>
			</div>
		</div><!-- second_categories_content end-->
		<div class="pagination"></div>
	</div><!--container  -->
	<!-- ========================지역 팝업 창==============================  -->
	
	<div class="pop_where_wrap">	<!--pop_where_wrap start-->
		<div class="pop_where_box">
			<!--pop_where_box start-->
			<div class="pop_where_header_wrap">
				<!--pop_where_header_wrap start-->
				<div class="pop_where_header_title">
					<div class="title_wrap">
						<span class="filter_where">지역</span>
					</div>
					<div class="filter_info_wrap">
						<span class="filter_info">배송가능한 지역 목록입니다(e.g. 서울은 서울 전체)</span>
					</div>
					<div class="filter_info_wrap">
						<p class="filter_note">한 상품이 여러 지역에 배송이 가능한 경우가 있으므로, </p>
						<p class="filter_note">목록에서 보여지는 상품 수와 실제 보여지는 상품 수가 다를 수 있습니다. </p>
					</div>
				</div>
				<button name="close_btn" type="button" class="pop_close_button fas fa-times"></button>
			</div><!--//pop_where_header_wrap end-->
			<div class="location_area">
				<div class="pop_primary_location">
					<c:forEach items="${primaryLocation}" var="item">
					<div class="primary_location_item item_block">
						<span class="primary_location">${item.name}</span>
						<span class="item_numbers">${item.num}</span>
					</div>
					</c:forEach>
				<!--pop_where_container start-->
				</div><!--//states_specifics end-->
				<c:forEach items="${secondLocation}" var="list">
				<div class="pop_second_location">
					<c:forEach items="${list}" var="item">
					<div class="second_location_item item_block">
						<span class="second_location">${item.name}</span>
						<span class="item_numbers">${item.num}</span>
					</div>
					</c:forEach>
				</div>
				</c:forEach>
			</div>
		</div><!--//pop_where_container end-->
	</div><!--//pop_where_box end-->

<!-- =================================제품 카드 템플릿=================================  -->
<script type="text/template" id="subsCardTmpl">
	<@ _.each(subsCardList,function(subsCard) { @>
		<li class="search_result_item">
			<a class="search_result_detail_link" href="/taker/subscribe/<@=subsCard.no@>"><img src="/img/products/<@=subsCard.photo@>" />
					<div class="subscription_item_info">
									<!--subscription_item_info start -->
							<div class="subscription_item_company_and_label">
										<!--subscription_item_company_and_label start -->
								<div class="subscription_item_company"><@=subsCard.name@></div>
								<div class="subscription_item_label">인기</div>
							</div>
									<!--//subscription_item_company_and_label end -->
							<div class="subscription_item_name"><@=subsCard.company@></div>
							<div class="subscription_item_price_and_rate_box">
										<!--subscription_item_price_and_rate_box start -->
								<div class="subscription_item_price"><@=subsCard.price@>원부터</div>
								<div class="subscription_item_rate">
											<!--subscription_item_rate start -->
								<div class="grade_star box">
									<div class="inner_star box" style="width :<@=subsCard.star*20@>%"></div>
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
	
<c:import url="/WEB-INF/view/template/js-import.jsp" />
<script src="/js/item-list.js"></script>
<script src="/js/header.js"></script>
</body>
</html>