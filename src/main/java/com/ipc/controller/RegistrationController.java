package com.ipc.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ipc.dao.RegistrationDao;
import com.ipc.service.RegistrationService;
import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.userVo;

@Controller
@RequestMapping("/registration")
public class RegistrationController {
	@Autowired
	HttpSession session;
	@Autowired
	RegistrationDao regismapper;
	
	@RequestMapping("/addidea")
	public String addidea(){
		return "registration/idea_registration";
	}
	
	@RequestMapping(value="/inputidea",method=RequestMethod.POST)
	public String inputidea(HttpServletRequest request){
		String uid=request.getParameter("uid");
		String typeOfInvent=request.getParameter("typeOfInvent");
		String title=request.getParameter("title");
		String summary=request.getParameter("summary");
		String whyInvent=request.getParameter("whyInvent");
		String solution=request.getParameter("solution");
		String effect=request.getParameter("effect");
		String core_element=request.getParameter("core_element");
		HashMap<String,String> map=new HashMap();
		map.put("uid", uid);
		map.put("typeOfInvent", typeOfInvent);
		map.put("title", title);
		map.put("summary", summary);
		map.put("whyInvent", whyInvent);
		map.put("solution", solution);
		map.put("effect", effect);
		map.put("core_element", core_element);
		RegistrationService rs=new RegistrationService();
		map.put("registrtaion_date",rs.getToday() );
		regismapper.makeidea(map);
		return "home/index";
	}
}
