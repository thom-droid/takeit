package com.summer.cabbage.controller;

import java.io.File;
import java.sql.Date;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.summer.cabbage.service.MembersService;
import com.summer.cabbage.util.FileRenameUtil;
import com.summer.cabbage.util.ResizeImageUtil;
import com.summer.cabbage.vo.Giver;
import com.summer.cabbage.vo.Member;
import com.summer.cabbage.vo.Taker;

@Controller
public class MemberController {
	@Autowired
	private MembersService service;

	// index GET
	@RequestMapping(value={"/","/index"}, method=RequestMethod.GET)
	public String index(Model model) {
		model.addAllAttributes(service.showMainForm());
		return "index";
	}
	
	// log GET
	@RequestMapping(value="/log",method=RequestMethod.GET)
	public String loginForm() {
		return "/login";
	}
	

	// log POST
	@RequestMapping(value="/log",method=RequestMethod.POST)
	public String login(Member member, HttpSession session, RedirectAttributes ra) {
		// 서비스 메서드 이용해서 로그인 처리 해주기 
		
		Map<String, Object> loginInfo = service.login(member); 
		Member m = (Member) loginInfo.get("member");
		
		if(loginInfo!=null) {
			
			session.setAttribute("loginMember", loginInfo);
			
			// when giver logging in
			if(m.getType().equals("G")) {
				
				return "redirect:/giver/"+m.getNo()+"/main";
				
			// taker logging in
			}else if(m.getType().equals("T")){
				
				Taker t = (Taker) loginInfo.get("taker");
				String success = "반갑습니다,"+  t.getNickname()+" 님";
				ra.addFlashAttribute("msg", success);
				return "redirect:/index";
			}
			
		}
		
		ra.addFlashAttribute("msg", "아이디 혹은 비밀번호 혹은 회원 유형선택이 틀렸습니다.");
		
		return "redirect:/log";
	}
	
	// log DELETE
	@DeleteMapping(value="/log")
	public String logOut(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/index";
	}
	
	// pw find GET
	@RequestMapping(value="/find/password",method = RequestMethod.GET )
	public String findPassword(){
		
		return "findPassword";
		
	}
	
	// pw find PUT
	@RequestMapping(value="/find/password",method = RequestMethod.PUT )
	public String findPassword(Member member){
		
		service.findPw(member);
		
		return "redirect:/log";
		
	}
	
	// id Check ajax GET
	@RequestMapping(value="/ajax/check/id", method = RequestMethod.GET)
	@ResponseBody
	public String checkId(String id){
		return "{\"result\":"+service.checkId(id)+"}";
	}
	
	// nickname check ajax GET
	@RequestMapping(value="/ajax/check/nickname", method=RequestMethod.GET)
	@ResponseBody
	public String checkNickname(String nickname) {
		return "{\"result\":"+service.checkNickname(nickname)+"}";
	}
	
	
	// signUp POST
	@RequestMapping(value="/signUp", method=RequestMethod.POST)
	public String takerSignUp(Member member, Taker taker, Giver giver, String type, String birthYear, String birthMonth, String birthDay, HttpSession session, RedirectAttributes ra) {
		
		if(type.equals("T")) {
			try {
				Date birthDateVal = Date.valueOf(birthYear+"-"+birthMonth+"-"+birthDay);
				
				taker.setBirthDate(birthDateVal);
				
				// insert member, taker transaction
				boolean signUp =  service.signUpTaker(member, taker);
				
				if(signUp) {
					session.setAttribute("loginMember", service.login(member));
					String success = "반갑습니다," + taker.getNickname() +" 님";
					ra.addFlashAttribute("msg", success);
				}
			} catch (Exception e) {
				String error = "에러가 발생했습니다.";
				ra.addFlashAttribute("msg", error);
				
			}
			
		} else if(type.equals("G")){
			try {
				boolean signUp = service.signUpGiver(member, giver);
				
				if(signUp) {
					
					session.setAttribute("loginMember", service.login(member));
					Member loginMember = (Member)session.getAttribute("loginMember");
					
					return "redirect:/giver/"+loginMember.getNo()+"/main";
				}
			} catch (Exception e) {
				
				String error = "에러가 발생했습니다.";
				ra.addFlashAttribute("msg", error);
			}
			
		}
		
		return "redirect:/index";
	}
	
	// signUp select (giver/taker) GET
	@RequestMapping(value="/signUp/select", method=RequestMethod.GET)
	public String sdfsf() {
		return "signupSelect";
	}
	
	// signUp giver 1 GET
	@RequestMapping(value="/giver/signUp/step1", method=RequestMethod.GET)
	public String sdfqsf() {
		return "signupGiverStep1";
	}
	
	// signUP giver 2 GET
	@RequestMapping(value="/giver/signUp/step2", method=RequestMethod.GET)
	public String sdfswf() {
		return "signupGiverStep2";
	}
	
	// signUp GET
	@RequestMapping(value="/signUp", method=RequestMethod.GET)
	public String signUp(Model model, @RequestParam(required=false) String type, Giver giver, RedirectAttributes ra) {
		
		// if signUp for giver
		if(type!=null) {
			Giver giverBusinessNum = service.getGiverBusinessNum(giver.getBusinessNum());
			
			if(giverBusinessNum!=null) {
				ra.addFlashAttribute("msg", "이미 등록된 사업자 번호입니다.");
				return "redirect:/signupGiverStep2";
			}else {
				model.addAttribute("type", "G");
				model.addAttribute("giver", giver);
				return "signUp";
			}
		} else {
			return "signUp";
		}
		
	}
	
	// check bizname ajax GET
	@RequestMapping(value="/ajax/check/businessName", method=RequestMethod.GET)
	@ResponseBody
	public String checkBusinessName(String businessName) {
		return "{\"result\":"+service.checkBusinessName(businessName)+"}";
	}
	
	// profile upload ajax POST
	@RequestMapping(value="/ajax/profile", method=RequestMethod.POST)
	@ResponseBody
	private String uploadProfile(String type, MultipartFile uploadImg, HttpServletRequest request) 
			throws Exception {
		// 서버
		ServletContext application = request.getServletContext();
		// 기본경로
		String rootPath = application.getRealPath("/");
		// 업로드 폴더 경로
		String uploadPath = rootPath + "img" + File.separator + "upload" + File.separator + "profile" +File.separator;
		// 파일의 실제 이름
		String fileName = uploadImg.getOriginalFilename();
		// 파일 객체 생성
		File file = new File(uploadPath + fileName);
		// 파일이름이 같다면 숫자가 붙음
		file = FileRenameUtil.rename(file);
		// 임시폴더에 우리 업로드폴더로 이동
		uploadImg.transferTo(file);
		// 리사이즈가 필요한 경우 하면 됨
		String resizePath = rootPath + "img" + File.separator + "upload" + File.separator + "resized" + File.separator;
		// 리사이즈
		ResizeImageUtil.resize(file.toString(), resizePath + file.getName(), 200);
		return "{\"profileName\":\""+file.getName()+"\"}";
	}
	
	// profile ajax DELETE
	@RequestMapping(value="/ajax/profile/{profileImage}")
	@ResponseBody
	private String deleteProfile(@PathVariable String profileImage, HttpServletRequest request) {
		System.out.println(profileImage);
		
		ServletContext application = request.getServletContext();
		
		String rootPath = application.getRealPath("/");
		
		String uploadedPath = rootPath + "img"  + File.separator + "upload" + File.separator + "profile" +File.separator;
		
		String resizedPath = rootPath + "img"  + File.separator + "upload" + File.separator + "resized" +File.separator;
		//실제 경로에 있는 파일을 삭제
		try {
			File uploaded = new File(uploadedPath + profileImage);
			File resized = new File(resizedPath + profileImage);
			uploaded.delete();
			resized.delete();
		} catch(Exception e) {
			System.out.println("error");
		}
		
		String msg = "deleted";
		return "{\"msg\":\""+msg+"\"}";
	}
	
	
}
