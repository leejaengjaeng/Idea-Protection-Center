package com.ipc.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class CommentController {
	@RequestMapping("/test")
	public String test(Model model)
	{
		return "comment/comment";
	}
	
	@RequestMapping(value="/detail",method=RequestMethod.POST)
	public String detail(Model model)
	{
		return "comment/comment";
	}
	
}
