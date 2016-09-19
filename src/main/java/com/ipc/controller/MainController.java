package com.ipc.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
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
import com.ipc.dao.UserDao;
import com.ipc.service.SignUpService;
import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.adminListVo;
import com.ipc.vo.userVo;

@Controller
public class MainController {
	
	@Autowired
	HttpSession session;
	@Autowired
	RegistrationDao regDao;
	@Autowired
	UserDao usermapper;
	
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
				List<RegistrationPatentVo> processList;
				
				if(currentUser.getRole().equals(roleInventor))
				{
					processList = regDao.getInventorProcessList(currentUser.getUid());			
				}
				else if(currentUser.getRole().equals(rolePatientntLawyer))
				{
					processList = regDao.getPlProcessList(currentUser.getUid());			
				}
				// 발명가나 변리사가 아니면 리다이렉트
				// If not only Inventor but patientLawyer, Redirecting to root path
				else
				{
					return "redirect:/";			
				}
				
				model.addAttribute("processList",processList);
				return "user/userMain";

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
	
	@RequestMapping("/IPC_adminPage")
	public String admin2(Model model)
	{
		//권한 검사하기
		List<adminListVo> ideaList = regDao.adminGetIdeaList();
		model.addAttribute("ideaList", ideaList);
		return "admin/admin_management";
	}

	
}
