package com.ipc.controller;


import com.ipc.dao.RegistrationDao;
import com.ipc.dao.UserDao;
import com.ipc.vo.userVo;
import com.ipc.vo.RegistrationPatentVo;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;


@Controller
public class AuthController {
	
	@Autowired
	UserDao userDao;
	@Autowired
	RegistrationDao regDao;
	
	@Autowired
	HttpSession session;
	private static final String roleAdmin = "ROLE_ADMIN";
	private static final String roleInventor = "ROLE_INVENTOR";
	private static final String rolePatientntLawyer = "ROLE_PATIENTENTLAWYER";
	
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@RequestMapping("/login")
	public String loginPage()
	{
		return "home/login";
	}
	
	@RequestMapping("/authError")
	@ResponseBody
	public String no()
	{
		return "You can not see this";
	}
	
	@RequestMapping("/loginProcess.do")
	public String loginProcess(Model model)
	{
		try{
			String userId = SecurityContextHolder.getContext().getAuthentication().getName();		
			System.out.println("userId : "+userId);
			
			userVo currentUser = userDao.getUserById(userId);
			System.out.println("uid : "+currentUser.getUid());
			
			List<RegistrationPatentVo> processList = regDao.getProcessList(currentUser.getUid());
			System.out.println("role: "+currentUser.getRole() );
				
			// 인증 정보가 없으면 userId = anonymousUser
			// currnetUser = null
			
			session.setAttribute("currentUser", currentUser);
			model.addAttribute("processList",processList);
		
			System.out.println(currentUser.getRole().equals(rolePatientntLawyer)+","+currentUser.getRole().equals(roleInventor));
			if(currentUser.getRole().equals(roleInventor) || currentUser.getRole().equals(rolePatientntLawyer))
				return "tmpMain";
			else
			{
				System.out.println(currentUser.getId()+": role-> "+currentUser.getRole());
				return "redirect:/";		
			}
		}
		catch(Exception e)
		{
			logger.info("비정상 접근입니다(/loginProcess.do): "+e.getMessage());
			return "redirect:/";
		}
	}
	
	@RequestMapping("/logoutProcess.do")
	public String logoutProcess(HttpServletRequest req, HttpServletResponse res)
	{
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth != null)
		{
			new SecurityContextLogoutHandler().logout(req, res, auth);
		}
		session.invalidate();
		return "redirect:/";
	}

}

