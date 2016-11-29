package com.ipc.controller;

import java.util.HashMap;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.ipc.dao.DesignDao;
import com.ipc.dao.UpLoadDocDao;
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
	@Autowired
	UpLoadDocDao upDao;
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	private static final String roleAdmin = "ROLE_ADMIN";
	private static final String roleInventor = "ROLE_INVENTOR";
	private static final String rolePatientntLawyer = "ROLE_PATIENTENTLAWYER";
	private static final String roleGuest = "anonymousUser";
	@RequestMapping("/detail/{deid}")
	public String designDetail(@PathVariable int deid,Model model){
		session.removeAttribute("currentApply");
		
		session.setAttribute("currentApply", "Design");
		session.setAttribute("DesignId", deid);
		
		userVo currentUser = (userVo) session.getAttribute("currentUser");
		DesignVo nowDv = designmapper.getDesignByDeid(deid);
		
		int start_deid=designmapper.getStart_deid(deid);
		int countOfDesign = designmapper.countDesignByStart_deid(start_deid);
		if(currentUser != null){
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
		designService.designInputPl(request,currentUser);
		return "redirect:/mainPage";
	}
	@RequestMapping(value="/inputEditDesign",method=RequestMethod.POST)
	public String inputEditDesign(HttpServletRequest request){
		userVo currentUser = (userVo) session.getAttribute("currentUser");
		designService.designInputIn(request, currentUser);
		return "redirect:/mainPage";
	}
	@RequestMapping(value="/changeDesign",method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> changeDesign(HttpServletRequest request){
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Integer> parameterMap = new HashMap<String,Integer>();
		int num = Integer.parseInt(request.getParameter("num"));
		
		int deid = Integer.parseInt(request.getParameter("deid"));
		int start_deid=designmapper.getStart_deid(deid);
		parameterMap.put("num", num-1);
		parameterMap.put("start_deid", start_deid);

		DesignVo beVo = designmapper.getDesignByNum(parameterMap);
		System.out.println("beVo's title : "+beVo.getTitle());
		parameterMap.remove("num");
		if(num!=Integer.parseInt(request.getParameter("count"))){
			parameterMap.put("num",num);
		
			DesignVo cuVo = designmapper.getDesignByNum(parameterMap);
		
			resultMap.put("cuVo", cuVo);
			System.out.println("cuVo's title : "+cuVo.getTitle());

		}

		resultMap.put("beVo", beVo);
		//System.out.println("title = "+cuVo.getTitle());
		System.out.println("Ajax request : "+num);
		
		
		return resultMap;
	}
	@RequestMapping(value="/changeDesignPL",method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> changeDesignPL(HttpServletRequest request){
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Integer> parameterMap = new HashMap<String,Integer>();
		int num = Integer.parseInt(request.getParameter("num"));
		
		int deid = Integer.parseInt(request.getParameter("deid"));
		int start_deid=designmapper.getStart_deid(deid);
		if(num!=1){
			parameterMap.put("num", num-2);
			parameterMap.put("start_deid", start_deid);

			DesignVo beVo = designmapper.getDesignByNum(parameterMap);
			System.out.println("beVo's title : "+beVo.getTitle());
			resultMap.put("beVo", beVo);
			parameterMap.remove("num");

		}
		parameterMap.put("num", num-1);
		parameterMap.put("start_deid", start_deid);

		DesignVo cuVo = designmapper.getDesignByNum(parameterMap);
		System.out.println("cuVo's title : "+cuVo.getTitle());
		resultMap.put("cuVo", cuVo);
		
//		if(num!=Integer.parseInt(request.getParameter("count"))){
//			parameterMap.put("num",num);
//		
//			DesignVo cuVo = designmapper.getDesignByNum(parameterMap);
//		
//			resultMap.put("cuVo", cuVo);
//			System.out.println("cuVo's title : "+cuVo.getTitle());
//
//		}

		
		//System.out.println("title = "+cuVo.getTitle());
		System.out.println("Ajax request : "+num);
		
		
		return resultMap;
	}
	@RequestMapping(value="/gotoApply",method=RequestMethod.POST)
	@ResponseBody
	public String gotoApply(HttpServletRequest request){
		HashMap<String,String> map = new HashMap<String,String>();
		try{
			map.put("iscomplete", "3");
			map.put("deid",request.getParameter("deid"));
			
			designmapper.changeIsCompleteByHashMap(map);
			
			
			return "OK";
		}
		catch(Exception e){
			return "FAIL";
		}
	}
	@RequestMapping("/gotoUpLoad")
	public String gotoUpLoad(Model model){
		HashMap<String,String> mapExist=new HashMap<String,String>();
		System.out.println("Session DesignId : "+(int)session.getAttribute("DesignId"));
		mapExist.put("seq", Integer.toString((int)session.getAttribute("DesignId")));
		
		
		mapExist.put("patent_kind", "Design");
		
		int isExist=upDao.isExist(mapExist);
		System.out.println("isExist : "+isExist);
		model.addAttribute("isExist", isExist);
		return "apply/uploadother";
	}
}
