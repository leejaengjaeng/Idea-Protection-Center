package com.ipc.controller;

import java.util.List;

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
		return "home/index";
	}
	
	@RequestMapping("/admin")
	@ResponseBody
	public String admin()
	{
		return "test Admin";
	}
}
