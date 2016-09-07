package com.ipc.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/registration")
public class RegistrationController {
	@Autowired
	HttpSession session;
	
	@RequestMapping("/addidea")
	public String addidea(){
		return "registration/idea_registration";
	}
	
	@RequestMapping("/inputidea")
	public String inputidea(){
		
		return "/";
	}
}
