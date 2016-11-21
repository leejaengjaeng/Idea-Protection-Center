package com.ipc.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ipc.dao.CopyrightDao;
import com.ipc.dao.TypeOfCopyrightDao;
import com.ipc.dao.UserDao;
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
		
		copyrightDao.addCopyright(cv);

		return "redirect:/";
	}
	
}


