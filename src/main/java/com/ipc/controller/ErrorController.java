package com.ipc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/error")
public class ErrorController {

	@RequestMapping("/404")
	public String error404(){
		return "error/404NotFound";
	}
	@RequestMapping("/500")
	public String error500(){
		return "error/500error";
	}
}
