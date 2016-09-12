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

		Object isAuthenticated = session.getAttribute("currentUser");

		if(assosiatedMemberId != null && isAuthenticated != null )
		{
			int inventorId = assosiatedMemberId.getUid();
			int plId = assosiatedMemberId.getLid();
			int userId = ((userVo)isAuthenticated).getUid();
			int lastRid = regDao.getLastRidInProcessList(start_rid);

			//현재 나타내는 rid 저장
			session.setAttribute("currentPosition", lastRid);

			//발명가가 보는 경우
			if(inventorId==userId) 
			{
				List<RegistrationPatentVo> processList = regDao.getAssociatedProcessList(start_rid);
				RegistrationPatentVo lastItem = regDao.getInventorProcessByRid(lastRid);
				RegistrationPatentVo beforeComment = regDao.getPrevCommentByPrevRid(lastItem.getPrev_rid());
				
				model.addAttribute("user","inventor");
				model.addAttribute("processList",processList);
				model.addAttribute("item",lastItem);
				model.addAttribute("lastRid",lastRid);
				model.addAttribute("beforeComment", beforeComment);

				if(beforeComment == null)
					model.addAttribute("isNull","true");
				else
					model.addAttribute("isNull","false");
				
				return "comment/comment";
			}
			//변리사가 보는 경우
			if(plId==userId)
			{
				List<RegistrationPatentVo> processList = regDao.getAssociatedProcessList(start_rid);
				RegistrationPatentVo lastItem = regDao.getPlProcessByRid(lastRid);
				RegistrationPatentVo beforeComment = regDao.getPrevCommentByPrevRid(lastItem.getPrev_rid());
				RegistrationPatentVo afterComment = regDao.getAfterCommentByRid(lastRid);
				
				model.addAttribute("user","pl");
				model.addAttribute("processList",processList);
				model.addAttribute("item",lastItem);
				model.addAttribute("lastRid",lastRid);
				model.addAttribute("afterComment", afterComment);
				model.addAttribute("beforeComment", beforeComment);
				
				if(beforeComment == null)
					model.addAttribute("isNull","true");
				else
					model.addAttribute("isNull","false");
				
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
			
			session.setAttribute("currentPosition", rid);
			
			Map<String,Object> retVal = new HashMap<String,Object>();
			
			//발명가가 보는 경우
			if(inventorId==userId) 
			{
				RegistrationPatentVo item = regDao.getInventorProcessByRid(rid);
				RegistrationPatentVo beforeComment = regDao.getPrevCommentByPrevRid(item.getPrev_rid());
				
				retVal.put("role", "inventor");
				retVal.put("item",item);
				retVal.put("beforeComment", beforeComment);
				
				return retVal;
			}
			//변리사가 보는 경우
			if(plId==userId)
			{
				RegistrationPatentVo item = regDao.getPlProcessByRid(rid);
				RegistrationPatentVo afterComment = regDao.getAfterCommentByRid(rid);
				RegistrationPatentVo beforeComment = regDao.getPrevCommentByPrevRid(item.getPrev_rid());
				
				retVal.put("role", "pl");
				retVal.put("item", item);
				retVal.put("beforeComment", beforeComment);
				retVal.put("afterComment", afterComment);
				
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
		
		//완료여부에 따른 체크 
		if(1 == regDao.checkIsCompletedByRid(regVo.getRid()))
			return "이미 완료된 사항입니다.";
		
		regVo.setIscomplete(0);
		
		//현재 페이지의 rid와 수정 요청한 rid가 같은지 확인 
		if((int)session.getAttribute("currentPosition") != regVo.getRid())
			return "잘못된 접근입니다.";
			
		if(role.equals("pl"))
		{
			regDao.plUpdate(regVo);
		}
		else if(role.equals("inventor"))
		{
			regDao.inventorSave(regVo);
		}
		else
		{
			return "저장 실패";
		}
		return "임시 저장 성공";
	}
	
	@RequestMapping(value="/ideaSave",method=RequestMethod.POST)
	@ResponseBody
	public String ideaSave(RegistrationPatentVo regVo, HttpServletRequest req)
	{
		String role = req.getParameter("role");
		System.out.println(role);
		//완료여부에 따른 체크 
		if(1 == regDao.checkIsCompletedByRid(regVo.getRid()))
			return "이미 완료된 사항입니다.";
		
		
		//현재 페이지의 rid와 수정 요청한 rid가 같은지 확인 
		if((int)session.getAttribute("currentPosition") != regVo.getRid())
		{
			System.out.println(regVo.getRid()+","+(int)session.getAttribute("currentPosition"));
			return "잘못된 접근입니다.";
		}
			
		if(role.equals("pl"))
		{
			RegistrationPatentVo tmpVo = regDao.getResourceForPlSaveByRid(regVo.getRid());
			regVo.setIscomplete(0);
			regVo.setPrev_rid(regVo.getRid());
			regVo.setStart_rid(tmpVo.getStart_rid());
			regVo.setLid(tmpVo.getLid());
			regVo.setUid(tmpVo.getUid());
			regDao.plSave(regVo);
		}
		else if(role.equals("inventor"))
		{
			regVo.setIscomplete(1);
			regDao.inventorSave(regVo);
		}
		else
		{
			System.out.println(role+"잉?");
			
			return "저장 실패";
		}
		return "저장 성공";
	}
}
