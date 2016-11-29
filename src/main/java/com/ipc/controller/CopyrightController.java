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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ipc.dao.CopyrightDao;
import com.ipc.dao.CopyrightInfoDao;
import com.ipc.dao.TypeOfCopyrightDao;
import com.ipc.dao.UserDao;
import com.ipc.service.RegistrationService;
import com.ipc.util.CreateFileUtils;
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
		RegistrationService rs = new RegistrationService();
		CreateFileUtils cfu = new CreateFileUtils();
		
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)req;  //�떎以묓뙆�씪 �뾽濡쒕뱶
		List<MultipartFile> files = multipartRequest.getFiles("plane_img");
		String file_name="mark"+rs.getToday(1);
		cfu.CreateFile(files.get(0), req, "/resources/uploadimgs/mark/", file_name);
		
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


