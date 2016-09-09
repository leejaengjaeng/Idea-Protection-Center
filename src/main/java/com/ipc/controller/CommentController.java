package com.ipc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import com.ipc.dao.RegistrationDao;
import com.ipc.vo.RegistrationPatentVo;
import com.ipc.vo.userVo;


@Controller
public class CommentController {
	
	@Autowired
	RegistrationDao regDao;
	@Autowired
	HttpSession session;
	
	@RequestMapping("/test")
	public String test(Model model)
	{
		return "comment/comment";
	}
	
	@RequestMapping(value="/detail/{start_rid}",method=RequestMethod.GET)
	public String detail(@PathVariable int start_rid,Model model)
	{
		//접근한 경로에 대한 권한 확인
		RegistrationPatentVo assosiatedMemberId= regDao.getAssociatedMembersByRid(start_rid);		
		System.out.println(assosiatedMemberId);

		Object isAuthenticated = session.getAttribute("currentUser");

		if(assosiatedMemberId != null && isAuthenticated != null )
		{
			int inventorId = assosiatedMemberId.getUid();
			int plId = assosiatedMemberId.getLid();
			int userId = ((userVo)isAuthenticated).getUid();
			
			//발명가가 보는 경우
			if(inventorId==userId) 
			{
				List<RegistrationPatentVo> processList = regDao.getAssociatedProcessList(start_rid);
				RegistrationPatentVo firstItem = regDao.getInventorProcessByRid(start_rid);
				model.addAttribute("user","inventor");
				model.addAttribute("processList",processList);
				model.addAttribute("item",firstItem);
				return "comment/comment";
			}
			//변리사가 보는 경우
			if(plId==userId)
			{
				List<RegistrationPatentVo> processList = regDao.getAssociatedProcessList(start_rid);
				RegistrationPatentVo firstItem = regDao.getPlProcessByRid(start_rid);
				model.addAttribute("user","pl");
				model.addAttribute("processList",processList);
				model.addAttribute("item",firstItem);
				return "comment/comment";
			}
		}
		return "redirect:/authError";
	}
	
	//Ajax용
	@RequestMapping(value="/detailByRid/{rid}",method=RequestMethod.GET)
	@ResponseBody
	public Map detailByRid(@PathVariable int rid)
	{
		//접근한 경로에 대한 권한 확인
		RegistrationPatentVo assosiatedMemberId= regDao.getAssociatedMembersByRid(rid);		
		Object isAuthenticated = session.getAttribute("currentUser");

		if(assosiatedMemberId != null && isAuthenticated != null )
		{
			int inventorId = assosiatedMemberId.getUid();
			int plId = assosiatedMemberId.getLid();
			int userId = ((userVo)isAuthenticated).getUid();
		
		
			//발명가가 보는 경우
			if(inventorId==userId) 
			{
				RegistrationPatentVo item = regDao.getInventorProcessByRid(rid);
				RegistrationPatentVo beforeComment = regDao.getPrevCommentByPrevRid(item.getPrev_rid());
				
				Map<String,Object> retVal = new HashMap<String,Object>();
				retVal.put("role", "inventor");
				retVal.put("item",item);
				retVal.put("beforeComment", beforeComment);
				
				return retVal;
			}
			//변리사가 보는 경우
			if(plId==userId)
			{
				Map<String,Object> retVal = new HashMap<String,Object>();
				RegistrationPatentVo item = regDao.getPlProcessByRid(rid);
				
				retVal.put("role", "pl");
				retVal.put("item", item);
				return retVal;
			}
		}
		
		return null;
	}
	
	//Ajax용
	@RequestMapping(value="/tmpSave",method=RequestMethod.POST)
	@ResponseBody
	public String tmpSave(RegistrationPatentVo regVo, HttpServletRequest req)
	{
		String role = req.getParameter("role");
		System.out.println(regVo.getTitle());
		System.out.println(regVo.getTypeOfInvent());
		
		if(role.equals("pl"))
		{
			System.out.println("/tmpSave -> pl 작성중");
		}
		else if(role.equals("inventor"))
		{
			regDao.tmpInventorSave(regVo);
		}
		else
		{
			return "error";
		}
		return "success";
	}
}
