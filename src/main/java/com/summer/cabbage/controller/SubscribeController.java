package com.summer.cabbage.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.javassist.expr.Instanceof;
import org.springframework.aop.framework.AbstractAdvisingBeanPostProcessor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.summer.cabbage.service.SubscribesService;
import com.summer.cabbage.util.FileRenameUtil;
import com.summer.cabbage.util.ResizeImageUtil;
import com.summer.cabbage.vo.Member;
import com.summer.cabbage.vo.PageVO;
import com.summer.cabbage.vo.Product;
import com.summer.cabbage.vo.Region;
import com.summer.cabbage.vo.Subscribe;
import com.summer.cabbage.vo.SubscriptionDay;
import com.summer.cabbage.vo.TakerAddr;
import com.summer.cabbage.vo.TakerCard;

@Controller
public class SubscribeController {

	@Autowired
	private SubscribesService service;
	
	//20210304 정진하 풀캘린더에 뜨게하기 위함
	@RequestMapping(value="/ajax/taker/{no}/subscriptions", method=RequestMethod.GET)
	@ResponseBody
	public List<SubscriptionDay> getMonthlySubscriptions(@PathVariable int no) throws IOException {
		return service.getSubscriptionDays(no);
	}
	
	// subscribe before payment 
	@RequestMapping(value="/subscribe/{productNo}", method=RequestMethod.GET)
	public String subscribe(Subscribe subscribe, Model model, HttpSession session , @PathVariable int productNo) {
		
		// loginMember is a map that consists of two parts - member, taker/giver 
		ConcurrentHashMap<String, Object> loginMember = (ConcurrentHashMap<String, Object>) session.getAttribute("loginMember"); 
		
		Member m = (Member) loginMember.get("member");
		System.out.println(m.getNo());
		 
		// 유저 배송지 
		model.addAllAttributes(service.applySubscribes(m.getNo(), productNo));
		 
		return "/subscribe"; 
	}
	
	// 0309 방 수정 
	// 구독을 결제
	@RequestMapping(value="/subscribe", method=RequestMethod.POST)
	public String subscribe(HttpSession session, TakerAddr takerAddr,
			@RequestParam(required = false) String addDeliveryList, @RequestParam(required = false) String noAddr, Subscribe subscribe, TakerCard takerCard) {

		ConcurrentHashMap<String, Object> loginMember = (ConcurrentHashMap<String, Object>) session.getAttribute("loginMember");
		
		Member member = (Member) loginMember.get("member");
		// 같은 데이터인데 db상 이름이 달라서 set해줌
		subscribe.setDelLocation(takerAddr.getName());
		
		//System.out.println(addDeliveryList);
		//System.out.println(takerAddr.getType());
		
		service.registerSubscribe(member.getNo(), takerAddr, addDeliveryList, noAddr, subscribe, takerCard);
		
		return "redirect:/index";
	}
	
	
	// item detail GET
	@RequestMapping(value="/taker/subscribe/{productNo}",method=RequestMethod.GET)
	public String adad(Model model,@PathVariable int productNo) {
		
		model.addAllAttributes(service.getProductDetail(productNo));
		
		return "item";
	}
	
	// item list GET
	
	@GetMapping(value="/item/list")
	public String maniList(Model model){
		model.addAllAttributes(service.getProductListByCategory());
		return "item-list";
	}
	
	// item list by category GET
	@RequestMapping(value="/item/{category}", method = RequestMethod.GET)
	public String mainList(@PathVariable String category, Model model) {
		model.addAllAttributes(service.getProductListByCategory(category)); 
		return "item-list";
	}
	
	// item list filter ajax GET
	
	@GetMapping(value="/ajax/filter/category/")
	@ResponseBody
	public Map<String, Object> listFilteredAjax(PageVO pageVO, @RequestParam(defaultValue = "1") Integer page) {
		return service.getProductFiltered(pageVO, page);
	}
	
	// item list result from search GET
	@GetMapping(value="/item/search")
	public String listSearched(PageVO pageVO, Model model) {
		model.addAllAttributes(service.getSearchResult(pageVO));
		return "item-list";
	}
	
	
	// 03-05 박형우 추가

	//	구독 등록 폼
	@RequestMapping(value="/subscription/{category}/register", method = RequestMethod.GET)
	private String giverSubsRegisterForm(@PathVariable int category, Model model) {
		model.addAllAttributes(service.showRegisterSubsForm(category));
		return "giverSubsRegisterForm";
	}
	//210304 박형우------------------------------------------------------
	
	//해당 시,군의 속하는 Json
	@RequestMapping(value="/ajax/subState", method = RequestMethod.GET)
	@ResponseBody
	private List<Region> subStateJson(@RequestParam int stateNo){
		return service.getSubStateJson(stateNo);
	}
	//210304 박형우------------------------------------------------------

	//이미지 업로드와 Json
	@RequestMapping(value="/ajax/uploadImage", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	private String uploadImage(String type, MultipartFile uploadImg, HttpServletRequest request) throws Exception{
		// 서버
		ServletContext application = request.getServletContext();
	
		// 기본경로
		String rootPath = application.getRealPath("/");
	
		// 업로드 폴더 경로
		String uploadPath = rootPath + "img" + File.separator + "upload" + File.separator;
	
		// 파일의 실제 이름
		String fileName = uploadImg.getOriginalFilename();
	
		// 파일 객체 생성
		File file = new File(uploadPath + fileName);
	
		// 파일이름이 같다면 숫자가 붙음
		file = FileRenameUtil.rename(file);
		
		// 임시폴더에 우리 업로드폴더로 이동
		uploadImg.transferTo(file);
		
		switch(type) {
		case "PR":
			String resizePath = rootPath + "img" + File.separator + "resize" + File.separator;
			ResizeImageUtil.resize(file.toString(), resizePath + file.getName(), 100);
			break;
		default: 
			break;
		}
		
		return "{\"imageName\":\""+file.getName()+"\"}";
	}
	//210304 박형우------------------------------------------------------

	//구독 등록하기
	@RequestMapping(value="/giver/subscription", method = RequestMethod.POST)
	private String uploadSubs(HttpSession session, Product product, String editorContent, int[] days, int[] deliveryAvailSubState, int[] deliveryAvailTax) {
		
		Member loginMember=(Member)session.getAttribute("loginMember");
		System.out.println(loginMember.getNo()+"기버번호");
		System.out.println(product.getCategoryNo()+"카테고리번호");
		System.out.println(product.getName()+"상품명");
		System.out.println(product.getPrice()+"가격");
		System.out.println(product.getDiscount()+"할인가");
		System.out.println(product.getDateAvail() +"날짜");
		System.out.println(product.getSalesQty()+"세일즈 qty");
		System.out.println(product.getReqMsg()+"요청메세지");
		System.out.println(product.getPhoto()+"썸네일");
		System.out.println(editorContent+": 컨트롤러에서 상세");
		System.out.println(product.getInstruction()+"제품이미지");
		
		boolean result = service.registerProduct(loginMember, product, editorContent, days, deliveryAvailSubState, deliveryAvailTax);
		
		return "redirect:/giver/"+loginMember.getNo();
	}
	//210304 박형우------------------------------------------------------
	
	//카테고리 선택 폼
	@RequestMapping(value="/category", method = RequestMethod.GET)
	private String registerCategoryForm() {
		return "registerCategoryForm";
	}
	//210305 박형우------------------------------------------------------
	
	// 03-05 박형우 추가 end
	
	
}
