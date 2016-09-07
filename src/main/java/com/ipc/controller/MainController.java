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
import org.springframework.web.bind.annotation.ResponseBody;

import com.ipc.dao.RegistrationDao;
import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.userVo;

@Controller
public class MainController {
	
	@Autowired
	HttpSession session;
	@Autowired
	RegistrationDao regDao;
	
	private static final String roleAdmin = "ROLE_ADMIN";
	private static final String roleInventor = "ROLE_INVENTOR";
	private static final String rolePatientntLawyer = "ROLE_PATIENTENTLAWYER";
	private static final String roleGuest = "anonymousUser";
	
	@RequestMapping("/")
	public String hello()
	{
		return "home/index";
	}
	
	@RequestMapping("/mainPage")
	public String myMain(Model model)
	{
		try
		{
			userVo currentUser = (userVo) session.getAttribute("currentUser");
			if(currentUser != null)
			{
				List<RegistrationPatentVo> processList = regDao.getProcessList(currentUser.getUid());
				if(currentUser.getRole().equals(roleInventor) || currentUser.getRole().equals(rolePatientntLawyer))
				{
					model.addAttribute("processList",processList);
					return "user/userMain";
				}		
				else 
					return "redirect:/";				
			}
			else
				return "redirect:/login";				
		}
		catch(Exception e)
		{
			System.out.println("뭐징 " + e);
			return "redirect:/";		
		}
	}
	
	@RequestMapping("/admin")
	@ResponseBody
	public String admin()
	{
		return "test Admin";
	}
	
}
