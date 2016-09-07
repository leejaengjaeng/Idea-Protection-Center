package com.ipc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/registration")
public class RegistrationController {
	@RequestMapping("/addidea")
	public String addidea(){
		return "registration/idea_registration";
	}
	
	@RequestMapping("/inputidea")
	public String inputidea(){
		String a="aa";
		StringBuffer b=new StringBuffer();
		b.append("aa");
		a=a+b;
		System.out.println(a);
		
		return "/";
	}
}
