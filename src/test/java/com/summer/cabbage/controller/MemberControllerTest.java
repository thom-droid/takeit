package com.summer.cabbage.controller;

import static org.hamcrest.CoreMatchers.any;
import static org.junit.Assert.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.MockitoJUnitRunner;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.RequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import com.summer.cabbage.dao.GiversDAO;
import com.summer.cabbage.dao.MembersDAO;
import com.summer.cabbage.dao.TakersDAO;
import com.summer.cabbage.service.MembersService;
import com.summer.cabbage.vo.Member;
import com.summer.cabbage.vo.Taker;

@RunWith(MockitoJUnitRunner.class)
@ContextConfiguration(locations = {"classpath:WEB-INF/applicationContext.xml", "classpath:WEB-INF/web.xml"})
public class MemberControllerTest {

	// object to be injected 
	@InjectMocks
	MemberController memberController;
	
	// mock object to inject
	@Mock
	MembersService service;
	
	@Mock
	MembersDAO membersDao;
	
	@Mock
	TakersDAO takersDao;
	
	@Mock
	GiversDAO giversDao;
	
	// entry point for spring support
	private MockMvc mockMvc;
	
	// create instance before tests get started
	@Before
	public void createController() {
		MockitoAnnotations.openMocks(this);
		mockMvc = MockMvcBuilders.standaloneSetup(memberController).build();
	}
	
	@Test
	public void testLogin() throws Exception{
		Member m = mock(Member.class);
		Taker t = takersDao.selectNo(1000);
		Map<String, Object> map = Mockito.anyMap();
		m.setId("test@gmail.com");
		m.setPassword("1111");
		m.setType("T");
		map.put("taker", t);
		map.put("member", m);
		assertNotNull(m);
		assertNotNull(map);
		
		when(service.login(m)).thenReturn(map);
		RequestBuilder rq = MockMvcRequestBuilders.post("/log").contentType(MediaType.APPLICATION_FORM_URLENCODED);
		mockMvc.perform(rq).andExpect(status().is3xxRedirection()).andDo(print());
		
	}

}
