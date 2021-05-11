<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Take It</title>
    <c:import url="/WEB-INF/view/template/link.jsp" />
    <link rel="stylesheet" href="/css/searchResult.css">
	<link rel="stylesheet" href="/css/index.css"/>
</head>
<body>
<c:import url="/WEB-INF/view/template/header.jsp" />
<div id="container">
    <div id="hero_img_content">
        <div class="hero_comment_wrap">
            <p class="main_msg msg">구독은 TAKE IT<br/>
                과 함께
            </p>
            <a class="sub_msg" href=""><p class="msg">클릭 한 번으로  편리하게 생활하세요</p></a>
        </div>
        <div class="hero_cover"></div>
    </div>
    <!--//hero_img_content-->
    <!--//main_menu_content-->
    <div class="best_seller_content">
    	<div class="best_seller_box">
        	<p class="best_seller_p"><span class="best_seller_msg">주간 구독 서비스</span><span class="msg_caption">구독 신청이 많은 서비스</span></p>
        </div>
        <div class="best_seller_wrap">
            <div class="kategorie_box">
                <ul class="kategorie_list">
                    <li><span class="kategorie">의</span></li>
                    <li><span class="kategorie">식</span></li>
                    <li><span class="kategorie">주</span></li>
                </ul>
            </div>
            <div class="slide_box">
                <ul class="slide_list">                
                    <c:forEach items="${hotCProducts }" var="hotCProduct">
                    <li>
                        <a href="">
                            <img src="/img/product/${hotCProduct.photo }"/>
                            <div class="subscription_item_info"><!--subscription_item_info start -->
                                <div class="subscription_item_company_and_label"><!--subscription_item_company_and_label start -->
                                    <div class="subscription_item_company">${hotCProduct.company }</div>
                                    <div class="subscription_item_label">인기</div>
                                </div><!--//subscription_item_company_and_label end -->
                                <div class="subscription_item_name">${hotCProduct.name }</div>
                                <div class="subscription_item_price_and_rate_box"><!--subscription_item_price_and_rate_box start -->
                                    <div class="subscription_item_price">${hotCProduct.price }</div>
                                    <div class="subscription_item_rate"><!--subscription_item_rate start -->
                                        <div class="grade_star box">
                                            <div class="inner_star box" style="width:${star*20}%"></div>
                                        </div>
                                    </div><!--//subscription_item_rate end -->
                                </div><!--//subscription_item_price_and_rate_box end -->
                            </div><!--//subscription_item_info end -->
                        </a>
                    </li>
                    </c:forEach>
                    <c:forEach items="${hotFProducts }" var="hotFProduct">
                    <li>
                        <a href="">
                            <img src="/img/product/${hotFProduct.photo }"/>
                            <div class="subscription_item_info"><!--subscription_item_info start -->
                                <div class="subscription_item_company_and_label"><!--subscription_item_company_and_label start -->
                                    <div class="subscription_item_company">${hotFProduct.company }</div>
                                    <div class="subscription_item_label">인기</div>
                                </div><!--//subscription_item_company_and_label end -->
                                <div class="subscription_item_name">${hotFProduct.name }</div>
                                <div class="subscription_item_price_and_rate_box"><!--subscription_item_price_and_rate_box start -->
                                    <div class="subscription_item_price">${hotFProduct.price }</div>
                                    <div class="subscription_item_rate"><!--subscription_item_rate start -->
                                        <div class="grade_star box">
                                            <div class="inner_star box" style="width:${hotFProduct.star*20}%"></div>
                                        </div>
                                    </div><!--//subscription_item_rate end -->
                                </div><!--//subscription_item_price_and_rate_box end -->
                            </div><!--//subscription_item_info end -->
                        </a>
                    </li>
                    </c:forEach>
                    <c:forEach items="${hotHProducts }" var="hotHProduct">
                    <li>
                        <a href="">
                            <img src="/img/product/${hotHProduct.photo }"/>
                            <div class="subscription_item_info"><!--subscription_item_info start -->
                                <div class="subscription_item_company_and_label"><!--subscription_item_company_and_label start -->
                                    <div class="subscription_item_company">${hotHProduct.company }</div>
                                    <div class="subscription_item_label">인기</div>
                                </div><!--//subscription_item_company_and_label end -->
                                <div class="subscription_item_name">${hotHProduct.name }</div>
                                <div class="subscription_item_price_and_rate_box"><!--subscription_item_price_and_rate_box start -->
                                    <div class="subscription_item_price">${hotHProduct.price }원</div>
                                    <div class="subscription_item_rate"><!--subscription_item_rate start -->
                                        <div class="grade_star box">
                                            <div class="inner_star box" style="width:${hotHProduct.star*20}%"></div>
                                        </div>
                                    </div><!--//subscription_item_rate end -->
                                </div><!--//subscription_item_price_and_rate_box end -->
                            </div><!--//subscription_item_info end -->
                        </a>
                    </li>
                    </c:forEach>
            </ul>
        </div>
    </div>
    <!--//best_seller_content-->
    <div class="steady_seller_content">
    	<div class="best_seller_box">
        	<p class="best_seller_p"><span class="best_seller_msg">최신 서비스</span><span class="msg_caption">최근에 등록된 서비스</span></p>
        </div>
        <a href="" class="btn">더보기</a>
        <div class="search_result_wrap">
            <ul class="search_result_list">
            	<c:forEach items="${currentProducts }" var="currentProduct">
                <li>
                    <a href="">
                        <img src="/img/products/${currentProduct.photo }"/>
                        <div class="subscription_item_info"><!--subscription_item_info start -->
                            <div class="subscription_item_company_and_label"><!--subscription_item_company_and_label start -->
                                <div class="subscription_item_company">${currentProduct.name }</div>
                                <div class="subscription_item_label">인기</div>
                            </div><!--//subscription_item_company_and_label end -->
                            <div class="subscription_item_name">${currentProduct.company}</div>
                            <div class="subscription_item_price_and_rate_box"><!--subscription_item_price_and_rate_box start -->
                                <div class="subscription_item_price">${currentProduct.price}원</div>
                                <div class="subscription_item_rate"><!--subscription_item_rate start -->
                                    <div class="grade_star box">
                                        <div class="inner_star box" style="width:${currentProduct.star*20}%"></div>
                                    </div>
                                </div><!--//subscription_item_rate end -->
                            </div><!--//subscription_item_price_and_rate_box end -->
                        </div><!--//subscription_item_info end -->
                    </a>
                </li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <!--//steady_seller_content-->
</div>
</div> <!-- container -->

<c:import url="/WEB-INF/view/template/footer.jsp"/>
<c:import url="/WEB-INF/view/template/js-import.jsp" />
<script src="/js/index.js"></script>
<script src="/js/header.js"></script>
</body>
</html>