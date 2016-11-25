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

import com.ipc.dao.CopyrightInfoDao;
import com.ipc.dao.DesignDao;
import com.ipc.dao.MainPageDao;
import com.ipc.dao.NoticeDao;
import com.ipc.dao.RegistrationDao;
import com.ipc.dao.UserDao;
import com.ipc.service.MessageService;
import com.ipc.service.RegistrationService;
import com.ipc.service.SignUpService;
import com.ipc.vo.CopyRightInfoVo;
import com.ipc.vo.DesignAdminVo;
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
	@Autowired
	RegistrationService rs;
	@Autowired
	DesignDao designDao;
	@Autowired
	CopyrightInfoDao copyrightInfoDao;
	
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
				List<DesignAdminVo> designList;
				List<CopyRightInfoVo> copyrightList;
				int currentUserUid = currentUser.getUid();
				
				if(currentUser.getRole().equals(roleInventor))
				{
					processList = mainPageDao.getMainPageList(currentUserUid);	
					designList=designDao.getDesignListIn(currentUserUid);
					copyrightList = copyrightInfoDao.getCopyrightListInventer(currentUserUid);
					
					model.addAttribute("comIdea",regDao.countCompleteIdeaIn(currentUserUid));
					model.addAttribute("ingIdea",regDao.countIngIdeaIn(currentUserUid));
					model.addAttribute("MessageList",ms.getMessageList(Integer.toString(currentUser.getUid())));
					model.addAttribute("isLawyer",0);
				}
				else if(currentUser.getRole().equals(rolePatientntLawyer))
				{
					processList = mainPageDao.getPlMainPageList(currentUserUid);
					designList=designDao.getDesignListPl(currentUser.getUid());
					copyrightList = copyrightInfoDao.getCopyrightListPl(currentUserUid);
				
					model.addAttribute("comIdea",regDao.countCompleteIdeaPl(currentUserUid));
					model.addAttribute("ingIdea",regDao.countIngIdeaPl(currentUserUid));
					model.addAttribute("MessageList",ms.getMessageListPL(Integer.toString(currentUser.getUid())));
					model.addAttribute("isLawyer",1);
				}
				// 발명가나 변리사가 아니면 리다이렉트
				// If not only Inventor but patientLawyer, Redirecting to root path
				else
				{
					System.out.println("re");
					return "redirect:/";			
				}
				
				model.addAttribute("processList",processList);
				model.addAttribute("processList",processList);
				model.addAttribute("trademarkList",null);
				model.addAttribute("designList",designList);
				model.addAttribute("copyrightList",copyrightList);
				model.addAttribute("userVo",userDao.getUserByUid(Integer.toString(currentUser.getUid())));
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
	@RequestMapping("/changeIsread")
	@ResponseBody
	public String changeIsread(HttpServletRequest request){
		String mid=request.getParameter("mid");
		
		ms.changeIsread(mid);
		return "OK";
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
	@RequestMapping("/intro_service")
	public String service_intro(){
		return "intro/service_intro";
	}
	@RequestMapping("/intro_whyideapc")
	public String whyideapc(){
		return "intro/whyideapc";
	}
	@RequestMapping("/site_info")
	public String siteinfo(){
		return "info/siteinfo";
	}
	@RequestMapping("/costinfo")
	public String costinfo(){
		return "info/costinfo";
	}
	@RequestMapping("/designcmt/inventor")
	public String design_cmt_inventor(){
		return "comment/copy_comment_inventor";
	}
	@RequestMapping("/designcmt/pl")
	public String design_cmt_pl(){
		return "comment/copy_comment_pl";
	}
}
	