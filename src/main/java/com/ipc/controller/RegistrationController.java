package com.ipc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.userVo;

@Controller
@RequestMapping("/registration")
public class RegistrationController {
	@Autowired
	HttpSession session;
	
	@RequestMapping("/addidea")
	public String addidea(){
		return "registration/idea_registration";
	}
	
	@RequestMapping(value="/inputidea",method=RequestMethod.POST)
	public String inputidea(HttpServletRequest request){
		request.getParameter("title");
		return "home/index";
	}
}
