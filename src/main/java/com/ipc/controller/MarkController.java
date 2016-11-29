package com.ipc.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ipc.dao.MarkDao;
import com.ipc.service.MarkService;
import com.ipc.service.RegistrationService;
import com.ipc.util.CreateFileUtils;
import com.ipc.util.PathUtils;
import com.ipc.vo.MarkVo;
import com.ipc.vo.userVo;

@Controller
@RequestMapping("/mark")
public class MarkController {
	@Autowired
	HttpSession session;
	@Autowired
	MarkDao markmapper;
	@Autowired
	MarkService markService;
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	private static final String roleAdmin = "ROLE_ADMIN";
	private static final String roleInventor = "ROLE_INVENTOR";
	private static final String rolePatientntLawyer = "ROLE_PATIENTENTLAWYER";
	private static final String roleGuest = "anonymousUser";
	@RequestMapping(value="/regMark",method=RequestMethod.POST)
	public String regMark(HttpServletRequest request,MarkVo mv){
		userVo currentUser = (userVo) session.getAttribute("currentUser");
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //�떎以묓뙆�씪 �뾽濡쒕뱶
		List<MultipartFile> files = multipartRequest.getFiles("logo_file");
		RegistrationService rs = new RegistrationService();
		CreateFileUtils cfu = new CreateFileUtils();
		
		String file_name="mark"+rs.getToday(1);
		cfu.CreateFile(files.get(0), request, "/resources/mark/", file_name);
		
		mv.setLogo("/resources/mark/"+file_name);
		mv.setUid(currentUser.getUid());
		
		markmapper.insertFirstMark(mv);
		markmapper.updateFirstMarkStart_mid(mv.getMid());
		return "user/userMain";
	}
	@RequestMapping("/detail/{mid}")
	public String markDetail(HttpServletRequest request,@PathVariable int mid,Model model){
		MarkVo mv=markmapper.getMarkByMid(mid);
		MarkVo prev_mv;
		int start_mid=markmapper.getStart_midByMid(mid);
		int countMark=markmapper.countMarkByStart_mid(start_mid);
		userVo currentUser = (userVo) session.getAttribute("currentUser");
		if(currentUser!=null){
			if(countMark>1){
				prev_mv=markmapper.getMarkByMid(mv.getPrev_mid());
				model.addAttribute("prev_mv", prev_mv);
			}
			model.addAttribute("countMark", countMark);
			model.addAttribute("mv", mv);
			if(currentUser.getRole().equals(roleInventor))
			{
				if(currentUser.getUid()!=mv.getUid()){
					return "redirect:/authError";
				}
				
				
				
				return "comment/mark_comment_inventor";
			}
			else if(currentUser.getRole().equals(rolePatientntLawyer))
			{
				if(currentUser.getUid()!=mv.getLuid()){
					return "redirect:/authError";
				}
				
				
				
				return "comment/mark_comment_pl";
			}
		}
		
		
		return "aa";
	}
	@RequestMapping(value="/regMarkPl",method=RequestMethod.POST)
	public String regMarkPl(HttpServletRequest request,MarkVo mv){
		markService.saveMarkRegPL(request, mv);
		return "redirect:/mainPage";
				
	}
	@RequestMapping(value="/regMarkIn",method=RequestMethod.POST)
	public String regMarkIn(HttpServletRequest request,MarkVo mv){
		return null;
	}
}
