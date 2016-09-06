package com.ipc.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MainController {
	
	@RequestMapping("/")
	public String hello()
	{
		return "index";
	}
	
	@RequestMapping("/authError")
	@ResponseBody
	public String no()
	{
		return "You can not see this";
	}
	
	@RequestMapping("/admin")
	@ResponseBody
	public String admin()
	{
		return "test Admin";
	}
}
