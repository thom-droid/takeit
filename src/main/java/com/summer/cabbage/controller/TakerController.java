package com.summer.cabbage.controller;

import java.io.File;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.summer.cabbage.service.TakersService;
import com.summer.cabbage.util.FileRenameUtil;
import com.summer.cabbage.util.ResizeImageUtil;
import com.summer.cabbage.vo.Member;
import com.summer.cabbage.vo.Taker;

@Controller
public class TakerController {
	
	@Autowired
	private TakersService service;
	
	// taker mypage GET
	@RequestMapping(value="/taker/{no}", method=RequestMethod.GET)
	public String takerMyPage(@PathVariable int no, Model model) {
		
		model.addAttribute("taker", service.getTaker(no));
		
		return "takerMyPage";
	}
	

	// 테이커 마이페이지에서 내 구독 상품과 히스토리 출력하기  03-04 오승주
	@RequestMapping(value="/taker/{takerNo}/items", method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> mySubList(@PathVariable int takerNo,String status,int page){
		///taker/"+${taker.no}+"/items

		return service.getSubList(takerNo,status,page);
	}
	
	// profileImg ajax POST
	@RequestMapping(value="/ajax/taker/{no}/profile", method=RequestMethod.POST)
	@ResponseBody
	private String uploadProfile(String type, MultipartFile uploadImg, HttpServletRequest request, Member member, @PathVariable int no) 
			throws Exception {
		
		ServletContext application = request.getServletContext();
		
		String rootPath = application.getRealPath("/");
		
		String uploadPath = rootPath + "img" + File.separator + "upload" + File.separator + "profile" +File.separator;
		
		String fileName = uploadImg.getOriginalFilename();
		
		File file = new File(uploadPath + fileName);
		
		file = FileRenameUtil.rename(file);
		
		uploadImg.transferTo(file);
		
		String resizePath = rootPath + "img" + File.separator + "upload" + File.separator + "resized" + File.separator;
		
		ResizeImageUtil.resize(file.toString(), resizePath + file.getName(), 200);
		member.setProfileImg(file.getName());
		service.updateProfile(member);
		
		return "{\"profileName\":\""+file.getName()+"\"}";
	}
	
	//테이커 닉네임 유효성 검사
	@RequestMapping(value="/ajax/signUp/check/nickname", method=RequestMethod.GET)
	@ResponseBody	
	public String checkNickname(String nickname) {
		return "{\"result\":"+service.checkNickname(nickname)+"}";
		
	}
	
	@RequestMapping(value="/ajax/taker/{no}/nickname", method=RequestMethod.POST, produces ="application/json;charset=UTF-8")
	@ResponseBody
	public String updateNickname(Taker taker, @PathVariable int no) {
		
		service.updateNickname(taker);
		
		return "{\"nickname\":\""+taker.getNickname()+"\"}";
		
	}
	//정진하 end
}
