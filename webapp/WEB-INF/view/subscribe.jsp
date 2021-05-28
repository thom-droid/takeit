<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>TakeIt</title>
    <c:import url="/WEB-INF/view/template/link.jsp" />
    <link rel="stylesheet" href="/css/subscribe.css" />
    <link rel="stylesheet" href="/css/datepicker.css" />

</head>
<body>

	<c:import url="/WEB-INF/view/template/header.jsp" />
<form id="subscribeForm" action="/subscribe" method="POST">

    <div id="container">
            <div>
                <div class="product_detail_page_head_contents">
            <div class="product_detail_page_content_left">
                <!-- 구독 제품 대표 이미지-->
                <img class="product_thumbnail_img" src="/img/products/${product.photo }">
            </div>
            <div class="product_detail_page_content_right">
                <h2 class="subs_title">${product.name }</h2>
                <div class="giver_information_box">
                    <div class="giver_information">
                       <!-- taker 가 보는 giver 상세 페이지로 이동 -->
                        <a href=""><img class="giver_profile_img" src="/img/upload/profile/${giverInfo.profileImg }"></a>
                        <a href=""><span>${giver.company }</span></a>
                    </div>
                </div>
                <div class="item_info_box">
                    <dl>
                        <dt>배송 시작일</dt>
                        <dd>
                        	<div role="button">
                        		<input id="datepicker" class="datepicker_input" name="deliveryStart" autocomplete ="off" placeholder="희망배송시작일" readonly value="${param.deliveryStart}">
                        	</div>
                        </dd>
                    </dl>
                    <dl>
                        <dt>배송일</dt>
                        <dd>
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
                    
                    <dl>
                        <dt class="delivery_addr_option">배송지역 선택</dt>
                        <dd class="opt_area">
                        	<c:forEach items="${deliveryOpt}" var="opt">
                         		
                            <input id="deliveryAddrOption${opt.areaNo}" name="addrOpt" value="${opt.primaryRegionName}${opt.regionName}+${opt.price}" class="addr_option_input" type="radio" <c:if test="${opt.areaNo eq param.optAreaNo}"> checked</c:if>>
                            <label class="delivery_opt_label" for="deliveryAddrOption${opt.areaNo }" data-opt-price="${opt.price}" data-price="${opt.price+product.price}" data-sido="${opt.primaryRegionName}" data-sigungu="${opt.regionName}">${opt.primaryRegionName}${opt.regionName}/+<span class="opt_price">${opt.price}</span></label>
                            
                            </c:forEach>
                        </dd>
                        <dd>
                        	<input type="hidden" name="takerNo" value="${loginMember['member'].no}" />
                        	<input id="optPrice" type="hidden" class="opt_price_input" name="optPrice" value="${param.price }"/>
                        	<input id="primaryRegion" type="hidden" class="opt_region1_input" name="primaryRegion" value="${param.primaryRegion }" />
                        	<input id="secondaryRegion" type="hidden" class="opt_region2_input" name="secondaryRegion" value="${param.secondaryRegion }" />
                        	<input id="optNo" type="hidden" class="opt_no" name="optNo" />
                        	<input id="optAreaNo" type="hidden" class="opt_area_no" name="optAreaNo" />
                        	<input id="productNo" type="hidden" class="product_no" name="productNo" value="${product.no }"/>
                        	
                        </dd>
                    </dl>
                   
                    <dl class="sold_out">
                        <dt>남은 수량</dt>
                        <dd class="last_qnt">9 개</dd>
                    </dl>
                    <dl class="price_tag">
                        <dt>총 가격</dt>
                       		<dd>
                       		<span class="product_price">
                        	<c:out value=" ${param.price + param.optPrice }" />
                        	</span>
                        	원</dd>
                            <input class="total_price_input" type="hidden" name="price" value="${param.price + param.optPrice}" />
                    </dl>

                </div><!--item_info_box-->
            </div>
        </div>

                <div class="division_line"></div>

                <div class="giver_msg_content">
                    <div class="giver_msg_to_taker"><!--얘를 배송지 쪽에다가 적게하면 어떨까-->
                        <h2 class="msg_title">기버의 메세지</h2>
                        <div class="msg_box">
                            <p> ${product.reqMsg} </p>
                        </div>
                    </div> <!--giver_msg_to_taker-->
                </div><!--msg_content-->

                <div class="taker_msg_content">
                    <h3 class="msg_title">기버의 메세지에 답변해주세요</h3>
                    <div class="form_wrap">
                        <textarea name="takerMsg" class="taker_textarea"></textarea>

                    </div>
                </div>

                <div class="division_line"></div>
                <div class="delivery_content">
                    <div class="delivery_info_box">
                        <h2>배송지정보</h2>
                        
                        <div class="delivery_info_header">
                            <div class="delivery_info_title">배송지 선택</div>
                            <ul class="delivery_type_box">
                                <li><input name="deliveryAddrType" class="check_input" id="defaultDeliveryAddr" type="radio" value="d" ><label class="default_addr_label" for="defaultDeliveryAddr">기본배송지</label></li>
                                <li><input name="deliveryAddrType" class="check_input" id="newDeliveryAddr" type="radio" value="n" checked><label class="new_addr_label" for="newDeliveryAddr">신규배송지</label></li>
                            </ul>
                            <div class="addr_list_box">
                                <button type="button" class="addr_list btn">배송지목록</button>
                            </div>
                        </div>
                        <div class="delivery_form_container">

                            <div class="addr_form default_addr">
                            <c:choose>
                            <c:when test="${takerOneAddr!=null }">
                                <div class="delivery_option_wrap">
                                    <div class="delivery_info_title">수령인</div>
                                    <p class="default_addr recipient">${takerOneAddr.receiver}</p>
                                </div>
                                <div class="delivery_option_wrap">
                                    <div class="delivery_info_title">배송지명</div>
                                    <p class="default_addr delivery_name">${takerOneAddr.name}</p>
                                </div>
                                <div class="delivery_option_wrap">
                                    <div class="delivery_info_title">연락처</div>
                                    <div>
                                        <p class="default_addr phone_num">${takerOneAddr.phoneNum}</p>
                                    </div>
                                </div>
                                <div class="delivery_option_wrap delivery_addr">
                                    <div class="delivery_info_title">배송지 주소</div>
                                    <p class="default_addr delivery_addr"> 
                                    	<span class="default_zip_code">${takerOneAddr.zipCode }</span>
                                   		<span class="default_addr_content">${takerOneAddr.addr }</span>
                                   		<span class="default_addr_detail">${takerOneAddr.addrDetail }</span></p>
                                    <button type="button" class="default_addr_edit_btn">수정</button>
                                </div><!--delivery_option_wrap-->
							</c:when>
							<c:otherwise>
								<div class="no_default_addr">
									<p>등록된 기본 배송지가 없습니다</p>
								</div>
							</c:otherwise>
                           	</c:choose>
                            </div><!--addr_form default_delivery-->


                            <div class="addr_form new_addr show">
                                <div class="delivery_option_wrap">
                                    <div class="delivery_info_title">수령인</div>
                                    <div>
                                        <input class="new_delivery delivery_txt1" name="receiver" placeholder="5자 이내로 입력하세요" maxlength="5"/>
                                    </div>
                                </div>
                                <div class="delivery_option_wrap">
                                    <div class="delivery_info_title">배송지명</div>
                                    <div>
                                        <input class="new_delivery delivery_txt2" name="name" placeholder="10자 이내로 입력하세요" maxlength="10"/>
                                    </div>
                                </div>
                                <div class="delivery_option_wrap">
                                    <div class="delivery_info_title phone_num">연락처</div>
                                    <div class="phone_num_check">
                                        <div class="phone1">
                                            <select name="phone1" class="new_delivery phone1_txt" >
                                                <option value="010" selected>010</option>
                                                <option value="011">011</option>
                                                <option value="016">016</option>
                                                <option value="017">017</option>
                                            </select>
                                            <span>-</span>
                                        </div>
                                        <div class="phone2">
                                            <input name="phone2" class="new_delivery phone2_txt" maxlength="4" />
                                            <span>-</span>
                                        </div>
                                        <div class="phone3">
                                            <input name="phone3" class="new_delivery phone3_txt" maxlength="4" />
                                        </div>
                                        <input class="total_phone_num" type="hidden" name="phone" />
                                    </div><!-- phone_num_check -->
                                </div>
                                <div class="delivery_option_wrap delivery_addr">
                                    <div class="delivery_info_title">배송지 주소</div>
                                    <div class="delivery_detail_box">
                                        <div>
                                            <span><input id="zipCode" name="zipCode" class="new_delivery zip_code" readonly/></span>
                                            <button type="button" class="zip_code_btn btn">우편번호</button>
                                        </div>
                                        <div>
                                            <input id="roadAddr" name="addr" class="new_delivery addr" readonly />
                                            <input id="jibunAddr" name="jibunAddr" type="hidden" />
                                        </div>
                                        <div>
                                            <input name="addrDetail" class="new_delivery addr_detail" placeholder="상세주소를 입력해주세요" />
                                        </div>
                                    </div><!--delivery_detail_box-->
                                    <div class="delivery_addr_setting">
                                    
                                    <%--배송지가 하나도 없는 경우는 무조건 기본 배송지로 등록하도록 --%>
                                    	<c:choose>
	                                    	<c:when test="${takerOneAddr!=null}">
		                                        <label class="btn"><input type="checkbox" name="addDeliveryList" value="Y">배송지목록에 추가</label>
		                                        <label class="btn"><input class="default_checkbox" type="checkbox" name="type" value="Y" >기본배송지로 설정</label>
	                                        </c:when>
	                                        <c:otherwise>
	                                        	<input type="hidden" name="noAddr" value="Y" /> 
	                                        </c:otherwise>
                                        </c:choose>
                                    </div><!--checkbox_box-->
                                </div><!--delivery_option_wrap-->
                            </div><!--addr_form new_delivery-->
                        </div><!--delivery_form_container-->
                    </div><!--deliver_info_box-->
                </div> <!--deliver_content-->


                <div class="division_line"></div>

                <div class="payment_content">
                    <button type="button" class="btn payment_btn">결제하기</button>
                </div>
            </div>
    </div><!--container-->
    <input id="dateVal" type="hidden" name="dateVal" value="${product.dateAvail}" />

<c:import url="/WEB-INF/view/template/footer.jsp" />

    <!-- ================================== 배송지 팝업 ====================================== -->
    <div id="delPopOverlay">
        <div id="popPage">
            <!-- pop_header -->

            <div id="popHeader">
                <div class="placeholder"></div>
                <h1 class="h1">배송지 목록</h1>
                <button type="button" class="fas fa-times"><span class="screen_out">목록 닫기</span></button>
            </div>

            <div id="popContainer">
                <div id="popContent">
                    <div class="delivery_list_area">
                        <table class="tbl_delivery_list">
                            <caption><span class="screen_out">등록된 배송지 목록</span></caption>
                            <colgroup>
                                <col class="cell_delivery">
                                <col>
                                <col class="cell_tel">
                                <col class="cell_btn">
                            </colgroup>
                            <thead>
                            <tr>
                                <th class="cell_delivery">배송지</th>
                                <th>주소</th>
                                <th class="cell_tel">연락처</th>
                                <th class="cell_btn">선택</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${takerAddrs}" var="addr">
                                <tr page="1" class="addr_item" >
                                    <td class="cell_delivery">
                                        <div class="address_nick">${addr.name}</div>
                                        <div><strong class="recipient">${addr.receiver}</strong></div>
                                        <c:if test="${addr.type == 'Y'}"><div><span class="default_marker">기본</span></div></c:if>
                                    </td>
                                    <td class="addr">	
                                        <span class="zipCode">${addr.zipCode}</span><br>
                                        <span class="baseAddr">${addr.addr}</span><br>
                                        <span class="addr_detail">${addr.addrDetail}</span>
                                        <span class="road_name_Yn" style="display:none;">Y</span>
                                    </td>
                                    <td class="cell_tel">
                                        <span class="tel_no"><br>${addr.phoneNum}</span>
                                    </td>
                                    <td class="cell_btn">
                                        <button type="button" class="setting_btn">선택</button>
                                    </td>
                                </tr>
                             </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="setting_paginate">
                        <div class="paginate">
                            <span><a class="fa fa-chevron-left" href=""></a></span>
                            <strong title="">1</strong>
                            <span><a class="fa fa-chevron-right" href=""></a></span>
                        </div>
                    </div>
                </div><!--popContent-->
            </div><!--popContainer-->
        </div><!--popPage-->
    </div><!--#delPopOverlay-->
    
    

    <div id="paymentOverlay">
        <div id="paymentPopPage">
            <div id="paymentPopHeader">
                <div class="placeholder"></div>
                <h1 class="h1">결제하기</h1>
                <button type="button" class="fas fa-times"><span class="screen_out">결제창 닫기</span></button>
            </div><!--paymentPopHeader-->

            <div id="paymentPopContainer">
                <div class="card_number_area">
                    <label class="card_label" for="cardDigit">카드 번호</label>
                    <span class="card_digit_input">
                        <input id="cardDigit" class="card_digit" name="cardDigit1" maxlength="4" placeholder="0000"/>
                        <input name="cardDigit2" class="card_digit" maxlength="4" placeholder="0000"/>
                        <input name="cardDigit3" class="card_digit" maxlength="4" placeholder="0000"/>
                        <input name="cardDigit4" class="card_digit" maxlength="4" placeholder="0000"/>
                        <input type="hidden" class="total_card_num" name="cardNum" />
                    </span>
                </div>
                <div class="card_cvc_area">
                    <label class="card_label" for="cardCVC">CVC</label>
                    <input id="cardCVC" class="card_digit" name="cvc" maxlength="3" placeholder="000" />
                </div>
                <div class="msg_area">
                    <p class="verifying_msg"></p>
                </div>
            </div><!--paymentPopContainer-->

            <div id="paymentPopFooter">

                <div class="submit_btn_area">
                    <button form="subscribeForm" type="submit" class="submit_btn" disabled>결제</button>
                </div>
            </div><!--paymentPopFooter-->
        </div><!--paymentPopPage-->
    </div><!--paymentOverlay-->
</form>




<!-- ============================= 배송지 목록 template ==========================-->
<script type="text/template" id="addrListTmpl">
    <tr page="1" class="addr_item" >
        <td class="cell_delivery">
            <div class="address_nick">우리집</div>
            <div><strong class="recipient">방현수</strong></div>
            <div></div>
        </td>
        <td class="addr">
            <span class="zipCode">28668</span><br>
            <span class="baseAddr">충청북도 청주시 서원구 모충로 44-2 (개신동, 서우아파트)</span><br>
            <span class="addr_detail">C동 105호</span>
            <span class="road_name_Yn" style="display:none;">Y</span>
        </td>
        <td class="cell_tel">
            <span class="tel_no"><br>010-4120-3645</span>
        </td>
        <td class="cell_btn">
            <button type="button" class="setting_btn">선택</button>
        </td>
    </tr>
</script>

<c:import url="/WEB-INF/view/template/js-import.jsp"/>
<script src="/js/header.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/tui-date-picker.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/js/subscribe.js"></script>
</body>
</html>