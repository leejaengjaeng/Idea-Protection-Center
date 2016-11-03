package com.ipc.controller;


import com.ipc.dao.RegistrationDao;
import com.ipc.dao.UserDao;
import com.ipc.vo.userVo;
import com.ipc.vo.RegistrationPatentVo;

import java.util.List;

import javax.naming.AuthenticationException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
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
	private static final String roleGuest = "anonymousUser";
	
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@RequestMapping("/login")
	public String loginPage()
	{
		return "home/login";
	}
	
	@RequestMapping("/authError")
	public String no()
	{
		return "error/noaccess";
	}
	
	@RequestMapping("/beforeLogin.do")
	public String beforeLogin()
	{
		return "redirect:/login";
	}
	
	@RequestMapping("/loginProcess.do")
	public String loginProcess()
	{
		try{
			String userId = SecurityContextHolder.getContext().getAuthentication().getName();		
			userVo currentUser = userDao.getUserById(userId);
			// 인증 정보가 없으면 userId = anonymousUser
			// currnetUser = null
			if(currentUser == null)
				return "redirect:/login";		
			else
			{
				session.setAttribute("currentUser", currentUser);
				logger.debug("로그인 :"+currentUser.getName());
				if(currentUser.getRole().equals("ROLE_ADMIN"))
					return "redirect:/IPC_admin/";
				else
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

