package com.ipc.controller;

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

import com.ipc.dao.DesignDao;
import com.ipc.dao.UserDao;
import com.ipc.service.DesignService;
import com.ipc.vo.DesignVo;
import com.ipc.vo.userVo;

@Controller
@RequestMapping("/design")
public class DesignController {
	@Autowired
	DesignDao designmapper;
	@Autowired
	HttpSession session;
	@Autowired 
	UserDao userDao;
	@Autowired
	DesignService designService;
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	private static final String roleAdmin = "ROLE_ADMIN";
	private static final String roleInventor = "ROLE_INVENTOR";
	private static final String rolePatientntLawyer = "ROLE_PATIENTENTLAWYER";
	private static final String roleGuest = "anonymousUser";
	@RequestMapping("/detail/{deid}")
	public String designDetail(@PathVariable int deid,Model model){
		userVo currentUser = (userVo) session.getAttribute("currentUser");
		if(currentUser != null){
			DesignVo nowDv = designmapper.getDesignByDeid(deid);
			int start_deid=designmapper.getStart_deid(deid);
			int countOfDesign = designmapper.countDesignByStart_deid(start_deid);
			System.out.println("count : "+countOfDesign);
			model.addAttribute("count", countOfDesign);
			model.addAttribute("userVo",userDao.getUserByUid(Integer.toString(currentUser.getUid())));
			model.addAttribute("nowDv", nowDv);
			model.addAttribute("start_deid", start_deid);
			if(countOfDesign>1){
				DesignVo prevDv = designmapper.getDesignByDeid(nowDv.getPrev_deid());
				model.addAttribute("prevDv", prevDv);
			}
			if(currentUser.getRole().equals(roleInventor))
			{
				System.out.println("IN!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				if(currentUser.getUid()!=nowDv.getUid()){
					return "redirect:/authError";
				}
				return "comment/d_comment_inventor";
			}
			else if(currentUser.getRole().equals(rolePatientntLawyer))
			{
				System.out.println("PL!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				if(currentUser.getUid()!=nowDv.getLuid()){
					return "redirect:/authError";
				}
				return "comment/d_comment_pl";
			}
			else{
				return "redirect:/login";
			}
		}
		else
			return "redirect:/login";
	}
	@RequestMapping(value="/inputCommentDesign",method=RequestMethod.POST)
	public String inputCommentDesign(HttpServletRequest request){
		System.out.println("Good");
		userVo currentUser = (userVo) session.getAttribute("currentUser");
		designService.designInput(request,currentUser);
		return "redirect:/userMain";
	}
}
