package com.summer.cabbage.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.summer.cabbage.dao.CategoriesDAO;
import com.summer.cabbage.dao.DeliveryDaysDAO;
import com.summer.cabbage.dao.DeliveryRegionsDAO;
import com.summer.cabbage.dao.GiversDAO;
import com.summer.cabbage.dao.PaymentsDAO;
import com.summer.cabbage.dao.ProductsDAO;
import com.summer.cabbage.dao.RegionsDAO;
import com.summer.cabbage.dao.ReviewsDAO;
import com.summer.cabbage.dao.SubscribesDAO;
import com.summer.cabbage.dao.TakerAddrsDAO;
import com.summer.cabbage.dao.TakerCardsDAO;
import com.summer.cabbage.util.PaginateUtil;
import com.summer.cabbage.vo.Category;
import com.summer.cabbage.vo.DeliveryDay;
import com.summer.cabbage.vo.DeliveryRegion;
import com.summer.cabbage.vo.Giver;
import com.summer.cabbage.vo.Member;
import com.summer.cabbage.vo.PageVO;
import com.summer.cabbage.vo.Payment;
import com.summer.cabbage.vo.Product;
import com.summer.cabbage.vo.Region;
import com.summer.cabbage.vo.Subscribe;
import com.summer.cabbage.vo.SubscriptionDay;
import com.summer.cabbage.vo.TakerAddr;
import com.summer.cabbage.vo.TakerCard;

@Service
public class SubscribesServiceImpl implements SubscribesService {

	
	@Autowired
	private SubscribesDAO subscribesDAO;
	
	@Autowired
	private DeliveryDaysDAO deliveryDaysDAO;
	
	@Autowired
	private TakerAddrsDAO takerAddrsDAO;
	
	@Autowired
	private ProductsDAO productsDAO;
	
	@Autowired
	private DeliveryRegionsDAO deliveryRegionsDAO;
	
	@Autowired
	private TakerCardsDAO takerCardsDAO;
	
	@Autowired
	private PaymentsDAO paymentsDAO;
	
	
	@Autowired
	private GiversDAO giversDAO;

	@Autowired
	private ReviewsDAO reviewsDAO;
	
	@Autowired
	private CategoriesDAO categoriesDAO; 
	
	@Autowired
	private RegionsDAO regionsDAO;
	@Autowired
	private ProductsDAO productDAO;
	
	// 03-04 ????????? ??????
	@Override
	public List<Subscribe> getMonthlySubscriptions(int takerNo) {
		return subscribesDAO.selectMonthlySubscriptions(takerNo);
	}

	
	@Override
	public List<SubscriptionDay> getSubscriptionDays(int takerNo) {
		
		List<SubscriptionDay> list = subscribesDAO.selectSubscriptionDays(takerNo);
		
		for (SubscriptionDay subscriptionDay : list) {
			subscriptionDay.setDeliveryDays(deliveryDaysDAO.selectList(subscriptionDay.getProductNo()));
		}//for end
		
		return list;
	}
	// 03-04 ????????? ?????? end
	
	// 03-04 ????????? ?????? (?????? ???????????? ?????? ????????????)
	@Override
	public Map<String, Object> applySubscribes(int takerNo, int productNo) {
		
		Map<String, Object> map = new ConcurrentHashMap<String, Object>();
		
		// ?????? ?????? ????????????
		map.put("takerAddrs", takerAddrsDAO.selectList(takerNo));
		
		// ?????? ????????? ????????????
		if(takerAddrsDAO.selectOne(takerNo)!=null) {
			map.put("takerOneAddr", takerAddrsDAO.selectOne(takerNo));
		}else {
			System.out.println("????????? ????????? ??????");
		}
		
		// delivery options available
		List<DeliveryRegion> dr = new ArrayList<DeliveryRegion>();
		
		// primary region select
		if(deliveryRegionsDAO.selectPrimary(productNo)!=null) {
			
			dr.addAll(deliveryRegionsDAO.selectPrimary(productNo));
			
		}
		
		// secondary region select (e.g. ?????????, ????????? ?????????...)
		if(deliveryRegionsDAO.selectSecondary(productNo)!=null) {
			
			List<DeliveryRegion> secondaryList = deliveryRegionsDAO.selectSecondary(productNo);
			
			for(int i = 0;i<secondaryList.size();i++) {
				
				// setting primary region (e.g. ??????, ??????...) to combine with secondary region
				DeliveryRegion prmyName = deliveryRegionsDAO.selectPrimaryName(secondaryList.get(i).getNo());
				
				secondaryList.get(i).setPrimaryRegionName(prmyName.getPrimaryRegionName());
				
			}
			
			dr.addAll(secondaryList);
			
		}
		
		map.put("deliveryOpt", dr);
		
		// ?????? ????????? ?????? ?????? ????????????
		map.put("daysOpt", deliveryDaysDAO.selectListDays(productNo));
		
		Giver giver = giversDAO.selectDetailOne(productNo);
		map.put("product",productsDAO.selectDetailOne(productNo));
		map.put("giver", giver);
		map.put("giverInfo", giversDAO.selectDetail(giver.getNo()));
		map.put("reviews",reviewsDAO.selectReviewsByProductNo(productNo));
		map.put("deliveryDays",deliveryDaysDAO.selectListDay(productNo));
		
		return map;
	}
	
	
	//0309 ????????? ?????? (????????????)
	@Transactional
	@Override
	public int registerSubscribe(int takerNo, TakerAddr takerAddr, String addDeliveryList, String noAddr, Subscribe subscribe, TakerCard takerCard) {
		
		
		/* 1. ????????? insert */
		
		int result =0;
		// ?????? ?????? ????????? ????????? ???????????? ????????? ?????????(noAddr==Y -> noAddr!=null) ?????????????????? ??????
		// ?????? takerAddr?????? ??????????????? ???????????? ???????????? ?????????
		takerAddr.setTakerNo(takerNo);
		
		// ???????????? ????????? ?????? ??????????????? ??????, ????????? ????????? ????????????, ?????????????????? ??????
		if (addDeliveryList==null&&takerAddr.getType()==null &&noAddr!=null) {
			
			// ????????? ?????? ?????????
			takerAddr.setType("Y");
			takerAddrsDAO.insertAddr(takerAddr);
	
		} else if(addDeliveryList!=null&&takerAddr.getType()!=null || takerAddr.getType()!=null){
		// ????????? ????????? ?????? ???????????? ????????? ????????? ????????? ?????? ?????? ?????? // ?????? ?????? ???????????? ???????????? ?????? ??????
			// ?????? ???????????? ???????????? ????????? ??????
			takerAddrsDAO.updateSetOthersNormal(takerNo);
						
			// ?????? ???????????? ???????????? ?????????????????? 
			result = takerAddrsDAO.insertAddr(takerAddr);
			
			// ???????????? ?????? ????????????, ????????? ????????? ?????? ??????
		} else if(addDeliveryList!=null){
			
			takerAddr.setType("N");
			result = takerAddrsDAO.insertAddr(takerAddr);
			
		} 
		
		
		/* 2. ?????? ???????????? insert */
		
		subscribesDAO.insertSubscribe(subscribe);
		
		
		/* 3. ????????? ????????? insert */
		
		takerCardsDAO.insertCardInfo(takerCard);
		
		
		/* 4. ?????? ???????????? insert
		 *  ??????????????? ?????? ????????? ??????????????? -> selectKey */
		
		Payment payment = new Payment();
		
		payment.setSubNo(subscribe.getNo());
		payment.setCardNo(takerCard.getNo());
		payment.setPrice(subscribe.getPrice());
		
		paymentsDAO.insertPaymentInfo(payment);
		
		return result;
	}
	
	// item detail
	@Override
	public Map<String, Object> getProductDetail(int productNo) {
		Map<String, Object> map= new ConcurrentHashMap<String, Object>();
		
		Giver giver = giversDAO.selectDetailOne(productNo);
		map.put("product",productsDAO.selectDetailOne(productNo));
		map.put("giver", giver);
		map.put("giverInfo", giversDAO.selectDetail(giver.getNo()));
		map.put("deliveryDays",deliveryDaysDAO.selectListDay(productNo));
		map.put("reviews",reviewsDAO.selectReviewsByProductNo(productNo));
		
		// delivery options available
		List<DeliveryRegion> dr = new ArrayList<DeliveryRegion>();
		
		// primary region select
		if(deliveryRegionsDAO.selectPrimary(productNo)!=null) {
			
			dr.addAll(deliveryRegionsDAO.selectPrimary(productNo));
			
		}
		
		// secondary region select (e.g. ?????????, ????????? ?????????...)
		if(deliveryRegionsDAO.selectSecondary(productNo)!=null) {
			
			List<DeliveryRegion> secondaryList = deliveryRegionsDAO.selectSecondary(productNo);
			
			for(int i = 0;i<secondaryList.size();i++) {
				
				// setting primary region (e.g. ??????, ??????...) to combine with secondary region
				DeliveryRegion prmyName = deliveryRegionsDAO.selectPrimaryName(secondaryList.get(i).getNo());
				
				secondaryList.get(i).setPrimaryRegionName(prmyName.getPrimaryRegionName());
				
			}
			
			dr.addAll(secondaryList);
			
		}
		
		map.put("deliveryOpt", dr);
		
		return map;
	}
	
	// categories and location options of the all items 
	@Override
	public Map<String, Object> getProductListByCategory() {
		Map<String, Object> map = new ConcurrentHashMap<String, Object>();
		
		
		// categories value
		List<Category> cgList = categoriesDAO.selectCategoryWithNum();
		
		// int arr containing categories no
		Integer[] intArr = new Integer[cgList.size()];
		
		// retrieving category names and setting into vo
		for(int i = 0 ; i < cgList.size() ; i++) {
			
			intArr[i] = cgList.get(i).getNo();
			
			cgList.get(i).setName(categoriesDAO.selectCategoryName(intArr[i]));
		}
		
		map.put("categories", cgList);
		
		// location info with product numbers
		PageVO pageVO = new PageVO();
		List<List<Region>> list = new ArrayList<List<Region>>();
		List<Region> scndLocation = new ArrayList<Region>();
		List<Region> prmy = new ArrayList<Region>();
		
		pageVO.setTempNo(1);
		
		
		for(int i = 0;i<17;i++) {
			List<Region> items = new ArrayList<Region>();
			
			// primary, secondary location search with categoryNo, tempNo(1 to 17)
			scndLocation = regionsDAO.selectLocationWithNum(pageVO);
			
			if(scndLocation!=null) {
				items.addAll(regionsDAO.selectLocationWithNum(pageVO));
			}

			// add a List<Region> object to the new List to get indexed
			list.add(items);
			prmy.add(regionsDAO.selectPrimaryLocationWithNum(pageVO));
			pageVO.setTempNo(pageVO.getTempNo()+1);
		}
		
		map.put("primaryLocation", prmy);
		map.put("secondLocation", list);

		
		return map;
	}
	
	// categories, location options
	@Override
	public Map<String, Object> getProductListByCategory(String category) {  
			
		Map<String, Object> map  = new ConcurrentHashMap<String, Object>();
		
		PageVO pageVO = new PageVO();
		
		//pathVariable??? ???????????? ????????? ???????????? ????????? ?????? category??? priorNo ??? ?????????
		int priorNo = 0;
		
		// setting when accessing to list with category value
		if(category.equals("clothes")) {
			priorNo = 1;
		} else if(category.equals("food")) {
			priorNo = 2;
		} else if(category.equals("living")) {
			priorNo = 3;
		} else if(category.equals("etc")) {
			priorNo = 4;
		}
		
		//setting priorNo 
		pageVO.setPriorNo(priorNo);
		
		// primary and secondary categories
		
		map.put("category", categoriesDAO.selectSecondCategory(priorNo));
		
		// categories with numbers of item
		List<Category> cgList = categoriesDAO.selectCategoryWithNum(priorNo);
		
		// int arr containing categories no
		Integer[] intArr = new Integer[cgList.size()];
		
		// retrieving category names and setting into vo
		for(int i = 0 ; i < cgList.size() ; i++) {
			
			intArr[i] = cgList.get(i).getNo();
			
			cgList.get(i).setName(categoriesDAO.selectCategoryName(intArr[i]));
		}
		
		map.put("categories", cgList);
		
		
		// location info with product numbers
		List<List<Region>> list = new ArrayList<List<Region>>();
		List<Region> scndLocation = new ArrayList<Region>();
		List<Region> prmy = new ArrayList<Region>();
		
		pageVO.setCategoryNo(priorNo);
		pageVO.setTempNo(1);
		
		
		for(int i = 0;i<17;i++) {
			List<Region> items = new ArrayList<Region>();
			
			// primary, secondary location search with categoryNo, tempNo(1 to 17)
			scndLocation = regionsDAO.selectLocationWithNum(pageVO);
			
			if(scndLocation!=null) {
				items.addAll(regionsDAO.selectLocationWithNum(pageVO));
			}

			// add a List<Region> object to the new List to get indexed
			list.add(items);
			prmy.add(regionsDAO.selectPrimaryLocationWithNum(pageVO));
			pageVO.setTempNo(pageVO.getTempNo()+1);
		}
		
		map.put("primaryLocation", prmy);
		map.put("secondLocation", list);
		return map;
	}
	
	
	// item list filter ajax GET
	@Override
	public Map<String, Object> getProductFiltered(PageVO pageVO, int page) {
		
		Map<String, Object> map = new ConcurrentHashMap<String, Object>();
		
		System.out.println("type :" +pageVO.getSearchType());
		System.out.println("value :" +pageVO.getSearchValue());
		System.out.println("categoryNo :" +pageVO.getCategoryNo());
		System.out.println("sort:" +pageVO.getSort());
		System.out.println("location :" +pageVO.getLocation());
		
		//pagination
		int no = pageVO.getCategoryNo();
		
		pageVO.setEnd(page*8);
		pageVO.setStart(pageVO.getEnd()-8+1);
		
		Category cg = new Category();
		
		if (no!=0) {
			cg = categoriesDAO.selectEngName(pageVO.getCategoryNo());
		} else if (no ==0) {
			cg.setEngName("search");
		}
		
		int total = productsDAO.selectTotalByCategory(pageVO);
		
		System.out.println("total found" +total);
		String paginate = PaginateUtil.getPaginate(page, total, 8, 16, cg.getEngName());
		
		map.put("subList", productsDAO.selectProductListByCategory(pageVO));
		map.put("paginate", paginate);
		
		return map;
	}
	
	// item list from search result
	@Override
	public Map<String, Object> getSearchResult(PageVO pageVO) {
		
		System.out.println("searchType :" + pageVO.getSearchType());
		System.out.println("searchValue :" + pageVO.getSearchValue());
		
		Map<String, Object> map = new ConcurrentHashMap<String, Object>();
		
		// retrieve categories
		
		List<Category> cgList = categoriesDAO.selectListBySearch(pageVO.getSearchValue());
		
		// int arr containing categories no
				Integer[] intArr = new Integer[cgList.size()];
				
			// retrieving category names and setting into vo
			for(int i = 0 ; i < cgList.size() ; i++) {
				
				intArr[i] = cgList.get(i).getNo();
				
				cgList.get(i).setName(categoriesDAO.selectCategoryName(intArr[i]));
			}
			
		// categories when searched with location
		if(pageVO.getSearchType().equals("location")){
			map.put("categories", cgList);
		}
		
		// locations when searched with item
		if(pageVO.getSearchType().equals("item")) {
			map.put("locations", regionsDAO.selectLocationWithNumBySearch(pageVO.getSearchValue()));
		}
		
		return map;
	}
	
	
	//?????? ?????? ??? ?????????
	@Override
	public Map<String, Object> showRegisterSubsForm(int category) {
		Map<String, Object> map = new ConcurrentHashMap<String, Object>();

		map.put("categories", categoriesDAO.selectSecondCategories(category));
		map.put("states", regionsDAO.selectStates());
		
		return map;
	}
	//210304 ?????????------------------------------------------------------
	
	//?????? ???,?????? ????????? Json
	@Override
	public List<Region> getSubStateJson(int stateNo) {
		return regionsDAO.selectSubStates(stateNo);
	}
	//210304 ?????????------------------------------------------------------

	//?????? ????????????
	@Override
	@Transactional
	public boolean registerProduct(Member loginMember, Product product, String editorContent, int[] days, int[] deliveryAvailSubState,
			int[] deliveryAvailTax) {
		product.setGiverNo(loginMember.getNo());
		product.setDetails(editorContent);
		
		System.out.println(product.getDetails()+" : ??????????????? ??????");
		
		int result1 = productDAO.insertProduct(product);
		
		DeliveryDay tempDelDay = new DeliveryDay();
		tempDelDay.setProductNo(product.getNo());
		int result2 = 1;
		for(int day : days) {
			tempDelDay.setDay(day);
			result2 *= deliveryDaysDAO.insertDeliveryDays(tempDelDay);
		}
		
		DeliveryRegion tempDelRegion = new DeliveryRegion();
		tempDelRegion.setProductNo(product.getNo());
		int result3 = 1;
		for(int i=0; i<deliveryAvailSubState.length; i++) {
			tempDelRegion.setAreaNo(deliveryAvailSubState[i]);
			tempDelRegion.setPrice(deliveryAvailTax[i]);
			result3 *= deliveryRegionsDAO.insertDeliveryRegions(tempDelRegion);
		}
		
		return 1==result1*result2*result3;
	}
	//210304 ?????????------------------------------------------------------
	
}
