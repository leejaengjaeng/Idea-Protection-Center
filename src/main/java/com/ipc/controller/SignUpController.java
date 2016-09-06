package com.ipc.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ipc.vo.userVo;

@Controller
@RequestMapping("/signup")
public class SignUpController {
	
	@RequestMapping("/signupPage")
	public String signupPage(Model model){
		return "signup/signup";
	}
	@RequestMapping(value="/inputsignup", method=RequestMethod.POST)
	public String inputsignup(Model model,HttpServletRequest request,userVo uv){
		System.out.println(uv.getId());
		
		return "OK";
	}
}
