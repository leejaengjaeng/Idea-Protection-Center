package com.ipc.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ipc.dao.CopyrightDao;
import com.ipc.dao.CopyrightInfoDao;
import com.ipc.dao.TypeOfCopyrightDao;
import com.ipc.dao.UserDao;
import com.ipc.vo.CopyRightInfoVo;
import com.ipc.vo.CopyRightVo;
import com.ipc.vo.userVo;

@Controller
@RequestMapping("/copyRight")
public class CopyrightController {

	@Autowired
	TypeOfCopyrightDao typeOfCopyrightDao;
	@Autowired
	UserDao userDao;
	@Autowired
	CopyrightDao copyrightDao;
	@Autowired
	CopyrightInfoDao copyrightInfoDao;
	@Autowired
	HttpSession session;
	
	
	@RequestMapping("/showRegPage")
	public String copyRightShow(Model model)
	{
		List typeList = typeOfCopyrightDao.getTypeList();
		model.addAttribute("typeList", typeList);
		return "registration/idea_copyright";
	}
	
	@RequestMapping(value="/regCopyright", method=RequestMethod.POST)
	public String copyRightReg(HttpServletRequest req, Model model)
	{
		String title	= req.getParameter("idea_kind");
		String field	= req.getParameter("field_selected");
		String type 	= req.getParameter("kind");
		String meaning  = req.getParameter("meaning");
		int uid			= Integer.parseInt(req.getParameter("uid"));
		
		CopyRightVo cv = new CopyRightVo();
		cv.setTitle(title);
		cv.setField(field);
		cv.setType(type);
		cv.setMeaning(meaning);
		cv.setUid(uid);
		
		CopyRightInfoVo civ = new CopyRightInfoVo();
		civ.setUid(uid);
		civ.setTitle(title);
		civ.setInventor_name(userDao.getNameByUid(uid));
		
		copyrightDao.addCopyright(cv);
		copyrightInfoDao.addCopyrightInfo(civ);
		
		return "redirect:/";
	}
	@RequestMapping(value="/regCopyright_inventor", method=RequestMethod.POST)
	public String copyRightUpdate_Inventor(HttpServletRequest req, Model model)
	{
		//int cid
		
		String title	= req.getParameter("re_idea_kind_inventor");
		if(title.equals(""))title = req.getParameter("idea_kind");
		else
		{
			CopyRightInfoVo civ = new CopyRightInfoVo();
			civ.setTitle(title);
			//civ.setCid
			//copyrightInfoDao.addCopyrightInfo(civ);
		}
		
		String field	= req.getParameter("re_field_selected");
		if(field.equals("")) field = req.getParameter("field_selected");
		
		String type 	= req.getParameter("re_kind");
		if(type.equals("")) type = req.getParameter("kind");
		
		String meaning  = req.getParameter("re_meaning");
		if(meaning.equals("")) meaning = req.getParameter("meaning");
		
		int uid			= Integer.parseInt(req.getParameter("uid"));

		
		CopyRightVo cv = new CopyRightVo();
		cv.setTitle(title);
		cv.setField(field);
		cv.setType(type);
		cv.setMeaning(meaning);
		cv.setUid(uid);
		
		//copyrightDao.addCopyright(cv);
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/regCopyright_pl", method=RequestMethod.POST)
	public String copyRightUpdate_pl(HttpServletRequest req, Model model)
	{
		//int cid
		
		String title	= req.getParameter("re_idea_kind_inventor");
		if(title.equals(""))title = req.getParameter("idea_kind");
		else
		{
			CopyRightInfoVo civ = new CopyRightInfoVo();
			civ.setTitle(title);
			//civ.setCid
			//copyrightInfoDao.addCopyrightInfo(civ);
		}
		
		String field	= req.getParameter("re_field_selected");
		if(field.equals("")) field = req.getParameter("field_selected");
		
		String type 	= req.getParameter("re_kind");
		if(type.equals("")) type = req.getParameter("kind");
		
		String meaning  = req.getParameter("re_meaning");
		if(meaning.equals("")) meaning = req.getParameter("meaning");
		
		int uid			= Integer.parseInt(req.getParameter("uid"));

		
		CopyRightVo cv = new CopyRightVo();
		cv.setTitle(title);
		cv.setField(field);
		cv.setType(type);
		cv.setMeaning(meaning);
		cv.setUid(uid);
		
		//copyrightDao.addCopyright(cv);
		
		return "redirect:/";
	}
	
	@RequestMapping("/detail/{cid}")
	public String detailView(Model model,@PathVariable int cid)
	{
		userVo currentUser = (userVo) session.getAttribute("currentUser");
		CopyRightVo cv = copyrightDao.getOneRowByCid(cid);
		if(cv==null) return "redirect:/authError";
		
		List typeList = typeOfCopyrightDao.getTypeList();

		if(currentUser.getRole().equals("ROLE_INVENTOR"))
		{
			if(cv.getUid()!=currentUser.getUid()) return "redirect:/authError";
			
			model.addAttribute("copyrightVo",cv);
			model.addAttribute("typeList", typeList);
			
			return "comment/copy_comment_inventor";
		}
		else if(currentUser.getRole().equals("ROLE_PATIENTENTLAWYER"))
		{
			if(cv.getLid()!=currentUser.getUid()) return "redirect:/authError";
			
			model.addAttribute("copyrightVo",cv);
			model.addAttribute("typeList", typeList);
			
			return "comment/copy_comment_pl";
		}
		else
			return "redirect:/";
	}

	
	
}


