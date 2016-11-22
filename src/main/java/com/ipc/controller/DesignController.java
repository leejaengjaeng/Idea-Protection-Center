package com.ipc.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ipc.dao.DesignDao;
import com.ipc.dao.UserDao;
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
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	private static final String roleAdmin = "ROLE_ADMIN";
	private static final String roleInventor = "ROLE_INVENTOR";
	private static final String rolePatientntLawyer = "ROLE_PATIENTENTLAWYER";
	private static final String roleGuest = "anonymousUser";
	@RequestMapping("/detail/{deid}")
	public String designDetail(@PathVariable int deid,Model model){
		userVo currentUser = (userVo) session.getAttribute("currentUser");
		if(currentUser != null){
			model.addAttribute("userVo",userDao.getUserByUid(Integer.toString(currentUser.getUid())));
			if(currentUser.getRole().equals(roleInventor))
			{
				DesignVo nowDv = designmapper.getDesignByDeid(deid);
				model.addAttribute("nowDv", nowDv);
				int start_deid=designmapper.getStart_deid(deid);
				int countOfDesign = designmapper.countDesignByStart_deid(start_deid);
				model.addAttribute("count", countOfDesign);
				return "comment/d_comment_inventor";
			}
			else if(currentUser.getRole().equals(rolePatientntLawyer))
			{
				return "comment/d_comment_pl";
			}
			else
				return "redirect:/login";
		}
		else
			return "redirect:/login";
	}
}
