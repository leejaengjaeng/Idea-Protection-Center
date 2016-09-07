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
}
