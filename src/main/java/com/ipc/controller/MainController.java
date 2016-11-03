package com.ipc.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ipc.dao.MainPageDao;
import com.ipc.dao.NoticeDao;
import com.ipc.dao.RegistrationDao;
import com.ipc.dao.UserDao;
import com.ipc.service.MessageService;
import com.ipc.service.RegistrationService;
import com.ipc.service.SignUpService;
import com.ipc.vo.IndexVo;
import com.ipc.vo.RegistrationFileVo;
import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.adminListVo;
import com.ipc.vo.adminNoticeVo;
import com.ipc.vo.mainPageVo;
import com.ipc.vo.userVo;

@Controller
public class MainController {

	@Autowired
	HttpSession session;
	@Autowired
	RegistrationDao regDao;
	@Autowired
	UserDao userDao;
	@Autowired
	NoticeDao noticeDao;
	@Autowired
	MainPageDao mainPageDao;
	@Autowired
	SignUpService ss;
	@Autowired
	MessageService ms;

	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	private static final String roleAdmin = "ROLE_ADMIN";
	private static final String roleInventor = "ROLE_INVENTOR";
	private static final String rolePatientntLawyer = "ROLE_PATIENTENTLAWYER";
	private static final String roleGuest = "anonymousUser";
	@RequestMapping("/")
	public String hello(Model model)
	{
		List<adminNoticeVo> an = noticeDao.getNoticeListDescLimit(5);
		int totalUser = userDao.counTotalUser();
		int totalIdea = regDao.counTotalIdea();
		List<IndexVo> iv = regDao.getCurrentRegistration();
		model.addAttribute("noticeList",an);
		model.addAttribute("totalUser",totalUser);
		model.addAttribute("totalIdea",totalIdea);
		model.addAttribute("current", iv);
		return "home/index";
	}
	
	@RequestMapping("/mainPage")
	public String myMain(Model model)
	{
		try
		{
			userVo currentUser = (userVo) session.getAttribute("currentUser");
			List<adminNoticeVo> an = noticeDao.getNoticeListDescLimit(5);
			model.addAttribute("noticeList",an);
			if(currentUser != null)
			{
				List<mainPageVo> processList;
				int comIdea=0;
				int ingIdea=0;
				if(currentUser.getRole().equals(roleInventor))
				{
					System.out.println("in");
					processList = mainPageDao.getMainPageList(currentUser.getUid());	
					comIdea=regDao.countCompleteIdeaIn(currentUser.getUid());
					ingIdea=regDao.countIngIdeaIn(currentUser.getUid());
					model.addAttribute("MessageList",ms.getMessageList(Integer.toString(currentUser.getUid())));
				}
				else if(currentUser.getRole().equals(rolePatientntLawyer))
				{
					System.out.println("law");
					System.out.println("aaasddd");
					processList = mainPageDao.getPlMainPageList(currentUser.getUid());		
					comIdea=regDao.countCompleteIdeaPl(currentUser.getUid());
					ingIdea=regDao.countIngIdeaPl(currentUser.getUid());
					
					model.addAttribute("MessageList",ms.getMessageListPL(Integer.toString(currentUser.getUid())));
				}
				// 발명가나 변리사가 아니면 리다이렉트
				// If not only Inventor but patientLawyer, Redirecting to root path
				else
				{
					System.out.println("re");
					return "redirect:/";			
				}
				model.addAttribute("comIdea",comIdea);
				model.addAttribute("ingIdea",ingIdea);
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
	@RequestMapping(value="/assign",method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, String> assign(HttpServletRequest req){
		HashMap<String, String> map = new HashMap<String,String>(); 
		map.put("rid", req.getParameter("rid"));
		map.put("uid", req.getParameter("uid"));
		userDao.assign(map);
		HashMap<String, String> resultMap = new HashMap<String,String>();
		userVo uv = userDao.getUserByUid(req.getParameter("uid"));
		mainPageDao.updateMainPageLid(map);
		resultMap.put("result", "aa");
		resultMap.put("lawyerName", uv.getName());
		
		return resultMap;
	}

	@RequestMapping("/siteMap")
	public String comeOn(){
		return "sub/sitemap";
	}
	@RequestMapping("/role")
	public String role(){
		return "sub/role";
	}
	@RequestMapping("/copyright")
	public String copyright(){
		return "registration/idea_copyright";
	}
	@RequestMapping("/design")
	public String design(){
		return "registration/idea_design";
	}
}
